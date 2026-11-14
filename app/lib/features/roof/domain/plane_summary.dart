import 'dart:math' as math;

import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';

/// Medidas de un plano para mostrar en pantalla (todo en m y m²).
typedef PlaneSummary = ({
  List<double> sides,
  List<double> angles,
  double horizontalArea,
  double slopedArea,
  double usableArea,
});

/// Calcula las medidas de un plano: lados y ángulos vistos desde arriba,
/// área horizontal, área real inclinada y área útil (después de retiros,
/// pasillos y obstáculos).
/// Ficha: docs/formulas/16-poligonos-del-techo.md y 18-orientacion-de-planos.md
PlaneSummary summarizePlane(
  RoofPlaneModel plane, {
  List<ObstacleModel> obstacles = const [],
}) {
  final pts = plane.polygon;
  final horizontal = PolygonMetrics.area(pts);
  final inner = plane.edgeSetbackM > 0
      ? PolygonOps.inset(pts, plane.edgeSetbackM)
      : pts;
  var usable = inner == null ? 0.0 : PolygonMetrics.area(inner);
  if (inner != null) {
    for (final w in plane.walkways) {
      usable -= _areaInside(w.polygon, inner);
    }
    for (final o in obstacles) {
      usable -= _areaInside(o.footprint, inner);
    }
  }
  final cosT = math.cos(plane.tiltDeg * math.pi / 180);
  return (
    sides: PolygonMetrics.sideLengths(pts),
    angles: PolygonMetrics.interiorAngles(pts),
    horizontalArea: horizontal,
    slopedArea: horizontal / cosT,
    usableArea: math.max(0, usable) / cosT,
  );
}

/// Área aproximada de [shape] que cae dentro de [region]: se muestrea una
/// rejilla de 20 × 20 puntos sobre [shape] (suficiente para restar
/// pasillos y obstáculos del área útil).
double _areaInside(List<Vec2> shape, List<Vec2> region) {
  if (shape.length < 3) return 0;
  var minX = double.infinity;
  var minY = double.infinity;
  var maxX = double.negativeInfinity;
  var maxY = double.negativeInfinity;
  for (final p in shape) {
    minX = math.min(minX, p.x);
    minY = math.min(minY, p.y);
    maxX = math.max(maxX, p.x);
    maxY = math.max(maxY, p.y);
  }
  const n = 20;
  final dx = (maxX - minX) / n;
  final dy = (maxY - minY) / n;
  var hits = 0;
  for (var i = 0; i < n; i++) {
    for (var j = 0; j < n; j++) {
      final p = Vec2(minX + (i + 0.5) * dx, minY + (j + 0.5) * dy);
      if (PolygonMetrics.contains(shape, p) &&
          PolygonMetrics.contains(region, p)) {
        hits++;
      }
    }
  }
  return hits * dx * dy;
}
