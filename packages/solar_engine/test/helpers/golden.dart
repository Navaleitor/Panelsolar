import 'dart:io';
import 'dart:typed_data';

import 'package:solar_engine/solar_engine.dart';

/// Carpeta de datos golden (generados con tools/golden_data).
const String goldenDir = 'test/golden';

/// Sitios de referencia (igual que tools/golden_data/sites.py).
const Map<String, Site> goldenSites = {
  'monterrey': Site(latitude: 25.6866, longitude: -100.3161, elevation: 540),
  'cdmx': Site(latitude: 19.4326, longitude: -99.1332, elevation: 2240),
  'hermosillo': Site(latitude: 29.0729, longitude: -110.9559, elevation: 210),
  'madrid': Site(latitude: 40.4168, longitude: -3.7038, elevation: 667),
  'bogota': Site(latitude: 4.7110, longitude: -74.0721, elevation: 2640),
  'phoenix': Site(latitude: 33.4484, longitude: -112.0740, elevation: 331),
};

/// Lee un CSV con encabezado como lista de mapas columna → texto.
List<Map<String, String>> readCsv(String path) {
  final file = File(path);
  final text = path.endsWith('.gz')
      ? String.fromCharCodes(gzip.decode(file.readAsBytesSync()))
      : file.readAsStringSync();
  final lines = text.trim().split('\n');
  final header = lines.first.trim().split(',');
  return [
    for (final line in lines.skip(1))
      Map.fromIterables(header, line.trim().split(',')),
  ];
}

/// Valor numérico de una columna.
double num(Map<String, String> row, String key) => double.parse(row[key]!);

/// Carga el TMY de PVGIS de un sitio como [WeatherSeries]. Si [repeatYears]
/// > 1, repite la serie desplazándola un año cada vez (para pruebas de
/// rendimiento).
WeatherSeries loadTmy(String site, {int repeatYears = 1}) {
  final rows = readCsv('$goldenDir/tmy/$site.csv.gz');
  final n = rows.length * repeatYears;
  final epochs = List<int>.filled(n, 0);
  final ghi = Float64List(n);
  final dni = Float64List(n);
  final dhi = Float64List(n);
  final temp = Float64List(n);
  final wind = Float64List(n);
  for (var y = 0; y < repeatYears; y++) {
    for (var i = 0; i < rows.length; i++) {
      final k = y * rows.length + i;
      final r = rows[i];
      epochs[k] = int.parse(r['epoch_start']!) + y * 365 * 86400;
      ghi[k] = num(r, 'ghi');
      dni[k] = num(r, 'dni');
      dhi[k] = num(r, 'dhi');
      temp[k] = num(r, 'temp_air');
      wind[k] = num(r, 'wind_speed');
    }
  }
  return WeatherSeries(
    startEpochSeconds: epochs,
    ghi: ghi,
    dni: dni,
    dhi: dhi,
    tempAir: temp,
    windSpeed: wind,
  );
}

/// Sistemas de prueba (igual que tools/golden_data/reference_model.py).
PvSystem goldenSystem(String name, Site site) => switch (name) {
  's1' => PvSystem(
    tilt: site.latitude.abs().roundToDouble(),
    azimuth: 180,
    pdc0: 1000,
    inverter: const PvwattsInverter(pacMax: 1000 / 1.2),
  ),
  _ => const PvSystem(
    tilt: 10,
    azimuth: 135,
    pdc0: 1000,
    gammaPdc: -0.004,
    inverter: PvwattsInverter(pacMax: 1000 / 1.4, etaNominal: 0.97),
    losses: SystemLosses.none,
    temperatureModel: NoctModel(),
    transposition: TranspositionModel.hayDavies,
  ),
};
