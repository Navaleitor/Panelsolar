import 'package:flutter/material.dart';
import 'package:geo_kit/geo_kit.dart';
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
    final design = a.designTemperatures;
    String t(double v) => v.isNaN ? '—' : v.toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.weatherSource(a.sourceLabel)),
        if (a.timeZone != null && a.utcOffsetHours != null)
          Text(
            l10n.weatherTimeZone(a.timeZone!, _offsetLabel(a.utcOffsetHours!)),
          ),
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
              l10n.weatherDesignMin(t(design.min), design.minSource ?? '—'),
              key: const Key('weatherDesignMin'),
            ),
            Text(
              l10n.weatherDesignMax(t(design.max), design.maxSource ?? '—'),
              key: const Key('weatherDesignMax'),
            ),
            Text(l10n.weatherDesignHint),
            for (final e in design.bySource.entries)
              Text(
                l10n.weatherTemperaturesBySource(
                  e.key,
                  t(e.value.recordMin),
                  t(e.value.recordMax),
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
            for (final t in [
              ...a.attributions,
              if (a.timeZone != null) TimeZoneLocator.attribution,
            ])
              Text(t, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

/// "UTC−7", "UTC+5:30".
String _offsetLabel(double hours) {
  final sign = hours < 0 ? '−' : '+';
  final abs = hours.abs();
  final h = abs.floor();
  final m = ((abs - h) * 60).round();
  return m == 0 ? 'UTC$sign$h' : 'UTC$sign$h:${m.toString().padLeft(2, '0')}';
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
