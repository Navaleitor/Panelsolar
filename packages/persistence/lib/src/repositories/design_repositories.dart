import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `pv_designs`: un diseño por proyecto.
class PvDesignRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  SimpleSelectStatement<$PvDesignsTable, PvDesign> _of(String projectId) =>
      _db.select(_db.pvDesigns)
        ..where((t) => t.projectId.equals(projectId) & t.deletedAt.isNull());

  /// Diseño del proyecto (nulo si aún no hay).
  Stream<PvDesign?> watchForProject(String projectId) =>
      _of(projectId).watchSingleOrNull();

  /// Lee el diseño del proyecto.
  Future<PvDesign?> getForProject(String projectId) =>
      _of(projectId).getSingleOrNull();

  /// Crea el diseño si falta y aplica [changes].
  Future<PvDesign> save(String projectId, PvDesignsCompanion changes) async {
    if (changes.inverterCount.present && changes.inverterCount.value < 1) {
      throw ArgumentError.value(changes.inverterCount.value, 'inverterCount');
    }
    final current = await getForProject(projectId);
    if (current == null) {
      return await _db
          .into(_db.pvDesigns)
          .insertReturning(changes.copyWith(projectId: Value(projectId)));
    }
    await (_db.update(_db.pvDesigns)..where((t) => t.id.equals(current.id)))
        .write(changes.copyWith(updatedAt: Value(utcNow())));
    return (await getForProject(projectId))!;
  }
}

/// Acceso a `array_layouts`: paneles de cada plano.
class ArrayLayoutRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  SimpleSelectStatement<$ArrayLayoutsTable, ArrayLayout> _of(String id) =>
      _db.select(_db.arrayLayouts)
        ..where((t) => t.projectId.equals(id) & t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);

  /// Arreglos del proyecto.
  Stream<List<ArrayLayout>> watchByProject(String projectId) =>
      _of(projectId).watch();

  /// Lee los arreglos del proyecto.
  Future<List<ArrayLayout>> listByProject(String projectId) =>
      _of(projectId).get();

  /// Guarda el arreglo de un plano (uno por plano).
  Future<ArrayLayout> saveForPlane(
    String projectId,
    String planeId,
    ArrayLayoutsCompanion changes,
  ) async {
    final current =
        await (_db.select(_db.arrayLayouts)..where(
              (t) =>
                  t.projectId.equals(projectId) &
                  t.roofPlaneId.equals(planeId) &
                  t.deletedAt.isNull(),
            ))
            .getSingleOrNull();
    if (current == null) {
      return await _db
          .into(_db.arrayLayouts)
          .insertReturning(
            changes.copyWith(
              projectId: Value(projectId),
              roofPlaneId: Value(planeId),
            ),
          );
    }
    await (_db.update(_db.arrayLayouts)..where((t) => t.id.equals(current.id)))
        .write(changes.copyWith(updatedAt: Value(utcNow())));
    return await (_db.select(
      _db.arrayLayouts,
    )..where((t) => t.id.equals(current.id))).getSingle();
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) =>
      (_db.update(_db.arrayLayouts)..where((t) => t.id.equals(id))).write(
        ArrayLayoutsCompanion(
          deletedAt: Value(utcNow()),
          updatedAt: Value(utcNow()),
        ),
      );
}

/// Acceso a `string_configs`.
class StringConfigRepository {
  /// Crea el repositorio.
  new(this._db);

  final AppDatabase _db;

  /// Grupos de strings del proyecto en orden.
  Stream<List<StringConfig>> watchByProject(String projectId) =>
      (_db.select(_db.stringConfigs)
            ..where((t) => t.projectId.equals(projectId) & t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .watch();

  /// Sustituye todos los grupos del proyecto (los anteriores se borran
  /// lógicamente).
  Future<void> replaceAll(
    String projectId,
    List<StringConfigsCompanion> groups,
  ) => _db.transaction(() async {
    final now = utcNow();
    await (_db.update(_db.stringConfigs)
          ..where((t) => t.projectId.equals(projectId) & t.deletedAt.isNull()))
        .write(
          StringConfigsCompanion(deletedAt: Value(now), updatedAt: Value(now)),
        );
    for (final (i, g) in groups.indexed) {
      if (g.series.value < 1 || (g.parallel.present && g.parallel.value < 1)) {
        throw ArgumentError('Serie y paralelo deben ser ≥ 1');
      }
      await _db
          .into(_db.stringConfigs)
          .insert(g.copyWith(projectId: Value(projectId), sortOrder: Value(i)));
    }
  });
}
