import 'package:geo_kit/src/geometry/polygon_metrics.dart';
import 'package:geo_kit/src/geometry/vec2.dart';

/// Pruebas de geometría para el empaquetado de paneles.
abstract final class RegionTests {
  /// `true` si el polígono convexo [rect] queda completo dentro de [region]
  /// (sus esquinas dentro y ninguna orilla de [region] lo cruza).
  static bool insideRegion(List<Vec2> rect, List<Vec2> region) {
    for (final c in rect) {
      if (!PolygonMetrics.contains(region, c)) return false;
    }
    return !_edgesCross(rect, region);
  }

  /// `true` si los polígonos [a] y [b] se tocan o se enciman.
  static bool overlaps(List<Vec2> a, List<Vec2> b) {
    if (!_boxesTouch(a, b)) return false;
    if (_edgesCross(a, b)) return true;
    if (a.isNotEmpty && PolygonMetrics.contains(b, a.first)) return true;
    if (b.isNotEmpty && PolygonMetrics.contains(a, b.first)) return true;
    // Centro de a dentro de b (caso de huellas pequeñas).
    return PolygonMetrics.contains(b, PolygonMetrics.centroid(a));
  }

  static bool _edgesCross(List<Vec2> a, List<Vec2> b) {
    for (var i = 0; i < a.length; i++) {
      final a1 = a[i];
      final a2 = a[(i + 1) % a.length];
      for (var j = 0; j < b.length; j++) {
        if (PolygonMetrics.segmentsIntersect(
          a1,
          a2,
          b[j],
          b[(j + 1) % b.length],
        )) {
          return true;
        }
      }
    }
    return false;
  }

  static bool _boxesTouch(List<Vec2> a, List<Vec2> b) {
    final (ax0, ay0, ax1, ay1) = bounds(a);
    final (bx0, by0, bx1, by1) = bounds(b);
    return !(ax1 < bx0 || bx1 < ax0 || ay1 < by0 || by1 < ay0);
  }

  /// Rectángulo que contiene a [pts]: (minX, minY, maxX, maxY).
  static (double, double, double, double) bounds(List<Vec2> pts) {
    var x0 = double.infinity;
    var y0 = double.infinity;
    var x1 = double.negativeInfinity;
    var y1 = double.negativeInfinity;
    for (final p in pts) {
      if (p.x < x0) x0 = p.x;
      if (p.y < y0) y0 = p.y;
      if (p.x > x1) x1 = p.x;
      if (p.y > y1) y1 = p.y;
    }
    return (x0, y0, x1, y1);
  }
}
