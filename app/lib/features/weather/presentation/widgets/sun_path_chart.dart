import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:solar_engine/solar_engine.dart';

/// Carta solar: azimut (eje X, 0–360°) contra altura solar (eje Y) para los
/// solsticios y los equinoccios (los dos equinoccios casi coinciden).
class SunPathChart extends StatelessWidget {
  /// Crea la gráfica.
  const new({required this.paths, super.key});

  /// Trayectorias por día característico.
  final Map<SunPathDay, List<SunPathPoint>> paths;

  /// Colores fijos por día (alto contraste).
  static const Map<SunPathDay, Color> colors = {
    SunPathDay.juneSolstice: Color(0xFFD84315),
    SunPathDay.marchEquinox: Color(0xFF2E7D32),
    SunPathDay.septemberEquinox: Color(0xFF2E7D32),
    SunPathDay.decemberSolstice: Color(0xFF1565C0),
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final legend = {
      l10n.weatherJuneSolstice: colors[SunPathDay.juneSolstice]!,
      l10n.weatherEquinox: colors[SunPathDay.marchEquinox]!,
      l10n.weatherDecemberSolstice: colors[SunPathDay.decemberSolstice]!,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 240,
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: 360,
              minY: 0,
              maxY: 90,
              borderData: FlBorderData(show: true),
              titlesData: const FlTitlesData(
                topTitles: AxisTitles(),
                rightTitles: AxisTitles(),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 30,
                    reservedSize: 32,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, interval: 90),
                ),
              ),
              lineBarsData: [
                for (final e in paths.entries)
                  LineChartBarData(
                    spots: [
                      for (final p in e.value) FlSpot(p.azimuth, p.elevation),
                    ],
                    color: colors[e.key],
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: [
            for (final e in legend.entries)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 16, height: 4, color: e.value),
                  const SizedBox(width: 6),
                  Text(e.key),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
