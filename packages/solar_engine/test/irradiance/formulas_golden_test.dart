import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import '../helpers/golden.dart';

/// Compara cada fórmula suelta contra los casos de pvlib en
/// test/golden/formulas.csv (tolerancia 1e-6 relativa).
void main() {
  final rows = readCsv('$goldenDir/formulas.csv');
  double inp(Map<String, String> r, int i) => num(r, 'in$i');

  double compute(Map<String, String> r) {
    final f = r['formula']!;
    switch (f) {
      case 'extra_spencer':
        return extraterrestrialNormal(inp(r, 0).toInt());
      case 'airmass_ky':
        return relativeAirmass(inp(r, 0));
      case 'alt2pres':
        return altitudeToPressure(inp(r, 0));
      case 'aoi':
        return angleOfIncidence(inp(r, 0), inp(r, 1), inp(r, 2), inp(r, 3));
      case 'erbs_dni' || 'erbs_dhi' || 'erbs_kt':
        final e = erbs(
          inp(r, 0),
          inp(r, 1),
          extraterrestrialNormal(inp(r, 2).toInt()),
        );
        return f == 'erbs_dni' ? e.dni : (f == 'erbs_dhi' ? e.dhi : e.kt);
      case 'iam_ashrae':
        return ashraeIam(inp(r, 0), b0: inp(r, 1));
      case 'faiman':
        return const FaimanModel().cellTemperature(
          inp(r, 0),
          inp(r, 1),
          inp(r, 2),
        );
      case 'ross_noct45':
        return const NoctModel().cellTemperature(inp(r, 0), inp(r, 1), 3);
      case 'pvwatts_dc':
        return pvwattsDc(
          effectiveIrradiance: inp(r, 0),
          cellTemperature: inp(r, 1),
          pdc0: inp(r, 2),
          gammaPdc: inp(r, 3),
        );
      case 'inverter_pvwatts':
        final etaNom = inp(r, 2);
        return PvwattsInverter(
          pacMax: inp(r, 1) * etaNom,
          etaNominal: etaNom,
        ).acPower(inp(r, 0));
      case 'losses_default':
        return const SystemLosses().totalPercent;
      case 'perez' || 'haydavies':
        final args = [for (var i = 0; i < 7; i++) inp(r, i)];
        if (f == 'haydavies') {
          return hayDaviesSkyDiffuse(
            surfaceTilt: args[0],
            surfaceAzimuth: args[1],
            dhi: args[2],
            dni: args[3],
            dniExtra: args[4],
            solarZenith: args[5],
            solarAzimuth: args[6],
          );
        }
        return perezSkyDiffuse(
          surfaceTilt: args[0],
          surfaceAzimuth: args[1],
          dhi: args[2],
          dni: args[3],
          dniExtra: args[4],
          solarZenith: args[5],
          solarAzimuth: args[6],
          airmass: relativeAirmass(args[5]),
        );
    }
    throw StateError('Fórmula desconocida: $f');
  }

  for (final (i, r) in rows.indexed) {
    test('${r['formula']} caso $i', () {
      final expected = num(r, 'out');
      expect(compute(r), closeTo(expected, 1e-6 * expected.abs() + 1e-7));
    });
  }
}
