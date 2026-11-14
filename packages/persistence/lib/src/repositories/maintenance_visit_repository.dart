import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/date_math.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `maintenance_visits`: bitácora de visitas de mantenimiento.
class MaintenanceVisitRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  /// Visitas del proyecto, de la más reciente a la más antigua.
  Stream<List<MaintenanceVisit>> watchVisits(String projectId) {
    final select = _db.select(_db.maintenanceVisits)
      ..where((v) => v.projectId.equals(projectId) & v.deletedAt.isNull())
      ..orderBy([(v) => OrderingTerm.desc(v.visitDate)]);
    return select.watch();
  }

  /// Busca una visita por `id`.
  Future<MaintenanceVisit?> findVisit(String id) => (_db.select(
    _db.maintenanceVisits,
  )..where((v) => v.id.equals(id))).getSingleOrNull();

  /// Registra una visita. Cada servicio hecho ([doneItemIds]) queda con
  /// `lastDoneAt` = fecha de la visita y su próxima fecha se recorre según
  /// su frecuencia.
  Future<MaintenanceVisit> logVisit({
    required String projectId,
    required DateTime visitDate,
    required List<String> doneItemIds,
    String? technician,
    String? notes,
  }) {
    final day = calendarDayUtc(visitDate);
    return _db.transaction(() async {
      final visit = await _db
          .into(_db.maintenanceVisits)
          .insertReturning(
            MaintenanceVisitsCompanion.insert(
              projectId: projectId,
              visitDate: day,
              technician: Value(_clean(technician)),
              doneItemIds: Value(doneItemIds.join(',')),
              notes: Value(_clean(notes)),
            ),
          );
      for (final id in doneItemIds) {
        final item = await (_db.select(
          _db.maintenancePlanItems,
        )..where((p) => p.id.equals(id))).getSingleOrNull();
        if (item == null) continue;
        await (_db.update(
          _db.maintenancePlanItems,
        )..where((p) => p.id.equals(id))).write(
          MaintenancePlanItemsCompanion(
            lastDoneAt: Value(day),
            nextDueAt: Value(addMonthsUtc(day, item.intervalMonths)),
            updatedAt: Value(utcNow()),
          ),
        );
      }
      return visit;
    });
  }

  /// Cambia fecha, técnico y notas de una visita (no recalcula el plan).
  Future<void> updateVisit(
    String id, {
    required DateTime visitDate,
    String? technician,
    String? notes,
  }) async {
    await (_db.update(
      _db.maintenanceVisits,
    )..where((v) => v.id.equals(id))).write(
      MaintenanceVisitsCompanion(
        visitDate: Value(calendarDayUtc(visitDate)),
        technician: Value(_clean(technician)),
        notes: Value(_clean(notes)),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico de una visita.
  Future<void> softDeleteVisit(String id) async {
    final now = utcNow();
    await (_db.update(
      _db.maintenanceVisits,
    )..where((v) => v.id.equals(id))).write(
      MaintenanceVisitsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }
}

String? _clean(String? text) {
  final trimmed = text?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}
