import 'dart:math' as math;

import 'package:geo_kit/src/geometry/vec2.dart';
import 'package:meta/meta.dart';

/// Relación entre los píxeles de la imagen del techo y las coordenadas
/// locales del sitio (metros, x = este, y = norte).
///
/// - [metersPerPixel]: escala (calibración).
/// - [northAngleDeg]: hacia dónde apunta el norte en la imagen, en grados
///   medidos en sentido horario desde "arriba" de la imagen (0 = norte
///   arriba, el valor por defecto).
/// - [origin]: píxel que corresponde al punto (0, 0) local.
///
/// Ficha: docs/formulas/17-calibracion-de-escala.md
@immutable
class ImageFrame {
  /// Crea el marco.
  const new({
    required this.metersPerPixel,
    this.northAngleDeg = 0,
    this.origin = Vec2.zero,
  });

  /// Metros por píxel.
  final double metersPerPixel;

  /// Ángulo del norte en la imagen (grados, horario desde arriba).
  final double northAngleDeg;

  /// Píxel del origen local.
  final Vec2 origin;

  double get _r => northAngleDeg * math.pi / 180;

  /// Píxel → metros locales (este, norte).
  Vec2 toLocal(Vec2 px) {
    final right = (px.x - origin.x) * metersPerPixel;
    final up = -(px.y - origin.y) * metersPerPixel;
    final c = math.cos(_r);
    final s = math.sin(_r);
    return Vec2(right * c - up * s, right * s + up * c);
  }

  /// Metros locales (este, norte) → píxel.
  Vec2 toPixel(Vec2 local) {
    final c = math.cos(_r);
    final s = math.sin(_r);
    final right = local.x * c + local.y * s;
    final up = -local.x * s + local.y * c;
    return Vec2(
      origin.x + right / metersPerPixel,
      origin.y - up / metersPerPixel,
    );
  }

  /// Ángulo del norte en la imagen que hace que una línea dibujada con
  /// rumbo [lineImageBearingDeg] (horario desde arriba de la imagen) tenga
  /// el azimut verdadero [trueAzimuthDeg] que marcó la brújula.
  static double northAngleFrom({
    required double lineImageBearingDeg,
    required double trueAzimuthDeg,
  }) => _mod360(lineImageBearingDeg - trueAzimuthDeg);

  /// Rumbo en la imagen (grados, horario desde arriba) de [from] a [to].
  static double imageBearing(Vec2 from, Vec2 to) {
    final d = to - from;
    return _mod360(math.atan2(d.x, -d.y) * 180 / math.pi);
  }

  /// Copia con otros valores.
  ImageFrame copyWith({
    double? metersPerPixel,
    double? northAngleDeg,
    Vec2? origin,
  }) => ImageFrame(
    metersPerPixel: metersPerPixel ?? this.metersPerPixel,
    northAngleDeg: northAngleDeg ?? this.northAngleDeg,
    origin: origin ?? this.origin,
  );
}

double _mod360(double v) {
  final r = v % 360;
  return r < 0 ? r + 360 : r;
}
