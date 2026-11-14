import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

// Caso de libro (ficha 22): panel Voc 37.8 V, Vmp 31.0 V, Isc 9.0 A,
// βVoc −0.30 %/°C, βVmp −0.40 %/°C; inversor 600 V, MPPT 150–500 V,
// 12 A por MPPT, 2 MPPT; sitio con −5 °C y 40 °C.
const module = StringModule(
  pmaxW: 250,
  vocV: 37.8,
  iscA: 9,
  vmpV: 31,
  impA: 8.1,
  betaVocPct: -0.30,
  betaVmpPct: -0.40,
);
const inverter = StringInverter(
  pacW: 5000,
  vdcMaxV: 600,
  mpptMinV: 150,
  mpptMaxV: 500,
  mpptCount: 2,
  imaxPerMpptA: 12,
);
const StringTemperatures temps = (minAmbientC: -5.0, maxAmbientC: 40.0);

void main() {
  final limits = StringSizing.limits(
    module: module,
    inverter: inverter,
    temps: temps,
  );

  group('Límites de string (B.6 punto 14)', () {
    test('Voc a Tmin = 37.8 × 1.09 = 41.20 V → máximo 14 en serie', () {
      expect(limits.vocColdV, closeTo(41.202, 1e-3));
      expect(limits.maxSeries, 14);
    });

    test('Vmp a Tc máx (40 + 31.4 °C) = 25.25 V → mínimo 6 en serie', () {
      expect(limits.cellTempHotC, closeTo(71.41, 0.01));
      expect(limits.vmpHotV, closeTo(25.245, 1e-3));
      expect(limits.minSeries, 6);
    });

    test('Isc × 1.25 = 11.25 A ≤ 12 A → un string por MPPT', () {
      expect(limits.stringDesignCurrentA, closeTo(11.25, 1e-9));
      expect(limits.maxParallelPerMppt, 1);
      expect(limits.feasible, isTrue);
    });

    test('la norma (600 V) limita aunque el inversor acepte más', () {
      const big = StringInverter(
        pacW: 5000,
        vdcMaxV: 1000,
        mpptMinV: 150,
        mpptMaxV: 800,
        mpptCount: 2,
        imaxPerMpptA: 12,
        iscMaxPerMpptA: 30,
      );
      final l = StringSizing.limits(
        module: module,
        inverter: big,
        temps: temps,
      );
      expect(l.maxSeries, 14);
      final l1000 = StringSizing.limits(
        module: module,
        inverter: big,
        temps: temps,
        systemVoltageLimit: 1000,
      );
      expect(l1000.maxSeries, 24);
    });
  });

  group('Propuesta automática', () {
    test('20 paneles → 2 strings de 10 (uno por MPPT)', () {
      final p = StringPlanner.propose(
        totalPanels: 20,
        limits: limits,
        inverterCount: 1,
        mpptCount: 2,
      );
      expect(p.groups, hasLength(2));
      expect(p.groups.every((g) => g.series == 10 && g.parallel == 1), isTrue);
      expect(p.usedPanels, 20);
      expect(p.unusedPanels, 0);
    });

    test('31 paneles → 2 strings de 14 y sobran 3', () {
      final p = StringPlanner.propose(
        totalPanels: 31,
        limits: limits,
        inverterCount: 1,
        mpptCount: 2,
      );
      expect(p.groups.map((g) => g.series), [14, 14]);
      expect(p.unusedPanels, 3);
    });

    test('con microinversores, un panel por entrada', () {
      final p = StringPlanner.propose(
        totalPanels: 5,
        limits: limits,
        inverterCount: 3,
        mpptCount: 2,
        microinverter: true,
      );
      expect(p.groups, hasLength(5));
      expect(p.groups.last.inverterIndex, 2);
      expect(p.unusedPanels, 0);
    });

    test('sin paneles o sin solución, no propone nada', () {
      expect(
        StringPlanner.propose(
          totalPanels: 0,
          limits: limits,
          inverterCount: 1,
          mpptCount: 2,
        ).groups,
        isEmpty,
      );
      expect(
        StringPlanner.propose(
          totalPanels: 4,
          limits: limits,
          inverterCount: 1,
          mpptCount: 2,
        ).unusedPanels,
        4,
      );
    });
  });

  group('Validaciones en rojo', () {
    List<StringIssue> check(List<StringGroup> g) => StringValidator.validate(
      groups: g,
      module: module,
      inverter: inverter,
      limits: limits,
      inverterCount: 1,
    );

    test('10 × 1 en cada MPPT no tiene problemas', () {
      expect(
        check(const [
          StringGroup(inverterIndex: 0, mpptIndex: 0, series: 10, parallel: 1),
          StringGroup(inverterIndex: 0, mpptIndex: 1, series: 10, parallel: 1),
        ]),
        isEmpty,
      );
    });

    test('15 en serie pasa 600 V (618 V) y avisa del MPPT máximo', () {
      final issues = check(const [
        StringGroup(inverterIndex: 0, mpptIndex: 0, series: 15, parallel: 1),
      ]);
      final voc = issues.firstWhere(
        (i) => i.code == StringIssueCode.vocOverLimit,
      );
      expect(voc.severity, IssueSeverity.error);
      expect(voc.value, closeTo(618.03, 0.01));
      expect(voc.limit, 600);
      expect(
        issues.any(
          (i) =>
              i.code == StringIssueCode.vmpAboveMppt &&
              i.severity == IssueSeverity.warning,
        ),
        isTrue,
      );
    });

    test('5 en serie queda bajo el MPPT con calor', () {
      final issues = check(const [
        StringGroup(inverterIndex: 0, mpptIndex: 0, series: 5, parallel: 1),
      ]);
      expect(issues.single.code, StringIssueCode.vmpBelowMppt);
      expect(issues.single.value, closeTo(126.2, 0.1));
    });

    test('2 strings en paralelo: 22.5 A > 12 A', () {
      final issues = check(const [
        StringGroup(inverterIndex: 0, mpptIndex: 0, series: 10, parallel: 2),
      ]);
      expect(issues.single.code, StringIssueCode.currentOverMppt);
      expect(issues.single.value, closeTo(22.5, 1e-9));
    });

    test('MPPT inexistente y series mezcladas', () {
      final issues = check(const [
        StringGroup(inverterIndex: 0, mpptIndex: 5, series: 10, parallel: 1),
        StringGroup(inverterIndex: 1, mpptIndex: 0, series: 10, parallel: 1),
      ]);
      expect(
        issues.where((i) => i.code == StringIssueCode.invalidInput),
        hasLength(2),
      );
      final mixed = StringValidator.validate(
        groups: const [
          StringGroup(inverterIndex: 0, mpptIndex: 0, series: 10, parallel: 1),
          StringGroup(inverterIndex: 0, mpptIndex: 0, series: 9, parallel: 1),
        ],
        module: module,
        inverter: const StringInverter(
          pacW: 5000,
          vdcMaxV: 600,
          mpptMinV: 150,
          mpptMaxV: 500,
          mpptCount: 2,
          imaxPerMpptA: 30,
        ),
        limits: limits,
        inverterCount: 1,
      );
      expect(mixed.single.code, StringIssueCode.mixedSeriesInMppt);
    });

    test('copyWith conserva lo que no cambia', () {
      const g = StringGroup(
        inverterIndex: 0,
        mpptIndex: 1,
        series: 10,
        parallel: 1,
      );
      final c = g.copyWith(series: 12);
      expect((c.mpptIndex, c.series, c.parallel, c.panels), (1, 12, 1, 12));
    });
  });
}
