import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:panelsolar/features/backup/data/backup_archive.dart';
import 'package:panelsolar/features/backup/data/backup_crypto.dart';
import 'package:panelsolar/features/backup/data/backup_schedule.dart';
import 'package:panelsolar/features/backup/data/backup_settings.dart';
import 'package:panelsolar/features/backup/data/drive/drive_auth.dart';
import 'package:panelsolar/features/backup/data/drive/drive_backup_service.dart';
import 'package:panelsolar/features/backup/data/drive/remote_store.dart';
import 'package:panelsolar/features/backup/data/secret_store.dart';
import 'package:panelsolar/features/backup/domain/backup_manifest.dart';
import 'package:persistence/persistence.dart';

/// Crea el almacén remoto con un cliente HTTP autorizado.
typedef RemoteStoreFactory = RemoteStore Function(http.Client client);

/// Orquesta el respaldo: .zip local, Google Drive, historial y
/// programación. Lo usan las pantallas y la tarea en segundo plano.
class BackupService {
  const new({
    required this.archive,
    required this.logs,
    required this.settings,
    required this.auth,
    required this.secrets,
    required this.schedule,
    required this.remoteStore,
    this.iterations = BackupCipher.defaultIterations,
  });

  final BackupArchive archive;
  final BackupLogRepository logs;
  final AppSettingsRepository settings;
  final DriveAuth auth;
  final SecretStore secrets;
  final BackupSchedule schedule;
  final RemoteStoreFactory remoteStore;

  /// Iteraciones de PBKDF2 (menos en pruebas).
  final int iterations;

  // --- .zip ------------------------------------------------------------------

  /// Exporta todo a [out]. Con [password] (no vacía) va cifrado.
  Future<BackupManifest> exportZip(File out, {String? password}) async {
    try {
      BackupEncryption? enc;
      if (password != null && password.isNotEmpty) {
        final salt = BackupCipher.newSalt();
        enc = (
          cipher: await BackupCipher.derive(
            password,
            salt,
            iterations: iterations,
          ),
          salt: salt,
          iterations: iterations,
        );
      }
      final manifest = await archive.write(out, encryption: enc);
      await logs.add(
        target: BackupTarget.zip,
        trigger: BackupTrigger.manual,
        status: BackupStatus.success,
        fileName: out.uri.pathSegments.last,
        sizeBytes: await out.length(),
        fileCount: manifest.files.length,
      );
      return manifest;
    } catch (e) {
      await _logFailure(BackupTarget.zip, BackupTrigger.manual, e);
      rethrow;
    }
  }

  /// Restaura [zip] (reemplaza todo).
  Future<RestoreResult> restoreZip(File zip, {String? password}) async {
    final result = await archive.restore(zip, password: password);
    await logs.add(
      target: BackupTarget.zip,
      trigger: BackupTrigger.restore,
      status: BackupStatus.success,
      fileName: zip.uri.pathSegments.last,
      fileCount: result.filesRestored,
    );
    return result;
  }

  // --- Drive -----------------------------------------------------------------

  /// `true` si el usuario activó el respaldo en Drive.
  Future<bool> driveEnabled() async =>
      await settings.get(BackupSettingKeys.driveEnabled) == 'true';

  /// Frecuencia guardada (diaria por omisión).
  Future<BackupFrequency> frequency() async {
    final v = await settings.get(BackupSettingKeys.driveFrequency);
    return BackupFrequency.values.where((f) => f.name == v).firstOrNull ??
        BackupFrequency.daily;
  }

  /// Inicia sesión con Google y activa el respaldo automático.
  Future<String> connectDrive() async {
    final email = await auth.signIn();
    await settings.set(BackupSettingKeys.driveEmail, email);
    await settings.set(BackupSettingKeys.driveEnabled, 'true');
    await schedule.apply(await frequency());
    return email;
  }

  /// Cierra sesión y apaga el respaldo automático (lo ya subido se queda).
  Future<void> disconnectDrive() async {
    await schedule.apply(BackupFrequency.manual);
    await settings.set(BackupSettingKeys.driveEnabled, null);
    await settings.set(BackupSettingKeys.driveEmail, null);
    try {
      await auth.signOut();
    } on Object {
      // Ya estaba cerrada.
    }
  }

  /// Cambia la frecuencia y reprograma.
  Future<void> setFrequency(BackupFrequency f) async {
    await settings.set(BackupSettingKeys.driveFrequency, f.name);
    if (await driveEnabled()) await schedule.apply(f);
  }

  /// Cambia la contraseña de Drive (`null` = sin cifrado). Cambia también
  /// la sal, así que el siguiente respaldo vuelve a subir los archivos.
  Future<void> setDrivePassword(String? password) async {
    final clean = (password == null || password.isEmpty) ? null : password;
    await secrets.setDrivePassword(clean);
    await settings.set(
      BackupSettingKeys.driveSalt,
      clean == null ? null : BackupCipher.newSalt(),
    );
  }

  Future<BackupEncryption?> _driveEncryption() async {
    final password = await secrets.drivePassword();
    if (password == null || password.isEmpty) return null;
    var salt = await settings.get(BackupSettingKeys.driveSalt);
    if (salt == null) {
      salt = BackupCipher.newSalt();
      await settings.set(BackupSettingKeys.driveSalt, salt);
    }
    return (
      cipher: await BackupCipher.derive(password, salt, iterations: iterations),
      salt: salt,
      iterations: iterations,
    );
  }

  Future<DriveBackupService?> _drive({required bool interactive}) async {
    final client = interactive
        ? await auth.interactiveClient()
        : await auth.silentClient();
    if (client == null) return null;
    return DriveBackupService(archive: archive, store: remoteStore(client));
  }

  /// Respalda en Drive si está activado. Devuelve `null` si está apagado o
  /// no hay sesión (en segundo plano no se puede pedir).
  Future<DriveBackupResult?> backupToDrive({
    required BackupTrigger trigger,
    bool interactive = false,
  }) async {
    if (!await driveEnabled()) return null;
    try {
      final drive = await _drive(interactive: interactive);
      if (drive == null) {
        await _logFailure(BackupTarget.drive, trigger, 'sin sesión');
        return null;
      }
      final r = await drive.backup(encryption: await _driveEncryption());
      await logs.add(
        target: BackupTarget.drive,
        trigger: trigger,
        status: BackupStatus.success,
        fileName: r.snapshotName,
        sizeBytes: r.sizeBytes,
        fileCount: r.uploadedFiles,
      );
      return r;
    } catch (e) {
      await _logFailure(BackupTarget.drive, trigger, e);
      if (interactive) rethrow;
      return null;
    }
  }

  /// Respaldos en Drive (inicia sesión si hace falta; sirve en un
  /// teléfono nuevo).
  Future<List<RemoteFile>> driveSnapshots() async =>
      await (await _drive(interactive: true))!.listSnapshots();

  /// Baja un respaldo de Drive para la vista previa.
  Future<File> downloadDriveSnapshot(RemoteFile snapshot) async =>
      await (await _drive(interactive: true))!.download(snapshot);

  /// Restaura un respaldo de Drive ya descargado.
  Future<RestoreResult> restoreDrive(File zip, {String? password}) async {
    final drive = (await _drive(interactive: true))!;
    final result = await drive.restore(zip, password: password);
    await logs.add(
      target: BackupTarget.drive,
      trigger: BackupTrigger.restore,
      status: BackupStatus.success,
      fileName: zip.uri.pathSegments.last,
      fileCount: result.filesRestored,
    );
    return result;
  }

  Future<void> _logFailure(
    BackupTarget target,
    BackupTrigger trigger,
    Object error,
  ) => logs.add(
    target: target,
    trigger: trigger,
    status: BackupStatus.failed,
    message: error.toString(),
  );
}
