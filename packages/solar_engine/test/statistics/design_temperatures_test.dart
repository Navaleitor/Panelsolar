import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

DesignTemperatures _t(double min, double max) => (
  recordMin: min,
  recordMax: max,
  meanAnnualMin: min + 2,
  meanAnnualMax: max - 2,
);

void main() {
  test('usa la mínima más fría y la máxima más caliente', () {
    final d = SiteDesignTemperatures.mostExtreme({
      'NASA POWER': _t(-5.7, 37.6),
      'PVGIS': _t(-2.1, 40.3),
    });
    expect(d.min, -5.7);
    expect(d.minSource, 'NASA POWER');
    expect(d.max, 40.3);
    expect(d.maxSource, 'PVGIS');
    expect(d.bySource.length, 2);
  });

  test('ignora fuentes sin datos', () {
    final d = SiteDesignTemperatures.mostExtreme({
      'A': _t(double.nan, double.nan),
      'B': _t(3, 30),
    });
    expect((d.min, d.max, d.minSource, d.maxSource), (3, 30, 'B', 'B'));
    final empty = SiteDesignTemperatures.mostExtreme({});
    expect(empty.min.isNaN, isTrue);
    expect(empty.maxSource, isNull);
  });
}
