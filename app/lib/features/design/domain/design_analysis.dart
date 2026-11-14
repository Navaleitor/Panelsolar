import 'package:data_sources/data_sources.dart';
import 'package:panelsolar/features/design/domain/design_inputs.dart';
import 'package:panelsolar/features/design/domain/design_models.dart';
import 'package:panelsolar/features/roof/domain/shade_job.dart';
import 'package:persistence/persistence.dart' show LayoutOrientation, MountType;
import 'package:solar_engine/solar_engine.dart';

/// Analiza el diseño con el clima ya cargado (función pura y pesada; la
/// app la corre en un isolate):
/// 1. temperaturas de diseño (la más extrema de NASA y PVGIS);
/// 2. sombra de cada panel con diodos y vista de cielo (B.7.1 pasos 4–6);
/// 3. paneles activos (encendidos y bajo el umbral);
/// 4. strings sobre los paneles activos y pérdida eléctrica por plano;
/// 5. producción del primer año y de la vida útil.
DesignJobResult analyzeDesign(DesignJobInput job, SiteClimate climate) {
  final site = Site(
    latitude: job.site.latitude,
    longitude: job.site.longitude,
    elevation:
        job.site.elevation ??
        climate.tmy?.elevation ??
        climate.primary.elevation ??
        0,
    utcOffsetHours: job.site.utcOffsetHours,
  );
  final horizon = combinedHorizon(job.terrain, job.far) ?? climate.horizon;
  final temps = _temperatures(site, climate);
  final inputs = SimulationInputs.prepare(
    site: site,
    weather: climate.primary.series,
    horizon: horizon,
  );
  final diffuse = _diffuseShare(inputs);
  final shading = toShadingObstacles(job.obstacles);
  final independent = job.inverter?.independent ?? true;

  // Paneles activos en orden (plano, fila, columna) para los strings.
  final planeResults = <PlaneShadeResult>[];
  final groups = <ArrayGroup>[];
  final stringSlots = _stringSlots(job.strings);
  var cursor = 0;
  for (final a in job.arrays) {
    final plane = job.planes.where((p) => p.id == a.planeId).firstOrNull;
    if (plane == null) continue;
    final rack = a.mount == MountType.tiltedRack;
    final tilt = rack ? a.rackTiltDeg : plane.tiltDeg;
    final az = rack ? a.rackAzimuthDeg : plane.azimuthDeg;
    final samples = SunSamples.year(
      site,
      year: 2026,
      dayStep: job.dayStep,
      minuteStep: job.minuteStep,
      tiltDeg: tilt,
      azimuthDeg: az,
    );
    final surface = rack ? RoofSurface.flat : surfaceOf(plane);
    final onIdx = [
      for (final (i, p) in a.panels.indexed)
        if (p.on) i,
    ];
    final obstacles = [...shading, if (rack) ..._rowWalls(a, job.panel, onIdx)];
    final shadePanels = [
      for (final i in onIdx) _shadePanel(a.panels[i], a.orientation),
    ];
    final first = PanelShadeCalculator.compute(
      panels: shadePanels,
      obstacles: obstacles,
      samples: samples,
      horizon: horizon,
      surface: surface,
      diffuseShare: diffuse,
    );
    final perPanel = List<PanelShadeResult?>.filled(a.panels.length, null);
    final active = List<bool>.filled(a.panels.length, false);
    final activeLocal = <int>[];
    for (final (k, i) in onIdx.indexed) {
      perPanel[i] = first.panels[k];
      if (first.panels[k].loss * 100 < job.thresholdPct) {
        active[i] = true;
        activeLocal.add(k);
      }
    }
    var loss = activeLocal.isEmpty
        ? 0.0
        : activeLocal.fold<double>(0, (s, k) => s + first.panels[k].loss) /
              activeLocal.length;
    if (!independent && activeLocal.isNotEmpty && stringSlots.isNotEmpty) {
      // Strings: cada panel activo toma el siguiente lugar de string.
      final members = <int, List<int>>{};
      for (final (j, _) in activeLocal.indexed) {
        final slot = cursor + j < stringSlots.length
            ? stringSlots[cursor + j]
            : -1;
        if (slot >= 0) (members[slot] ??= []).add(j);
      }
      cursor += activeLocal.length;
      final second = PanelShadeCalculator.compute(
        panels: [for (final k in activeLocal) shadePanels[k]],
        obstacles: obstacles,
        samples: samples,
        horizon: horizon,
        surface: surface,
        strings: members.values.toList(),
        diffuseShare: diffuse,
      );
      loss = second.stringLoss;
    }
    planeResults.add((
      planeId: a.planeId,
      panels: perPanel,
      active: active,
      loss: loss,
    ));
    if (activeLocal.isNotEmpty) {
      groups.add(
        ArrayGroup(
          tiltDeg: tilt,
          azimuthDeg: az,
          panelCount: activeLocal.length,
          panelPowerW: job.panel.pmaxW,
          shadingLoss: loss,
        ),
      );
    }
  }

  final inv = job.inverter;
  final production = inv == null || groups.isEmpty
      ? null
      : DesignSimulator.run(
          inputs: inputs,
          groups: groups,
          pacW: inv.pacW * inv.count,
          inverterEfficiency: inv.efficiencyPct / 100,
          gammaPdc: job.panel.gammaPct / 100,
          losses: job.losses,
          years: job.years,
        );
  final p = climate.primary;
  return DesignJobResult(
    temperatures: temps,
    planes: planeResults,
    production: production,
    weatherLabel: p.source == WeatherSource.nasaPower
        ? 'NASA POWER ${p.yearStart}–${p.yearEnd}'
        : 'PVGIS TMY',
    diffuseShare: diffuse,
  );
}

SiteDesignTemperatures _temperatures(Site site, SiteClimate c) {
  String name(WeatherDataset d) =>
      d.source == WeatherSource.nasaPower ? 'NASA POWER' : 'PVGIS';
  final tmy = c.tmy;
  return SiteDesignTemperatures.mostExtreme({
    name(c.primary): ClimateStatistics.compute(site, c.primary.series).design,
    if (tmy != null && tmy.source != c.primary.source)
      name(tmy): ClimateStatistics.compute(site, tmy.series).design,
  });
}

/// Σ DHI / Σ GHI de día (0.3 si no hay datos).
double _diffuseShare(SimulationInputs i) {
  var d = 0.0;
  var g = 0.0;
  for (var k = 0; k < i.length; k++) {
    if (i.zenith[k] >= 90) continue;
    d += i.dhi[k];
    g += i.ghi[k];
  }
  return g <= 0 ? 0.3 : (d / g).clamp(0.05, 1.0);
}

/// Lugar de string de cada panel en orden: [0,0,...,1,1,...].
List<int> _stringSlots(List<({int series, int parallel})> groups) {
  final out = <int>[];
  var s = 0;
  for (final g in groups) {
    for (var p = 0; p < g.parallel; p++) {
      for (var k = 0; k < g.series; k++) {
        out.add(s);
      }
      s++;
    }
  }
  return out;
}

/// Panel para el motor: la orilla `[0]→[1]` debe ser la corta (3 secciones
/// de diodos a lo ancho del panel).
ShadePanel _shadePanel(DesignPanel p, LayoutOrientation o) {
  final c = [for (final v in p.corners) (x: v.x, y: v.y)];
  return o == LayoutOrientation.portrait
      ? ShadePanel(c)
      : ShadePanel([c[0], c[3], c[2], c[1]]);
}

/// Fila de estructura como muro en su orilla alta (sombra sobre la fila
/// de atrás).
List<ShadingObstacle> _rowWalls(PlaneArray a, PanelSpec panel, List<int> on) {
  final slope = a.orientation == LayoutOrientation.portrait
      ? panel.lengthM
      : panel.widthM;
  final h = slope * sind(a.rackTiltDeg);
  return [
    for (final i in on)
      ShadingObstacle(
        footprint: () {
          final c = a.panels[i].corners;
          final up = (c[3] - c[0]).normalized * 0.02;
          return [
            (x: c[3].x - up.x, y: c[3].y - up.y),
            (x: c[2].x - up.x, y: c[2].y - up.y),
            (x: c[2].x, y: c[2].y),
            (x: c[3].x, y: c[3].y),
          ];
        }(),
        heightM: h,
      ),
  ];
}
