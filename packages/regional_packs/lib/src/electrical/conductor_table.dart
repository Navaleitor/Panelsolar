/// Material del conductor (igual que en `solar_engine`).
enum WireMaterial {
  /// Cobre.
  copper,

  /// Aluminio.
  aluminum,
}

/// Tipo de canalización: decide cuánto se calienta el conductor.
enum RacewayType {
  /// Tubo en azotea al sol, a menos de 13 mm del techo.
  rooftopUnder13mm,

  /// Tubo en azotea al sol, de 13 a 90 mm del techo.
  rooftop13to90mm,

  /// Tubo en azotea al sol, de 90 a 300 mm del techo.
  rooftop90to300mm,

  /// Tubo en azotea al sol, de 300 a 900 mm del techo.
  rooftop300to900mm,

  /// Tubo en interior, muro o sombra.
  indoorConduit,

  /// Charola o al aire libre a la sombra.
  freeAir,

  /// Enterrado.
  buried,
}

/// Un calibre de la tabla.
class ConductorSize {
  /// Crea el calibre.
  const new({
    required this.label,
    required this.areaMm2,
    required this.resistanceOhmPerKm,
    required this.ampacity75C,
    required this.ampacity90C,
  });

  /// Nombre ("10 AWG", "1/0 AWG").
  final String label;

  /// Sección (mm²).
  final double areaMm2;

  /// Resistencia DC a 75 °C (Ω/km), conductor cableado sin recubrir.
  final double resistanceOhmPerKm;

  /// Ampacidad con aislamiento de 75 °C (A), máx. 3 conductores, 30 °C.
  final double ampacity75C;

  /// Ampacidad con aislamiento de 90 °C (A), máx. 3 conductores, 30 °C.
  final double ampacity90C;
}

/// Tablas de conductores de una norma.
abstract interface class ConductorStandard {
  /// Nombre de la norma.
  String get name;

  /// Calibres de [material], de menor a mayor.
  List<ConductorSize> sizes(WireMaterial material);

  /// Factor por temperatura ambiente [ambientC] para la columna de
  /// [insulationC] °C (75 o 90). 0 si no se permite.
  double temperatureFactor(double ambientC, int insulationC);

  /// Factor por número de conductores portadores de corriente en la
  /// canalización.
  double fillFactor(int currentCarryingConductors);

  /// Grados que se suman al ambiente por la canalización.
  double racewayAdderC(RacewayType raceway);

  /// Ampacidad corregida de [size]: columna de 90 °C con factores, sin
  /// pasar la de 75 °C (temperatura de las terminales).
  double correctedAmpacity(
    ConductorSize size, {
    required double ambientC,
    required RacewayType raceway,
    required int currentCarryingConductors,
  });
}
