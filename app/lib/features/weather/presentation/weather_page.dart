import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/site/presentation/site_providers.dart';
import 'package:panelsolar/features/weather/data/weather_job.dart';
import 'package:panelsolar/features/weather/presentation/widgets/weather_form.dart';

/// Coordenada de prueba cuando no hay proyecto: centro de Monterrey.
const double _demoLatitude = 25.6866;
const double _demoLongitude = -100.3161;

/// Clima y producción de un sitio.
///
/// - Con [projectId]: usa la ubicación guardada del proyecto; si el proyecto
///   no tiene ubicación, permite escribir las coordenadas.
/// - Sin proyecto (desde Ajustes): coordenadas a mano.
class WeatherPage extends ConsumerWidget {
  /// Crea la pantalla.
  const new({this.projectId, super.key});

  /// Proyecto cuyo sitio se analiza (opcional).
  final String? projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final id = projectId;
    Widget body;
    if (id == null) {
      body = const WeatherForm(
        cacheId: weatherManualCacheId,
        initialLatitude: _demoLatitude,
        initialLongitude: _demoLongitude,
      );
    } else {
      final site = ref.watch(siteProvider(id));
      body = switch (site) {
        AsyncData(:final value) when value != null => WeatherForm(
          key: ValueKey(value.updatedAt),
          cacheId: id,
          initialLatitude: value.latitude,
          initialLongitude: value.longitude,
          elevation: value.altitudeM,
          timeZone: value.timeZone,
          fromProject: true,
        ),
        AsyncData() || AsyncError() => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_off),
                title: Text(l10n.weatherNoProjectLocation),
              ),
            ),
            const SizedBox(height: 12),
            WeatherForm(
              cacheId: id,
              initialLatitude: _demoLatitude,
              initialLongitude: _demoLongitude,
            ),
          ],
        ),
        _ => const Center(child: CircularProgressIndicator()),
      };
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.weatherTitle)),
      body: ListView(
        key: const Key('weatherList'),
        padding: const EdgeInsets.all(16),
        children: [body],
      ),
    );
  }
}
