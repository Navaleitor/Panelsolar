import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `horizon_profiles`: horizonte del terreno (uno por proyecto) y
/// obstáculos lejanos medidos en sitio.
class HorizonProfileRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  SimpleSelectStatement<$HorizonProfilesTable, HorizonProfileRecord> _active(
    String id,
  ) => _db.select(_db.horizonProfiles)
    ..where((h) => h.projectId.equals(id) & h.deletedAt.isNull())
    ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]);

  /// Perfiles activos del proyecto.
  Stream<List<HorizonProfileRecord>> watchByProject(String projectId) =>
      _active(projectId).watch();

  /// Lee los perfiles activos del proyecto.
  Future<List<HorizonProfileRecord>> listByProject(String projectId) =>
      _active(projectId).get();

  /// Guarda (crea o reemplaza) el horizonte del terreno. [points] es JSON
  /// `[[azimut, elevación], ...]`.
  Future<HorizonProfileRecord> saveTerrain({
    required String projectId,
    required String points,
  }) => _db.transaction(() async {
    final existing =
        await (_db.select(_db.horizonProfiles)..where(
              (h) =>
                  h.projectId.equals(projectId) &
                  h.source.equalsValue(HorizonSource.terrain),
            ))
            .get();
    if (existing.isEmpty) {
      return await _db
          .into(_db.horizonProfiles)
          .insertReturning(
            HorizonProfilesCompanion.insert(
              projectId: projectId,
              source: HorizonSource.terrain,
              points: points,
            ),
          );
    }
    final updated =
        await (_db.update(
          _db.horizonProfiles,
        )..where((h) => h.id.equals(existing.first.id))).writeReturning(
          HorizonProfilesCompanion(
            points: Value(points),
            updatedAt: Value(utcNow()),
            deletedAt: const Value(null),
          ),
        );
    return updated.single;
  });

  /// Agrega un obstáculo lejano medido con brújula e inclinómetro.
  Future<HorizonProfileRecord> addManual({
    required String projectId,
    required String name,
    required String points,
  }) => _db
      .into(_db.horizonProfiles)
      .insertReturning(
        HorizonProfilesCompanion.insert(
          projectId: projectId,
          source: HorizonSource.manual,
          name: Value(name.trim()),
          points: points,
        ),
      );

  /// Reemplaza los puntos de un perfil.
  Future<void> updatePoints(String id, String points) async {
    await (_db.update(
      _db.horizonProfiles,
    )..where((h) => h.id.equals(id))).write(
      HorizonProfilesCompanion(
        points: Value(points),
        updatedAt: Value(utcNow()),
      ),
    );
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await (_db.update(
      _db.horizonProfiles,
    )..where((h) => h.id.equals(id))).write(
      HorizonProfilesCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }
}
