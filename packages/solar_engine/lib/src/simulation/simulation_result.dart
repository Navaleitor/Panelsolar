import 'dart:typed_data';

/// Resultado de una simulación horaria.
///
/// Energías en kWh; irradiaciones en kWh/m². "Año típico" = suma de los 12
/// meses típicos (promedio de los meses completos de la serie).
class SimulationResult {
  /// Crea el resultado.
  const new({
    required this.pdc0,
    required this.monthlyAcEnergy,
    required this.monthlyPoaIrradiation,
    required this.yearlyAcEnergy,
    required this.totalAcEnergy,
    required this.totalDcEnergy,
    required this.totalPoaIrradiation,
    required this.clippedEnergy,
    this.hourlyAcPower,
  });

  /// Potencia DC nominal del sistema simulado (W).
  final double pdc0;

  /// Energía AC del mes típico (12 valores, kWh).
  final List<double> monthlyAcEnergy;

  /// Irradiación en el plano del mes típico (12 valores, kWh/m²).
  final List<double> monthlyPoaIrradiation;

  /// Energía AC por año calendario completo (kWh).
  final Map<int, double> yearlyAcEnergy;

  /// Energía AC de toda la serie (kWh).
  final double totalAcEnergy;

  /// Energía DC (después de pérdidas) de toda la serie (kWh).
  final double totalDcEnergy;

  /// Irradiación en el plano de toda la serie (kWh/m²).
  final double totalPoaIrradiation;

  /// Energía perdida por recorte del inversor en toda la serie (kWh).
  final double clippedEnergy;

  /// Potencia AC por registro (W), si se pidió conservarla.
  final Float64List? hourlyAcPower;

  /// Energía AC del año típico (kWh).
  double get annualAcEnergy => _sum(monthlyAcEnergy);

  /// Irradiación en el plano del año típico (kWh/m²).
  double get annualPoaIrradiation => _sum(monthlyPoaIrradiation);

  /// Rendimiento específico (kWh/kWp por año).
  double get specificYield => annualAcEnergy / (pdc0 / 1000);

  /// Performance ratio = Yf / Yr = (E/Pdc0) / (H_poa / 1 kW/m²).
  double get performanceRatio =>
      annualPoaIrradiation == 0 ? 0 : specificYield / annualPoaIrradiation;

  static double _sum(List<double> v) {
    var s = 0.0;
    for (final x in v) {
      if (!x.isNaN) s += x;
    }
    return s;
  }
}
