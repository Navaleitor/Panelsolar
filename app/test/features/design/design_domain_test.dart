import 'package:flutter_test/flutter_test.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/design/domain/array_planner.dart';
import 'package:panelsolar/features/design/domain/design_analysis.dart';
import 'package:panelsolar/features/design/domain/design_inputs.dart';
import 'package:panelsolar/features/design/domain/design_models.dart';
import 'package:panelsolar/features/design/domain/string_analysis.dart';
import 'package:panelsolar/features/design/domain/wind_design.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:persistence/persistence.dart' hide Site;
import 'package:solar_engine/solar_engine.dart';

import '../weather/weather_test_data.dart';

const RoofPlaneModel flatRoof = RoofPlaneModel(
  id: 'p1',
  name: 'Azotea',
  polygon: [Vec2.zero, Vec2(10, 0), Vec2(10, 8), Vec2(0, 8)],
);

const PanelSize panel = (lengthM: 2.2, widthM: 1.1);

const ArraySettings flush = (
  orientation: null,
  mount: MountType.flush,
  rackTiltDeg: 15,
  rackAzimuthDeg: 180,
  gapM: 0.02,
  rowGapM: 0.02,
  clearanceM: 0.3,
);

const Site monterreySite = Site(latitude: 25.67, longitude: -100.31);

void main() {
  group('Máximo de paneles en la app (ficha 29)', () {
    test('azotea de 10 × 8 m: elige horizontal (28 > 24)', () {
      final plan = planArray(
        plane: flatRoof,
        obstacles: const [],
        panel: panel,
        settings: flush,
      );
      expect(plan.orientation, LayoutOrientation.landscape);
      expect(plan.panels, hasLength(28));
      expect(plan.panels.every((p) => p.on), isTrue);
    });

    test('retiro y tinaco quitan paneles', () {
      final plan = planArray(
        plane: flatRoof.copyWith(edgeSetbackM: 0.5),
        obstacles: const [
          ObstacleModel(
            id: 't',
            type: ObstacleType.waterTank,
            shape: ObstacleShape.circle,
            center: Vec2(5, 4),
            widthM: 1.1,
            heightM: 1.7,
            heightSource: HeightSource.typical,
          ),
        ],
        panel: panel,
        settings: flush,
      );
      expect(plan.panels.length, lessThan(24));
      for (final p in plan.panels) {
        expect(p.center.distanceTo(const Vec2(5, 4)), greaterThan(0.85));
      }
    });

    test('estructura inclinada en techo plano usa la separación de filas', () {
      final plan = planArray(
        plane: flatRoof,
        obstacles: const [],
        panel: panel,
        settings: (
          orientation: LayoutOrientation.portrait,
          mount: MountType.tiltedRack,
          rackTiltDeg: 25,
          rackAzimuthDeg: 180,
          gapM: 0.02,
          rowGapM: 0.02,
          clearanceM: 0.3,
        ),
        site: monterreySite,
      );
      // Panel de 2.2 m a 25°: d ≈ 1.44 m; paso ≈ 1.99 + 1.44 = 3.44 m →
      // 2 filas de 8.
      expect(plan.rowSpacingM, closeTo(1.44, 0.05));
      expect(plan.panels, hasLength(16));
    });

    test('el mapa de calor apaga los paneles sobre el umbral', () {
      final heat = ShadeHeatmap(
        originX: 0,
        originY: 0,
        cellSize: 1,
        columns: 10,
        rows: 8,
        values: [
          for (var r = 0; r < 8; r++)
            for (var c = 0; c < 10; c++)
              if (c < 3) 0.5 else 0.0,
        ],
        monthlyLoss: List.filled(12, 0),
      );
      final plan = planArray(
        plane: flatRoof,
        obstacles: const [],
        panel: panel,
        settings: flush,
        heatmap: heat,
      );
      expect(plan.panels.where((p) => !p.on), isNotEmpty);
      final off = plan.panels.firstWhere((p) => !p.on);
      expect(heatmapLoss(heat, off.corners), greaterThanOrEqualTo(0.1));
      final on = plan.panels.firstWhere((p) => p.on);
      expect(heatmapLoss(heat, on.corners), lessThan(0.1));
    });
  });

  group('JSON del diseño', () {
    test('paneles, pérdidas y viento ida y vuelta', () {
      const p = DesignPanel(
        corners: [Vec2.zero, Vec2(1, 0), Vec2(1, 2), Vec2(0, 2)],
        row: 1,
        column: 2,
        on: false,
      );
      final back = DesignPanel.decodeList(DesignPanel.encodeList([p])).single;
      expect((back.row, back.column, back.on), (1, 2, false));
      expect(back.center, const Vec2(0.5, 1));
      expect(DesignPanel.decodeList('basura'), isEmpty);

      final l = LossesCodec.decode(
        LossesCodec.encode(const SystemLosses(soiling: 4)),
      );
      expect(l.soiling, 4);
      expect(LossesCodec.decode('').mismatch, 2);

      const w = WindSettings(city: 'Monterrey', speedKmh: 143);
      final w2 = WindSettings.decode(w.encode());
      expect((w2.city, w2.speedKmh, w2.anchorsPerPanel), ('Monterrey', 143, 4));
      expect(WindSettings.decode('{').exposure, WindExposure.c);
    });
  });

  group('Strings y viento en la app', () {
    test('propuesta y validación con el panel y el inversor', () {
      final a = analyzeStrings(
        module: const StringModule(
          pmaxW: 550,
          vocV: 49.6,
          iscA: 14,
          vmpV: 41.7,
          impA: 13.2,
        ),
        inverter: const StringInverter(
          pacW: 5000,
          vdcMaxV: 600,
          mpptMinV: 90,
          mpptMaxV: 520,
          mpptCount: 2,
          imaxPerMpptA: 18,
        ),
        temps: (minAmbientC: -2, maxAmbientC: 42),
        panels: 20,
        inverterCount: 1,
        microinverter: false,
      );
      expect(a.limits.maxSeries, 11);
      expect(a.connectedPanels, 20);
      expect(a.issues, isEmpty);
    });

    test('fuerza por anclaje = presión × área / anclajes', () {
      final w = windDesign(
        settings: const WindSettings(speedKmh: 144),
        panelAreaM2: 2.5,
        siteElevationM: 0,
      );
      expect(w.result.forcePerAnchorN, closeTo(w.upliftPerPanelN / 4, 1e-9));
    });
  });

  group('Análisis completo (Monterrey, clima de prueba)', () {
    final climate = monterreyClimate();
    final plan = planArray(
      plane: flatRoof,
      obstacles: const [],
      panel: panel,
      settings: flush,
    );
    DesignJobInput job({
      List<ObstacleModel> obstacles = const [],
      InverterSpec? inverter = (
        pacW: 10000,
        efficiencyPct: 97,
        count: 1,
        independent: false,
      ),
    }) => DesignJobInput(
      projectId: 'p',
      site: (
        latitude: 25.67,
        longitude: -100.31,
        elevation: 540,
        timeZone: 'America/Monterrey',
        utcOffsetHours: -6,
      ),
      planes: const [flatRoof],
      obstacles: obstacles,
      terrain: const [],
      far: const [],
      arrays: [
        (
          planeId: 'p1',
          panels: plan.panels,
          orientation: plan.orientation,
          mount: MountType.flush,
          rackTiltDeg: 0,
          rackAzimuthDeg: 180,
        ),
      ],
      panel: (pmaxW: 450, gammaPct: -0.35, lengthM: 2.2, widthM: 1.1),
      inverter: inverter,
      strings: const [(series: 14, parallel: 2)],
      losses: const SystemLosses(),
      dayStep: 30,
      minuteStep: 60,
    );

    test('sin obstáculos: todos activos, producción y temperaturas', () {
      final r = analyzeDesign(job(), climate);
      expect(r.activePanels, 28);
      expect(r.planes.single.loss, closeTo(0, 1e-9));
      expect(r.temperatures.min, lessThan(r.temperatures.max));
      final p = r.production!;
      expect(p.pdcW, 28 * 450);
      expect(p.yearlyKwh, hasLength(25));
      expect(p.specificYield, inInclusiveRange(1300, 2100));
      expect(r.diffuseShare, inInclusiveRange(0.05, 1));
      expect(r.weatherLabel, contains('NASA'));
      expect(r.panel('p1', 0), isNotNull);
    });

    test('un cubo de escalera al sur da sombra; el string pierde más', () {
      const stair = ObstacleModel(
        id: 'e',
        type: ObstacleType.stairwell,
        shape: ObstacleShape.rectangle,
        center: Vec2(5, -1.5),
        widthM: 3,
        depthM: 2,
        heightM: 3,
        heightSource: HeightSource.typical,
      );
      final string = analyzeDesign(job(obstacles: const [stair]), climate);
      final micro = analyzeDesign(
        job(
          obstacles: const [stair],
          inverter: (
            pacW: 10000,
            efficiencyPct: 97,
            count: 1,
            independent: true,
          ),
        ),
        climate,
      );
      expect(micro.planes.single.loss, greaterThan(0));
      expect(
        string.planes.single.loss,
        greaterThanOrEqualTo(micro.planes.single.loss),
      );
      expect(
        string.production!.firstYearKwh,
        lessThanOrEqualTo(micro.production!.firstYearKwh),
      );
    });

    test('sin inversor: solo sombras y temperaturas', () {
      final r = analyzeDesign(job(inverter: null), climate);
      expect(r.production, isNull);
      expect(
        r.planes.single.panels.whereType<PanelShadeResult>(),
        hasLength(28),
      );
    });
  });
}
