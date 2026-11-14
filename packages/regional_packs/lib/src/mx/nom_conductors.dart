import 'dart:math' as math;

import 'package:regional_packs/src/electrical/conductor_table.dart';

/// Tablas de NOM-001-SEDE-2012 (equivalente a NEC 2011) para elegir
/// calibres. Indicativo: requiere revisión de un profesional (UVIE).
///
/// - Ampacidades: tabla 310-15(b)(16), 30 °C, hasta 3 conductores.
/// - Resistencias: capítulo 10, tabla 8 (DC a 75 °C, cableado sin
///   recubrir), en Ω/km.
/// - Temperatura: 310-15(b)(2)(a). Agrupamiento: 310-15(b)(3)(a).
/// - Azotea al sol: 310-15(b)(3)(c).
/// Ficha: docs/formulas/24-caida-de-tension-y-calibre.md
class NomConductors implements ConductorStandard {
  /// Crea la tabla.
  const new();

  @override
  String get name => 'NOM-001-SEDE-2012';

  static const List<ConductorSize> _copper = [
    ConductorSize(
      label: '14 AWG',
      areaMm2: 2.08,
      resistanceOhmPerKm: 10.3,
      ampacity75C: 20,
      ampacity90C: 25,
    ),
    ConductorSize(
      label: '12 AWG',
      areaMm2: 3.31,
      resistanceOhmPerKm: 6.50,
      ampacity75C: 25,
      ampacity90C: 30,
    ),
    ConductorSize(
      label: '10 AWG',
      areaMm2: 5.26,
      resistanceOhmPerKm: 4.07,
      ampacity75C: 35,
      ampacity90C: 40,
    ),
    ConductorSize(
      label: '8 AWG',
      areaMm2: 8.37,
      resistanceOhmPerKm: 2.55,
      ampacity75C: 50,
      ampacity90C: 55,
    ),
    ConductorSize(
      label: '6 AWG',
      areaMm2: 13.3,
      resistanceOhmPerKm: 1.61,
      ampacity75C: 65,
      ampacity90C: 75,
    ),
    ConductorSize(
      label: '4 AWG',
      areaMm2: 21.2,
      resistanceOhmPerKm: 1.01,
      ampacity75C: 85,
      ampacity90C: 95,
    ),
    ConductorSize(
      label: '3 AWG',
      areaMm2: 26.7,
      resistanceOhmPerKm: 0.802,
      ampacity75C: 100,
      ampacity90C: 115,
    ),
    ConductorSize(
      label: '2 AWG',
      areaMm2: 33.6,
      resistanceOhmPerKm: 0.636,
      ampacity75C: 115,
      ampacity90C: 130,
    ),
    ConductorSize(
      label: '1 AWG',
      areaMm2: 42.4,
      resistanceOhmPerKm: 0.505,
      ampacity75C: 130,
      ampacity90C: 145,
    ),
    ConductorSize(
      label: '1/0 AWG',
      areaMm2: 53.5,
      resistanceOhmPerKm: 0.399,
      ampacity75C: 150,
      ampacity90C: 170,
    ),
    ConductorSize(
      label: '2/0 AWG',
      areaMm2: 67.4,
      resistanceOhmPerKm: 0.317,
      ampacity75C: 175,
      ampacity90C: 195,
    ),
    ConductorSize(
      label: '3/0 AWG',
      areaMm2: 85,
      resistanceOhmPerKm: 0.2513,
      ampacity75C: 200,
      ampacity90C: 225,
    ),
    ConductorSize(
      label: '4/0 AWG',
      areaMm2: 107,
      resistanceOhmPerKm: 0.1996,
      ampacity75C: 230,
      ampacity90C: 260,
    ),
  ];

  static const List<ConductorSize> _aluminum = [
    ConductorSize(
      label: '12 AWG',
      areaMm2: 3.31,
      resistanceOhmPerKm: 10.7,
      ampacity75C: 20,
      ampacity90C: 25,
    ),
    ConductorSize(
      label: '10 AWG',
      areaMm2: 5.26,
      resistanceOhmPerKm: 6.69,
      ampacity75C: 30,
      ampacity90C: 35,
    ),
    ConductorSize(
      label: '8 AWG',
      areaMm2: 8.37,
      resistanceOhmPerKm: 4.20,
      ampacity75C: 40,
      ampacity90C: 45,
    ),
    ConductorSize(
      label: '6 AWG',
      areaMm2: 13.3,
      resistanceOhmPerKm: 2.65,
      ampacity75C: 50,
      ampacity90C: 55,
    ),
    ConductorSize(
      label: '4 AWG',
      areaMm2: 21.2,
      resistanceOhmPerKm: 1.67,
      ampacity75C: 65,
      ampacity90C: 75,
    ),
    ConductorSize(
      label: '3 AWG',
      areaMm2: 26.7,
      resistanceOhmPerKm: 1.32,
      ampacity75C: 75,
      ampacity90C: 85,
    ),
    ConductorSize(
      label: '2 AWG',
      areaMm2: 33.6,
      resistanceOhmPerKm: 1.05,
      ampacity75C: 90,
      ampacity90C: 100,
    ),
    ConductorSize(
      label: '1 AWG',
      areaMm2: 42.4,
      resistanceOhmPerKm: 0.830,
      ampacity75C: 100,
      ampacity90C: 115,
    ),
    ConductorSize(
      label: '1/0 AWG',
      areaMm2: 53.5,
      resistanceOhmPerKm: 0.659,
      ampacity75C: 120,
      ampacity90C: 135,
    ),
    ConductorSize(
      label: '2/0 AWG',
      areaMm2: 67.4,
      resistanceOhmPerKm: 0.522,
      ampacity75C: 135,
      ampacity90C: 150,
    ),
    ConductorSize(
      label: '3/0 AWG',
      areaMm2: 85,
      resistanceOhmPerKm: 0.413,
      ampacity75C: 155,
      ampacity90C: 175,
    ),
    ConductorSize(
      label: '4/0 AWG',
      areaMm2: 107,
      resistanceOhmPerKm: 0.328,
      ampacity75C: 180,
      ampacity90C: 205,
    ),
  ];

  // (ambiente máximo °C, factor 75 °C, factor 90 °C); tabla 310-15(b)(2)(a).
  static const List<(double, double, double)> _temperature = [
    (10, 1.20, 1.15),
    (15, 1.15, 1.12),
    (20, 1.11, 1.08),
    (25, 1.05, 1.04),
    (30, 1.00, 1.00),
    (35, 0.94, 0.96),
    (40, 0.88, 0.91),
    (45, 0.82, 0.87),
    (50, 0.75, 0.82),
    (55, 0.67, 0.76),
    (60, 0.58, 0.71),
    (65, 0.47, 0.65),
    (70, 0.33, 0.58),
    (75, 0, 0.50),
    (80, 0, 0.41),
    (85, 0, 0.29),
  ];

  @override
  List<ConductorSize> sizes(WireMaterial material) =>
      material == WireMaterial.copper ? _copper : _aluminum;

  @override
  double temperatureFactor(double ambientC, int insulationC) {
    for (final (limit, f75, f90) in _temperature) {
      if (ambientC <= limit) return insulationC >= 90 ? f90 : f75;
    }
    return 0;
  }

  @override
  double fillFactor(int currentCarryingConductors) {
    final n = currentCarryingConductors;
    if (n <= 3) return 1;
    if (n <= 6) return 0.80;
    if (n <= 9) return 0.70;
    if (n <= 20) return 0.50;
    if (n <= 30) return 0.45;
    if (n <= 40) return 0.40;
    return 0.35;
  }

  @override
  double racewayAdderC(RacewayType raceway) => switch (raceway) {
    RacewayType.rooftopUnder13mm => 33,
    RacewayType.rooftop13to90mm => 22,
    RacewayType.rooftop90to300mm => 17,
    RacewayType.rooftop300to900mm => 14,
    RacewayType.indoorConduit || RacewayType.freeAir || RacewayType.buried => 0,
  };

  @override
  double correctedAmpacity(
    ConductorSize size, {
    required double ambientC,
    required RacewayType raceway,
    required int currentCarryingConductors,
  }) {
    final t = ambientC + racewayAdderC(raceway);
    final a90 =
        size.ampacity90C *
        temperatureFactor(t, 90) *
        fillFactor(currentCarryingConductors);
    return math.min(a90, size.ampacity75C);
  }
}
