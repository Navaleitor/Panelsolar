import 'package:geo_kit/src/geometry/vec2.dart';
import 'package:meta/meta.dart';

/// Línea trazada sobre la imagen (en píxeles) con su medida real en metros.
@immutable
class MeasuredLine {
  /// Crea la línea de [start] a [end] (píxeles) que mide [lengthM] metros.
  const new(this.start, this.end, this.lengthM);

  /// Lee el JSON de [toJson].
  factory fromJson(Map<String, Object?> json) => MeasuredLine(
    Vec2.fromJson(json['a']),
    Vec2.fromJson(json['b']),
    (json['m']! as num).toDouble(),
  );

  /// Extremo inicial (píxeles).
  final Vec2 start;

  /// Extremo final (píxeles).
  final Vec2 end;

  /// Medida real en metros (con cinta, plano o frente del lote).
  final double lengthM;

  /// Largo en píxeles.
  double get lengthPx => start.distanceTo(end);

  /// JSON `{"a":[x,y],"b":[x,y],"m":metros}`.
  Map<String, Object> toJson() => {
    'a': start.toJson(),
    'b': end.toJson(),
    'm': lengthM,
  };
}

/// Calibración de escala: metros por píxel a partir de una línea de medida
/// conocida, con verificación opcional por una segunda línea.
/// Ficha: docs/formulas/17-calibracion-de-escala.md
abstract final class ScaleCalibration {
  /// Largo mínimo de la línea de calibración (píxeles). Con menos, un error
  /// de 1 px al tocar ya es > 5 %.
  static const double minLinePx = 20;

  /// Diferencia de verificación a partir de la cual se avisa (%).
  static const double warnDifferencePercent = 5;

  /// Metros por píxel = metros reales / largo en píxeles.
  ///
  /// Lanza [ArgumentError] si la línea es muy corta o la medida no es
  /// positiva.
  static double metersPerPixel(MeasuredLine line) {
    if (!(line.lengthM > 0) || !line.lengthM.isFinite) {
      throw ArgumentError.value(line.lengthM, 'lengthM', 'debe ser > 0');
    }
    if (line.lengthPx < minLinePx) {
      throw ArgumentError.value(
        line.lengthPx,
        'lengthPx',
        'la línea debe medir al menos $minLinePx px',
      );
    }
    return line.lengthM / line.lengthPx;
  }

  /// Diferencia (%) entre lo que mide la línea de verificación con la escala
  /// [metersPerPixel] y su medida real: (medida − real) / real × 100.
  static double verificationDifferencePercent(
    double metersPerPixel,
    MeasuredLine check,
  ) {
    final measured = check.lengthPx * metersPerPixel;
    return (measured - check.lengthM) / check.lengthM * 100;
  }
}
