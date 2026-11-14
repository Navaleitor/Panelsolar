import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/production/domain/performance.dart';
import 'package:persistence/persistence.dart';

ProductionReading reading(int month, double actual, double? expected) =>
    ProductionReading(
      id: '$month',
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
      projectId: 'p',
      month: DateTime.utc(2026, month),
      actualKwh: actual,
      expectedKwh: expected,
    );

void main() {
  test('índice real/esperado y desviación', () {
    expect(performanceIndex(595, 700), closeTo(0.85, 1e-9));
    expect(deviationFromExpectedPct(595, 700), closeTo(-15, 1e-9));
    expect(performanceIndex(595, null), isNull);
    expect(performanceIndex(595, 0), isNull);
  });

  test('PR = E / (kWp × H): 5 kWp, 150 kWh/m², 600 kWh → 0.80', () {
    expect(performanceRatio(600, 5, 150), closeTo(0.8, 1e-9));
    expect(performanceRatio(600, null, 150), isNull);
    expect(performanceRatio(600, 5, 0), isNull);
  });

  test('alerta solo si queda por debajo del umbral', () {
    expect(isBelowThreshold(595, 700, -15), isFalse); // justo −15 %
    expect(isBelowThreshold(594, 700, -15), isTrue);
    expect(isBelowThreshold(594, null, -15), isFalse);
  });

  test('resumen de los últimos 12 meses', () {
    final readings = [
      for (var m = 1; m <= 12; m++) reading(m, 600, 700),
      reading(13, 500, 700), // enero siguiente: −28.6 %
    ];
    final s = ProductionSummary.of(readings, thresholdPct: -15);
    expect(s.actualKwh, 600 * 11 + 500);
    expect(s.expectedKwh, 700 * 12);
    expect(s.alerts.single.id, '13');
    expect(s.latestInAlert, isTrue);
  });
}
