import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/domain/roof_codec.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/presentation/editor/drawing_state.dart';
import 'package:panelsolar/features/roof/presentation/editor/editor_tool.dart';
import 'package:panelsolar/features/roof/presentation/editor/hit_test.dart';
import 'package:panelsolar/features/roof/presentation/editor/roof_painter.dart';
import 'package:panelsolar/features/roof/presentation/roof_declination.dart';
import 'package:panelsolar/features/roof/presentation/sensors/sensor_dialogs.dart';
import 'package:panelsolar/features/roof/presentation/widgets/number_input_dialog.dart';
import 'package:panelsolar/features/roof/presentation/widgets/obstacle_sheet.dart';
import 'package:panelsolar/features/roof/presentation/widgets/plane_sheet.dart';
import 'package:persistence/persistence.dart';

/// Lo que hace cada herramienta del editor al tocar el lienzo.
mixin EditorActions<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  /// Proyecto.
  String get projectId;

  /// Herramienta activa.
  abstract EditorTool tool;

  /// Trazo del plano en curso (px).
  final drawing = DrawingState();

  /// Puntos de la línea en curso (calibración, norte, pasillo, pretil).
  final linePts = <Vec2>[];

  /// Plano elegido.
  String? selectedPlaneId;

  /// Obstáculo elegido.
  String? selectedObstacleId;

  /// Vértice tomado para mover.
  int? grabbedVertex;

  /// Tipo de obstáculo a colocar.
  ObstacleType obstacleType = ObstacleType.waterTank;

  /// Cambia el estado desde los paneles.
  void refresh(VoidCallback fn) => setState(fn);

  /// Cambia de herramienta y limpia lo que estaba a medias.
  void selectTool(EditorTool t) {
    tool = t;
    drawing.clear();
    linePts.clear();
    grabbedVertex = null;
  }

  /// Capas a dibujar.
  RoofLayers layersFor(RoofLayout layout) {
    final r = layout.record;
    final lines = <(List<Vec2>, Color)>[
      if (tool == EditorTool.calibrate || tool == EditorTool.verify) ...[
        if (RoofCodec.decodeLine(r?.calibrationLine) case final l?)
          ([l.start, l.end], Colors.purple),
        if (RoofCodec.decodeLine(r?.verificationLine) case final l?)
          ([l.start, l.end], Colors.teal),
      ],
      if (linePts.isNotEmpty) (List.of(linePts), Colors.pink),
    ];
    return RoofLayers(
      planes: layout.planes,
      obstacles: layout.obstacles,
      selectedPlaneId: selectedPlaneId,
      selectedObstacleId: selectedObstacleId,
      grabbedVertex: grabbedVertex,
      drawingPx: List.of(drawing.points),
      linesPx: lines,
    );
  }

  /// Reparte el toque según la herramienta.
  Future<void> onCanvasTap(RoofLayout layout, Vec2 px, double zoom) async {
    final frame = layout.space.frame;
    switch (tool) {
      case EditorTool.calibrate:
      case EditorTool.verify:
      case EditorTool.north:
        setState(() {
          if (linePts.length >= 2) linePts.clear();
          linePts.add(px);
        });
        if (linePts.length == 2 && tool != EditorTool.north) {
          await _measureLine(layout);
        }
      case EditorTool.draw:
        if (frame == null) return;
        final vertices = [
          for (final p in layout.planes)
            for (final v in p.polygon) frame.toPixel(v),
        ];
        var closed = false;
        setState(
          () => closed = drawing.add(px, vertices: vertices, zoom: zoom),
        );
        if (closed) await closePolygon(layout);
      case EditorTool.obstacle:
        if (frame == null) return;
        final preset = ObstacleCatalog.presets[obstacleType]!;
        if (preset.shape == ObstacleShape.line) {
          setState(() => linePts.add(px));
          if (linePts.length < 2) return;
          final pts = [for (final p in linePts) frame.toLocal(p)];
          setState(linePts.clear);
          await _newObstacle(layout, center: pts.first, points: pts);
        } else {
          await _newObstacle(layout, center: frame.toLocal(px));
        }
      case EditorTool.walkway:
        if (frame == null) return;
        setState(() => linePts.add(px));
        if (linePts.length == 2) await _addWalkway(layout, frame);
      case EditorTool.select:
        if (frame == null) return;
        await _select(
          layout,
          frame.toLocal(px),
          24 / zoom * frame.metersPerPixel,
        );
    }
  }

  Future<void> _measureLine(RoofLayout layout) async {
    final l10n = AppLocalizations.of(context);
    final calibrating = tool == EditorTool.calibrate;
    final meters = await showNumberDialog(
      context,
      title: calibrating
          ? l10n.roofCalibrateDialogTitle
          : l10n.roofVerifyDialogTitle,
      label: l10n.roofLengthMetersLabel,
      help: l10n.roofCalibrateDialogHelp,
      fieldKey: const Key('line-length'),
    );
    if (meters == null || !mounted) return;
    final line = MeasuredLine(linePts[0], linePts[1], meters);
    final service = ref.read(roofEditingServiceProvider);
    final r = layout.record;
    if (line.lengthPx < ScaleCalibration.minLinePx) {
      _snack(l10n.roofLineTooShort);
      setState(linePts.clear);
      return;
    }
    {
      if (calibrating) {
        await service.saveCalibration(
          projectId: projectId,
          line: line,
          verification: RoofCodec.decodeLine(r?.verificationLine),
        );
      } else {
        final cal = RoofCodec.decodeLine(r?.calibrationLine);
        if (cal == null) return;
        await service.saveCalibration(
          projectId: projectId,
          line: cal,
          verification: line,
        );
      }
    }
    if (mounted) setState(linePts.clear);
  }

  /// Guarda el plano trazado.
  Future<void> closePolygon(RoofLayout layout) async {
    final frame = layout.space.frame;
    if (frame == null || !drawing.canClose) return;
    final l10n = AppLocalizations.of(context);
    final local = [for (final p in drawing.points) frame.toLocal(p)];
    final site = await siteFor(ref, projectId);
    await ref
        .read(roofEditingServiceProvider)
        .addPlane(
          projectId: projectId,
          polygon: local,
          nameFor: l10n.roofPlaneDefaultName,
          southernHemisphere: (site?.latitude ?? 1) < 0,
        );
    if (mounted) setState(drawing.clear);
  }

  Future<void> _newObstacle(
    RoofLayout layout, {
    required Vec2 center,
    List<Vec2> points = const [],
  }) async {
    final preset = ObstacleCatalog.presets[obstacleType]!;
    final model = ObstacleModel(
      id: '',
      type: obstacleType,
      shape: preset.shape,
      center: center,
      widthM: preset.widthM,
      depthM: preset.depthM,
      rotationDeg: layout.space.frame?.northAngleDeg ?? 0,
      points: points,
      heightM: preset.heightM,
      heightSource: HeightSource.typical,
      tankLiters: obstacleType == ObstacleType.waterTank ? 1100 : null,
    );
    final result = await showObstacleSheet(context, model);
    if (result == null || result.delete) return;
    await ref
        .read(roofEditingServiceProvider)
        .addObstacle(projectId, result.model);
  }

  Future<void> _addWalkway(RoofLayout layout, ImageFrame frame) async {
    final l10n = AppLocalizations.of(context);
    final a = frame.toLocal(linePts[0]);
    final b = frame.toLocal(linePts[1]);
    setState(linePts.clear);
    final plane = RoofHitTest.planeAt(layout.planes, (a + b) * 0.5);
    if (plane == null) {
      _snack(l10n.roofWalkwayOutside);
      return;
    }
    final width = await showNumberDialog(
      context,
      title: l10n.roofWalkwayWidthTitle,
      label: l10n.roofLengthMetersLabel,
      initialValue: 0.6,
      fieldKey: const Key('walkway-width'),
    );
    if (width == null) return;
    await ref
        .read(roofEditingServiceProvider)
        .updatePlane(
          projectId,
          plane.copyWith(walkways: [...plane.walkways, Walkway(a, b, width)]),
        );
  }

  Future<void> _select(RoofLayout layout, Vec2 p, double radiusM) async {
    final service = ref.read(roofEditingServiceProvider);
    final selected = layout.planes
        .where((x) => x.id == selectedPlaneId)
        .firstOrNull;
    if (selected != null && grabbedVertex != null) {
      final poly = List.of(selected.polygon)..[grabbedVertex!] = p;
      setState(() => grabbedVertex = null);
      if (PolygonMetrics.isSimple(poly)) {
        await service.updatePlane(projectId, selected.copyWith(polygon: poly));
      }
      return;
    }
    if (selected != null) {
      final v = RoofHitTest.vertexAt(selected, p, radiusM);
      if (v != null) {
        setState(() => grabbedVertex = v);
        return;
      }
    }
    final o = RoofHitTest.obstacleAt(layout.obstacles, p);
    if (o != null) {
      setState(() => selectedObstacleId = o.id);
      final result = await showObstacleSheet(context, o);
      if (result != null) {
        if (result.delete) {
          await ref.read(obstacleRepositoryProvider).softDelete(o.id);
        } else {
          await service.updateObstacle(projectId, result.model);
        }
      }
      if (mounted) setState(() => selectedObstacleId = null);
      return;
    }
    final plane = RoofHitTest.planeAt(layout.planes, p);
    setState(() {
      selectedPlaneId = plane?.id;
      grabbedVertex = null;
    });
  }

  /// Abre la hoja de edición del plano elegido.
  Future<void> editSelectedPlane(RoofLayout layout) async {
    final plane = layout.planes
        .where((x) => x.id == selectedPlaneId)
        .firstOrNull;
    if (plane == null) return;
    await showPlaneSheet(context, projectId: projectId, plane: plane);
  }

  void _snack(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  /// Mide con la brújula el rumbo de la línea de referencia y fija el norte.
  Future<void> confirmNorthWithCompass() async {
    if (linePts.length != 2) return;
    final decl = await declinationFor(ref, projectId);
    if (!mounted) return;
    final r = await showSensorDialog(
      context,
      mode: SensorMode.compass,
      declinationDeg: decl,
    );
    final az = r?.azimuthDeg;
    if (az == null) return;
    await ref
        .read(roofEditingServiceProvider)
        .saveNorth(
          projectId: projectId,
          northAngleDeg: ImageFrame.northAngleFrom(
            lineImageBearingDeg: ImageFrame.imageBearing(
              linePts[0],
              linePts[1],
            ),
            trueAzimuthDeg: az,
          ),
          source: NorthSource.compass,
          declinationDeg: decl,
        );
    if (mounted) setState(linePts.clear);
  }
}
