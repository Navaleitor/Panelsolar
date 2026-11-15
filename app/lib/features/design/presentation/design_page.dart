import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/features/catalog/data/catalog_providers.dart';
import 'package:panelsolar/features/design/data/design_providers.dart';
import 'package:panelsolar/features/design/data/design_service.dart';
import 'package:panelsolar/features/design/domain/design_models.dart';
import 'package:panelsolar/features/design/presentation/widgets/design_widgets.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';

/// Diseño FV del proyecto: equipos, arreglo, análisis y cada cálculo.
class DesignPage extends ConsumerWidget {
  /// Crea la pantalla.
  const new({required this.projectId, super.key});

  /// Proyecto.
  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final design = ref.watch(pvDesignProvider(projectId)).value;
    final panels = ref.watch(panelModelsProvider).value ?? const [];
    final inverters = ref.watch(inverterModelsProvider).value ?? const [];
    final panel = panels.where((p) => p.id == design?.panelModelId).firstOrNull;
    final inv = inverters
        .where((i) => i.id == design?.inverterModelId)
        .firstOrNull;
    final layouts = ref.watch(arrayLayoutsProvider(projectId)).value ?? [];
    final count = layouts.fold(
      0,
      (s, l) => s + DesignPanel.decodeList(l.panels).where((p) => p.on).length,
    );
    final analysis = ref.watch(designAnalysisProvider(projectId));
    final roof = ref.watch(roofLayoutProvider(projectId)).value;
    final result = analysis.value;

    Widget tile(String key, IconData icon, String title, String sub) => Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: ListTile(
        key: Key('design-$key'),
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(sub),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push(AppRoutes.designSection(projectId, key)),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.designTitle)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          tile(
            'equipment',
            Icons.solar_power,
            l10n.designEquipment,
            panel == null
                ? l10n.designEquipmentMissing
                : '${panel.manufacturer} ${panel.model}'
                      '${inv == null ? '' : ' · ${design!.inverterCount} × ${inv.model}'}',
          ),
          tile(
            'array',
            Icons.grid_view,
            l10n.designArray,
            l10n.designArraySummary(
              count,
              Formatters.number(
                count * (panel?.pmaxW ?? 0) / 1000,
                locale,
                decimals: 2,
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.designAnalysisTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(l10n.designAnalysisHelp),
                  const SizedBox(height: 12),
                  if (analysis.isLoading)
                    const LinearProgressIndicator()
                  else
                    FilledButton.icon(
                      key: const Key('design-analyze'),
                      onPressed: panel == null || roof == null || count == 0
                          ? null
                          : () => ref
                                .read(designServiceProvider)
                                .analyze(projectId: projectId, roof: roof),
                      icon: const Icon(Icons.play_arrow),
                      label: Text(l10n.designAnalyze),
                    ),
                  if (analysis.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        l10n.designAnalysisError,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  if (result != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      key: const Key('design-analysis-summary'),
                      l10n.designAnalysisSummary(
                        result.activePanels,
                        Formatters.number(result.temperatures.min, locale),
                        Formatters.number(result.temperatures.max, locale),
                        result.production == null
                            ? '—'
                            : Formatters.number(
                                result.production!.firstYearKwh,
                                locale,
                              ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          tile('shade', Icons.wb_shade, l10n.designShade, l10n.designShadeSub),
          tile(
            'strings',
            Icons.electrical_services,
            l10n.designStrings,
            l10n.designStringsSub,
          ),
          tile(
            'production',
            Icons.bar_chart,
            l10n.designProduction,
            l10n.designProductionSub,
          ),
          tile(
            'electrical',
            Icons.cable,
            l10n.designElectrical,
            l10n.designElectricalSub,
          ),
          tile('wind', Icons.air, l10n.designWind, l10n.designWindSub),
          const DesignDisclaimer(),
        ],
      ),
    );
  }
}
