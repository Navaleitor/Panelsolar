import 'dart:math' as math;

/// Inversor con la curva de eficiencia de PVWatts (Dobos, 2014) y recorte
/// (clipping) a la potencia AC máxima. Igual que `pvlib.inverter.pvwatts`.
/// Ficha: docs/formulas/10-inversor-pvwatts.md
///
/// ζ = Pdc/Pdc0
/// η = (ηnom/ηref)·(−0.0162·ζ − 0.0059/ζ + 0.9858)
/// Pac = min(η·Pdc, Pac0), nunca negativo; Pac0 = ηnom·Pdc0.
class PvwattsInverter {
  /// Crea el inversor a partir de su potencia AC nominal [pacMax] (W) y su
  /// eficiencia nominal [etaNominal] (de la hoja de datos, p. ej. 0.96).
  const new({
    required this.pacMax,
    this.etaNominal = 0.96,
    this.etaReference = 0.9637,
  });

  /// Potencia AC máxima Pac0 (W). Por encima se recorta.
  final double pacMax;

  /// Eficiencia nominal ηnom.
  final double etaNominal;

  /// Eficiencia de referencia de la curva ηref (constante de PVWatts).
  final double etaReference;

  /// Límite de entrada DC equivalente Pdc0 = Pac0/ηnom (W).
  double get pdc0 => pacMax / etaNominal;

  /// Potencia AC (W) que daría la curva de eficiencia sin recorte.
  double unclippedAcPower(double pdc) {
    if (pdc <= 0) return 0;
    final zeta = pdc / pdc0;
    final eta =
        etaNominal / etaReference * (-0.0162 * zeta - 0.0059 / zeta + 0.9858);
    final p = eta * pdc;
    return p < 0 ? 0 : p;
  }

  /// Potencia AC (W) para una potencia DC [pdc] (W), con recorte.
  double acPower(double pdc) => math.min(pacMax, unclippedAcPower(pdc));

  /// Verdadero si con [pdc] el inversor está recortando.
  bool isClipping(double pdc) => unclippedAcPower(pdc) > pacMax;
}
