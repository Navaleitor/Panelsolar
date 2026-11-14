import 'package:solar_engine/src/power/losses.dart';
import 'package:solar_engine/src/power/pvwatts_inverter.dart';
import 'package:solar_engine/src/simulation/pv_system.dart';
import 'package:solar_engine/src/simulation/simulation_inputs.dart';
import 'package:solar_engine/src/simulation/simulator.dart';

/// Paneles de un plano con la misma orientación.
class ArrayGroup {
  /// Crea el grupo.
  const new({
    required this.tiltDeg,
    required this.azimuthDeg,
    required this.panelCount,
    required this.panelPowerW,
    this.shadingLoss = 0,
  });

  /// Inclinación de los paneles (grados).
  final double tiltDeg;

  /// Azimut de los paneles (grados, 180 = sur).
  final double azimuthDeg;

  /// Número de paneles.
  final int panelCount;

  /// Potencia de cada panel en STC (W).
  final double panelPowerW;

  /// Pérdida por sombra calculada (0–1), con el efecto eléctrico.
  final double shadingLoss;

  /// Potencia DC del grupo (W).
  double get pdcW => panelCount * panelPowerW;
}

/// Rango recomendado de la relación DC/AC (plan B.6 punto 9).
const double dcAcRecommendedMin = 1.1;

/// Límite superior recomendado de la relación DC/AC.
const double dcAcRecommendedMax = 1.35;

/// Producción del sistema diseñado.
class DesignProduction {
  /// Crea el resultado.
  const new({
    required this.pdcW,
    required this.pacW,
    required this.firstYearKwh,
    required this.monthlyFirstYearKwh,
    required this.yearlyKwh,
    required this.clippedKwh,
    required this.shadingLoss,
    required this.poaKwhPerM2,
  });

  /// Potencia DC instalada (W).
  final double pdcW;

  /// Potencia AC de los inversores (W).
  final double pacW;

  /// Energía AC del primer año (kWh).
  final double firstYearKwh;

  /// Energía AC por mes del primer año (12 valores, kWh).
  final List<double> monthlyFirstYearKwh;

  /// Energía AC de cada año de operación (kWh), con degradación.
  final List<double> yearlyKwh;

  /// Energía recortada por el inversor en un año (kWh).
  final double clippedKwh;

  /// Pérdida por sombra ponderada por potencia (0–1).
  final double shadingLoss;

  /// Irradiación anual en el plano, ponderada por potencia (kWh/m²).
  final double poaKwhPerM2;

  /// Relación DC/AC.
  double get dcAcRatio => pacW <= 0 ? 0 : pdcW / pacW;

  /// `true` si la relación está en 1.1–1.35.
  bool get dcAcInRange =>
      dcAcRatio >= dcAcRecommendedMin && dcAcRatio <= dcAcRecommendedMax;

  /// Energía de toda la vida útil (kWh).
  double get lifetimeKwh => yearlyKwh.fold(0, (s, e) => s + e);

  /// Rendimiento específico del primer año (kWh/kWp).
  double get specificYield => pdcW <= 0 ? 0 : firstYearKwh / (pdcW / 1000);

  /// Performance ratio del primer año.
  double get performanceRatio =>
      poaKwhPerM2 <= 0 ? 0 : specificYield / poaKwhPerM2;

  /// Recorte como fracción de la energía del primer año.
  double get clippingFraction => firstYearKwh + clippedKwh <= 0
      ? 0
      : clippedKwh / (firstYearKwh + clippedKwh);
}

/// Simulación anual con el sistema real (B.6 puntos 8 y 9): pérdidas
/// editables, sombra calculada por grupo, recorte del inversor y
/// degradación anual.
/// Ficha: docs/formulas/28-produccion-del-sistema.md
abstract final class DesignSimulator {
  /// Simula los [groups] con [pacW] de inversores repartidos en proporción
  /// a la potencia DC de cada grupo.
  static DesignProduction run({
    required SimulationInputs inputs,
    required List<ArrayGroup> groups,
    required double pacW,
    double inverterEfficiency = 0.96,
    double gammaPdc = -0.0035,
    SystemLosses losses = const SystemLosses(),
    int years = 25,
  }) {
    final pdc = groups.fold<double>(0, (s, g) => s + g.pdcW);
    final monthly = List<double>.filled(12, 0);
    var annual = 0.0;
    var clipped = 0.0;
    var shade = 0.0;
    var poa = 0.0;
    if (pdc > 0 && pacW > 0) {
      for (final g in groups) {
        if (g.pdcW <= 0) continue;
        final share = g.pdcW / pdc;
        final system = PvSystem(
          tilt: g.tiltDeg,
          azimuth: g.azimuthDeg,
          pdc0: g.pdcW,
          gammaPdc: gammaPdc,
          inverter: PvwattsInverter(
            pacMax: pacW * share,
            etaNominal: inverterEfficiency,
          ),
          losses: losses.copyWith(shading: g.shadingLoss * 100),
        );
        final r = Simulator.run(inputs, system);
        for (var m = 0; m < 12; m++) {
          final v = r.monthlyAcEnergy[m];
          if (!v.isNaN) monthly[m] += v;
        }
        annual += r.annualAcEnergy;
        if (r.totalAcEnergy > 0) {
          clipped += r.clippedEnergy * r.annualAcEnergy / r.totalAcEnergy;
        }
        shade += g.shadingLoss * share;
        poa += r.annualPoaIrradiation * share;
      }
    }
    return DesignProduction(
      pdcW: pdc,
      pacW: pacW,
      firstYearKwh: annual,
      monthlyFirstYearKwh: monthly,
      yearlyKwh: [
        for (var y = 0; y < years; y++) annual * losses.degradationFactor(y),
      ],
      clippedKwh: clipped,
      shadingLoss: shade,
      poaKwhPerM2: poa,
    );
  }
}
