import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/weather/domain/weather_analysis.dart';
import 'package:panelsolar/features/weather/presentation/widgets/monthly_energy_chart.dart';
import 'package:panelsolar/features/weather/presentation/widgets/sun_path_chart.dart';

/// Tarjetas con el resultado del análisis de clima.
class WeatherResultsView extends StatelessWidget {
  /// Crea la vista.
  const new({required this.analysis, super.key});

  /// Resultado a mostrar.
  final WeatherAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final a = analysis;
    final diff = (a.latitudeTiltEnergy - a.annualEnergy) / a.annualEnergy * 100;
    final design = a.statistics.design;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.weatherSource(a.sourceLabel)),
        _Section(
          title: l10n.weatherAnnualTitle,
          children: [
            Text(
              l10n.weatherAnnualValue(a.annualEnergy.toStringAsFixed(0)),
              key: const Key('weatherAnnual'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              l10n.weatherPerformanceRatio(
                a.performanceRatio.toStringAsFixed(2),
              ),
            ),
          ],
        ),
        _Section(
          title: l10n.weatherMonthlyTitle,
          children: [MonthlyEnergyChart(values: a.monthlyEnergy)],
        ),
        _Section(
          title: l10n.weatherOptimalTitle,
          children: [
            Text(
              l10n.weatherOptimalValue(
                a.optimalTilt.toStringAsFixed(0),
                a.optimalAzimuth.toStringAsFixed(0),
              ),
              key: const Key('weatherOptimal'),
            ),
            Text(
              l10n.weatherLatitudeRule(
                a.latitudeTiltEnergy.toStringAsFixed(0),
                diff.toStringAsFixed(1),
              ),
            ),
          ],
        ),
        _Section(
          title: l10n.weatherTemperaturesTitle,
          children: [
            Text(
              l10n.weatherTemperaturesValue(
                design.recordMin.toStringAsFixed(1),
                design.recordMax.toStringAsFixed(1),
              ),
            ),
          ],
        ),
        _Section(
          title: l10n.weatherSunPathTitle,
          children: [
            Text(l10n.weatherSunPathAxis),
            SunPathChart(paths: a.sunPath),
          ],
        ),
        if (a.warnings.isNotEmpty)
          _Section(
            title: l10n.weatherWarningsTitle,
            children: [for (final w in a.warnings) Text('• $w')],
          ),
        _Section(
          title: l10n.weatherAttributionsTitle,
          children: [
            for (final t in a.attributions)
              Text(t, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const new({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(top: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          ...children,
        ],
      ),
    ),
  );
}
