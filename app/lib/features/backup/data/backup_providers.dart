import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/app_info.dart';
import 'package:panelsolar/core/database/database_providers.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/backup/data/backup_archive.dart';
import 'package:panelsolar/features/backup/data/backup_crypto.dart';
import 'package:panelsolar/features/backup/data/backup_schedule.dart';
import 'package:panelsolar/features/backup/data/backup_service.dart';
import 'package:panelsolar/features/backup/data/drive/drive_auth.dart';
import 'package:panelsolar/features/backup/data/drive/drive_remote_store.dart';
import 'package:panelsolar/features/backup/data/secret_store.dart';
import 'package:path/path.dart' as p;
import 'package:persistence/persistence.dart';

/// Inicio de sesión con Google (falso en pruebas).
final driveAuthProvider = Provider<DriveAuth>((ref) => GoogleDriveAuth());

/// Almacén de la contraseña de Drive (falso en pruebas).
final secretStoreProvider = Provider<SecretStore>((ref) => SecureSecretStore());

/// Programación en segundo plano (falsa en pruebas).
final backupScheduleProvider = Provider<BackupSchedule>(
  (ref) => const WorkmanagerBackupSchedule(),
);

/// Almacén remoto a partir del cliente autorizado (falso en pruebas).
final remoteStoreFactoryProvider = Provider<RemoteStoreFactory>(
  (ref) => DriveRemoteStore.new,
);

/// Iteraciones de PBKDF2 (se bajan en pruebas para que sean rápidas).
final backupIterationsProvider = Provider<int>(
  (ref) => BackupCipher.defaultIterations,
);

/// Servicio de respaldo de la app.
final backupServiceProvider = Provider<BackupService>((ref) {
  final storage = ref.watch(appStorageProvider);
  return BackupService(
    archive: BackupArchive(
      db: ref.watch(appDatabaseProvider),
      storage: storage,
      appVersion: AppInfo.version,
      workDir: Directory(p.join(storage.root.path, 'tmp', 'backup')),
    ),
    logs: ref.watch(backupLogRepositoryProvider),
    settings: ref.watch(appSettingsRepositoryProvider),
    auth: ref.watch(driveAuthProvider),
    secrets: ref.watch(secretStoreProvider),
    schedule: ref.watch(backupScheduleProvider),
    remoteStore: ref.watch(remoteStoreFactoryProvider),
    iterations: ref.watch(backupIterationsProvider),
  );
});

/// Historial reciente de respaldos.
final StreamProvider<List<BackupLog>> backupLogsProvider =
    StreamProvider.autoDispose<List<BackupLog>>(
      (ref) => ref.watch(backupLogRepositoryProvider).watchRecent(limit: 10),
    );

/// Valor de un ajuste (y sus cambios).
final StreamProviderFamily<String?, String> settingProvider = StreamProvider
    .autoDispose
    .family<String?, String>(
      (ref, key) => ref.watch(appSettingsRepositoryProvider).watch(key),
    );

/// Respaldo automático al finalizar un proyecto (pasar a Instalado). No
/// bloquea la pantalla y no hace nada si Drive no está activado.
final projectFinishedBackupProvider = Provider<void Function()>(
  (ref) =>
      () => unawaited(
        ref
            .read(backupServiceProvider)
            .backupToDrive(trigger: BackupTrigger.projectFinished),
      ),
);
