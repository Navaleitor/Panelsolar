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

/// Clima de prueba: serie principal "NASA POWER" sintética (el mismo TMY
/// con +2 °C, para que las dos fuentes difieran) y el TMY de PVGIS.
SiteClimate monterreyClimate() {
  final tmy = monterreyTmy();
  final s = tmy.series;
  final nasa = WeatherDataset(
    source: WeatherSource.nasaPower,
    latitude: tmy.latitude,
    longitude: tmy.longitude,
    elevation: 786,
    version: 'v2.10.4',
    accessedAt: tmy.accessedAt,
    yearStart: 2021,
    yearEnd: 2025,
    series: WeatherSeries(
      startEpochSeconds: s.startEpochSeconds,
      ghi: s.ghi,
      dni: s.dni,
      dhi: s.dhi,
      tempAir: Float64List.fromList([for (final t in s.tempAir) t + 2]),
      windSpeed: s.windSpeed,
    ),
  );
  final qc = WeatherQualityControl.check(nasa.series, monterrey);
  return SiteClimate(
    primary: nasa.withSeries(qc.series),
    primaryQuality: qc.report,
    tmy: tmy.withSeries(WeatherQualityControl.check(s, monterrey).series),
    horizon: HorizonProfile.flat(),
    warnings: const ['Advertencia de prueba'],
  );
}
