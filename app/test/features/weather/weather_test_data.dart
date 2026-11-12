import 'dart:io';
import 'dart:typed_data';

import 'package:data_sources/data_sources.dart';
import 'package:solar_engine/solar_engine.dart';

/// Sitio de prueba: Monterrey.
const Site monterrey = Site(
  latitude: 25.6866,
  longitude: -100.3161,
  elevation: 540,
);

/// TMY de PVGIS de Monterrey (el mismo de las pruebas golden del motor).
WeatherDataset monterreyTmy() {
  final bytes = File(
    '../packages/solar_engine/test/golden/tmy/monterrey.csv.gz',
  ).readAsBytesSync();
  final lines = String.fromCharCodes(gzip.decode(bytes)).trim().split('\n');
  final rows = [for (final l in lines.skip(1)) l.split(',')];
  Float64List col(int i) =>
      Float64List.fromList([for (final r in rows) double.parse(r[i])]);
  return WeatherDataset(
    source: WeatherSource.pvgisTmy,
    latitude: monterrey.latitude,
    longitude: monterrey.longitude,
    elevation: 540,
    version: '5.3',
    accessedAt: DateTime.utc(2026, 11, 10),
    radiationDatabase: 'PVGIS-ERA5',
    series: WeatherSeries(
      startEpochSeconds: [for (final r in rows) int.parse(r[0])],
      ghi: col(1),
      dni: col(2),
      dhi: col(3),
      tempAir: col(4),
      windSpeed: col(5),
    ),
  );
}

/// Clima de prueba con el TMY como serie principal.
SiteClimate monterreyClimate() {
  final tmy = monterreyTmy();
  final qc = WeatherQualityControl.check(tmy.series, monterrey);
  return SiteClimate(
    primary: tmy.withSeries(qc.series),
    primaryQuality: qc.report,
    tmy: tmy.withSeries(qc.series),
    horizon: HorizonProfile.flat(),
    warnings: const ['Advertencia de prueba'],
  );
}
