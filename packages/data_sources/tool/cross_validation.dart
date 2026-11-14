// Validación cruzada del motor (plan D): energía anual de 1 kWp en los 6
// sitios con el motor de Panelsolar, comparada con PVWatts (NREL, vía PySAM)
// y PVGIS PVcalc (tools/golden_data/out/cross_reference.csv).
//
// Uso (desde packages/data_sources; necesita red para NASA POWER):
//   dart run tool/cross_validation.dart
// Escribe tools/golden_data/out/engine_results.csv y una tabla Markdown.
// ignore_for_file: avoid_print, herramienta de línea de comandos.

import 'dart:io';
import 'dart:typed_data';

import 'package:data_sources/data_sources.dart';
import 'package:http/http.dart' as http;
import 'package:solar_engine/solar_engine.dart';

const _root = '../..';
const _sites = {
  'monterrey': Site(latitude: 25.6866, longitude: -100.3161, elevation: 540),
  'cdmx': Site(latitude: 19.4326, longitude: -99.1332, elevation: 2240),
  'hermosillo': Site(latitude: 29.0729, longitude: -110.9559, elevation: 210),
  'madrid': Site(latitude: 40.4168, longitude: -3.7038, elevation: 667),
  'bogota': Site(latitude: 4.7110, longitude: -74.0721, elevation: 2640),
  'phoenix': Site(latitude: 33.4484, longitude: -112.0740, elevation: 331),
};

/// Mismo sistema que tools/golden_data/cross_validation.py.
PvSystem _system(Site s) => PvSystem(
  tilt: s.latitude.abs().roundToDouble(),
  azimuth: 180,
  pdc0: 1000,
  gammaPdc: -0.0037,
  inverter: const PvwattsInverter(pacMax: 1000 / 1.2),
  losses: const SystemLosses(shading: 3),
);

List<Map<String, String>> _csv(String text) {
  final lines = text.trim().split('\n');
  final header = lines.first.split(',');
  return [
    for (final l in lines.skip(1)) Map.fromIterables(header, l.split(',')),
  ];
}

WeatherSeries _tmy(String key) {
  final bytes = File('$_root/packages/solar_engine/test/golden/tmy/$key.csv.gz')
      .readAsBytesSync();
  final rows = _csv(String.fromCharCodes(gzip.decode(bytes)));
  Float64List col(String k) =>
      Float64List.fromList([for (final r in rows) double.parse(r[k]!)]);
  return WeatherSeries(
    startEpochSeconds: [for (final r in rows) int.parse(r['epoch_start']!)],
    ghi: col('ghi'),
    dni: col('dni'),
    dhi: col('dhi'),
    tempAir: col('temp_air'),
    windSpeed: col('wind_speed'),
  );
}

String _pct(double a, double b) {
  final d = (a - b) / b * 100;
  return '${d >= 0 ? '+' : ''}${d.toStringAsFixed(1)} %';
}

Future<void> main() async {
  final ref = {
    for (final r in _csv(
      File('$_root/tools/golden_data/out/cross_reference.csv')
          .readAsStringSync(),
    ))
      r['site']!: r,
  };
  final client = http.Client();
  final repo = WeatherRepository(
    nasa: NasaPowerClient(client: client),
    pvgis: PvgisClient(client: client),
    cache: ProjectCache(Directory('$_root/tools/golden_data/out/cache')),
  );
  final out = StringBuffer(
    'site,engine_tmy_kwh,pvwatts_tmy_kwh,engine_nasa_kwh,pvgis_kwh,'
    'nasa_vs_pvgis_ghi_pct,nasa_minus_pvgis_temp_c\n',
  );
  print(
    '| Sitio | Motor + TMY | PVWatts + TMY | Dif. | Motor + NASA '
    '| PVGIS PVcalc | Dif. | GHI NASA/PVGIS | ΔT media |',
  );
  print('|---|---|---|---|---|---|---|---|---|');
  for (final e in _sites.entries) {
    final site = e.value;
    final system = _system(site);
    final tmyEnergy = Simulator.run(
      SimulationInputs.prepare(site: site, weather: _tmy(e.key)),
      system,
    ).totalAcEnergy;
    final climate = await repo.load(projectId: 'xval_${e.key}', site: site);
    final nasaEnergy = Simulator.run(
      SimulationInputs.prepare(site: site, weather: climate.primary.series),
      system,
    ).annualAcEnergy;
    final cross = climate.crossCheck!;
    final r = ref[e.key]!;
    final pvwatts = double.parse(r['pvwatts_kwh']!);
    final pvgis = double.parse(r['pvgis_kwh']!);
    final ghiPct = cross.differencePercent;
    final dT = cross.temperatureDifference;
    final cells = [
      e.key,
      tmyEnergy.toStringAsFixed(1),
      pvwatts.toStringAsFixed(1),
      nasaEnergy.toStringAsFixed(1),
      pvgis.toStringAsFixed(1),
      ghiPct.toStringAsFixed(2),
      dT.toStringAsFixed(2),
    ];
    out.writeln(cells.join(','));
    final row = [
      e.key,
      '${tmyEnergy.round()}',
      '${pvwatts.round()}',
      _pct(tmyEnergy, pvwatts),
      '${nasaEnergy.round()}',
      '${pvgis.round()}',
      _pct(nasaEnergy, pvgis),
      '${ghiPct.toStringAsFixed(1)} %',
      '${dT.toStringAsFixed(1)} °C',
    ];
    print('| ${row.join(' | ')} |');
  }
  File('$_root/tools/golden_data/out/engine_results.csv')
      .writeAsStringSync(out.toString());
  client.close();
}
