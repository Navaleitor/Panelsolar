import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/weather/data/weather_providers.dart';
import 'package:panelsolar/features/weather/presentation/widgets/weather_results_view.dart';

/// Coordenadas, botón de cálculo y resultados.
///
/// Si [fromProject] es verdadero las coordenadas vienen de la ubicación
/// guardada del proyecto y no se editan aquí.
class WeatherForm extends ConsumerStatefulWidget {
  /// Crea el formulario.
  const new({
    required this.cacheId,
    required this.initialLatitude,
    required this.initialLongitude,
    this.elevation,
    this.fromProject = false,
    super.key,
  });

  /// Carpeta de caché (id del proyecto o "sin proyecto").
  final String cacheId;

  /// Latitud inicial (grados).
  final double initialLatitude;

  /// Longitud inicial (grados).
  final double initialLongitude;

  /// Altitud conocida (m), si la hay.
  final double? elevation;

  /// Verdadero si las coordenadas son las del proyecto.
  final bool fromProject;

  @override
  ConsumerState<WeatherForm> createState() => _WeatherFormState();
}

class _WeatherFormState extends ConsumerState<WeatherForm> {
  late final _lat = TextEditingController(
    text: widget.initialLatitude.toString(),
  );
  late final _lon = TextEditingController(
    text: widget.initialLongitude.toString(),
  );
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _lat.dispose();
    _lon.dispose();
    super.dispose();
  }

  double? _parse(String? v) => double.tryParse((v ?? '').replaceAll(',', '.'));

  String? _validate(String? v, double limit, AppLocalizations l10n) {
    final x = _parse(v);
    return (x == null || x.abs() > limit)
        ? l10n.weatherInvalidCoordinate
        : null;
  }

  void _run({bool refresh = false}) {
    if (!(_form.currentState?.validate() ?? false)) return;
    unawaited(
      ref
          .read(weatherAnalysisProvider.notifier)
          .analyze(
            projectId: widget.cacheId,
            latitude: _parse(_lat.text)!,
            longitude: _parse(_lon.text)!,
            elevation: widget.elevation,
            forceRefresh: refresh,
          ),
    );
  }

  Widget _field(
    String key,
    TextEditingController c,
    String label,
    double limit,
    AppLocalizations l10n,
  ) => Expanded(
    child: TextFormField(
      key: Key(key),
      controller: c,
      readOnly: widget.fromProject,
      keyboardType: const TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      decoration: InputDecoration(labelText: label),
      validator: (v) => _validate(v, limit, l10n),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(weatherAnalysisProvider);
    final busy = state.isLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.weatherIntro),
        const SizedBox(height: 12),
        if (widget.fromProject) Text(l10n.weatherProjectLocation),
        Form(
          key: _form,
          child: Row(
            spacing: 12,
            children: [
              _field('weatherLat', _lat, l10n.weatherLatitude, 90, l10n),
              _field('weatherLon', _lon, l10n.weatherLongitude, 180, l10n),
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
            l10n.weatherError(_message(error)),
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          AsyncData(:final value) when value != null => WeatherResultsView(
            analysis: value,
          ),
          _ => const SizedBox.shrink(),
        },
      ],
    );
  }

  static String _message(Object error) {
    final text = error.toString();
    final i = text.indexOf(': ');
    return error is Exception && i >= 0 ? text.substring(i + 2) : text;
  }
}
