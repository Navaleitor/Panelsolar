import 'dart:io';
import 'dart:ui';

import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:panelsolar/core/app_info.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/backup/data/backup_archive.dart';
import 'package:panelsolar/features/backup/data/backup_schedule.dart';
import 'package:panelsolar/features/backup/data/backup_service.dart';
import 'package:panelsolar/features/backup/data/drive/drive_auth.dart';
import 'package:panelsolar/features/backup/data/drive/drive_remote_store.dart';
import 'package:panelsolar/features/backup/data/secret_store.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:persistence/persistence.dart';
import 'package:workmanager/workmanager.dart';

/// Punto de entrada de WorkManager (otro *isolate*, sin pantalla). Abre la
/// base y sube el respaldo a Drive si hay sesión de Google.
@pragma('vm:entry-point')
void backupCallbackDispatcher() {
  Workmanager().executeTask((task, input) async {
    if (task != driveBackupTask) return true;
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();
    final docs = await getApplicationDocumentsDirectory();
    final db = AppDatabase(driftDatabase(name: 'panelsolar'));
    try {
      final storage = AppStorage(docs);
      final service = BackupService(
        archive: BackupArchive(
          db: db,
          storage: storage,
          appVersion: AppInfo.version,
          workDir: Directory(p.join(docs.path, 'tmp', 'backup-bg')),
        ),
        logs: BackupLogRepository(db),
        settings: AppSettingsRepository(db),
        auth: GoogleDriveAuth(),
        secrets: SecureSecretStore(),
        schedule: const WorkmanagerBackupSchedule(),
        remoteStore: DriveRemoteStore.new,
      );
      await service.backupToDrive(trigger: BackupTrigger.daily);
      return true;
    } on Object {
      // Se reintenta en la siguiente ventana; el error queda en el historial.
      return true;
    } finally {
      await db.close();
    }
  });
}

/// Registra el despachador (una vez al abrir la app).
Future<void> initBackgroundBackup() async {
  try {
    await Workmanager().initialize(backupCallbackDispatcher);
  } on Object {
    // Plataforma sin WorkManager (pruebas, escritorio).
  }
}
