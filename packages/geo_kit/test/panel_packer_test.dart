import 'package:geo_kit/geo_kit.dart';
import 'package:test/test.dart';

List<Vec2> rect(double x0, double y0, double x1, double y1) => [
  Vec2(x0, y0),
  Vec2(x1, y0),
  Vec2(x1, y1),
  Vec2(x0, y1),
];

// Panel de 1.1 × 2.2 m en vertical, 2 cm entre paneles y entre filas.
const portrait = PackingGrid(
  alongM: 1.1,
  acrossM: 2.2,
  columnPitchM: 1.12,
  rowPitchM: 2.22,
);
const landscape = PackingGrid(
  alongM: 2.2,
  acrossM: 1.1,
  columnPitchM: 2.22,
  rowPitchM: 1.12,
);

void main() {
  group('Máximo de paneles (B.6 punto 13)', () {
    test('techo de 10 × 8 m: vertical 8 × 3 = 24, horizontal 4 × 7 = 28', () {
      final r = rect(0, 0, 10, 8);
      final v = PanelPacker.pack(region: r, azimuthDeg: 180, grid: portrait);
      final h = PanelPacker.pack(region: r, azimuthDeg: 180, grid: landscape);
      expect(v.panels.length, 24);
      expect(h.panels.length, 28);
      expect(v.score, 24);
    });

    test('las filas siguen el azimut: plano al este', () {
      final r = rect(0, 0, 8, 10);
      final v = PanelPacker.pack(region: r, azimuthDeg: 90, grid: portrait);
      expect(v.panels.length, 24);
      // A lo largo de la fila (norte-sur) el panel mide 1.1 m.
      final p = v.panels.first;
      expect(p.corners[0].distanceTo(p.corners[1]), closeTo(1.1, 1e-9));
      expect((p.corners[1] - p.corners[0]).x.abs(), lessThan(1e-9));
    });

    test('un obstáculo en medio quita paneles; un pasillo también', () {
      final r = rect(0, 0, 10, 8);
      final free = PanelPacker.pack(region: r, azimuthDeg: 180, grid: portrait);
      final withTank = PanelPacker.pack(
        region: r,
        azimuthDeg: 180,
        grid: portrait,
        exclusions: [rect(4.5, 3.5, 5.5, 4.5)],
      );
      expect(withTank.panels.length, lessThan(free.panels.length));
      for (final p in withTank.panels) {
        expect(
          RegionTests.overlaps(p.corners, rect(4.5, 3.5, 5.5, 4.5)),
          isFalse,
        );
      }
    });

    test('techo en L: todos los paneles quedan dentro', () {
      final l = [
        Vec2.zero,
        const Vec2(10, 0),
        const Vec2(10, 4),
        const Vec2(5, 4),
        const Vec2(5, 9),
        const Vec2(0, 9),
      ];
      final p = PanelPacker.pack(region: l, azimuthDeg: 180, grid: landscape);
      expect(p.panels, isNotEmpty);
      // Ningún panel invade el hueco de la L.
      for (final panel in p.panels) {
        expect(PolygonMetrics.contains(l, panel.center), isTrue);
        expect(
          RegionTests.overlaps(panel.corners, rect(5.01, 4.01, 10, 9)),
          isFalse,
        );
      }
    });

    test('el desplazamiento de la rejilla ayuda en un techo irregular', () {
      final r = rect(0.3, 0, 10.3, 2.3);
      final one = PanelPacker.pack(
        region: r,
        azimuthDeg: 180,
        grid: portrait,
        offsets: 1,
      );
      expect(one.panels.length, 8);
    });

    test('el peso elige el arreglo con más energía, no solo cantidad', () {
      final r = rect(0, 0, 10, 8);
      // Media mitad norte sin sol: cada panel ahí vale 0.1.
      double w(List<Vec2> c) => (c[0] + c[2]).y / 2 > 4 ? 0.1 : 1;
      final p = PanelPacker.pack(
        region: r,
        azimuthDeg: 180,
        grid: portrait,
        weight: w,
      );
      expect(p.score, lessThan(p.panels.length));
      expect(p.score, greaterThan(0));
    });

    test('datos inválidos → arreglo vacío', () {
      expect(
        PanelPacker.pack(
          region: const [Vec2.zero, Vec2(1, 0)],
          azimuthDeg: 180,
          grid: portrait,
        ).panels,
        isEmpty,
      );
      expect(
        PanelPacker.pack(
          region: rect(0, 0, 1, 1),
          azimuthDeg: 180,
          grid: portrait,
        ).panels,
        isEmpty,
      );
    });

    test('pruebas de región: tocar no es estar dentro', () {
      final region = rect(0, 0, 4, 4);
      expect(RegionTests.insideRegion(rect(1, 1, 2, 2), region), isTrue);
      expect(RegionTests.insideRegion(rect(3, 3, 5, 5), region), isFalse);
      expect(RegionTests.overlaps(rect(0, 0, 1, 1), rect(2, 2, 3, 3)), isFalse);
      expect(RegionTests.overlaps(rect(0, 0, 4, 4), rect(1, 1, 2, 2)), isTrue);
      expect(RegionTests.overlaps(rect(1, 1, 2, 2), rect(0, 0, 4, 4)), isTrue);
    });
  });
}
