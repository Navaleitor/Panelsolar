import 'package:flutter_test/flutter_test.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/plane_summary.dart';
import 'package:panelsolar/features/roof/domain/reframe.dart';
import 'package:panelsolar/features/roof/domain/roof_codec.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/domain/roof_space.dart';
import 'package:panelsolar/features/roof/domain/shade_job.dart';
import 'package:panelsolar/features/roof/presentation/editor/drawing_state.dart';
import 'package:persistence/persistence.dart';

const List<Vec2> _rect = [Vec2.zero, Vec2(10, 0), Vec2(10, 8), Vec2(0, 8)];

RoofPlaneModel _plane({
  double tilt = 0,
  double setback = 0,
  List<Walkway> w = const [],
}) => RoofPlaneModel(
  id: 'p1',
  name: 'Plano 1',
  polygon: _rect,
  tiltDeg: tilt,
  edgeSetbackM: setback,
  walkways: w,
  azimuthEdgeIndex: 0,
);

ObstacleModel _tank(Vec2 c) => ObstacleModel(
  id: 'o1',
  type: ObstacleType.waterTank,
  shape: ObstacleShape.circle,
  center: c,
  widthM: 1.1,
  heightM: 1.7,
  heightSource: HeightSource.typical,
);

void main() {
  group('RoofCodec', () {
    test('polígono, pasillos, horizonte y línea de ida y vuelta', () {
      expect(RoofCodec.decodePolygon(RoofCodec.encodePolygon(_rect)), _rect);
      final w = RoofCodec.decodeWalkways(
        RoofCodec.encodeWalkways([const Walkway(Vec2(0, 1), Vec2(10, 1), 0.6)]),
      );
      expect(w.single.widthM, 0.6);
      expect(w.single.end, const Vec2(10, 1));
      final h = RoofCodec.decodeHorizon(
        RoofCodec.encodeHorizon(const [(azimuth: 180, elevation: 12.3456)]),
      );
      expect(h.single.elevation, 12.346);
      final l = RoofCodec.decodeLine(
        RoofCodec.encodeLine(const MeasuredLine(Vec2.zero, Vec2(400, 0), 10)),
      );
      expect(l!.lengthPx, 400);
    });

    test('texto vacío o dañado no rompe la app', () {
      expect(RoofCodec.decodePolygon('no json'), isEmpty);
      expect(RoofCodec.decodeWalkways(null), isEmpty);
      expect(RoofCodec.decodeHorizon('[1,2'), isEmpty);
      expect(RoofCodec.decodeLine('{}'), isNull);
    });
  });

  group('summarizePlane', () {
    test('10 × 8 a 30°: 80 m² desde arriba, 92.38 m² reales', () {
      final s = summarizePlane(_plane(tilt: 30));
      expect(s.sides, [10, 8, 10, 8]);
      expect(s.angles, everyElement(closeTo(90, 1e-9)));
      expect(s.horizontalArea, 80);
      expect(s.slopedArea, closeTo(92.376, 1e-3));
      expect(s.usableArea, closeTo(92.376, 1e-3));
    });

    test('retiro, pasillo y tinaco reducen el área útil', () {
      final s = summarizePlane(
        _plane(
          setback: 0.5,
          w: const [Walkway(Vec2(0.5, 4), Vec2(9.5, 4), 0.6)],
        ),
        obstacles: [_tank(const Vec2(3, 2))],
      );
      // 9 × 7 = 63; pasillo 9 × 0.6 = 5.4; tinaco ≈ 0.94.
      expect(s.usableArea, closeTo(63 - 5.4 - 0.94, 0.15));
    });
  });

  group('Reframe', () {
    test('al recalibrar, lo dibujado se estira con la imagen', () {
      const a = ImageFrame(metersPerPixel: 0.02);
      const b = ImageFrame(metersPerPixel: 0.025);
      final p = Reframe.plane(_plane(), a, b);
      expect(PolygonMetrics.area(p.polygon), closeTo(80 * 1.5625, 1e-9));
      final o = Reframe.obstacle(_tank(const Vec2(4, 4)), a, b);
      expect(o.center.x, closeTo(5, 1e-9));
      expect(o.widthM, 1.1); // medidas reales sin cambio
    });

    test(
      'norte a la derecha de la imagen: el alero de abajo pasa a mirar al este',
      () {
        const a = ImageFrame(metersPerPixel: 0.02);
        const b = ImageFrame(metersPerPixel: 0.02, northAngleDeg: 90);
        final p = Reframe.plane(_plane(), a, b);
        expect(p.azimuthDeg, closeTo(90, 1e-6));
        expect(PolygonMetrics.area(p.polygon), closeTo(80, 1e-9));
      },
    );
  });

  group('RoofSpace', () {
    test('sin fila → croquis de 40 × 40 m con origen al centro', () {
      final s = RoofSpace.fromRecord(null);
      expect(s.mode, RoofMode.sketch);
      expect(s.isCalibrated, isTrue);
      expect(s.frame!.toLocal(const Vec2(1000, 1000)), Vec2.zero);
      expect(s.widthPx * s.frame!.metersPerPixel, 40);
    });
  });

  group('DrawingState', () {
    test('imán a 90° y cierre al tocar el primer punto', () {
      final d = DrawingState()
        ..add(const Vec2(100, 100))
        ..add(const Vec2(500, 103)) // casi horizontal → queda recto
        ..add(const Vec2(505, 400)); // casi vertical → 90°
      expect(d.points[2].x, closeTo(d.points[1].x, 1e-9));
      d.add(const Vec2(100, 400));
      expect(d.canClose, isTrue);
      expect(d.add(const Vec2(102, 98)), isTrue);
      d.undo();
      expect(d.points, hasLength(3));
    });
  });

  group('shade_job', () {
    test('horizonte combinado: nulo sin datos, máximo con datos', () {
      expect(combinedHorizon(const [], const []), isNull);
      final h = combinedHorizon(
        const [(azimuth: 0, elevation: 5), (azimuth: 180, elevation: 5)],
        const [
          FarObstacle(
            id: 'f',
            name: 'Árbol',
            points: [
              (azimuth: 170, elevation: 30),
              (azimuth: 190, elevation: 30),
            ],
          ),
        ],
      )!;
      expect(h.elevationAt(180), 30);
      expect(h.elevationAt(90), 5);
    });

    test('tinaco al sur de un techo en Monterrey deja sombra al norte', () {
      final maps = computeShadeMaps(
        site: (
          latitude: 25.69,
          longitude: -100.32,
          elevation: 540,
          utcOffsetHours: -6,
        ),
        planes: [_plane()],
        obstacles: [_tank(const Vec2(5, 1))],
        terrain: const [],
        far: const [],
        dayStep: 30,
        minuteStep: 60,
      );
      final m = maps.single.map;
      expect(maps.single.planeId, 'p1');
      expect(m.averageLoss, inExclusiveRange(0, 0.1));
      expect(m.monthlyLoss[11], greaterThan(m.monthlyLoss[5]));
    });
  });
}
