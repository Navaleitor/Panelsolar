import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/backup/data/backup_crypto.dart';
import 'package:panelsolar/features/backup/data/database_snapshot.dart';
import 'package:panelsolar/features/backup/domain/backup_manifest.dart';
import 'package:path/path.dart' as p;
import 'package:persistence/persistence.dart';

/// Llave de cifrado ya derivada, con los datos para volver a derivarla.
typedef BackupEncryption = ({BackupCipher cipher, String salt, int iterations});

/// El respaldo es de una versión más nueva de la app.
class IncompatibleBackupException implements Exception {
  const new(this.schemaVersion);

  final int schemaVersion;
}

/// Trae el contenido original (sin cifrar) de un archivo que no viene en
/// el .zip (respaldos de Drive). `null` si no se pudo.
typedef FileFetcher = Future<Uint8List?> Function(
  BackupFileEntry entry,
  BackupCipher? cipher,
);

/// Resultado de una restauración.
typedef RestoreResult = ({
  Map<String, int> counts,
  int filesRestored,
  int filesMissing,
});

/// Arma y lee el .zip de respaldo:
///
/// ```text
/// manifest.json              (sin cifrar; vista previa)
/// database.sqlite[.enc]      (foto de la base con VACUUM INTO)
/// files/<ruta relativa>[.enc] (fotos y documentos; omitidos en Drive)
/// ```
class BackupArchive {
  const new({
    required this.db,
    required this.storage,
    required this.appVersion,
    required this.workDir,
  });

  final AppDatabase db;
  final AppStorage storage;
  final String appVersion;

  /// Carpeta temporal para la foto de la base.
  final Directory workDir;

  static const _dbEntry = 'database.sqlite';
  static const _encSuffix = '.enc';

  /// Fotos y documentos activos cuyo archivo existe.
  Future<List<BackupFileEntry>> localFiles() async {
    final photos = await (db.select(
      db.photos,
    )..where((f) => f.deletedAt.isNull())).get();
    final docs = await (db.select(
      db.documents,
    )..where((d) => d.deletedAt.isNull())).get();
    final seen = <String>{};
    return [
      for (final (path, hash) in [
        for (final f in photos) (f.filePath, f.sha256),
        for (final d in docs) (d.filePath, d.sha256),
      ])
        if (seen.add(path) && storage.file(path).existsSync())
          BackupFileEntry(
            path: path,
            sha256: hash,
            size: storage.file(path).lengthSync(),
          ),
    ];
  }

  /// Escribe el respaldo en [out]. Con [encryption], la base y los
  /// archivos van cifrados. Con [includeFiles] en `false` solo va la base
  /// (los archivos se listan en el manifiesto).
  Future<BackupManifest> write(
    File out, {
    BackupEncryption? encryption,
    bool includeFiles = true,
  }) async {
    await workDir.create(recursive: true);
    final snapshot = File(p.join(workDir.path, 'snapshot.sqlite'));
    await writeSnapshot(db, snapshot);
    final files = await localFiles();
    final manifest = BackupManifest(
      createdAt: DateTime.now().toUtc(),
      appVersion: appVersion,
      schemaVersion: db.schemaVersion,
      encrypted: encryption != null,
      filesIncluded: includeFiles,
      kdfSalt: encryption?.salt,
      kdfIterations: encryption?.iterations,
      counts: await activeCounts(db),
      files: files,
    );
    final cipher = encryption?.cipher;
    final zip = ZipFileEncoder()..create(out.path);
    try {
      zip.addArchiveFile(
        ArchiveFile.bytes(
          BackupManifest.entryName,
          utf8.encode(manifest.encode()),
        ),
      );
      Future<void> add(String name, File file) async {
        if (cipher == null) {
          await zip.addFile(file, name);
        } else {
          final data = await cipher.encrypt(await file.readAsBytes());
          zip.addArchiveFile(ArchiveFile.bytes('$name$_encSuffix', data));
        }
      }

      await add(_dbEntry, snapshot);
      if (includeFiles) {
        for (final f in files) {
          await add(p.posix.join('files', f.path), storage.file(f.path));
        }
      }
    } finally {
      await zip.close();
      if (snapshot.existsSync()) snapshot.deleteSync();
    }
    return manifest;
  }

  /// Lee solo el manifiesto (vista previa, sin contraseña). Lanza
  /// [FormatException] si no es un respaldo de Panelsolar.
  static BackupManifest readManifest(File zip) {
    final input = InputFileStream(zip.path);
    try {
      final archive = ZipDecoder().decodeStream(input);
      final entry = archive.findFile(BackupManifest.entryName);
      if (entry == null) {
        throw const FormatException('No es un respaldo de Panelsolar');
      }
      return BackupManifest.decode(utf8.decode(entry.readBytes()!));
    } on ArchiveException {
      throw const FormatException('Archivo .zip dañado');
    } finally {
      input.closeSync();
    }
  }

  /// Restaura [zip] reemplazando los datos actuales. Lanza
  /// [WrongPasswordException] si la contraseña no es correcta.
  Future<RestoreResult> restore(
    File zip, {
    String? password,
    FileFetcher? fetchFile,
  }) async {
    final manifest = readManifest(zip);
    if (manifest.schemaVersion > db.schemaVersion) {
      throw IncompatibleBackupException(manifest.schemaVersion);
    }
    BackupCipher? cipher;
    if (manifest.encrypted) {
      if (password == null || password.isEmpty) {
        throw const WrongPasswordException();
      }
      cipher = await BackupCipher.derive(
        password,
        manifest.kdfSalt!,
        iterations: manifest.kdfIterations!,
      );
    }
    final suffix = manifest.encrypted ? _encSuffix : '';
    await workDir.create(recursive: true);
    final snapshot = File(p.join(workDir.path, 'restore.sqlite'));
    final input = InputFileStream(zip.path);
    try {
      final archive = ZipDecoder().decodeStream(input);
      Future<Uint8List?> read(String name) async {
        final bytes = archive.findFile('$name$suffix')?.readBytes();
        if (bytes == null) return null;
        return cipher == null ? bytes : await cipher.decrypt(bytes);
      }

      final dbBytes = await read(_dbEntry);
      if (dbBytes == null) throw const FormatException('Falta la base');
      await snapshot.writeAsBytes(dbBytes, flush: true);
      final counts = await upgradeSnapshot(snapshot);

      var restored = 0;
      var missing = 0;
      for (final f in manifest.files) {
        final bytes = manifest.filesIncluded
            ? await read(p.posix.join('files', f.path))
            : await fetchFile?.call(f, cipher);
        if (bytes == null || sha256.convert(bytes).toString() != f.sha256) {
          missing++;
          continue;
        }
        await storage.writeBytes(f.path, bytes);
        restored++;
      }
      await restoreSnapshot(db, snapshot);
      return (counts: counts, filesRestored: restored, filesMissing: missing);
    } finally {
      input.closeSync();
      if (snapshot.existsSync()) snapshot.deleteSync();
    }
  }
}
