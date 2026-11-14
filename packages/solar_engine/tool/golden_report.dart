// Resume los errores del motor contra los datos golden de pvlib, para
// docs/pruebas/validacion-motor.md.
//
// Uso (desde packages/solar_engine): dart run tool/golden_report.dart
// ignore_for_file: avoid_print, herramienta de línea de comandos.

import 'package:solar_engine/solar_engine.dart';

import '../test/helpers/golden.dart';

void main() {
  print(
    '| Sitio | Δ posición máx. (°) | Δ POA máx. s1 | Δ POA máx. s2 '
    '| Δ energía anual s1 | Δ energía anual s2 |',
  );
  print('|---|---|---|---|---|---|');
  final positions = readCsv('$goldenDir/solar_position.csv');
  final annual = readCsv('$goldenDir/annual.csv');
  final hourly = {
    for (final s in ['s1', 's2']) s: readCsv('$goldenDir/hourly_$s.csv'),
  };
  for (final e in goldenSites.entries) {
    final site = e.value;
    var maxPos = 0.0;
    for (final r in positions.where((r) => r['site'] == e.key)) {
      final p = Spa.compute(
        timeUtc: DateTime.fromMillisecondsSinceEpoch(
          int.parse(r['sample_epoch']!) * 1000,
          isUtc: true,
        ),
        latitude: site.latitude,
        longitude: site.longitude,
        elevation: site.elevation,
        pressureHpa: site.pressureHpa,
      );
      var daz = (p.azimuth - num(r, 'azimuth')).abs();
      if (daz > 180) daz = 360 - daz;
      for (final d in [
        (p.apparentZenith - num(r, 'apparent_zenith')).abs(),
        daz,
      ]) {
        if (d > maxPos) maxPos = d;
      }
    }
    final inputs = SimulationInputs.prepare(
      site: site,
      weather: loadTmy(e.key),
    );
    final cells = <String>[e.key, maxPos.toStringAsExponential(1)];
    final energy = <String>[];
    for (final s in ['s1', 's2']) {
      final pv = goldenSystem(s, site);
      var maxPoa = 0.0;
      for (final r in hourly[s]!.where((r) => r['site'] == e.key)) {
        final ref = num(r, 'poa_global');
        if (ref < 50) continue;
        final h = Simulator.hourly(inputs, pv, int.parse(r['row']!));
        final d = (h.poa.global - ref).abs() / ref * 100;
        if (d > maxPoa) maxPoa = d;
      }
      cells.add('${maxPoa.toStringAsExponential(1)} %');
      final ref = num(
        annual.firstWhere((r) => r['site'] == e.key && r['system'] == s),
        'ac_kwh',
      );
      final got = Simulator.run(inputs, pv).totalAcEnergy;
      final rel = ((got - ref) / ref * 100).abs();
      energy.add('${rel.toStringAsExponential(1)} %');
    }
    print('| ${[...cells, ...energy].join(' | ')} |');
  }
}
