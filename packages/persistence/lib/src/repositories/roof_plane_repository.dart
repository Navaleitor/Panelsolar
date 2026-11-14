import 'package:drift/drift.dart';
import 'package:persistence/src/database/app_database.dart';
import 'package:persistence/src/model/enums.dart';
import 'package:persistence/src/repositories/clock.dart';

/// Acceso a `roof_planes`: planos (aguas) del techo de un proyecto.
class RoofPlaneRepository {
  /// Crea el repositorio sobre una [AppDatabase] abierta.
  new(this._db);

  final AppDatabase _db;

  SimpleSelectStatement<$RoofPlanesTable, RoofPlane> _active(String id) =>
      _db.select(_db.roofPlanes)
        ..where((p) => p.projectId.equals(id) & p.deletedAt.isNull())
        ..orderBy([
          (p) => OrderingTerm.asc(p.sortOrder),
          (p) => OrderingTerm.asc(p.createdAt),
        ]);

  /// Planos activos del proyecto en orden.
  Stream<List<RoofPlane>> watchByProject(String projectId) =>
      _active(projectId).watch();

  /// Lee los planos activos del proyecto.
  Future<List<RoofPlane>> listByProject(String projectId) =>
      _active(projectId).get();

  /// Agrega un plano. [polygon] es JSON `[[x,y],...]` en metros.
  Future<RoofPlane> add({
    required String projectId,
    required String name,
    required String polygon,
    double tiltDeg = 0,
    TiltSource tiltSource = TiltSource.manual,
    double azimuthDeg = 180,
    int? azimuthEdgeIndex,
  }) async {
    _checkTilt(tiltDeg);
    final count = (await listByProject(projectId)).length;
    return await _db
        .into(_db.roofPlanes)
        .insertReturning(
          RoofPlanesCompanion.insert(
            projectId: projectId,
            name: name.trim(),
            polygon: polygon,
            tiltDeg: Value(tiltDeg),
            tiltSource: Value(tiltSource),
            azimuthDeg: Value(azimuthDeg),
            azimuthEdgeIndex: Value(azimuthEdgeIndex),
            sortOrder: Value(count),
          ),
        );
  }

  /// Guarda los cambios de [plane] (renueva `updatedAt`).
  Future<void> update(RoofPlane plane) async {
    _checkTilt(plane.tiltDeg);
    if (plane.edgeSetbackM < 0) {
      throw ArgumentError.value(plane.edgeSetbackM, 'edgeSetbackM', '≥ 0');
    }
    await (_db.update(_db.roofPlanes)..where((p) => p.id.equals(plane.id)))
        .write(plane.toCompanion(false).copyWith(updatedAt: Value(utcNow())));
  }

  /// Borrado lógico.
  Future<void> softDelete(String id) async {
    final now = utcNow();
    await (_db.update(_db.roofPlanes)..where((p) => p.id.equals(id))).write(
      RoofPlanesCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  static void _checkTilt(double tilt) {
    if (tilt.isNaN || tilt < 0 || tilt >= 90) {
      throw ArgumentError.value(tilt, 'tiltDeg', 'debe estar en [0, 90)');
    }
  }
}
