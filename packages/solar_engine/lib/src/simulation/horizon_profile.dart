import 'package:solar_engine/src/core/angles.dart';

/// Perfil de horizonte: elevación del terreno u obstáculos lejanos (grados)
/// en función del azimut (grados desde el norte, sentido horario).
/// Si el Sol está por debajo del perfil, se bloquea la irradiancia directa.
class HorizonProfile {
  /// Crea el perfil a partir de puntos (azimut, elevación). Se ordenan por
  /// azimut y se interpolan linealmente de forma circular.
  new(List<({double azimuth, double elevation})> points)
    : _points = [
        for (final p in points)
          (azimuth: positiveMod(p.azimuth, 360), elevation: p.elevation),
      ]..sort((a, b) => a.azimuth.compareTo(b.azimuth)) {
    if (_points.isEmpty) {
      throw ArgumentError('El perfil necesita al menos un punto.');
    }
  }

  /// Perfil plano (horizonte a 0°).
  factory flat() => HorizonProfile([(azimuth: 0, elevation: 0)]);

  final List<({double azimuth, double elevation})> _points;

  /// Puntos ordenados del perfil.
  List<({double azimuth, double elevation})> get points =>
      List.unmodifiable(_points);

  /// Elevación del horizonte (grados) en el azimut [azimuth].
  double elevationAt(double azimuth) {
    if (_points.length == 1) return _points.first.elevation;
    final az = positiveMod(azimuth, 360);
    for (var i = 0; i < _points.length; i++) {
      final next = _points[i];
      if (az <= next.azimuth) {
        final prev = i == 0 ? _points.last : _points[i - 1];
        final prevAz = i == 0 ? prev.azimuth - 360 : prev.azimuth;
        return _lerp(prevAz, prev.elevation, next.azimuth, next.elevation, az);
      }
    }
    final last = _points.last;
    final first = _points.first;
    return _lerp(
      last.azimuth,
      last.elevation,
      first.azimuth + 360,
      first.elevation,
      az,
    );
  }

  /// Verdadero si un Sol con elevación [sunElevation] y azimut [sunAzimuth]
  /// queda oculto por el perfil.
  bool blocks(double sunElevation, double sunAzimuth) =>
      sunElevation < elevationAt(sunAzimuth);

  static double _lerp(double x0, double y0, double x1, double y1, double x) {
    if (x1 == x0) return y0;
    return y0 + (y1 - y0) * (x - x0) / (x1 - x0);
  }
}
