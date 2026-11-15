import 'package:panelsolar/features/backup/data/backup_settings.dart';
import 'package:workmanager/workmanager.dart';

/// Programa el respaldo automático en segundo plano.
abstract interface class BackupSchedule {
  /// Programa (o reprograma) según [frequency]; `manual` lo cancela.
  Future<void> apply(BackupFrequency frequency);
}

/// Nombre único de la tarea de WorkManager.
const driveBackupTask = 'panelsolar.drive-backup';

/// [BackupSchedule] con WorkManager: solo con Wi-Fi (red no medida) y
/// batería suficiente (plan B.9).
class WorkmanagerBackupSchedule implements BackupSchedule {
  const new();

  @override
  Future<void> apply(BackupFrequency frequency) async {
    final wm = Workmanager();
    if (frequency == BackupFrequency.manual) {
      await wm.cancelByUniqueName(driveBackupTask);
      return;
    }
    await wm.registerPeriodicTask(
      driveBackupTask,
      driveBackupTask,
      frequency: frequency == BackupFrequency.daily
          ? const Duration(days: 1)
          : const Duration(days: 7),
      constraints: Constraints(
        networkType: NetworkType.unmetered,
        requiresBatteryNotLow: true,
      ),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
    );
  }
}
