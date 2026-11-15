import 'dart:convert';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/features/design/data/design_providers.dart';
import 'package:panelsolar/features/design/domain/array_planner.dart';
import 'package:panelsolar/features/design/domain/design_inputs.dart';
import 'package:panelsolar/features/design/domain/design_models.dart';
import 'package:panelsolar/features/design/domain/equipment_specs.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/domain/shade_job.dart';
import 'package:panelsolar/features/site/data/site_data_providers.dart';
import 'package:panelsolar/features/weather/data/weather_providers.dart';
import 'package:persistence/persistence.dart';
import 'package:solar_engine/solar_engine.dart' as engine;

/// Calcula el máximo de paneles (en un isolate; las pruebas lo cambian).
final arrayPlannerRunnerProvider =
    Provider<Future<ArrayPlan> Function(ArrayPlanRequest)>(
      (ref) =>
          (r) => Isolate.run(() => r.run()),
    );

/// Petición para el planificador (se manda completa al isolate).
class ArrayPlanRequest {
  /// Crea la petición.
  const new({
    required this.plane,
    required this.obstacles,
    required this.panel,
    required this.settings,
    required this.thresholdPct,
    this.site,
    this.heatmap,
  });

  /// Plano.
  final RoofPlaneModel plane;

  /// Obstáculos.
  final List<ObstacleModel> obstacles;

  /// Medidas del panel.
  final PanelSize panel;

  /// Ajustes.
  final ArraySettings settings;

  /// Umbral de sombra (%).
  final double thresholdPct;

  /// Sitio (para la separación entre filas).
  final engine.Site? site;

  /// Mapa de calor de F3.
  final engine.ShadeHeatmap? heatmap;

  /// Ejecuta.
  ArrayPlan run() => planArray(
    plane: plane,
    obstacles: obstacles,
    panel: panel,
    settings: settings,
    site: site,
    heatmap: heatmap,
    thresholdPct: thresholdPct,
  );
}

/// Operaciones del diseño FV de un proyecto.
class DesignService {
  /// Crea el servicio.
  const new(this._ref);

  final Ref _ref;

  PvDesignRepository get _designs => _ref.read(pvDesignRepositoryProvider);

  /// Ubicación del proyecto para el motor (nula si no tiene).
  Future<DesignSite?> site(String projectId) async {
    final s = await _ref
        .read(siteRepositoryProvider)
        .watchForProject(projectId)
        .first;
    if (s == null) return null;
    final zones = _ref.read(timeZoneServiceProvider);
    final offset = s.timeZone == null
        ? null
        : zones.standardUtcOffsetHours(s.timeZone!);
    return (
      latitude: s.latitude,
      longitude: s.longitude,
      elevation: s.altitudeM,
      timeZone: s.timeZone,
      utcOffsetHours: offset,
    );
  }

  /// Guarda cambios del diseño.
  Future<PvDesign> update(String projectId, PvDesignsCompanion c) =>
      _designs.save(projectId, c);

  /// Calcula el máximo de paneles de cada plano y lo guarda.
  Future<int> computeMaximum({
    required String projectId,
    required RoofLayout roof,
    required PanelModel panel,
    required ArraySettings settings,
    required double thresholdPct,
  }) async {
    final s = await site(projectId);
    final engineSite = s == null ? null : _engineSite(s);
    var maps = const <PlaneShade>[];
    if (s != null) {
      maps = await _ref.read(shadeRunnerProvider)(
        site: (
          latitude: s.latitude,
          longitude: s.longitude,
          elevation: s.elevation ?? 0,
          utcOffsetHours: engineSite!.utcOffsetHours,
        ),
        planes: roof.planes,
        obstacles: roof.obstacles,
        terrain: roof.terrain,
        far: roof.far,
      );
    }
    var total = 0;
    for (final plane in roof.planes) {
      if (plane.polygon.length < 3) continue;
      final plan = await _ref.read(arrayPlannerRunnerProvider)(
        ArrayPlanRequest(
          plane: plane,
          obstacles: roof.obstacles,
          panel: (lengthM: panel.lengthM, widthM: panel.widthM),
          settings: settings,
          thresholdPct: thresholdPct,
          site: engineSite,
          heatmap: maps.where((m) => m.planeId == plane.id).firstOrNull?.map,
        ),
      );
      total += plan.panels.where((p) => p.on).length;
      await _ref
          .read(arrayLayoutRepositoryProvider)
          .saveForPlane(
            projectId,
            plane.id,
            ArrayLayoutsCompanion(
              panelModelId: Value(panel.id),
              orientation: Value(plan.orientation),
              mount: Value(settings.mount),
              rackTiltDeg: Value(settings.rackTiltDeg),
              rackAzimuthDeg: Value(settings.rackAzimuthDeg),
              gapM: Value(settings.gapM),
              rowGapM: Value(settings.rowGapM),
              clearanceM: Value(settings.clearanceM),
              rowSpacingM: Value(plan.rowSpacingM),
              panels: Value(DesignPanel.encodeList(plan.panels)),
            ),
          );
    }
    return total;
  }

  /// Quita o vuelve a poner el panel [index] de un arreglo.
  Future<void> togglePanel(ArrayLayout layout, int index) async {
    final panels = DesignPanel.decodeList(layout.panels);
    if (index < 0 || index >= panels.length) return;
    panels[index] = panels[index].withOn(on: !panels[index].on);
    await _ref
        .read(arrayLayoutRepositoryProvider)
        .saveForPlane(
          layout.projectId,
          layout.roofPlaneId,
          ArrayLayoutsCompanion(panels: Value(DesignPanel.encodeList(panels))),
        );
  }

  /// Guarda los strings.
  Future<void> saveStrings(String projectId, List<engine.StringGroup> g) =>
      _ref.read(stringConfigRepositoryProvider).replaceAll(projectId, [
        for (final s in g)
          StringConfigsCompanion.insert(
            projectId: projectId,
            series: s.series,
            parallel: Value(s.parallel),
            inverterIndex: Value(s.inverterIndex),
            mpptIndex: Value(s.mpptIndex),
          ),
      ]);

  /// Corre el análisis completo y guarda la producción.
  Future<void> analyze({
    required String projectId,
    required RoofLayout roof,
    bool forceRefresh = false,
  }) async {
    final notifier = _ref.read(designAnalysisProvider(projectId).notifier)
      ..result = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final input = await _jobInput(projectId, roof, forceRefresh);
      final dir = await _ref.read(weatherCacheDirProvider.future);
      final r = await _ref.read(designRunnerProvider)(input, dir);
      final p = r.production;
      if (p != null) {
        await _ref
            .read(simulationResultRepositoryProvider)
            .add(
              SimulationResultsCompanion.insert(
                projectId: projectId,
                pdcW: p.pdcW,
                pacW: p.pacW,
                firstYearKwh: p.firstYearKwh,
                lifetimeKwh: p.lifetimeKwh,
                years: Value(p.yearlyKwh.length),
                monthlyKwh: jsonEncode(p.monthlyFirstYearKwh),
                yearlyKwh: jsonEncode(p.yearlyKwh),
                clippedKwh: Value(p.clippedKwh),
                shadingLossPct: Value(p.shadingLoss * 100),
                specificYield: p.specificYield,
                performanceRatio: p.performanceRatio,
                losses: Value(LossesCodec.encode(input.losses)),
                weatherLabel: Value(r.weatherLabel),
              ),
            );
      }
      return r;
    });
    notifier.result = result;
  }

  Future<DesignJobInput> _jobInput(
    String projectId,
    RoofLayout roof,
    bool force,
  ) async {
    final s = await site(projectId);
    if (s == null) throw StateError('El proyecto no tiene ubicación');
    final design = await _designs.getForProject(projectId);
    final panelId = design?.panelModelId;
    final panel = panelId == null
        ? null
        : await _ref.read(panelModelRepositoryProvider).find(panelId);
    if (panel == null) throw StateError('Falta elegir el panel');
    final invId = design?.inverterModelId;
    final inv = invId == null
        ? null
        : await _ref.read(inverterModelRepositoryProvider).find(invId);
    final layouts = await _ref
        .read(arrayLayoutRepositoryProvider)
        .listByProject(projectId);
    final strings = await _ref
        .read(stringConfigRepositoryProvider)
        .watchByProject(projectId)
        .first;
    return DesignJobInput(
      projectId: projectId,
      site: s,
      planes: roof.planes,
      obstacles: roof.obstacles,
      terrain: roof.terrain,
      far: roof.far,
      arrays: [
        for (final l in layouts)
          (
            planeId: l.roofPlaneId,
            panels: DesignPanel.decodeList(l.panels),
            orientation: l.orientation,
            mount: l.mount,
            rackTiltDeg: l.rackTiltDeg,
            rackAzimuthDeg: l.rackAzimuthDeg,
          ),
      ],
      panel: EquipmentSpecs.panelSpec(panel),
      inverter: inv == null
          ? null
          : EquipmentSpecs.inverterSpec(
              inv,
              count: design!.inverterCount,
              optimizers: design.optimizerModelId != null,
            ),
      strings: [
        for (final g in strings) (series: g.series, parallel: g.parallel),
      ],
      losses: LossesCodec.decode(design?.losses ?? '{}'),
      thresholdPct: design?.shadeThresholdPct ?? 10,
      forceRefresh: force,
    );
  }

  static engine.Site _engineSite(DesignSite s) => engine.Site(
    latitude: s.latitude,
    longitude: s.longitude,
    elevation: s.elevation ?? 0,
    utcOffsetHours: s.utcOffsetHours,
  );
}

/// Servicio del diseño.
final designServiceProvider = Provider<DesignService>(DesignService.new);
