import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';

/// Acceso a `backup_logs`: historial de respaldos.
class BackupLogRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Últimos [limit] registros, del más nuevo al más antiguo.
  Stream<List<BackupLog>> watchRecent({int limit = 20}) {
    final select = _db.select(_db.backupLogs)
      ..where((l) => l.deletedAt.isNull())
      ..orderBy([(l) => OrderingTerm.desc(l.createdAt)])
      ..limit(limit);
    return select.watch();
  }

  /// Último respaldo exitoso a [target], si hay.
  Future<BackupLog?> lastSuccess(BackupTarget target) {
    final select = _db.select(_db.backupLogs)
      ..where(
        (l) =>
            l.target.equalsValue(target) &
            l.status.equalsValue(BackupStatus.success) &
            l.trigger.equalsValue(BackupTrigger.restore).not(),
      )
      ..orderBy([(l) => OrderingTerm.desc(l.createdAt)])
      ..limit(1);
    return select.getSingleOrNull();
  }

  /// Registra un respaldo o restauración.
  Future<void> add({
    required BackupTarget target,
    required BackupTrigger trigger,
    required BackupStatus status,
    String? fileName,
    int? sizeBytes,
    int? fileCount,
    String? message,
  }) async {
    await _db
        .into(_db.backupLogs)
        .insert(
          BackupLogsCompanion.insert(
            target: target,
            trigger: trigger,
            status: status,
            fileName: Value(fileName),
            sizeBytes: Value(sizeBytes),
            fileCount: Value(fileCount),
            message: Value(message),
          ),
        );
  }
}
