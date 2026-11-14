import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

import '../helpers/golden.dart';

/// Validación golden de la simulación completa contra pvlib (plan D):
/// POA ±1 % por hora (o ±1 W/m² en valores pequeños) y energía anual ±2 %.
void main() {
  final annual = readCsv('$goldenDir/annual.csv');
  for (final system in ['s1', 's2']) {
    final hourly = readCsv('$goldenDir/hourly_$system.csv');
    for (final site in goldenSites.keys) {
      group('$site / $system', () {
        final s = goldenSites[site]!;
        final inputs = SimulationInputs.prepare(
          site: s,
          weather: loadTmy(site),
        );
        final pv = goldenSystem(system, s);

        test('POA horaria ±1 % y cadena de potencia', () {
          final rows = hourly.where((r) => r['site'] == site).toList();
          expect(rows, isNotEmpty);
          for (final r in rows) {
            final h = Simulator.hourly(inputs, pv, int.parse(r['row']!));
            final poa = num(r, 'poa_global');
            expect(h.poa.global, closeTo(poa, 0.01 * poa + 1), reason: 'POA');
            expect(h.aoi, closeTo(num(r, 'aoi'), 0.01));
            expect(h.iam, closeTo(num(r, 'iam'), 1e-3));
            expect(h.cellTemperature, closeTo(num(r, 'temp_cell'), 0.1));
            final pac = num(r, 'pac');
            expect(h.acPower, closeTo(pac, 0.01 * pac + 1), reason: 'Pac');
          }
        });

        test('energía anual ±2 %', () {
          final ref = annual.firstWhere(
            (r) => r['site'] == site && r['system'] == system,
          );
          final result = Simulator.run(inputs, pv);
          final ac = num(ref, 'ac_kwh');
          final poa = num(ref, 'poa_kwh_m2');
          expect(result.totalAcEnergy, closeTo(ac, 0.02 * ac));
          expect(result.totalPoaIrradiation, closeTo(poa, 0.01 * poa));
          expect(result.totalDcEnergy, closeTo(num(ref, 'dc_kwh'), 0.02 * ac));
        });
      });
    }
  }
}
