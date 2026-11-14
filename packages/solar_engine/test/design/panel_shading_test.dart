import 'dart:math' as math;

import 'package:solar_engine/solar_engine.dart';
import 'package:test/test.dart';

List<XY> box(double x0, double y0, double x1, double y1) => [
  (x: x0, y: y0),
  (x: x1, y: y0),
  (x: x1, y: y1),
  (x: x0, y: y1),
];

/// Panel de 1 × 2 m en vertical con esquina en (x0, 0); las 3 secciones
/// se reparten a lo ancho (x).
ShadePanel panelAt(double x0) => ShadePanel(box(x0, 0, x0 + 1, 2));

/// Un solo instante: Sol al sur a 45°.
const List<SunSample> noonSun = [
  (month: 1, azimuth: 180, elevation: 45, weight: 1),
];

void main() {
  group('Diodos bypass (B.7.1 paso 5)', () {
    test('sin sombra = 1; una sección con sombra = 2/3', () {
      expect(BypassModel.seriesPower([1, 1, 1]), 1);
      expect(BypassModel.seriesPower([1, 1, 0.3]), closeTo(2 / 3, 1e-12));
      expect(BypassModel.seriesPower([0.3, 0.3, 0.3]), closeTo(0.3, 1e-12));
      expect(BypassModel.seriesPower([]), 0);
    });

    test('string de 2 paneles con una sección sombreada pierde 1/6', () {
      final p = BypassModel.seriesPower([1, 1, 1, 1, 1, 0.3]);
      expect(p / 2, closeTo(5 / 6, 1e-12));
    });
  });

  group('Factor de vista de cielo (B.7.1 paso 6)', () {
    test('sin obstáculos = 1; horizonte a 90° = 0', () {
      expect(SkyView.factor((x: 0, y: 0), const []), 1);
      expect(
        SkyView.factor(
          (x: 0, y: 0),
          const [],
          horizon: HorizonProfile([(azimuth: 0, elevation: 90)]),
        ),
        closeTo(0, 1e-12),
      );
    });

    test('muro de 1 m a 1 m de distancia se ve a 45°', () {
      final wall = ShadingObstacle(footprint: box(-5, 1, 5, 1.2), heightM: 1);
      expect(
        SkyView.obstacleElevation(wall, (x: 0, y: 0), 0),
        closeTo(45, 1e-9),
      );
      expect(SkyView.obstacleElevation(wall, (x: 0, y: 0), 180), 0);
      final svf = SkyView.factor((x: 0, y: 0), [wall]);
      expect(svf, lessThan(1));
      expect(svf, greaterThan(0.7));
    });
  });

  group('Sombra por panel (B.7.1 pasos 4–6)', () {
    test('sin obstáculos no hay pérdida', () {
      final r = PanelShadeCalculator.compute(
        panels: [panelAt(0)],
        obstacles: const [],
        samples: noonSun,
      );
      expect(r.panels.single.beamLoss, 0);
      expect(r.panels.single.loss, closeTo(0, 1e-12));
      expect(r.panels.single.monthlyBeamLoss[0], 0);
      expect(r.panels.single.monthlyBeamLoss[5].isNaN, isTrue);
    });

    test('franja de sombra abajo: 25 % geométrico pero el panel se apaga', () {
      // Muro al sur de 0.7 m: con el Sol a 45° la sombra llega a y = 0.3,
      // cubre la fila de muestras de abajo de las 3 secciones.
      final wall = ShadingObstacle(
        footprint: box(-0.5, -0.5, 1.5, -0.4),
        heightM: 0.7,
      );
      final r = PanelShadeCalculator.compute(
        panels: [panelAt(0), panelAt(2)],
        obstacles: [wall],
        samples: noonSun,
        strings: const [
          [0, 1],
        ],
        diffuseShare: 0,
      );
      expect(r.panels[0].beamLoss, closeTo(0.25, 1e-12));
      expect(r.panels[0].loss, closeTo(1, 1e-12));
      // Panel solo (micro): pierde 100 %; en string con otro panel sin
      // sombra, el inversor puentea el sombreado: el string pierde 50 %.
      expect(r.independentLoss, closeTo(0.5, 1e-12));
      expect(r.stringLosses.single, closeTo(0.5, 1e-12));
      expect(r.stringLoss, closeTo(0.5, 1e-12));
    });

    test('una sección con sombra: pierde 1/3', () {
      final pole = ShadingObstacle(
        footprint: box(0, -0.2, 0.3, -0.1),
        heightM: 3,
      );
      final r = PanelShadeCalculator.compute(
        panels: [panelAt(0), panelAt(2)],
        obstacles: [pole],
        samples: noonSun,
        strings: const [
          [0, 1],
        ],
        diffuseShare: 0,
      );
      expect(r.panels[0].beamLoss, closeTo(1 / 3, 1e-12));
      expect(r.panels[0].loss, closeTo(1 / 3, 1e-12));
      expect(r.panels[1].loss, closeTo(0, 1e-12));
      expect(r.stringLoss, closeTo(1 / 6, 1e-12));
    });

    test('con horizonte que tapa todo y difusa 30 %: pérdida total', () {
      final r = PanelShadeCalculator.compute(
        panels: [panelAt(0)],
        obstacles: const [],
        samples: noonSun,
        horizon: HorizonProfile([(azimuth: 0, elevation: 90)]),
      );
      expect(r.panels.single.beamLoss, 1);
      expect(r.panels.single.skyViewFactor, closeTo(0, 1e-12));
      expect(r.panels.single.loss, closeTo(1, 1e-12));
    });

    test('la difusa reducida por el cielo cuenta aunque no haya sombra', () {
      final wall = ShadingObstacle(footprint: box(-5, 3, 5, 3.2), heightM: 2);
      final r = PanelShadeCalculator.compute(
        panels: [panelAt(0)],
        obstacles: [wall],
        samples: noonSun,
      );
      final p = r.panels.single;
      expect(p.beamLoss, 0);
      expect(p.loss, closeTo(0.3 * (1 - p.skyViewFactor), 1e-12));
      expect(p.loss, greaterThan(0));
    });

    test('año real en Monterrey: tinaco al sur pierde más en invierno', () {
      const site = Site(latitude: 25.67, longitude: -100.31);
      final tank = ShadingObstacle(
        footprint: [
          for (var k = 0; k < 16; k++)
            (
              x: 0.5 + 0.55 * math.cos(k * math.pi / 8),
              y: -1.5 + 0.55 * math.sin(k * math.pi / 8),
            ),
        ],
        heightM: 1.7,
      );
      final r = PanelShadeCalculator.compute(
        panels: [panelAt(0)],
        obstacles: [tank],
        samples: SunSamples.year(site, dayStep: 14, minuteStep: 60),
      );
      final m = r.panels.single.monthlyBeamLoss;
      expect(m[11], greaterThan(m[5]));
      expect(r.panels.single.beamLoss, inExclusiveRange(0, 0.5));
    });
  });
}
