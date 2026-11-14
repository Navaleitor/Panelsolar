import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/production/data/production_providers.dart';
import 'package:panelsolar/features/production/domain/performance.dart';
import 'package:panelsolar/features/production/presentation/widgets/production_chart.dart';
import 'package:panelsolar/features/production/presentation/widgets/production_settings_dialog.dart';
import 'package:panelsolar/features/production/presentation/widgets/reading_dialog.dart';
import 'package:persistence/persistence.dart';

/// Seguimiento de producción: lecturas mensuales del inversor, gráfica
/// real contra esperado, Performance Ratio y alertas.
class ProductionPage extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  Future<void> _addOrEdit(
    BuildContext context,
    WidgetRef ref, {
    ProductionReading? initial,
    DateTime? suggested,
  }) async {
    final r = await showReadingDialog(
      context,
      initial: initial,
      suggestedMonth: suggested,
    );
    if (r == null) return;
    var expected = r.expectedKwh;
    var poa = r.poaKwhM2;
    if (expected == null) {
      final auto = await ref
          .read(expectedProductionSourceProvider)
          .expectedFor(projectId, r.month);
      expected = auto?.expectedKwh;
      poa ??= auto?.poaKwhM2;
    }
    if (initial != null && initial.month != r.month) {
      await ref
          .read(productionRepositoryProvider)
          .softDeleteReading(initial.id);
    }
    await ref
        .read(productionRepositoryProvider)
        .saveReading(
          projectId: projectId,
          month: r.month,
          actualKwh: r.actualKwh,
          expectedKwh: expected,
          poaIrradiationKwhM2: poa,
          notes: r.notes,
        );
  }

  Future<void> _settings(
    BuildContext context,
    WidgetRef ref,
    ProductionSetting? s,
  ) async {
    final r = await showProductionSettingsDialog(
      context,
      systemKwp: s?.systemKwp,
      thresholdPct: s?.alertThresholdPct ?? defaultAlertThresholdPct,
    );
    if (r == null) return;
    await ref
        .read(productionRepositoryProvider)
        .saveSettings(
          projectId,
          systemKwp: r.systemKwp,
          alertThresholdPct: r.thresholdPct,
        );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    ProductionReading r,
  ) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.readingDeleteTitle,
      message: Formatters.monthYear(r.month, formatLocale(context)),
    );
    if (ok) {
      await ref.read(productionRepositoryProvider).softDeleteReading(r.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final readings = ref.watch(readingsProvider(projectId)).value ?? const [];
    final settings = ref.watch(productionSettingsProvider(projectId)).value;
    final threshold = settings?.alertThresholdPct ?? defaultAlertThresholdPct;
    final summary = ProductionSummary.of(readings, thresholdPct: threshold);
    String kwh(double v) => '${Formatters.number(v, locale)} kWh';
    final next = readings.isEmpty ? null : addMonthsUtc(readings.last.month, 1);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.productionTitle),
        actions: [
          IconButton(
            key: const Key('production-settings'),
            tooltip: l10n.productionSettings,
            icon: const Icon(Icons.tune),
            onPressed: () => _settings(context, ref, settings),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('reading-add'),
        onPressed: () => _addOrEdit(context, ref, suggested: next),
        icon: const Icon(Icons.add),
        label: Text(l10n.readingAdd),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 96),
        children: [
          if (summary.alerts.isNotEmpty)
            Card(
              key: const Key('production-alert'),
              color: Theme.of(context).colorScheme.errorContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListTile(
                leading: const Icon(Icons.warning),
                title: Text(l10n.productionAlertTitle(summary.alerts.length)),
                subtitle: Text(
                  l10n.productionAlertBody(
                    Formatters.number(threshold.abs(), locale),
                  ),
                ),
              ),
            ),
          if (readings.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l10n.productionEmpty),
            )
          else ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: ProductionChart(
                readings: readings,
                thresholdPct: threshold,
              ),
            ),
            ListTile(
              title: Text(l10n.productionLast12),
              subtitle: Text(
                [
                  '${l10n.productionActual}: ${kwh(summary.actualKwh)}',
                  if (summary.expectedKwh != null)
                    '${l10n.productionExpected}: ${kwh(summary.expectedKwh!)}',
                ].join(' · '),
              ),
            ),
          ],
          SectionHeader(title: l10n.readingsTitle),
          for (final r in readings.reversed)
            _ReadingTile(
              reading: r,
              systemKwp: settings?.systemKwp,
              threshold: threshold,
              onTap: () => _addOrEdit(context, ref, initial: r),
              onDelete: () => _delete(context, ref, r),
            ),
        ],
      ),
    );
  }
}

class _ReadingTile extends StatelessWidget {
  const new({
    required this.reading,
    required this.systemKwp,
    required this.threshold,
    required this.onTap,
    required this.onDelete,
  });

  final ProductionReading reading;
  final double? systemKwp;
  final double threshold;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final r = reading;
    final dev = deviationFromExpectedPct(r.actualKwh, r.expectedKwh);
    final pr = performanceRatio(r.actualKwh, systemKwp, r.poaIrradiationKwhM2);
    final alert = isBelowThreshold(r.actualKwh, r.expectedKwh, threshold);
    return ListTile(
      leading: Icon(
        alert ? Icons.trending_down : Icons.bolt,
        color: alert ? Theme.of(context).colorScheme.error : null,
      ),
      title: Text(
        '${Formatters.monthYear(r.month, locale)} · '
        '${Formatters.number(r.actualKwh, locale)} kWh',
      ),
      subtitle: Text(
        [
          if (r.expectedKwh != null)
            l10n.readingVsExpected(
              Formatters.number(r.expectedKwh!, locale),
              Formatters.signed(dev!, locale),
            ),
          if (pr != null) 'PR ${Formatters.number(pr * 100, locale)} %',
        ].join(' · '),
      ),
      onTap: onTap,
      trailing: IconButton(
        tooltip: l10n.actionDelete,
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
