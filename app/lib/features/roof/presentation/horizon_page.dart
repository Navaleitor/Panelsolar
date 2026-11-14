import 'package:data_sources/data_sources.dart' show Attributions;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/domain/shade_job.dart';
import 'package:panelsolar/features/roof/presentation/roof_declination.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:panelsolar/features/roof/presentation/widgets/far_obstacle_dialog.dart';
import 'package:panelsolar/features/roof/presentation/widgets/horizon_chart.dart';
import 'package:panelsolar/features/site/presentation/site_providers.dart';

/// Horizonte: terreno de PVGIS (B.7 A) y obstáculos lejanos medidos con
/// brújula e inclinómetro (B.7 B).
class HorizonPage extends ConsumerStatefulWidget {
  /// Crea la pantalla.
  const new({required this.projectId, super.key});

  /// Proyecto.
  final String projectId;

  @override
  ConsumerState<HorizonPage> createState() => _HorizonPageState();
}

class _HorizonPageState extends ConsumerState<HorizonPage> {
  bool _loading = false;

  Future<void> _downloadTerrain() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final site = siteFor(ref, widget.projectId);
    if (site == null) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.roofShadeNeedsLocation)),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final points = await ref.read(terrainHorizonLoaderProvider)(
        site.latitude,
        site.longitude,
      );
      await ref
          .read(roofEditingServiceProvider)
          .saveTerrain(widget.projectId, points);
    } on Object {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.roofHorizonDownloadError)),
      );
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _addFar() async {
    final decl = declinationFor(ref, widget.projectId);
    if (!mounted) return;
    final r = await showFarObstacleDialog(context, declinationDeg: decl);
    if (r == null) return;
    await ref
        .read(roofEditingServiceProvider)
        .addFarObstacle(widget.projectId, r.name, r.points);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final value = ref.watch(roofLayoutProvider(widget.projectId));
    ref.watch(siteProvider(widget.projectId));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.roofHorizonTitle)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('far-add'),
        onPressed: _addFar,
        icon: const Icon(Icons.add),
        label: Text(l10n.roofFarAdd),
      ),
      body: AsyncValueView(
        value: value,
        data: (layout) {
          final combined = combinedHorizon(layout.terrain, layout.far);
          final maxTerrain = layout.terrain.isEmpty
              ? null
              : layout.terrain
                    .map((p) => p.elevation)
                    .reduce((a, b) => a > b ? a : b);
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
            children: [
              Text(l10n.roofHorizonHelp),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: HorizonChart(profile: combined, far: layout.far),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.terrain),
                  title: Text(l10n.roofTerrainTitle),
                  subtitle: Text(
                    maxTerrain == null
                        ? l10n.roofTerrainNone
                        : l10n.roofTerrainValue(
                            RoofFormat.degrees(maxTerrain, locale, decimals: 1),
                          ),
                    key: const Key('terrain-status'),
                  ),
                  trailing: _loading
                      ? const CircularProgressIndicator()
                      : IconButton(
                          key: const Key('terrain-download'),
                          tooltip: l10n.roofTerrainDownload,
                          icon: const Icon(Icons.download),
                          onPressed: _downloadTerrain,
                        ),
                ),
              ),
              if (layout.terrain.isNotEmpty)
                Text(
                  Attributions.pvgis(DateTime.now()),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              const SizedBox(height: 12),
              Text(
                l10n.roofFarTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (layout.far.isEmpty) Text(l10n.roofFarEmpty),
              for (final f in layout.far)
                ListTile(
                  leading: const Icon(Icons.park),
                  title: Text(f.name),
                  subtitle: Text(
                    l10n.roofFarItem(
                      f.points.length,
                      RoofFormat.degrees(
                        f.points
                            .map((p) => p.elevation)
                            .fold<double>(0, (a, b) => a > b ? a : b),
                        locale,
                        decimals: 1,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => ref
                        .read(horizonProfileRepositoryProvider)
                        .softDelete(f.id),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
