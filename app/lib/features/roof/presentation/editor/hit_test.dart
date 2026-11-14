import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';

/// Qué hay bajo un toque (en metros locales).
abstract final class RoofHitTest {
  /// Obstáculo que contiene [p] (el último dibujado gana).
  static ObstacleModel? obstacleAt(List<ObstacleModel> list, Vec2 p) {
    for (final o in list.reversed) {
      if (PolygonMetrics.contains(o.footprint, p)) return o;
      if (o.center.distanceTo(p) <= o.widthM / 2 + 0.15) return o;
    }
    return null;
  }

  /// Plano que contiene [p].
  static RoofPlaneModel? planeAt(List<RoofPlaneModel> list, Vec2 p) {
    for (final pl in list.reversed) {
      if (PolygonMetrics.contains(pl.polygon, p)) return pl;
    }
    return null;
  }

  /// Vértice de [plane] a menos de [radiusM] metros de [p].
  static int? vertexAt(RoofPlaneModel plane, Vec2 p, double radiusM) {
    int? best;
    var bestD = radiusM;
    for (final (i, v) in plane.polygon.indexed) {
      final d = v.distanceTo(p);
      if (d <= bestD) {
        bestD = d;
        best = i;
      }
    }
    return best;
  }
}
