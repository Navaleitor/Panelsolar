import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/data/roof_mappers.dart';
import 'package:panelsolar/features/roof/domain/reframe.dart';
import 'package:panelsolar/features/roof/domain/roof_codec.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/domain/roof_space.dart';
import 'package:persistence/persistence.dart';

/// Operaciones del editor del techo sobre la base. Todo se guarda en
/// metros locales; al recalibrar o reorientar, lo dibujado se mueve con
/// la imagen ([Reframe]).
class RoofEditingService {
  /// Crea el servicio.
  const new({
    required this.images,
    required this.planes,
    required this.obstacles,
    required this.horizons,
  });

  /// Base del techo.
  final RoofImageRepository images;

  /// Planos.
  final RoofPlaneRepository planes;

  /// Obstáculos.
  final ObstacleRepository obstacles;

  /// Horizontes.
  final HorizonProfileRepository horizons;

  /// Guarda la calibración. Devuelve la escala (m/px).
  Future<double> saveCalibration({
    required String projectId,
    required MeasuredLine line,
    MeasuredLine? verification,
  }) async {
    final mpp = ScaleCalibration.metersPerPixel(line);
    final before = RoofSpace.fromRecord(await images.getForProject(projectId));
    await images.saveCalibration(
      projectId: projectId,
      metersPerPixel: mpp,
      calibrationLine: RoofCodec.encodeLine(line),
      verificationLine: verification == null
          ? null
          : RoofCodec.encodeLine(verification),
    );
    final after = RoofSpace.fromRecord(await images.getForProject(projectId));
    await _reframe(projectId, before.frame, after.frame);
    return mpp;
  }

  /// Guarda la orientación al norte.
  Future<void> saveNorth({
    required String projectId,
    required double northAngleDeg,
    required NorthSource source,
    double? declinationDeg,
  }) async {
    var record = await images.getForProject(projectId);
    record ??= await images.startSketch(projectId);
    final before = RoofSpace.fromRecord(record);
    await images.saveNorth(
      projectId: projectId,
      northAngleDeg: northAngleDeg,
      source: source,
      magneticDeclinationDeg: declinationDeg,
    );
    final after = RoofSpace.fromRecord(await images.getForProject(projectId));
    await _reframe(projectId, before.frame, after.frame);
  }

  Future<void> _reframe(
    String projectId,
    ImageFrame? from,
    ImageFrame? to,
  ) async {
    if (from == null || to == null) return;
    if (from.metersPerPixel == to.metersPerPixel &&
        from.northAngleDeg == to.northAngleDeg) {
      return;
    }
    for (final row in await planes.listByProject(projectId)) {
      final m = Reframe.plane(RoofMappers.plane(row), from, to);
      await planes.update(RoofMappers.planeRow(row, m));
    }
    for (final row in await obstacles.listByProject(projectId)) {
      final m = Reframe.obstacle(RoofMappers.obstacle(row), from, to);
      await obstacles.update(RoofMappers.obstacleRow(row, m));
    }
  }

  /// Agrega un plano con nombre automático ("Plano N") y azimut desde la
  /// arista que mira más al ecuador (el usuario la puede cambiar).
  Future<RoofPlane> addPlane({
    required String projectId,
    required List<Vec2> polygon,
    required String Function(int n) nameFor,
    bool southernHemisphere = false,
  }) async {
    final n = (await planes.listByProject(projectId)).length + 1;
    final edge = equatorFacingEdge(polygon, southern: southernHemisphere);
    return await planes.add(
      projectId: projectId,
      name: nameFor(n),
      polygon: RoofCodec.encodePolygon(polygon),
      azimuthDeg: PlaneOrientation.azimuthFromEdge(polygon, edge),
      azimuthEdgeIndex: edge,
    );
  }

  /// Arista cuya normal hacia afuera mira más al ecuador (sur en el
  /// hemisferio norte): punto de partida razonable para el alero.
  static int equatorFacingEdge(List<Vec2> polygon, {bool southern = false}) {
    final target = southern ? 0.0 : 180.0;
    var best = 0;
    var bestDiff = double.infinity;
    for (var i = 0; i < polygon.length; i++) {
      final az = PlaneOrientation.azimuthFromEdge(polygon, i);
      var d = (az - target).abs() % 360;
      if (d > 180) d = 360 - d;
      if (d < bestDiff - 1e-9) {
        bestDiff = d;
        best = i;
      }
    }
    return best;
  }

  /// Guarda los cambios de un plano.
  Future<void> updatePlane(String projectId, RoofPlaneModel m) async {
    final row = (await planes.listByProject(projectId))
        .firstWhere((r) => r.id == m.id);
    await planes.update(RoofMappers.planeRow(row, m));
  }

  /// Divide un plano por la diagonal entre los vértices [i] y [j]. La
  /// primera parte se queda con el plano; la segunda es un plano nuevo con
  /// la misma inclinación. Devuelve `false` si la diagonal no es válida.
  Future<bool> splitPlane({
    required String projectId,
    required RoofPlaneModel plane,
    required int i,
    required int j,
    required String newName,
  }) async {
    final parts = PolygonOps.splitByDiagonal(plane.polygon, i, j);
    if (parts == null) return false;
    await updatePlane(projectId, _withPolygon(plane, parts.$1, plane.name));
    final created = await planes.add(
      projectId: projectId,
      name: newName,
      polygon: RoofCodec.encodePolygon(parts.$2),
      tiltDeg: plane.tiltDeg,
      tiltSource: plane.tiltSource,
      azimuthDeg: plane.azimuthDeg,
    );
    await planes.update(created.copyWith(edgeSetbackM: plane.edgeSetbackM));
    return true;
  }

  RoofPlaneModel _withPolygon(RoofPlaneModel p, List<Vec2> poly, String name) =>
      RoofPlaneModel(
        id: p.id,
        name: name,
        polygon: poly,
        tiltDeg: p.tiltDeg,
        tiltSource: p.tiltSource,
        azimuthDeg: p.azimuthDeg,
        edgeSetbackM: p.edgeSetbackM,
        walkways: p.walkways,
      );

  /// Agrega un obstáculo.
  Future<Obstacle> addObstacle(String projectId, ObstacleModel m) =>
      obstacles.add(
        projectId: projectId,
        kind: RoofMappers.kindOf(m.type),
        outline: RoofMappers.outlineOf(m.shape),
        centerX: m.center.x,
        centerY: m.center.y,
        widthM: m.widthM,
        depthM: m.depthM,
        rotationDeg: m.rotationDeg,
        points: m.points.isEmpty ? null : RoofCodec.encodePolygon(m.points),
        heightM: m.heightM,
        heightSource: m.heightSource,
        tankLiters: m.tankLiters,
      );

  /// Guarda los cambios de un obstáculo.
  Future<void> updateObstacle(String projectId, ObstacleModel m) async {
    final row = (await obstacles.listByProject(projectId))
        .firstWhere((r) => r.id == m.id);
    await obstacles.update(RoofMappers.obstacleRow(row, m));
  }

  /// Guarda el horizonte del terreno.
  Future<void> saveTerrain(String projectId, List<HorizonPoint> points) =>
      horizons.saveTerrain(
        projectId: projectId,
        points: RoofCodec.encodeHorizon(points),
      );

  /// Agrega un obstáculo lejano.
  Future<void> addFarObstacle(
    String projectId,
    String name,
    List<HorizonPoint> points,
  ) => horizons.addManual(
    projectId: projectId,
    name: name,
    points: RoofCodec.encodeHorizon(points),
  );
}
