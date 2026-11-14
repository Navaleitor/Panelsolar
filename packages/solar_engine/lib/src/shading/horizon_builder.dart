import 'package:solar_engine/src/core/angles.dart';
import 'package:solar_engine/src/simulation/horizon_profile.dart';

/// Obstáculo lejano medido con brújula e inclinómetro (B.7 opción B):
/// puntos (azimut, elevación) del borde superior, de izquierda a derecha.
/// Fuera de su rango de azimut no tapa nada.
typedef FarObstacleSpan = List<({double azimuth, double elevation})>;

/// Une el horizonte del terreno (PVGIS) con los obstáculos lejanos medidos
/// en sitio: en cada azimut, la elevación más alta.
/// Ficha: docs/formulas/19-sombras-de-obstaculos.md
abstract final class HorizonBuilder {
  /// Perfil combinado muestreado cada [stepDeg] grados.
  static HorizonProfile combine({
    HorizonProfile? terrain,
    List<FarObstacleSpan> spans = const [],
    double stepDeg = 1,
  }) {
    final points = <({double azimuth, double elevation})>[];
    for (var az = 0.0; az < 360; az += stepDeg) {
      var e = terrain?.elevationAt(az) ?? 0.0;
      for (final s in spans) {
        final v = spanElevation(s, az);
        if (v != null && v > e) e = v;
      }
      points.add((azimuth: az, elevation: e));
    }
    return HorizonProfile(points);
  }

  /// Elevación del obstáculo [span] en el azimut [azimuth] (interpolación
  /// lineal entre sus puntos), o `null` si ese azimut queda fuera. Admite
  /// obstáculos que cruzan el norte (p. ej. de 350° a 10°).
  static double? spanElevation(FarObstacleSpan span, double azimuth) {
    if (span.isEmpty) return null;
    if (span.length == 1) {
      final d = _delta(span.first.azimuth, azimuth);
      return d.abs() <= 1 ? span.first.elevation : null;
    }
    // Azimuts "desenrollados" a partir del primero.
    final base = span.first.azimuth;
    final xs = <double>[0];
    for (var i = 1; i < span.length; i++) {
      var d = positiveMod(span[i].azimuth - base, 360);
      if (d < xs.last) d += 360;
      xs.add(d);
    }
    final x = positiveMod(azimuth - base, 360);
    if (x > xs.last) return null;
    for (var i = 1; i < xs.length; i++) {
      if (x <= xs[i]) {
        final x0 = xs[i - 1];
        final x1 = xs[i];
        final e0 = span[i - 1].elevation;
        final e1 = span[i].elevation;
        return x1 == x0 ? e1 : e0 + (e1 - e0) * (x - x0) / (x1 - x0);
      }
    }
    return span.last.elevation;
  }

  static double _delta(double a, double b) =>
      positiveMod(b - a + 180, 360) - 180;
}
