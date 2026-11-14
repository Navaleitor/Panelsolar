import 'dart:math' as math;

import 'package:geo_kit/src/geometry/polygon_metrics.dart';
import 'package:geo_kit/src/geometry/vec2.dart';

/// Orientación de un plano del techo a partir de su polígono (coordenadas
/// locales: x = este, y = norte).
/// Ficha: docs/formulas/18-orientacion-de-planos.md
abstract final class PlaneOrientation {
  /// Azimut (grados desde el norte, horario) hacia donde **baja** el plano
  /// cuando la arista [edgeIndex] es la orilla baja (el alero/gotero): la
  /// perpendicular a esa arista que apunta hacia afuera del polígono.
  static double azimuthFromEdge(List<Vec2> pts, int edgeIndex) {
    final n = pts.length;
    final a = pts[edgeIndex % n];
    final b = pts[(edgeIndex + 1) % n];
    final d = b - a;
    final ccw = PolygonMetrics.signedArea(pts) > 0;
    // Normal hacia afuera: a la derecha del recorrido si es antihorario.
    final out = ccw ? Vec2(d.y, -d.x) : Vec2(-d.y, d.x);
    final az = math.atan2(out.x, out.y) * 180 / math.pi;
    return az < 0 ? az + 360 : az;
  }

  /// Área real inclinada (m²) a partir del área vista desde arriba
  /// (proyección horizontal) y la inclinación: A = A_h / cos β.
  static double slopedArea(double horizontalArea, double tiltDeg) {
    if (tiltDeg < 0 || tiltDeg >= 90) {
      throw ArgumentError.value(tiltDeg, 'tiltDeg', 'debe estar en [0, 90)');
    }
    return horizontalArea / math.cos(tiltDeg * math.pi / 180);
  }

  /// Largo real de una arista que sube por la pendiente, a partir de su
  /// largo visto desde arriba: L = L_h / cos β (aristas perpendiculares al
  /// alero). Las paralelas al alero no cambian.
  static double slopedLength(double horizontalLength, double tiltDeg) =>
      horizontalLength / math.cos(tiltDeg * math.pi / 180);
}
