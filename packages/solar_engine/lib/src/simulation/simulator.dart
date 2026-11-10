import 'dart:typed_data';

import 'package:solar_engine/src/irradiance/incidence.dart';
import 'package:solar_engine/src/irradiance/poa.dart';
import 'package:solar_engine/src/optics/iam.dart';
import 'package:solar_engine/src/power/pvwatts_dc.dart';
import 'package:solar_engine/src/simulation/monthly_aggregator.dart';
import 'package:solar_engine/src/simulation/pv_system.dart';
import 'package:solar_engine/src/simulation/simulation_inputs.dart';
import 'package:solar_engine/src/simulation/simulation_result.dart';

/// Detalle de un registro de la simulación.
typedef HourlyOutput = ({
  PoaIrradiance poa,
  double aoi,
  double iam,
  double effectiveIrradiance,
  double cellTemperature,
  double dcPower,
  double acPower,
  bool clipping,
});

/// Simulación horaria completa (cadena de modelos del plan, B.6 1–9):
///
/// posición solar → (Erbs) → POA (Perez/Hay-Davies) → IAM ASHRAE →
/// temperatura de celda → Pdc PVWatts → pérdidas y degradación →
/// inversor PVWatts con recorte.
///
/// Ficha: docs/formulas/12-simulacion-horaria.md
abstract final class Simulator {
  /// Calcula un solo registro [i]. [operatingYear] aplica la degradación
  /// (0 = primer año).
  static HourlyOutput hourly(
    SimulationInputs inputs,
    PvSystem system,
    int i, {
    int operatingYear = 0,
  }) {
    final zenith = inputs.zenith[i];
    final blocked = inputs.beamBlocked[i] == 1;
    final poa = planeOfArrayIrradiance(
      surfaceTilt: system.tilt,
      surfaceAzimuth: system.azimuth,
      solarZenith: zenith,
      solarAzimuth: inputs.azimuth[i],
      dni: blocked ? 0 : inputs.dni[i],
      ghi: inputs.ghi[i],
      dhi: inputs.dhi[i],
      dniExtra: inputs.dniExtra[i],
      airmass: inputs.airmass[i],
      albedo: inputs.albedo[i],
      model: system.transposition,
    );
    final aoi = angleOfIncidence(
      system.tilt,
      system.azimuth,
      zenith,
      inputs.azimuth[i],
    );
    final b0 = system.iamB0;
    final iam = b0 == null ? 1.0 : ashraeIam(aoi, b0: b0);
    final eff = poa.direct * iam + poa.diffuse;
    final weather = inputs.weather;
    final temp = weather.tempAir[i];
    final wind = weather.windSpeed[i];
    final tc = system.temperatureModel.cellTemperature(
      poa.global,
      temp.isNaN ? 25 : temp,
      wind.isNaN ? 1 : wind,
    );
    final losses = system.losses;
    final pdc =
        pvwattsDc(
          effectiveIrradiance: eff,
          cellTemperature: tc,
          pdc0: system.pdc0,
          gammaPdc: system.gammaPdc,
        ) *
        losses.factor *
        losses.degradationFactor(operatingYear);
    return (
      poa: poa,
      aoi: aoi,
      iam: iam,
      effectiveIrradiance: eff,
      cellTemperature: tc,
      dcPower: pdc,
      acPower: system.inverter.acPower(pdc),
      clipping: system.inverter.isClipping(pdc),
    );
  }

  /// Simula toda la serie.
  static SimulationResult run(
    SimulationInputs inputs,
    PvSystem system, {
    int operatingYear = 0,
    bool keepHourly = false,
  }) {
    final weather = inputs.weather;
    final step = weather.stepHours;
    final offset = inputs.site.utcOffsetHours;
    final ac = MonthlyAggregator(stepHours: step);
    final poaAgg = MonthlyAggregator(stepHours: step);
    final hourlyAc = keepHourly ? Float64List(inputs.length) : null;
    var totalAc = 0.0;
    var totalDc = 0.0;
    var totalPoa = 0.0;
    var clipped = 0.0;
    for (var i = 0; i < inputs.length; i++) {
      final local = weather.localStart(i, offset);
      if (inputs.zenith[i] >= 90 && inputs.ghi[i] <= 0) {
        ac.add(local, 0);
        poaAgg.add(local, 0);
        continue;
      }
      final h = hourly(inputs, system, i, operatingYear: operatingYear);
      final eAc = h.acPower * step / 1000;
      final ePoa = h.poa.global * step / 1000;
      ac.add(local, eAc);
      poaAgg.add(local, ePoa);
      hourlyAc?[i] = h.acPower;
      totalAc += eAc;
      totalDc += h.dcPower * step / 1000;
      totalPoa += ePoa;
      if (h.clipping) {
        clipped +=
            (system.inverter.unclippedAcPower(h.dcPower) - h.acPower) *
            step /
            1000;
      }
    }
    return SimulationResult(
      pdc0: system.pdc0,
      monthlyAcEnergy: ac.typicalMonthlySums(),
      monthlyPoaIrradiation: poaAgg.typicalMonthlySums(),
      yearlyAcEnergy: ac.completeYearSums(),
      totalAcEnergy: totalAc,
      totalDcEnergy: totalDc,
      totalPoaIrradiation: totalPoa,
      clippedEnergy: clipped,
      hourlyAcPower: hourlyAc,
    );
  }
}
