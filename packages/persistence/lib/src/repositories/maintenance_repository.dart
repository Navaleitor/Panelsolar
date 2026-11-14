import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/date_math.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Servicio de plantilla o de plan: tipo, nombre opcional y frecuencia.
typedef ServiceInput = ({
  MaintenanceServiceKind kind,
  String? title,
  int intervalMonths,
});

/// Próxima visita de un proyecto, con nombres para el calendario.
typedef UpcomingService = ({
  MaintenancePlanItem item,
  String projectName,
  String clientName,
});

/// Acceso a la plantilla, el plan por proyecto y el calendario de
/// mantenimiento. La bitácora está en `MaintenanceVisitRepository`.
class MaintenanceRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  // --- Plantilla -----------------------------------------------------------

  /// Servicios de la plantilla, en orden.
  Stream<List<MaintenanceTemplateItem>> watchTemplate() {
    final select = _db.select(_db.maintenanceTemplateItems)
      ..where((t) => t.deletedAt.isNull())
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    return select.watch();
  }

  /// Si la plantilla nunca se ha llenado, la llena con [defaults]; los
  /// tipos en [disabled] quedan desactivados (servicios opcionales).
  Future<void> seedTemplateIfEmpty(
    List<ServiceInput> defaults, {
    Set<MaintenanceServiceKind> disabled = const {},
  }) async {
    await _db.transaction(() async {
      final any = await (_db.select(
        _db.maintenanceTemplateItems,
      )..limit(1)).getSingleOrNull();
      if (any != null) return;
      for (final (i, s) in defaults.indexed) {
        await _db
            .into(_db.maintenanceTemplateItems)
            .insert(
              MaintenanceTemplateItemsCompanion.insert(
                kind: s.kind,
                title: Value(_clean(s.title)),
                intervalMonths: _interval(s.intervalMonths),
                sortOrder: Value(i),
                enabled: Value(!disabled.contains(s.kind)),
              ),
            );
      }
    });
  }

  /// Agrega un servicio a la plantilla.
  Future<void> addTemplateItem(ServiceInput s) async {
    final count = await _db.select(_db.maintenanceTemplateItems).get();
    await _db
        .into(_db.maintenanceTemplateItems)
        .insert(
          MaintenanceTemplateItemsCompanion.insert(
            kind: s.kind,
            title: Value(_clean(s.title)),
            intervalMonths: _interval(s.intervalMonths),
            sortOrder: Value(count.length),
          ),
        );
  }

  /// Cambia un servicio de la plantilla.
  Future<void> updateTemplateItem(
    String id,
    ServiceInput s, {
    required bool enabled,
  }) async {
    await (_db.update(
      _db.maintenanceTemplateItems,
    )..where((t) => t.id.equals(id))).write(
      MaintenanceTemplateItemsCompanion(
        kind: Value(s.kind),
        title: Value(_clean(s.title)),
        intervalMonths: Value(_interval(s.intervalMonths)),
        enabled: Value(enabled),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico de un servicio de la plantilla.
  Future<void> softDeleteTemplateItem(String id) async {
    final now = utcNow();
    await (_db.update(
      _db.maintenanceTemplateItems,
    )..where((t) => t.id.equals(id))).write(
      MaintenanceTemplateItemsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  // --- Plan por proyecto ---------------------------------------------------

  /// Servicios del plan del proyecto, en orden.
  Stream<List<MaintenancePlanItem>> watchPlan(String projectId) {
    final select = _db.select(_db.maintenancePlanItems)
      ..where((p) => p.projectId.equals(projectId) & p.deletedAt.isNull())
      ..orderBy([(p) => OrderingTerm.asc(p.sortOrder)]);
    return select.watch();
  }

  /// Crea el plan del proyecto copiando los servicios activos de la
  /// plantilla. La primera visita de cada uno es [start] + su frecuencia.
  Future<int> createPlanFromTemplate(String projectId, DateTime start) {
    final day = calendarDayUtc(start);
    return _db.transaction(() async {
      final template =
          await (_db.select(_db.maintenanceTemplateItems)
                ..where((t) => t.deletedAt.isNull() & t.enabled.equals(true))
                ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
              .get();
      final existing = await (_db.select(
        _db.maintenancePlanItems,
      )..where((p) => p.projectId.equals(projectId))).get();
      for (final (i, t) in template.indexed) {
        await _db
            .into(_db.maintenancePlanItems)
            .insert(
              MaintenancePlanItemsCompanion.insert(
                projectId: projectId,
                kind: t.kind,
                title: Value(t.title),
                intervalMonths: t.intervalMonths,
                nextDueAt: addMonthsUtc(day, t.intervalMonths),
                sortOrder: Value(existing.length + i),
              ),
            );
      }
      return template.length;
    });
  }

  /// Agrega un servicio al plan del proyecto con su próxima fecha.
  Future<void> addPlanItem(
    String projectId,
    ServiceInput s, {
    required DateTime nextDueAt,
  }) async {
    final count = await (_db.select(
      _db.maintenancePlanItems,
    )..where((p) => p.projectId.equals(projectId))).get();
    await _db
        .into(_db.maintenancePlanItems)
        .insert(
          MaintenancePlanItemsCompanion.insert(
            projectId: projectId,
            kind: s.kind,
            title: Value(_clean(s.title)),
            intervalMonths: _interval(s.intervalMonths),
            nextDueAt: calendarDayUtc(nextDueAt),
            sortOrder: Value(count.length),
          ),
        );
  }

  /// Cambia un servicio del plan (frecuencia y próxima fecha).
  Future<void> updatePlanItem(
    String id,
    ServiceInput s, {
    required DateTime nextDueAt,
  }) async {
    await (_db.update(
      _db.maintenancePlanItems,
    )..where((p) => p.id.equals(id))).write(
      MaintenancePlanItemsCompanion(
        kind: Value(s.kind),
        title: Value(_clean(s.title)),
        intervalMonths: Value(_interval(s.intervalMonths)),
        nextDueAt: Value(calendarDayUtc(nextDueAt)),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico de un servicio del plan.
  Future<void> softDeletePlanItem(String id) async {
    final now = utcNow();
    await (_db.update(
      _db.maintenancePlanItems,
    )..where((p) => p.id.equals(id))).write(
      MaintenancePlanItemsCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  /// Calendario: servicios de proyectos activos ordenados por fecha.
  Stream<List<UpcomingService>> watchUpcoming() {
    final query =
        _db.select(_db.maintenancePlanItems).join([
            innerJoin(
              _db.projects,
              _db.projects.id.equalsExp(_db.maintenancePlanItems.projectId),
            ),
            innerJoin(
              _db.clients,
              _db.clients.id.equalsExp(_db.projects.clientId),
            ),
          ])
          ..where(
            _db.maintenancePlanItems.deletedAt.isNull() &
                _db.projects.deletedAt.isNull() &
                _db.clients.deletedAt.isNull(),
          )
          ..orderBy([OrderingTerm.asc(_db.maintenancePlanItems.nextDueAt)]);
    return query.watch().map(
      (rows) => [
        for (final r in rows)
          (
            item: r.readTable(_db.maintenancePlanItems),
            projectName: r.readTable(_db.projects).name,
            clientName: r.readTable(_db.clients).name,
          ),
      ],
    );
  }

  static int _interval(int months) {
    if (months < 1 || months > 120) {
      throw ArgumentError.value(months, 'intervalMonths', 'entre 1 y 120');
    }
    return months;
  }
}

String? _clean(String? text) {
  final trimmed = text?.trim();
  return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
}
