import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `obstacles`: tinacos, antenas, pretiles, árboles... de un
/// proyecto.
class ObstacleRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  SimpleSelectStatement<$ObstaclesTable, Obstacle> _active(String id) =>
      _db.select(_db.obstacles)
        ..where((o) => o.projectId.equals(id) & o.deletedAt.isNull())
        ..orderBy([(o) => OrderingTerm.asc(o.createdAt)]);

  /// Obstáculos activos del proyecto (del más viejo al más nuevo).
  Stream<List<Obstacle>> watchByProject(String projectId) =>
      _active(projectId).watch();

  /// Lee los obstáculos activos.
  Future<List<Obstacle>> listByProject(String projectId) =>
      _active(projectId).get();

  /// Agrega un obstáculo (medidas en metros, coordenadas locales).
  Future<Obstacle> add({
    required String projectId,
    required ObstacleKind kind,
    required ObstacleOutline outline,
    required double widthM,
    required double heightM,
    required HeightSource heightSource,
    double centerX = 0,
    double centerY = 0,
    double? depthM,
    double rotationDeg = 0,
    String? points,
    int? tankLiters,
    String? label,
  }) {
    _check(widthM, heightM);
    return _db
        .into(_db.obstacles)
        .insertReturning(
          ObstaclesCompanion.insert(
            projectId: projectId,
            kind: kind,
            outline: outline,
            widthM: widthM,
            heightM: heightM,
            heightSource: heightSource,
            centerX: Value(centerX),
            centerY: Value(centerY),
            depthM: Value(depthM),
            rotationDeg: Value(rotationDeg),
            points: Value(points),
            tankLiters: Value(tankLiters),
            label: Value(label),
          ),
        );
  }

  /// Guarda los cambios de [obstacle].
  Future<void> update(Obstacle obstacle) async {
    _check(obstacle.widthM, obstacle.heightM);
    await (_db.update(
      _db.obstacles,
    )..where((o) => o.id.equals(obstacle.id))).write(
      obstacle.toCompanion(false).copyWith(updatedAt: Value(utcNow())),
    );
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await (_db.update(_db.obstacles)..where((o) => o.id.equals(id))).write(
      ObstaclesCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  static void _check(double width, double height) {
    if (!(width > 0)) throw ArgumentError.value(width, 'widthM', '> 0');
    if (height.isNaN || height < 0) {
      throw ArgumentError.value(height, 'heightM', '≥ 0');
    }
  }
}
