import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/presentation/editor/editor_actions.dart';
import 'package:panelsolar/features/roof/presentation/editor/editor_panels.dart';
import 'package:panelsolar/features/roof/presentation/editor/editor_tool.dart';
import 'package:panelsolar/features/roof/presentation/editor/roof_canvas.dart';
import 'package:panelsolar/features/roof/presentation/editor/roof_painter.dart';
import 'package:panelsolar/features/roof/presentation/widgets/north_arrow.dart';
import 'package:panelsolar/features/site/presentation/site_providers.dart';
import 'package:persistence/persistence.dart';

/// Editor del techo: calibrar, orientar, trazar planos, obstáculos y
/// pasillos sobre la imagen (o el croquis), con zoom y arrastre.
class RoofEditorPage extends ConsumerStatefulWidget {
  /// Crea el editor en la herramienta [initialTool].
  const new({
    required this.projectId,
    this.initialTool = EditorTool.draw,
    super.key,
  });

  /// Proyecto.
  final String projectId;

  /// Herramienta inicial.
  final EditorTool initialTool;

  @override
  ConsumerState<RoofEditorPage> createState() => RoofEditorPageState();
}

/// Estado del editor (público para que las acciones lo usen).
class RoofEditorPageState extends ConsumerState<RoofEditorPage>
    with EditorActions {
  @override
  late EditorTool tool = widget.initialTool;

  @override
  String get projectId => widget.projectId;

  static const List<(EditorTool, IconData)> _tools = [
    (EditorTool.calibrate, Icons.straighten),
    (EditorTool.verify, Icons.rule),
    (EditorTool.north, Icons.explore),
    (EditorTool.draw, Icons.polyline),
    (EditorTool.obstacle, Icons.water_drop),
    (EditorTool.walkway, Icons.linear_scale),
    (EditorTool.select, Icons.touch_app),
  ];

  String _toolLabel(AppLocalizations l10n, EditorTool t) => switch (t) {
    EditorTool.calibrate => l10n.roofToolCalibrate,
    EditorTool.verify => l10n.roofToolVerify,
    EditorTool.north => l10n.roofToolNorth,
    EditorTool.draw => l10n.roofToolDraw,
    EditorTool.obstacle => l10n.roofToolObstacle,
    EditorTool.walkway => l10n.roofToolWalkway,
    EditorTool.select => l10n.roofToolSelect,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final value = ref.watch(roofLayoutProvider(widget.projectId));
    ref.watch(siteProvider(widget.projectId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.roofEditorTitle)),
      body: AsyncValueView(
        value: value,
        data: (layout) {
          final space = layout.space;
          final isSketch = space.mode == RoofMode.sketch;
          bool enabled(EditorTool t) {
            if (isSketch) {
              return t != EditorTool.calibrate && t != EditorTool.verify;
            }
            return space.isCalibrated ||
                t == EditorTool.calibrate ||
                t == EditorTool.north;
          }

          final storage = ref.watch(appStorageProvider);
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    for (final (t, icon) in _tools)
                      if (!isSketch ||
                          (t != EditorTool.calibrate && t != EditorTool.verify))
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ChoiceChip(
                            key: Key('tool-${t.name}'),
                            avatar: Icon(icon, size: 18),
                            label: Text(_toolLabel(l10n, t)),
                            selected: tool == t,
                            onSelected: enabled(t)
                                ? (_) => setState(() => selectTool(t))
                                : null,
                          ),
                        ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    RoofCanvas(
                      key: const Key('roof-canvas'),
                      space: space,
                      imageFile: space.imagePath == null
                          ? null
                          : storage.file(space.imagePath!),
                      onTapPx: (px, zoom) => onCanvasTap(layout, px, zoom),
                      painterBuilder: (zoom) => RoofPainter(
                        space: space,
                        zoom: zoom,
                        locale: formatLocale(context),
                        layers: layersFor(layout),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: NorthArrow(
                        angleDeg:
                            space.frame?.northAngleDeg ??
                            layout.record?.northAngleDeg ??
                            0,
                      ),
                    ),
                    if (!space.isCalibrated)
                      Positioned(
                        left: 8,
                        right: 72,
                        top: 8,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(l10n.roofCalibrateFirst),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Material(
                elevation: 4,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: EditorPanel(state: this, layout: layout),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
