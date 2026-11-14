import 'dart:math' as math;

import 'package:geo_kit/src/geometry/vec2.dart';

/// Lado de un croquis medido con cinta.
typedef TapeSide = ({double lengthM, double turnDeg});

/// Resultado del croquis.
typedef TapeSketchResult = ({List<Vec2> polygon, double closureErrorM});

/// Modo sin imagen: arma el polígono del techo a partir de las medidas de
/// sus lados con cinta y del giro en cada esquina.
/// Ficha: docs/formulas/16-poligonos-del-techo.md
abstract final class TapeSketch {
  /// Recorre los lados empezando en (0, 0) hacia el este. Después de cada
  /// lado se gira `turnDeg` grados a la izquierda (90 = esquina recta de un
  /// recorrido antihorario). El último lado vuelve al inicio; si las
  /// medidas no cierran, `closureErrorM` dice cuánto falta.
  static TapeSketchResult fromSides(List<TapeSide> sides) {
    if (sides.length < 3) {
      throw ArgumentError('Se necesitan al menos tres lados.');
    }
    var heading = 0.0;
    var p = Vec2.zero;
    final pts = <Vec2>[p];
    for (final s in sides) {
      if (!(s.lengthM > 0)) {
        throw ArgumentError.value(s.lengthM, 'lengthM', 'debe ser > 0');
      }
      final r = heading * math.pi / 180;
      p = p + Vec2(math.cos(r), math.sin(r)) * s.lengthM;
      pts.add(p);
      heading += s.turnDeg;
    }
    final error = pts.last.length;
    return (polygon: pts.sublist(0, pts.length - 1), closureErrorM: error);
  }

  /// Rectángulo de [widthM] (este–oeste) por [depthM] (norte–sur) con la
  /// esquina suroeste en (0, 0).
  static List<Vec2> rectangle(double widthM, double depthM) => [
    Vec2.zero,
    Vec2(widthM, 0),
    Vec2(widthM, depthM),
    Vec2(0, depthM),
  ];
}
