import 'dart:math' as math;

import 'package:geo_kit/src/geometry/vec2.dart';

/// Medidas de un polígono simple (lados, área, ángulos).
///
/// Los vértices van en orden (horario o antihorario) y el último se une con
/// el primero. Unidades: las de los puntos (metros en coordenadas locales).
/// Ficha: docs/formulas/16-poligonos-del-techo.md
abstract final class PolygonMetrics {
  /// Longitud de cada lado: el lado `i` va del vértice `i` al `i + 1`.
  static List<double> sideLengths(List<Vec2> pts) => [
    for (var i = 0; i < pts.length; i++)
      pts[i].distanceTo(pts[(i + 1) % pts.length]),
  ];

  /// Perímetro.
  static double perimeter(List<Vec2> pts) =>
      sideLengths(pts).fold(0, (a, b) => a + b);

  /// Área con signo (fórmula del agrimensor / *shoelace*): positiva si los
  /// vértices van en sentido antihorario (con y hacia arriba).
  static double signedArea(List<Vec2> pts) {
    if (pts.length < 3) return 0;
    var sum = 0.0;
    for (var i = 0; i < pts.length; i++) {
      sum += pts[i].cross(pts[(i + 1) % pts.length]);
    }
    return sum / 2;
  }

  /// Área (siempre positiva).
  static double area(List<Vec2> pts) => signedArea(pts).abs();

  /// Ángulo interior en cada vértice, en grados (0–360). Funciona con
  /// polígonos cóncavos: un ángulo > 180° indica una esquina "hacia
  /// adentro".
  static List<double> interiorAngles(List<Vec2> pts) {
    final n = pts.length;
    if (n < 3) return const [];
    final ccw = signedArea(pts) >= 0;
    return [
      for (var i = 0; i < n; i++)
        _interior(pts[(i - 1 + n) % n], pts[i], pts[(i + 1) % n], ccw),
    ];
  }

  static double _interior(Vec2 prev, Vec2 at, Vec2 next, bool ccw) {
    final a = prev - at;
    final b = next - at;
    // Ángulo de b hacia a, medido en el sentido que deja el interior dentro.
    var ang = math.atan2(a.cross(b), a.dot(b)) * 180 / math.pi;
    if (ccw) ang = -ang;
    if (ang < 0) ang += 360;
    return ang;
  }

  /// Centroide del área (si el área es cero, el promedio de los vértices).
  static Vec2 centroid(List<Vec2> pts) {
    final a = signedArea(pts);
    if (a.abs() < 1e-12) {
      var sx = 0.0;
      var sy = 0.0;
      for (final p in pts) {
        sx += p.x;
        sy += p.y;
      }
      return pts.isEmpty ? Vec2.zero : Vec2(sx / pts.length, sy / pts.length);
    }
    var cx = 0.0;
    var cy = 0.0;
    for (var i = 0; i < pts.length; i++) {
      final p = pts[i];
      final q = pts[(i + 1) % pts.length];
      final c = p.cross(q);
      cx += (p.x + q.x) * c;
      cy += (p.y + q.y) * c;
    }
    return Vec2(cx / (6 * a), cy / (6 * a));
  }

  /// `true` si [p] está dentro del polígono (regla par-impar).
  static bool contains(List<Vec2> pts, Vec2 p) {
    var inside = false;
    for (var i = 0, j = pts.length - 1; i < pts.length; j = i++) {
      final a = pts[i];
      final b = pts[j];
      if ((a.y > p.y) != (b.y > p.y) &&
          p.x < (b.x - a.x) * (p.y - a.y) / (b.y - a.y) + a.x) {
        inside = !inside;
      }
    }
    return inside;
  }

  /// `true` si ningún par de lados no vecinos se cruza (polígono simple).
  static bool isSimple(List<Vec2> pts) {
    final n = pts.length;
    if (n < 3) return false;
    for (var i = 0; i < n; i++) {
      for (var j = i + 1; j < n; j++) {
        if (j == i + 1 || (i == 0 && j == n - 1)) continue;
        if (segmentsIntersect(
          pts[i],
          pts[(i + 1) % n],
          pts[j],
          pts[(j + 1) % n],
        )) {
          return false;
        }
      }
    }
    return true;
  }

  /// `true` si los segmentos [a1]–[a2] y [b1]–[b2] se tocan o cruzan.
  static bool segmentsIntersect(Vec2 a1, Vec2 a2, Vec2 b1, Vec2 b2) {
    final d1 = (a2 - a1).cross(b1 - a1);
    final d2 = (a2 - a1).cross(b2 - a1);
    final d3 = (b2 - b1).cross(a1 - b1);
    final d4 = (b2 - b1).cross(a2 - b1);
    if (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
        ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))) {
      return true;
    }
    bool on(Vec2 p, Vec2 q, Vec2 r, double d) =>
        d == 0 &&
        math.min(p.x, q.x) <= r.x &&
        r.x <= math.max(p.x, q.x) &&
        math.min(p.y, q.y) <= r.y &&
        r.y <= math.max(p.y, q.y);
    return on(a1, a2, b1, d1) ||
        on(a1, a2, b2, d2) ||
        on(b1, b2, a1, d3) ||
        on(b1, b2, a2, d4);
  }
}
