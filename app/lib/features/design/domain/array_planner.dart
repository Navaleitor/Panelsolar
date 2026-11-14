import 'dart:math' as math;

import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/design/domain/design_models.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:persistence/persistence.dart' show LayoutOrientation, MountType;
import 'package:solar_engine/solar_engine.dart';

/// Medidas del panel (m).
typedef PanelSize = ({double lengthM, double widthM});

/// Ajustes de un arreglo.
typedef ArraySettings = ({
  LayoutOrientation? orientation,
  MountType mount,
  double rackTiltDeg,
  double rackAzimuthDeg,
  double gapM,
  double rowGapM,
  double clearanceM,
});

/// Resultado del máximo de paneles en un plano.
typedef ArrayPlan = ({
  LayoutOrientation orientation,
  List<DesignPanel> panels,
  double? rowSpacingM,
  double score,
});

/// Calcula el máximo de paneles de un plano (B.6 punto 13, ficha 29).
///
/// Prueba vertical y horizontal (si `orientation` es nulo)
/// con varios desplazamientos y se queda con la que da más energía: cada
/// panel vale 1 − pérdida del [heatmap] de F3 y 0 si pasa
/// [thresholdPct]. Los que valen 0 quedan apagados (se pueden encender).
/// En techo plano con estructura, la separación entre filas sale de la
/// ficha 23 con el [site].
ArrayPlan planArray({
  required RoofPlaneModel plane,
  required List<ObstacleModel> obstacles,
  required PanelSize panel,
  required ArraySettings settings,
  Site? site,
  ShadeHeatmap? heatmap,
  double thresholdPct = 10,
}) {
  final region = plane.edgeSetbackM > 0
      ? PolygonOps.inset(plane.polygon, plane.edgeSetbackM)
      : plane.polygon;
  final exclusions = <List<Vec2>>[
    for (final o in obstacles)
      if (_touches(o.footprint, plane.polygon))
        _buffer(o.footprint, settings.clearanceM),
    for (final w in plane.walkways) w.polygon,
  ];
  double weight(List<Vec2> c) {
    if (heatmap == null) return 1;
    final loss = heatmapLoss(heatmap, c);
    return loss * 100 >= thresholdPct ? 0 : 1 - loss;
  }

  final options = settings.orientation == null
      ? LayoutOrientation.values
      : [settings.orientation!];
  ArrayPlan? best;
  for (final o in options) {
    final g = gridFor(panel, o, settings, plane, site);
    final packed = region == null
        ? const PackedLayout(panels: [], score: 0)
        : PanelPacker.pack(
            region: region,
            azimuthDeg: settings.mount == MountType.tiltedRack
                ? settings.rackAzimuthDeg
                : plane.azimuthDeg,
            grid: g.grid,
            exclusions: exclusions,
            weight: weight,
          );
    if (best == null || packed.score > best.score + 1e-9) {
      best = (
        orientation: o,
        panels: [
          for (final p in packed.panels)
            DesignPanel(
              corners: p.corners,
              row: p.row,
              column: p.column,
              on: weight(p.corners) > 0,
            ),
        ],
        rowSpacingM: g.rowSpacingM,
        score: packed.score,
      );
    }
  }
  return best!;
}

/// Rejilla en planta de un panel con su orientación y montaje.
({PackingGrid grid, double? rowSpacingM}) gridFor(
  PanelSize panel,
  LayoutOrientation o,
  ArraySettings s,
  RoofPlaneModel plane,
  Site? site,
) {
  final along = o == LayoutOrientation.portrait ? panel.widthM : panel.lengthM;
  final slope = o == LayoutOrientation.portrait ? panel.lengthM : panel.widthM;
  if (s.mount == MountType.tiltedRack) {
    final c = cosd(s.rackTiltDeg);
    final across = slope * c;
    double? gap;
    var pitch = across + s.rowGapM;
    if (site != null && s.rackTiltDeg > 0) {
      final r = RowSpacing.compute(
        site: site,
        slopeLengthM: slope,
        tiltDeg: s.rackTiltDeg,
        arrayAzimuthDeg: s.rackAzimuthDeg,
      );
      gap = r.gapM;
      pitch = math.max(pitch, r.pitchM);
    }
    return (
      grid: PackingGrid(
        alongM: along,
        acrossM: across,
        columnPitchM: along + s.gapM,
        rowPitchM: pitch,
      ),
      rowSpacingM: gap,
    );
  }
  final c = cosd(plane.tiltDeg);
  return (
    grid: PackingGrid(
      alongM: along,
      acrossM: slope * c,
      columnPitchM: along + s.gapM,
      rowPitchM: (slope + s.rowGapM) * c,
    ),
    rowSpacingM: null,
  );
}

/// Pérdida promedio del mapa de calor en el centro y las esquinas del
/// panel (0–1; las celdas fuera del plano no cuentan).
double heatmapLoss(ShadeHeatmap m, List<Vec2> corners) {
  final pts = [...corners, (corners[0] + corners[2]) * 0.5];
  var s = 0.0;
  var n = 0;
  for (final p in pts) {
    final c = ((p.x - m.originX) / m.cellSize).floor();
    final r = ((p.y - m.originY) / m.cellSize).floor();
    if (c < 0 || r < 0 || c >= m.columns || r >= m.rows) continue;
    final v = m.at(c, r);
    if (v.isNaN) continue;
    s += v;
    n++;
  }
  return n == 0 ? 0 : s / n;
}

bool _touches(List<Vec2> footprint, List<Vec2> plane) =>
    RegionTests.overlaps(footprint, plane);

/// Huella agrandada [d] metros (envolvente de cada vértice desplazado en
/// 8 direcciones).
List<Vec2> _buffer(List<Vec2> f, double d) {
  if (d <= 0) return f;
  return PolygonOps.convexHull([
    for (final p in f)
      for (var k = 0; k < 8; k++)
        p + Vec2(math.cos(k * math.pi / 4), math.sin(k * math.pi / 4)) * d,
  ]);
}
