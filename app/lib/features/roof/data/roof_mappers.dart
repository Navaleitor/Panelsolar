import 'package:drift/drift.dart' show Value;
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/roof_codec.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:persistence/persistence.dart';

/// Filas de la base (`packages/persistence`) ↔ modelos del dominio.
abstract final class RoofMappers {
  /// Fila → plano.
  static RoofPlaneModel plane(RoofPlane r) => RoofPlaneModel(
    id: r.id,
    name: r.name,
    polygon: RoofCodec.decodePolygon(r.polygon),
    tiltDeg: r.tiltDeg,
    tiltSource: r.tiltSource,
    azimuthDeg: r.azimuthDeg,
    azimuthEdgeIndex: r.azimuthEdgeIndex,
    edgeSetbackM: r.edgeSetbackM,
    walkways: RoofCodec.decodeWalkways(r.walkways),
  );

  /// Copia [r] con los datos de [m].
  static RoofPlane planeRow(RoofPlane r, RoofPlaneModel m) => r.copyWith(
    name: m.name,
    polygon: RoofCodec.encodePolygon(m.polygon),
    tiltDeg: m.tiltDeg,
    tiltSource: m.tiltSource,
    azimuthDeg: m.azimuthDeg,
    azimuthEdgeIndex: Value(m.azimuthEdgeIndex),
    edgeSetbackM: m.edgeSetbackM,
    walkways: RoofCodec.encodeWalkways(m.walkways),
  );

  /// Fila → obstáculo.
  static ObstacleModel obstacle(Obstacle r) => ObstacleModel(
    id: r.id,
    type: ObstacleType.values.byName(r.kind.name),
    shape: ObstacleShape.values.byName(r.outline.name),
    center: Vec2(r.centerX, r.centerY),
    widthM: r.widthM,
    depthM: r.depthM,
    rotationDeg: r.rotationDeg,
    points: RoofCodec.decodePolygon(r.points),
    heightM: r.heightM,
    heightSource: r.heightSource,
    tankLiters: r.tankLiters,
  );

  /// Copia [r] con los datos de [m].
  static Obstacle obstacleRow(Obstacle r, ObstacleModel m) => r.copyWith(
    kind: kindOf(m.type),
    outline: outlineOf(m.shape),
    centerX: m.center.x,
    centerY: m.center.y,
    widthM: m.widthM,
    depthM: Value(m.depthM),
    rotationDeg: m.rotationDeg,
    points: Value(m.points.isEmpty ? null : RoofCodec.encodePolygon(m.points)),
    heightM: m.heightM,
    heightSource: m.heightSource,
    tankLiters: Value(m.tankLiters),
  );

  /// Tipo de geo_kit → enumeración guardada.
  static ObstacleKind kindOf(ObstacleType t) =>
      ObstacleKind.values.byName(t.name);

  /// Forma de geo_kit → enumeración guardada.
  static ObstacleOutline outlineOf(ObstacleShape s) =>
      ObstacleOutline.values.byName(s.name);

  /// Fila → obstáculo lejano.
  static FarObstacle far(HorizonProfileRecord r) => FarObstacle(
    id: r.id,
    name: r.name ?? '',
    points: RoofCodec.decodeHorizon(r.points),
  );
}
