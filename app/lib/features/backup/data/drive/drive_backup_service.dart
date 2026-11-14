import 'dart:io';
import 'dart:typed_data';

import 'package:panelsolar/features/backup/data/backup_archive.dart';
import 'package:panelsolar/features/backup/data/backup_crypto.dart';
import 'package:panelsolar/features/backup/data/drive/remote_store.dart';
import 'package:panelsolar/features/backup/domain/backup_manifest.dart';
import 'package:panelsolar/features/backup/domain/retention.dart';
import 'package:path/path.dart' as p;

/// Resultado de un respaldo a Drive.
typedef DriveBackupResult = ({
  String snapshotName,
  int uploadedFiles,
  int deletedSnapshots,
  int sizeBytes,
});

/// Respaldo en Drive (plan B.9):
/// - Cada respaldo sube un `snapshot-<fecha>.zip` con la base y el
///   manifiesto (sin fotos).
/// - Las fotos y documentos se suben aparte como `blob-<sha256>` **solo si
///   no están ya** (incremental por hash).
/// - Retención: 7 diarias + 4 semanales; el resto se borra.
class DriveBackupService {
  const new({required this.archive, required this.store});

  final BackupArchive archive;
  final RemoteStore store;

  static const snapshotPrefix = 'snapshot-';

  /// Nombre del archivo de un blob. Con cifrado incluye el inicio de la
  /// sal: si cambia la contraseña los archivos se vuelven a subir.
  static String blobName(String sha256, {String? salt}) =>
      salt == null ? 'blob-$sha256' : 'blob-$sha256-${_saltTag(salt)}.enc';

  static String _saltTag(String salt) => salt
      .replaceAll(RegExp('[^A-Za-z0-9]'), '')
      .padRight(8, 'x')
      .substring(0, 8);

  /// Respaldos disponibles, del más nuevo al más viejo.
  Future<List<RemoteFile>> listSnapshots() async {
    final files = await store.list();
    return [
      for (final f in files)
        if (f.name.startsWith(snapshotPrefix)) f,
    ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  /// Sube un respaldo nuevo y aplica la retención.
  Future<DriveBackupResult> backup({BackupEncryption? encryption}) async {
    final remote = await store.list();
    final names = {for (final f in remote) f.name};
    var uploaded = 0;
    for (final f in await archive.localFiles()) {
      final name = blobName(f.sha256, salt: encryption?.salt);
      if (names.contains(name)) continue;
      final file = archive.storage.file(f.path);
      if (encryption == null) {
        await store.upload(name, file);
      } else {
        await store.uploadBytes(
          name,
          await encryption.cipher.encrypt(await file.readAsBytes()),
        );
      }
      names.add(name);
      uploaded++;
    }

    final now = DateTime.now().toUtc();
    final snapshotName =
        '$snapshotPrefix${now.toIso8601String().replaceAll(':', '-')}.zip';
    final tmp = File(p.join(archive.workDir.path, snapshotName));
    await archive.workDir.create(recursive: true);
    try {
      await archive.write(tmp, encryption: encryption, includeFiles: false);
      final size = await tmp.length();
      await store.upload(snapshotName, tmp);

      final snapshots = await listSnapshots();
      final toDelete = backupsToDelete([
        for (final s in snapshots) (id: s.id, createdAt: s.createdAt),
      ]);
      for (final id in toDelete) {
        await store.delete(id);
      }
      return (
        snapshotName: snapshotName,
        uploadedFiles: uploaded,
        deletedSnapshots: toDelete.length,
        sizeBytes: size,
      );
    } finally {
      if (tmp.existsSync()) tmp.deleteSync();
    }
  }

  /// Baja el respaldo [snapshot] a un archivo temporal (para la vista
  /// previa con `BackupArchive.readManifest`).
  Future<File> download(RemoteFile snapshot) async {
    await archive.workDir.create(recursive: true);
    final file = File(p.join(archive.workDir.path, snapshot.name));
    await file.writeAsBytes(await store.download(snapshot.id), flush: true);
    return file;
  }

  /// Restaura el respaldo ya descargado [zip]: la base viene en el .zip y
  /// las fotos/documentos se bajan de sus blobs.
  Future<RestoreResult> restore(File zip, {String? password}) async {
    final manifest = BackupArchive.readManifest(zip);
    final byName = {for (final f in await store.list()) f.name: f};
    Future<Uint8List?> fetch(
      BackupFileEntry entry,
      BackupCipher? cipher,
    ) async {
      final name = blobName(
        entry.sha256,
        salt: manifest.encrypted ? manifest.kdfSalt : null,
      );
      final remote = byName[name];
      if (remote == null) return null;
      final bytes = await store.download(remote.id);
      return cipher == null ? bytes : await cipher.decrypt(bytes);
    }

    return await archive.restore(zip, password: password, fetchFile: fetch);
  }
}
