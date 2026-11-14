import 'dart:math' as math;

/// Material del conductor.
enum ConductorMaterial {
  /// Cobre.
  copper,

  /// Aluminio.
  aluminum,
}

/// Tipo de circuito para la caída de tensión.
enum CircuitKind {
  /// Corriente directa (ida y vuelta).
  dc,

  /// Alterna monofásica (ida y vuelta).
  ac1,

  /// Alterna trifásica (√3).
  ac3,
}

/// Caída de tensión en un tramo (B.6 punto 15).
/// Ficha: docs/formulas/24-caida-de-tension-y-calibre.md
abstract final class VoltageDrop {
  /// Coeficiente de temperatura de la resistencia (1/°C) a 75 °C
  /// (NEC cap. 9, tabla 8, nota 2): cobre 0.00323, aluminio 0.00330.
  static double alpha(ConductorMaterial m) =>
      m == ConductorMaterial.copper ? 0.00323 : 0.00330;

  /// Resistencia a [tempC] a partir de la de 75 °C (Ω/km):
  /// R_T = R_75·[1 + α·(T − 75)].
  static double resistanceAt(
    double r75OhmPerKm,
    ConductorMaterial material,
    double tempC,
  ) => r75OhmPerKm * (1 + alpha(material) * (tempC - 75));

  /// Caída de tensión (V) de un tramo de [lengthM] m (un sentido) con
  /// [currentA] A y resistencia [rOhmPerKm]:
  /// - DC y monofásica: ΔV = 2·L·I·R/1000.
  /// - Trifásica: ΔV = √3·L·I·R/1000.
  static double volts({
    required CircuitKind kind,
    required double lengthM,
    required double currentA,
    required double rOhmPerKm,
  }) {
    final k = kind == CircuitKind.ac3 ? math.sqrt(3) : 2.0;
    return k * lengthM * currentA * rOhmPerKm / 1000;
  }

  /// Caída en porcentaje de la tensión [voltageV].
  static double percent({
    required CircuitKind kind,
    required double lengthM,
    required double currentA,
    required double rOhmPerKm,
    required double voltageV,
  }) => voltageV <= 0
      ? double.infinity
      : volts(
              kind: kind,
              lengthM: lengthM,
              currentA: currentA,
              rOhmPerKm: rOhmPerKm,
            ) /
            voltageV *
            100;
}
