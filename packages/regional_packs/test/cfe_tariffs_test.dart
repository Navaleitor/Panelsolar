import 'package:regional_packs/regional_packs.dart';
import 'package:test/test.dart';

void main() {
  test('México trae 1, 1A–1F, DAC y PDBT', () {
    expect(mexicoTariffs.tariffs.map((t) => t.shortName), [
      '1',
      '1A',
      '1B',
      '1C',
      '1D',
      '1E',
      '1F',
      'DAC',
      'PDBT',
    ]);
    expect(TariffCatalog.validate(mexicoTariffs.tariffs), isEmpty);
  });

  test('las domésticas son bimestrales y PDBT mensual', () {
    expect(
      mexicoTariffs.byCode('MX-CFE-1C')!.billingPeriod,
      TariffBillingPeriod.bimonthly,
    );
    final pdbt = mexicoTariffs.byCode('MX-CFE-PDBT')!;
    expect(pdbt.billingPeriod, TariffBillingPeriod.monthly);
    expect(pdbt.sector, TariffSector.commercial);
  });

  test('temperatura de verano crece de 1A a 1F', () {
    final temps = [
      for (final s in ['1A', '1B', '1C', '1D', '1E', '1F'])
        mexicoTariffs.byCode('MX-CFE-$s')!.minSummerAvgTempC!,
    ];
    expect(temps, [25, 28, 30, 31, 32, 33]);
  });

  test('límite de alto consumo (DAC)', () {
    final t1 = mexicoTariffs.byCode('MX-CFE-1')!;
    expect(t1.highConsumptionLimitKwhPerMonth, 250);
    expect(t1.exceedsHighConsumptionLimit(250), isFalse);
    expect(t1.exceedsHighConsumptionLimit(251), isTrue);
    expect(
      mexicoTariffs.byCode('MX-CFE-1F')!.highConsumptionLimitKwhPerMonth,
      2500,
    );
    expect(
      mexicoTariffs.byCode('MX-CFE-DAC')!.exceedsHighConsumptionLimit(9999),
      isFalse,
    );
  });

  test('nombres en es/en y búsqueda por código', () {
    final dac = mexicoTariffs.byCode('MX-CFE-DAC')!;
    expect(dac.name('es'), contains('alto consumo'));
    expect(dac.name('en'), contains('High-consumption'));
    expect(mexicoTariffs.byCode('MX-CFE-XX'), isNull);
    expect(mexicoTariffs.byCode(null), isNull);
  });

  group('validador', () {
    const base = Tariff(
      code: 'MX-CFE-1',
      shortName: '1',
      country: 'MX',
      utility: 'CFE',
      sector: TariffSector.residential,
      billingPeriod: TariffBillingPeriod.bimonthly,
      nameEs: 'a',
      nameEn: 'b',
    );

    test('detecta códigos repetidos y prefijo incorrecto', () {
      const wrong = Tariff(
        code: 'CFE-2',
        shortName: '2',
        country: 'MX',
        utility: 'CFE',
        sector: TariffSector.residential,
        billingPeriod: TariffBillingPeriod.bimonthly,
        nameEs: 'a',
        nameEn: 'b',
        highConsumptionLimitKwhPerMonth: -1,
      );
      final problems = TariffCatalog.validate([base, base, wrong]);
      expect(problems, hasLength(3));
      expect(() => TariffCatalog([base, base]), throwsFormatException);
    });

    test('JSON mal formado lanza FormatException', () {
      expect(
        () => TariffCatalog.fromJsonString('{"x": []}'),
        throwsFormatException,
      );
      expect(
        () => TariffCatalog.fromJsonString('{"tariffs": [{"code": 1}]}'),
        throwsFormatException,
      );
    });
  });
}
