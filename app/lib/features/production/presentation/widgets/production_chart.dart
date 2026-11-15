import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/production/domain/performance.dart';
import 'package:persistence/persistence.dart';

/// Barras por mes: real (color principal; rojo si quedó bajo el umbral)
/// junto a esperado (gris claro). Últimos 12 meses con lectura.
class ProductionChart extends StatelessWidget {
  const new({required this.readings, required this.thresholdPct, super.key});

  /// Lecturas en orden cronológico.
  final List<ProductionReading> readings;
  final double thresholdPct;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final locale = formatLocale(context);
    final shown = readings.length > 12
        ? readings.sublist(readings.length - 12)
        : readings;
    final maxY = shown.fold<double>(0, (m, r) {
      final e = r.expectedKwh ?? 0;
      final top = r.actualKwh > e ? r.actualKwh : e;
      return top > m ? top : m;
    });
    BarChartRodData rod(double y, Color color) => BarChartRodData(
      toY: y,
      color: color,
      width: 8,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
    );
    return Column(
      children: [
        Semantics(
          label: 'kWh',
          child: SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                maxY: maxY == 0 ? 1 : maxY * 1.15,
                alignment: BarChartAlignment.spaceAround,
                gridData: const FlGridData(drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= shown.length) return const SizedBox();
                        return SideTitleWidget(
                          meta: meta,
                          child: Text(
                            Formatters.monthYear(shown[i].month, locale),
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < shown.length; i++)
                    BarChartGroupData(
                      x: i,
                      barsSpace: 2,
                      barRods: [
                        rod(
                          shown[i].actualKwh,
                          isBelowThreshold(
                                shown[i].actualKwh,
                                shown[i].expectedKwh,
                                thresholdPct,
                              )
                              ? scheme.error
                              : scheme.primary,
                        ),
                        rod(shown[i].expectedKwh ?? 0, scheme.outlineVariant),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        Wrap(
          spacing: 16,
          children: [
            _Legend(color: scheme.primary, label: l10n.productionActual),
            _Legend(
              color: scheme.outlineVariant,
              label: l10n.productionExpected,
            ),
            _Legend(color: scheme.error, label: l10n.productionBelow),
          ],
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const new({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 12, height: 12, color: color),
      const SizedBox(width: 4),
      Text(label, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}
