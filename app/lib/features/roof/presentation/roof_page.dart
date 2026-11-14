import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/features/photos/data/photo_providers.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/presentation/editor/editor_tool.dart';
import 'package:panelsolar/features/roof/presentation/roof_declination.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:panelsolar/features/roof/presentation/widgets/image_source_sheet.dart';
import 'package:panelsolar/features/roof/presentation/widgets/tape_sketch_dialog.dart';
import 'package:panelsolar/features/site/presentation/site_providers.dart';
import 'package:persistence/persistence.dart';

/// Módulo "Techo" del proyecto: base (imagen propia o croquis), escala,
/// norte, planos, obstáculos, sombras y horizonte.
class RoofPage extends ConsumerStatefulWidget {
  /// Crea la pantalla.
  const new({required this.projectId, super.key});

  /// Proyecto.
  final String projectId;

  @override
  ConsumerState<RoofPage> createState() => _RoofPageState();
}

class _RoofPageState extends ConsumerState<RoofPage> {
  bool _busy = false;

  String get _id => widget.projectId;

  void _open(EditorTool tool) =>
      context.push(AppRoutes.roofEditor(_id, tool.name));

  Future<void> _import() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final source = await showImageSourceSheet(context);
    if (source == null) return;
    final file = await ref.read(imagePickerProvider).pickImage(source: source);
    if (file == null) return;
    setState(() => _busy = true);
    final ok = await ref
        .read(roofImageImporterProvider)
        .import(projectId: _id, bytes: await file.readAsBytes());
    if (!mounted) return;
    setState(() => _busy = false);
    messenger.showSnackBar(
      SnackBar(content: Text(ok ? l10n.roofImageSaved : l10n.roofImageInvalid)),
    );
    if (ok) _open(EditorTool.calibrate);
  }

  Future<void> _sketch(RoofImage? record) async {
    if (record?.mode != RoofMode.sketch) {
      await ref.read(roofImageRepositoryProvider).startSketch(_id);
    }
    if (!mounted) return;
    final polygon = await showTapeSketchDialog(context);
    if (polygon == null || !mounted) return;
    final l10n = AppLocalizations.of(context);
    final site = siteFor(ref, _id);
    await ref
        .read(roofEditingServiceProvider)
        .addPlane(
          projectId: _id,
          polygon: polygon,
          nameFor: l10n.roofPlaneDefaultName,
          southernHemisphere: (site?.latitude ?? 1) < 0,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final value = ref.watch(roofLayoutProvider(_id));
    ref.watch(siteProvider(_id));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.roofTitle)),
      body: AsyncValueView(
        value: value,
        data: (layout) {
          final r = layout.record;
          final storage = ref.watch(appStorageProvider);
          final hasBase = r != null;
          final area = layout.planes.fold<double>(
            0,
            (a, p) => a + PolygonMetrics.area(p.polygon),
          );
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            children: [
              if (_busy) const LinearProgressIndicator(),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      title: Text(l10n.roofBaseTitle),
                      subtitle: Text(switch (r?.mode) {
                        null => l10n.roofBaseNone,
                        RoofMode.sketch => l10n.roofBaseSketch,
                        RoofMode.image =>
                          r!.metersPerPixel == null
                              ? l10n.roofBaseImageUncalibrated
                              : l10n.roofBaseImage(
                                  RoofFormat.meters(
                                    r.metersPerPixel! * 100,
                                    locale,
                                  ).replaceAll(' m', ' cm'),
                                ),
                      }, key: const Key('roof-base-status')),
                    ),
                    if (r?.filePath case final path?)
                      SizedBox(
                        height: 160,
                        child: Image.file(
                          storage.file(path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilledButton.icon(
                            key: const Key('roof-import'),
                            onPressed: _busy ? null : _import,
                            icon: const Icon(Icons.add_photo_alternate),
                            label: Text(
                              r?.mode == RoofMode.image
                                  ? l10n.roofChangeImage
                                  : l10n.roofImportImage,
                            ),
                          ),
                          OutlinedButton.icon(
                            key: const Key('roof-sketch'),
                            onPressed: () => _sketch(r),
                            icon: const Icon(Icons.straighten),
                            label: Text(l10n.roofSketchMode),
                          ),
                          if (r?.mode == RoofMode.image)
                            OutlinedButton.icon(
                              key: const Key('roof-calibrate'),
                              onPressed: () => _open(EditorTool.calibrate),
                              icon: const Icon(Icons.straighten),
                              label: Text(l10n.roofToolCalibrate),
                            ),
                          if (hasBase)
                            OutlinedButton.icon(
                              key: const Key('roof-north'),
                              onPressed: () => _open(EditorTool.north),
                              icon: const Icon(Icons.explore),
                              label: Text(l10n.roofToolNorth),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.polyline),
                      title: Text(l10n.roofPlanesTitle),
                      subtitle: Text(
                        layout.planes.isEmpty
                            ? l10n.roofPlanesEmpty
                            : l10n.roofEntrySummary(
                                layout.planes.length,
                                RoofFormat.area(area, locale),
                              ),
                      ),
                    ),
                    for (final p in layout.planes)
                      ListTile(
                        dense: true,
                        title: Text(p.name),
                        subtitle: Text(
                          l10n.roofPlaneListItem(
                            RoofFormat.area(
                              PolygonMetrics.area(p.polygon),
                              locale,
                            ),
                            RoofFormat.degrees(p.tiltDeg, locale),
                            RoofFormat.degrees(p.azimuthDeg, locale),
                          ),
                        ),
                      ),
                    ListTile(
                      leading: const Icon(Icons.water_drop),
                      title: Text(l10n.roofObstaclesTitle),
                      subtitle: Text(
                        l10n.roofObstaclesCount(layout.obstacles.length),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Wrap(
                        spacing: 8,
                        children: [
                          FilledButton.icon(
                            key: const Key('roof-edit'),
                            onPressed: hasBase
                                ? () => _open(EditorTool.draw)
                                : null,
                            icon: const Icon(Icons.edit),
                            label: Text(l10n.roofOpenEditor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      key: const Key('roof-shade'),
                      leading: const Icon(Icons.wb_twilight),
                      title: Text(l10n.roofShadeTitle),
                      subtitle: Text(l10n.roofShadeSubtitle),
                      trailing: const Icon(Icons.chevron_right),
                      enabled: layout.planes.isNotEmpty,
                      onTap: () => context.push(AppRoutes.roofShade(_id)),
                    ),
                    ListTile(
                      key: const Key('roof-horizon'),
                      leading: const Icon(Icons.landscape),
                      title: Text(l10n.roofHorizonTitle),
                      subtitle: Text(
                        l10n.roofHorizonSubtitle(layout.far.length),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push(AppRoutes.roofHorizon(_id)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
