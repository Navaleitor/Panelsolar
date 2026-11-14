import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/weather/domain/weather_analysis.dart';
import 'package:solar_engine/solar_engine.dart';

import 'weather_test_data.dart';

void main() {
  test('análisis de Monterrey: producción, óptimo y carta solar', () {
    final a = analyzeClimate(monterreyClimate(), monterrey, year: 2026);
    expect(a.annualEnergy, inInclusiveRange(1500, 2000));
    expect(a.monthlyEnergy.length, 12);
    expect(a.optimalTilt, inInclusiveRange(15, 35));
    expect(a.optimalAzimuth, inInclusiveRange(160, 200));
    // La regla "inclinación = latitud" nunca supera al óptimo.
    expect(a.latitudeTiltEnergy, lessThanOrEqualTo(a.annualEnergy + 1));
    expect(a.performanceRatio, inInclusiveRange(0.7, 0.9));
    expect(a.sunPath.length, 4);
    expect(a.statistics.design.recordMax, greaterThan(30));
    expect(a.sourceLabel, 'NASA POWER 2021–2025');
    expect(a.attributions.length, 3);
    expect(a.attributions.last, contains('PVGIS'));
    expect(a.warnings, ['Advertencia de prueba']);
  });

  test('temperaturas de diseño: la más extrema de NASA y PVGIS', () {
    final a = analyzeClimate(monterreyClimate(), monterrey, year: 2026);
    final d = a.designTemperatures;
    final nasa = d.bySource['NASA POWER']!;
    final pvgis = d.bySource['PVGIS']!;
    // NASA sintética = PVGIS + 2 °C: la mínima sale de PVGIS y la máxima
    // de NASA.
    expect(nasa.recordMax, closeTo(pvgis.recordMax + 2, 1e-9));
    expect((d.min, d.minSource), (pvgis.recordMin, 'PVGIS'));
    expect((d.max, d.maxSource), (nasa.recordMax, 'NASA POWER'));
  });

  test('zona horaria y desfase estándar se reportan', () {
    const site = Site(
      latitude: 25.6866,
      longitude: -100.3161,
      utcOffsetHours: -6,
    );
    final a = analyzeClimate(
      monterreyClimate(),
      site,
      year: 2026,
      timeZone: 'America/Monterrey',
    );
    expect(a.timeZone, 'America/Monterrey');
    expect(a.utcOffsetHours, -6);
  });

  test('sistema de referencia: 1 kWp', () {
    final s = referenceSystem(tilt: 20, azimuth: 180);
    expect(s.pdc0, 1000);
    expect(s.dcAcRatio, closeTo(1.2, 1e-9));
    expect(s.transposition, TranspositionModel.perez);
  });
}
