import 'dart:math' as math;

import 'package:geo_kit/src/geometry/vec2.dart';

/// Resultado de aplicar el imán a un punto.
typedef SnapResult = ({Vec2 point, SnapKind kind});

/// Qué imán se aplicó.
enum SnapKind {
  /// Ninguno: el punto queda donde se tocó.
  none,

  /// Se pegó a un vértice existente.
  vertex,

  /// Se ajustó para formar 90° (o 180°) con el lado anterior.
  rightAngle,
}

/// Imán del trazado: a vértices y a ángulos rectos.
/// Ficha: docs/formulas/16-poligonos-del-techo.md
abstract final class Snapping {
  /// Ajusta [candidate]:
  /// 1. Si hay un vértice de [vertices] a menos de [vertexRadius], lo usa.
  /// 2. Si no, y hay al menos dos puntos en [path], gira el nuevo lado para
  ///    que forme 90° (o siga recto) con el último lado si está a menos de
  ///    [angleToleranceDeg] grados, conservando su largo.
  /// 3. Con un solo punto previo, alinea con los ejes de [axisDeg] (0 =
  ///    horizontal/vertical).
  static SnapResult snap({
    required Vec2 candidate,
    required List<Vec2> path,
    List<Vec2> vertices = const [],
    double vertexRadius = 0,
    double angleToleranceDeg = 8,
    double axisDeg = 0,
  }) {
    Vec2? best;
    var bestD = vertexRadius;
    for (final v in vertices) {
      final d = v.distanceTo(candidate);
      if (d <= bestD) {
        bestD = d;
        best = v;
      }
    }
    if (best != null) return (point: best, kind: SnapKind.vertex);
    if (path.isEmpty) return (point: candidate, kind: SnapKind.none);

    final last = path.last;
    final seg = candidate - last;
    final len = seg.length;
    if (len == 0) return (point: candidate, kind: SnapKind.none);
    final segAng = math.atan2(seg.y, seg.x) * 180 / math.pi;
    final double refAng;
    if (path.length >= 2) {
      final prev = last - path[path.length - 2];
      refAng = math.atan2(prev.y, prev.x) * 180 / math.pi;
    } else {
      refAng = axisDeg;
    }
    // Múltiplo de 90° más cercano a la diferencia de ángulos.
    final diff = segAng - refAng;
    final k = (diff / 90).roundToDouble();
    final off = diff - k * 90;
    if (off.abs() > angleToleranceDeg) {
      return (point: candidate, kind: SnapKind.none);
    }
    final target = (refAng + k * 90) * math.pi / 180;
    return (
      point: last + Vec2(math.cos(target), math.sin(target)) * len,
      kind: SnapKind.rightAngle,
    );
  }
}
