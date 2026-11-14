import 'dart:math' as math;

import 'package:geo_kit/src/geometry/vec2.dart';
import 'package:geo_kit/src/layout/region_tests.dart';

/// Orientación del panel respecto a la fila.
enum PanelOrientation {
  /// Vertical: el lado largo sube con la pendiente.
  portrait,

  /// Horizontal: el lado largo va a lo largo de la fila.
  landscape,
}

/// Medidas en planta (vista desde arriba, metros) de un panel y su rejilla.
class PackingGrid {
  /// Crea la rejilla.
  const new({
    required this.alongM,
    required this.acrossM,
    required this.columnPitchM,
    required this.rowPitchM,
  });

  /// Medida del panel a lo largo de la fila (m).
  final double alongM;

  /// Medida del panel en planta en la dirección de la pendiente (m).
  final double acrossM;

  /// Distancia entre inicios de paneles vecinos de una fila (m).
  final double columnPitchM;

  /// Distancia entre inicios de filas (m).
  final double rowPitchM;
}

/// Un panel colocado.
class PlacedPanel {
  /// Crea el panel.
  const new({required this.corners, required this.row, required this.column});

  /// Esquinas en metros locales: [0]→[1] a lo largo de la fila (abajo),
  /// [0]→[3] cuesta arriba.
  final List<Vec2> corners;

  /// Fila (0 = la más baja).
  final int row;

  /// Posición en la fila.
  final int column;

  /// Centro.
  Vec2 get center => (corners[0] + corners[2]) * 0.5;
}

/// Resultado del empaquetado.
class PackedLayout {
  /// Crea el resultado.
  const new({required this.panels, required this.score});

  /// Paneles colocados.
  final List<PlacedPanel> panels;

  /// Puntaje (número de paneles o energía relativa).
  final double score;
}

/// Empaquetado rectangular de paneles en un plano (plan B.6 punto 13).
/// Ficha: docs/formulas/29-maximo-de-paneles.md
abstract final class PanelPacker {
  /// Coloca paneles en [region] (ya con retiros), evitando [exclusions]
  /// (obstáculos con holgura y pasillos). Las filas corren perpendiculares
  /// a [azimuthDeg] (hacia donde baja el plano o miran los paneles).
  ///
  /// Prueba [offsets] × [offsets] desplazamientos de la rejilla y, en cada
  /// fila, también corre los paneles hasta el primer lugar libre. Devuelve
  /// el arreglo con más puntaje: Σ [weight] de cada panel (1 si es nulo).
  static PackedLayout pack({
    required List<Vec2> region,
    required double azimuthDeg,
    required PackingGrid grid,
    List<List<Vec2>> exclusions = const [],
    int offsets = 4,
    double Function(List<Vec2> corners)? weight,
  }) {
    if (region.length < 3 ||
        grid.alongM <= 0 ||
        grid.acrossM <= 0 ||
        grid.columnPitchM < grid.alongM ||
        grid.rowPitchM < grid.acrossM) {
      return const PackedLayout(panels: [], score: 0);
    }
    final a = azimuthDeg * math.pi / 180;
    final down = Vec2(math.sin(a), math.cos(a));
    final up = -down;
    final along = Vec2(down.y, -down.x);
    Vec2 toFrame(Vec2 p) => Vec2(p.dot(along), p.dot(up));
    Vec2 fromFrame(double u, double v) => along * u + up * v;
    final local = [for (final p in region) toFrame(p)];
    final ex = [
      for (final e in exclusions) [for (final p in e) toFrame(p)],
    ];
    final (u0, v0, u1, v1) = RegionTests.bounds(local);
    final step = math.max(0.05, grid.columnPitchM / 20);

    bool fits(double u, double v) {
      const e = 0.001;
      final r = [
        Vec2(u + e, v + e),
        Vec2(u + grid.alongM - e, v + e),
        Vec2(u + grid.alongM - e, v + grid.acrossM - e),
        Vec2(u + e, v + grid.acrossM - e),
      ];
      if (!RegionTests.insideRegion(r, local)) return false;
      for (final x in ex) {
        if (RegionTests.overlaps(r, x)) return false;
      }
      return true;
    }

    PackedLayout? best;
    for (var oi = 0; oi < offsets; oi++) {
      for (var oj = 0; oj < offsets; oj++) {
        for (final greedy in [false, true]) {
          final panels = <PlacedPanel>[];
          var row = 0;
          for (
            var v = v0 + grid.rowPitchM * oj / offsets;
            v + grid.acrossM <= v1 + 1e-9;
            v += grid.rowPitchM
          ) {
            var col = 0;
            var u = u0 + grid.columnPitchM * oi / offsets;
            while (u + grid.alongM <= u1 + 1e-9) {
              if (fits(u, v)) {
                panels.add(
                  PlacedPanel(
                    corners: [
                      fromFrame(u, v),
                      fromFrame(u + grid.alongM, v),
                      fromFrame(u + grid.alongM, v + grid.acrossM),
                      fromFrame(u, v + grid.acrossM),
                    ],
                    row: row,
                    column: col++,
                  ),
                );
                u += grid.columnPitchM;
              } else {
                u += greedy ? step : grid.columnPitchM;
              }
            }
            row++;
          }
          final score = weight == null
              ? panels.length.toDouble()
              : panels.fold<double>(0, (s, p) => s + weight(p.corners));
          if (best == null || score > best.score + 1e-9) {
            best = PackedLayout(panels: panels, score: score);
          }
        }
      }
    }
    return best!;
  }
}
