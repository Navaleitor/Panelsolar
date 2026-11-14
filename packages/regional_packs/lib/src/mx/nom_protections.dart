/// Capacidades comerciales y conductor de tierra de NOM-001-SEDE-2012.
/// Indicativo: requiere revisión de un profesional (UVIE).
/// Ficha: docs/formulas/25-protecciones-y-tierra.md
abstract final class NomProtections {
  /// Capacidades normalizadas de interruptores (art. 240-6), A.
  static const List<double> breakerRatingsA = [
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    60,
    70,
    80,
    90,
    100,
    110,
    125,
    150,
    175,
    200,
    225,
    250,
    300,
    350,
    400,
  ];

  /// Capacidades comerciales de fusibles fotovoltaicos (gPV), A.
  static const List<double> pvFuseRatingsA = [
    1,
    2,
    3,
    4,
    5,
    6,
    8,
    10,
    12,
    15,
    20,
    25,
    30,
    32,
    35,
    40,
    45,
    50,
    60,
  ];

  /// Conductor de puesta a tierra de equipos de cobre (tabla 250-122):
  /// (protección máxima A, calibre).
  static const List<(double, String)> groundingCopper = [
    (15, '14 AWG'),
    (20, '12 AWG'),
    (60, '10 AWG'),
    (100, '8 AWG'),
    (200, '6 AWG'),
    (300, '4 AWG'),
    (400, '3 AWG'),
    (500, '2 AWG'),
    (600, '1 AWG'),
    (800, '1/0 AWG'),
    (1000, '2/0 AWG'),
    (1200, '3/0 AWG'),
  ];

  /// Igual en aluminio.
  static const List<(double, String)> groundingAluminum = [
    (15, '12 AWG'),
    (20, '10 AWG'),
    (60, '8 AWG'),
    (100, '6 AWG'),
    (200, '4 AWG'),
    (300, '2 AWG'),
    (400, '1 AWG'),
    (500, '1/0 AWG'),
    (600, '2/0 AWG'),
    (800, '3/0 AWG'),
    (1000, '4/0 AWG'),
  ];

  /// Tensión máxima del sistema FV en vivienda (art. 690-7), V.
  static const double residentialMaxVoltage = 600;
}
