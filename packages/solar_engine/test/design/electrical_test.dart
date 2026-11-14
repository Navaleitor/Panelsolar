import 'dart:math' as math;

import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

// Calibres de cobre (NEC/NOM cap. 10 tabla 8, Ω/km a 75 °C; ampacidad a
// 75 °C tabla 310-15(b)(16)).
const copper = [
  ConductorOption(
    label: '14 AWG',
    areaMm2: 2.08,
    resistanceOhmPerKm: 10.3,
    ampacityA: 20,
  ),
  ConductorOption(
    label: '12 AWG',
    areaMm2: 3.31,
    resistanceOhmPerKm: 6.50,
    ampacityA: 25,
  ),
  ConductorOption(
    label: '10 AWG',
    areaMm2: 5.26,
    resistanceOhmPerKm: 4.07,
    ampacityA: 35,
  ),
  ConductorOption(
    label: '8 AWG',
    areaMm2: 8.37,
    resistanceOhmPerKm: 2.55,
    ampacityA: 50,
  ),
];

void main() {
  group('Caída de tensión (B.6 punto 15)', () {
    test('DC: ΔV = 2·L·I·R/1000 (50 m, 20 A, 3.28 Ω/km → 6.56 V)', () {
      final v = VoltageDrop.volts(
        kind: CircuitKind.dc,
        lengthM: 50,
        currentA: 20,
        rOhmPerKm: 3.28,
      );
      expect(v, closeTo(6.56, 1e-9));
      expect(
        VoltageDrop.percent(
          kind: CircuitKind.ac1,
          lengthM: 50,
          currentA: 20,
          rOhmPerKm: 3.28,
          voltageV: 240,
        ),
        closeTo(2.7333, 1e-4),
      );
    });

    test('trifásica: ΔV = √3·L·I·R/1000', () {
      final v = VoltageDrop.volts(
        kind: CircuitKind.ac3,
        lengthM: 30,
        currentA: 15,
        rOhmPerKm: 4.07,
      );
      expect(v, closeTo(math.sqrt(3) * 30 * 15 * 4.07 / 1000, 1e-12));
      expect(
        VoltageDrop.percent(
          kind: CircuitKind.dc,
          lengthM: 1,
          currentA: 1,
          rOhmPerKm: 1,
          voltageV: 0,
        ),
        double.infinity,
      );
    });

    test('resistencia corregida por temperatura', () {
      expect(
        VoltageDrop.resistanceAt(4.07, ConductorMaterial.copper, 75),
        4.07,
      );
      expect(
        VoltageDrop.resistanceAt(4.07, ConductorMaterial.copper, 20),
        closeTo(4.07 * (1 - 0.00323 * 55), 1e-12),
      );
      expect(VoltageDrop.alpha(ConductorMaterial.aluminum), 0.00330);
    });
  });

  group('Calibre mínimo', () {
    test('string de 9 A: ampacidad pide 14.06 A y la caída manda', () {
      // 1.25 × 1.25 × 9 = 14.06 A; 14 AWG aguanta pero 40 m a 300 V da
      // 2·40·8.5·10.3/1000 = 7.0 V = 2.33 % (cumple 3 %).
      const r = RunRequest(
        kind: CircuitKind.dc,
        lengthM: 40,
        operatingCurrentA: 8.5,
        designCurrentA: 1.25 * 1.25 * 9,
        voltageV: 300,
        material: ConductorMaterial.copper,
      );
      final best = ConductorSelector.minimum(r, copper.reversed.toList())!;
      expect(best.option.label, '14 AWG');
      expect(best.dropPercent, closeTo(2.3347, 1e-3));
      // Más largo (80 m) → 4.67 % con 14 AWG; 12 AWG da 2.95 %.
      final far = ConductorSelector.minimum(
        const RunRequest(
          kind: CircuitKind.dc,
          lengthM: 80,
          operatingCurrentA: 8.5,
          designCurrentA: 14.06,
          voltageV: 300,
          material: ConductorMaterial.copper,
        ),
        copper,
      )!;
      expect(far.option.label, '12 AWG');
      expect(far.dropOk && far.ampacityOk, isTrue);
    });

    test('el factor de temperatura sube el calibre por ampacidad', () {
      final r = ConductorSelector.minimum(
        const RunRequest(
          kind: CircuitKind.ac1,
          lengthM: 5,
          operatingCurrentA: 22.7,
          designCurrentA: 28.4,
          voltageV: 220,
          material: ConductorMaterial.copper,
          ampacityFactor: 0.82,
        ),
        copper,
      )!;
      // 10 AWG: 35 × 0.82 = 28.7 A ≥ 28.4 A.
      expect(r.option.label, '10 AWG');
      expect(r.correctedAmpacityA, closeTo(28.7, 1e-9));
    });

    test('ninguno cumple → null', () {
      expect(
        ConductorSelector.minimum(
          const RunRequest(
            kind: CircuitKind.dc,
            lengthM: 10,
            operatingCurrentA: 90,
            designCurrentA: 120,
            voltageV: 300,
            material: ConductorMaterial.copper,
          ),
          copper,
        ),
        isNull,
      );
    });
  });

  group('Protecciones (B.6 punto 16)', () {
    const ratings = <double>[15, 20, 25, 30, 35, 40, 50, 60, 70];
    const ground = <(double, String)>[
      (15, '14 AWG'),
      (20, '12 AWG'),
      (60, '10 AWG'),
      (100, '8 AWG'),
    ];

    test('3 strings en paralelo → fusibles de 15 A; AC 30 A; tierra 10', () {
      final s = ProtectionSizing.suggest(
        const ProtectionInput(
          moduleIscA: 9,
          stringsInParallel: 3,
          totalStrings: 3,
          maxStringVocV: 450,
          inverterAcCurrentA: 22.7,
          gridVoltageV: 220,
          standardRatingsA: ratings,
          groundingTable: ground,
          moduleMaxSeriesFuseA: 20,
        ),
      );
      ProtectionSuggestion of(ProtectionKind k) =>
          s.firstWhere((p) => p.kind == k);
      final fuse = of(ProtectionKind.stringFuse);
      expect(fuse.required, isTrue);
      expect(fuse.ratingA, 15);
      expect(fuse.quantity, 6);
      expect(of(ProtectionKind.acBreaker).ratingA, 30);
      expect(of(ProtectionKind.groundingConductor).conductorLabel, '10 AWG');
      // 9 × 1.5625 × 3 = 42.2 A → 50 A.
      expect(of(ProtectionKind.dcDisconnect).ratingA, 50);
      expect(of(ProtectionKind.dcSpd).voltageV, closeTo(540, 1e-9));
      expect(of(ProtectionKind.acSpd).voltageV, closeTo(242, 1e-9));
    });

    test(
      'con 2 strings no hacen falta fusibles; respeta el fusible máximo',
      () {
        final s = ProtectionSizing.suggest(
          const ProtectionInput(
            moduleIscA: 14,
            stringsInParallel: 2,
            totalStrings: 2,
            maxStringVocV: 500,
            inverterAcCurrentA: 10,
            gridVoltageV: 127,
            standardRatingsA: ratings,
            groundingTable: ground,
            moduleMaxSeriesFuseA: 20,
          ),
        );
        final fuse = s.first;
        expect(fuse.required, isFalse);
        expect(fuse.quantity, 0);
        expect(fuse.ratingA, 20);
        expect(ProtectionSizing.roundUp(500, ratings), 70);
        expect(ProtectionSizing.roundUp(5, const []), 5);
        expect(ProtectionSizing.groundingFor(400, ground), '8 AWG');
        expect(ProtectionSizing.groundingFor(10, const []), isNull);
      },
    );
  });
}
