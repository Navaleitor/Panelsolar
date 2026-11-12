import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/weather/data/weather_providers.dart';
import 'package:panelsolar/features/weather/presentation/widgets/weather_results_view.dart';

/// Pantalla mínima de F2: dada una latitud/longitud de prueba descarga el
/// clima y muestra producción, orientación óptima y carta solar.
class WeatherPage extends ConsumerStatefulWidget {
  /// Crea la pantalla.
  const new({super.key});

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  // Coordenada de prueba: Monterrey (centro).
  final _lat = TextEditingController(text: '25.6866');
  final _lon = TextEditingController(text: '-100.3161');
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _lat.dispose();
    _lon.dispose();
    super.dispose();
  }

  String? _validate(String? v, double limit, AppLocalizations l10n) {
    final x = double.tryParse((v ?? '').replaceAll(',', '.'));
    return (x == null || x.abs() > limit)
        ? l10n.weatherInvalidCoordinate
        : null;
  }

  void _run({bool refresh = false}) {
    if (!(_form.currentState?.validate() ?? false)) return;
    double parse(TextEditingController c) =>
        double.parse(c.text.replaceAll(',', '.'));
    unawaited(
      ref
          .read(weatherAnalysisProvider.notifier)
          .analyze(parse(_lat), parse(_lon), forceRefresh: refresh),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(weatherAnalysisProvider);
    final busy = state.isLoading;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.weatherTitle)),
      body: ListView(
        key: const Key('weatherList'),
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.weatherIntro),
          const SizedBox(height: 12),
          Form(
            key: _form,
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: TextFormField(
                    key: const Key('weatherLat'),
                    controller: _lat,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.weatherLatitude,
                    ),
                    validator: (v) => _validate(v, 90, l10n),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    key: const Key('weatherLon'),
                    controller: _lon,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.weatherLongitude,
                    ),
                    validator: (v) => _validate(v, 180, l10n),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            key: const Key('weatherAnalyze'),
            onPressed: busy ? null : _run,
            icon: const Icon(Icons.wb_sunny),
            label: Text(l10n.weatherAnalyze),
          ),
          if (state.hasValue && state.value != null)
            TextButton(
              onPressed: busy ? null : () => _run(refresh: true),
              child: Text(l10n.weatherRefresh),
            ),
          const SizedBox(height: 12),
          switch (state) {
            AsyncLoading() => Column(
              children: [
                const LinearProgressIndicator(),
                const SizedBox(height: 8),
                Text(l10n.weatherLoading),
              ],
            ),
            AsyncError(:final error) => Text(
              l10n.weatherError(
                error is Exception ? error.toString() : '$error',
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            AsyncData(:final value) when value != null => WeatherResultsView(
              analysis: value,
            ),
            _ => const SizedBox.shrink(),
          },
        ],
      ),
    );
  }
}
