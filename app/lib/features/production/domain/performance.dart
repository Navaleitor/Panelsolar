import 'package:persistence/persistence.dart';

/// Cálculos del seguimiento de producción. Ficha:
/// `docs/formulas/performance-ratio.md`.

/// Índice de rendimiento = real / esperado (1.0 = lo esperado).
/// `null` si falta lo esperado o es 0.
double? performanceIndex(double actualKwh, double? expectedKwh) {
  if (expectedKwh == null || expectedKwh <= 0) return null;
  return actualKwh / expectedKwh;
}

/// Desviación (%) de lo real respecto de lo esperado.
double? deviationFromExpectedPct(double actualKwh, double? expectedKwh) {
  final index = performanceIndex(actualKwh, expectedKwh);
  return index == null ? null : (index - 1) * 100;
}

/// Performance Ratio simple (IEC 61724-1):
/// PR = E / (P₀ × H / G_STC), con E en kWh, P₀ en kWp, H (irradiación en
/// el plano de los paneles) en kWh/m² y G_STC = 1 kW/m².
double? performanceRatio(
  double actualKwh,
  double? systemKwp,
  double? poaKwhM2,
) {
  if (systemKwp == null ||
      poaKwhM2 == null ||
      systemKwp <= 0 ||
      poaKwhM2 <= 0) {
    return null;
  }
  return actualKwh / (systemKwp * poaKwhM2);
}

/// `true` si lo real quedó por debajo del umbral (p. ej. −15 %).
bool isBelowThreshold(
  double actualKwh,
  double? expectedKwh,
  double thresholdPct,
) {
  final dev = deviationFromExpectedPct(actualKwh, expectedKwh);
  return dev != null && dev < thresholdPct;
}

/// Resumen de un conjunto de lecturas.
class ProductionSummary {
  const new({
    required this.actualKwh,
    required this.expectedKwh,
    required this.alerts,
    required this.latest,
  });

  /// Construye el resumen de los últimos 12 meses con lectura.
  factory of(List<ProductionReading> readings, {required double thresholdPct}) {
    final last12 = readings.length > 12
        ? readings.sublist(readings.length - 12)
        : readings;
    final withExpected = last12.where((r) => r.expectedKwh != null);
    return ProductionSummary(
      actualKwh: last12.fold(0, (s, r) => s + r.actualKwh),
      expectedKwh: withExpected.isEmpty
          ? null
          : withExpected.fold<double>(0, (s, r) => s + r.expectedKwh!),
      alerts: [
        for (final r in readings)
          if (isBelowThreshold(r.actualKwh, r.expectedKwh, thresholdPct)) r,
      ],
      latest: readings.isEmpty ? null : readings.last,
    );
  }

  /// Suma real de los últimos 12 meses (kWh).
  final double actualKwh;

  /// Suma esperada de los meses que la tienen (kWh), o `null`.
  final double? expectedKwh;

  /// Lecturas por debajo del umbral.
  final List<ProductionReading> alerts;

  /// Lectura más reciente.
  final ProductionReading? latest;

  /// `true` si la lectura más reciente está en alerta.
  bool get latestInAlert => latest != null && alerts.contains(latest);
}
