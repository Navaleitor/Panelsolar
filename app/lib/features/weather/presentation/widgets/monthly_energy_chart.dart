import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Gráfica de barras de la producción mensual (12 valores).
class MonthlyEnergyChart extends StatelessWidget {
  /// Crea la gráfica.
  const new({required this.values, super.key});

  /// Energía por mes (índice 0 = enero).
  final List<double> values;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final months = DateFormat.MMM(locale);
    var maxY = 0.0;
    for (final v in values) {
      if (!v.isNaN && v > maxY) maxY = v;
    }
    return SizedBox(
      height: 220,
      child: BarChart(
        BarChartData(
          maxY: maxY * 1.15,
          gridData: const FlGridData(drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  meta: meta,
                  child: Text(
                    months
                        .format(DateTime(2026, value.toInt() + 1))
                        .substring(0, 1),
                  ),
                ),
              ),
            ),
          ),
          barGroups: [
            for (var m = 0; m < values.length; m++)
              BarChartGroupData(
                x: m,
                barRods: [
                  BarChartRodData(
                    toY: values[m].isNaN ? 0 : values[m],
                    color: color,
                    width: 14,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
