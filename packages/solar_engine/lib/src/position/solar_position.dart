/// Posición del Sol vista desde un punto de la Tierra.
///
/// Convenciones (iguales a pvlib):
/// - Ángulos en grados.
/// - Azimut medido desde el norte geográfico en sentido horario
///   (0 = N, 90 = E, 180 = S, 270 = O).
///
/// Ficha: docs/formulas/01-posicion-solar-spa.md
class SolarPosition {
  /// Crea una posición solar.
  const new({
    required this.zenith,
    required this.apparentZenith,
    required this.azimuth,
    this.declination = 0,
    this.earthSunDistance = 1,
  });

  /// Ángulo cenital geométrico θz (sin refracción), grados.
  final double zenith;

  /// Ángulo cenital aparente (con refracción atmosférica), grados. Es el que
  /// se usa en los cálculos de irradiancia.
  final double apparentZenith;

  /// Azimut solar γs, grados desde el norte en sentido horario.
  final double azimuth;

  /// Declinación topocéntrica δ', grados.
  final double declination;

  /// Distancia Tierra–Sol, unidades astronómicas.
  final double earthSunDistance;

  /// Elevación geométrica α = 90° − θz.
  double get elevation => 90 - zenith;

  /// Elevación aparente (con refracción) = 90° − cenit aparente.
  double get apparentElevation => 90 - apparentZenith;

  /// Verdadero si el Sol (aparente) está sobre el horizonte.
  bool get isUp => apparentZenith < 90;
}
