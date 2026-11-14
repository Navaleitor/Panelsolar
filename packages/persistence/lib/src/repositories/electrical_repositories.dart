import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `electrical_runs`.
class ElectricalRunRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  /// Tramos del proyecto en orden.
  Stream<List<ElectricalRun>> watchByProject(String projectId) =>
      (_db.select(_db.electricalRuns)
            ..where((t) => t.projectId.equals(projectId) & t.deletedAt.isNull())
            ..orderBy([
              (t) => OrderingTerm.asc(t.sortOrder),
              (t) => OrderingTerm.asc(t.createdAt),
            ]))
          .watch();

  /// Agrega o reemplaza un tramo.
  Future<ElectricalRun> save(ElectricalRunsCompanion row) {
    final l = row.lengthM.value;
    if (!(l > 0)) throw ArgumentError.value(l, 'lengthM', '> 0');
    return _db
        .into(_db.electricalRuns)
        .insertReturning(
          row.copyWith(updatedAt: Value(utcNow())),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Guarda el resultado calculado.
  Future<void> saveResult(String id, String? size, double? dropPercent) =>
      (_db.update(_db.electricalRuns)..where((t) => t.id.equals(id))).write(
        ElectricalRunsCompanion(
          resultSize: Value(size),
          dropPercent: Value(dropPercent),
          updatedAt: Value(utcNow()),
        ),
      );

  /// Borrado lógico.
  Future<void> softDelete(String id) =>
      (_db.update(_db.electricalRuns)..where((t) => t.id.equals(id))).write(
        ElectricalRunsCompanion(
          deletedAt: Value(utcNow()),
          updatedAt: Value(utcNow()),
        ),
      );
}

/// Acceso a `protection_devices`.
class ProtectionDeviceRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  /// Protecciones del proyecto.
  Stream<List<ProtectionDevice>> watchByProject(String projectId) =>
      (_db.select(
            _db.protectionDevices,
          )..where((t) => t.projectId.equals(projectId) & t.deletedAt.isNull()))
          .watch();

  /// Sustituye las protecciones del proyecto.
  Future<void> replaceAll(
    String projectId,
    List<ProtectionDevicesCompanion> rows,
  ) => _db.transaction(() async {
    final now = utcNow();
    await (_db.update(_db.protectionDevices)
          ..where((t) => t.projectId.equals(projectId) & t.deletedAt.isNull()))
        .write(
          ProtectionDevicesCompanion(
            deletedAt: Value(now),
            updatedAt: Value(now),
          ),
        );
    for (final r in rows) {
      await _db
          .into(_db.protectionDevices)
          .insert(r.copyWith(projectId: Value(projectId)));
    }
  });
}

/// Acceso a `simulation_results`.
class SimulationResultRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  /// Último resultado del proyecto.
  Stream<SimulationResultRecord?> watchLatest(String projectId) =>
      (_db.select(_db.simulationResults)
            ..where((t) => t.projectId.equals(projectId) & t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(1))
          .watchSingleOrNull();

  /// Guarda un resultado nuevo.
  Future<SimulationResultRecord> add(SimulationResultsCompanion row) =>
      _db.into(_db.simulationResults).insertReturning(row);
}
