import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:persistence/persistence.dart';

/// Gráfica de barras: kWh de cada recibo (eje X = mes en que termina el
/// periodo) con una línea punteada en el promedio por recibo.
class ConsumptionChart extends StatelessWidget {
  const new({required this.bills, super.key});

  /// Recibos en orden cronológico. Se muestran los últimos 12.
  final List<UtilityBill> bills;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final locale = formatLocale(context);
    final shown = bills.length > 12 ? bills.sublist(bills.length - 12) : bills;
    final values = [for (final b in shown) b.energyKwh];
    final maxY = values.fold<double>(0, (a, b) => a > b ? a : b);
    final average = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a + b) / values.length;
    return Semantics(
      label: 'kWh',
      child: SizedBox(
        height: 220,
        child: BarChart(
          BarChartData(
            maxY: maxY == 0 ? 1 : maxY * 1.15,
            alignment: BarChartAlignment.spaceAround,
            gridData: const FlGridData(drawVerticalLine: false),
            borderData: FlBorderData(show: false),
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                HorizontalLine(
                  y: average,
                  color: scheme.tertiary,
                  dashArray: [6, 4],
                ),
              ],
            ),
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
                        Formatters.monthYear(shown[i].periodEnd, locale),
                        style: const TextStyle(fontSize: 11),
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
                  barRods: [
                    BarChartRodData(
                      toY: shown[i].energyKwh,
                      color: scheme.primary,
                      width: 16,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
