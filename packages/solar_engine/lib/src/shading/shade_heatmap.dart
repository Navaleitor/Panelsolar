import 'package:solar_engine/src/shading/plane_geometry.dart';
import 'package:solar_engine/src/shading/shadow_caster.dart';
import 'package:solar_engine/src/shading/sun_samples.dart';
import 'package:solar_engine/src/simulation/horizon_profile.dart';

/// Mapa de calor de sombra: rejilla sobre el plano (vista desde arriba).
/// Cada celda guarda la fracción (0–1) de la luz directa del año que se
/// pierde por obstáculos u horizonte; `NaN` = fuera del plano.
class ShadeHeatmap {
  /// Crea el mapa (normalmente con [ShadeHeatmapCalculator.compute]).
  const new({
    required this.originX,
    required this.originY,
    required this.cellSize,
    required this.columns,
    required this.rows,
    required this.values,
    required this.monthlyLoss,
  });

  /// Esquina suroeste de la rejilla (m).
  final double originX;

  /// Esquina suroeste de la rejilla (m).
  final double originY;

  /// Lado de cada celda (m).
  final double cellSize;

  /// Columnas (oeste → este).
  final int columns;

  /// Filas (sur → norte).
  final int rows;

  /// Valores por fila: `values[row * columns + col]`.
  final List<double> values;

  /// Pérdida promedio del plano por mes (índice 0 = enero; `NaN` si no hay
  /// Sol sobre el plano ese mes).
  final List<double> monthlyLoss;

  /// Valor de la celda.
  double at(int col, int row) => values[row * columns + col];

  /// Centro de la celda (m).
  XY cellCenter(int col, int row) => (
    x: originX + (col + 0.5) * cellSize,
    y: originY + (row + 0.5) * cellSize,
  );

  /// Pérdida promedio anual del plano (0–1), sin contar celdas fuera.
  double get averageLoss {
    var s = 0.0;
    var n = 0;
    for (final v in values) {
      if (v.isNaN) continue;
      s += v;
      n++;
    }
    return n == 0 ? 0 : s / n;
  }
}

/// Cálculo del mapa de calor de sombra (B.6 punto 12, B.7.1 paso 6).
abstract final class ShadeHeatmapCalculator {
  /// Calcula el mapa del polígono [plane] con celdas de [cellSize] m. Si la
  /// rejilla saldría de más de [maxCells] celdas, agranda las celdas.
  /// Ficha: docs/formulas/19-sombras-de-obstaculos.md
  static ShadeHeatmap compute({
    required List<XY> plane,
    required List<ShadingObstacle> obstacles,
    required List<SunSample> samples,
    HorizonProfile? horizon,
    RoofSurface surface = RoofSurface.flat,
    double cellSize = 0.25,
    int maxCells = 4000,
  }) {
    final (minX, minY, maxX, maxY) = PlaneGeometry.bounds(plane);
    var size = cellSize;
    int cols() => ((maxX - minX) / size).ceil().clamp(1, 1 << 20);
    int rws() => ((maxY - minY) / size).ceil().clamp(1, 1 << 20);
    while (cols() * rws() > maxCells) {
      size *= 1.25;
    }
    final nc = cols();
    final nr = rws();

    final centers = <XY>[];
    final inside = <bool>[];
    for (var r = 0; r < nr; r++) {
      for (var c = 0; c < nc; c++) {
        final p = (x: minX + (c + 0.5) * size, y: minY + (r + 0.5) * size);
        centers.add(p);
        inside.add(PlaneGeometry.contains(plane, p));
      }
    }

    final lost = List<double>.filled(centers.length, 0);
    var total = 0.0;
    final monthLost = List<double>.filled(12, 0);
    final monthTotal = List<double>.filled(12, 0);
    final insideCount = inside.where((b) => b).length;

    for (final s in samples) {
      if (s.weight <= 0) continue;
      total += s.weight;
      final mi = s.month - 1;
      monthTotal[mi] += s.weight * insideCount;
      if (horizon != null && horizon.blocks(s.elevation, s.azimuth)) {
        for (var i = 0; i < centers.length; i++) {
          if (inside[i]) lost[i] += s.weight;
        }
        monthLost[mi] += s.weight * insideCount;
        continue;
      }
      final shadows = [
        for (final o in obstacles)
          ?ShadowCaster.shadowPolygon(
            o,
            sunAzimuthDeg: s.azimuth,
            sunElevationDeg: s.elevation,
            surface: surface,
          ),
      ];
      final boxes = [for (final sh in shadows) PlaneGeometry.bounds(sh)];
      for (var i = 0; i < centers.length; i++) {
        if (!inside[i]) continue;
        final p = centers[i];
        for (var k = 0; k < shadows.length; k++) {
          final b = boxes[k];
          if (p.x < b.$1 || p.x > b.$3 || p.y < b.$2 || p.y > b.$4) continue;
          if (PlaneGeometry.contains(shadows[k], p)) {
            lost[i] += s.weight;
            monthLost[mi] += s.weight;
            break;
          }
        }
      }
    }

    return ShadeHeatmap(
      originX: minX,
      originY: minY,
      cellSize: size,
      columns: nc,
      rows: nr,
      values: [
        for (var i = 0; i < centers.length; i++)
          if (!inside[i])
            double.nan
          else if (total == 0)
            0
          else
            lost[i] / total,
      ],
      monthlyLoss: [
        for (var m = 0; m < 12; m++)
          if (monthTotal[m] == 0) double.nan else monthLost[m] / monthTotal[m],
      ],
    );
  }
}
