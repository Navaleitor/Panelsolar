import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/features/weather/data/weather_job.dart';
import 'package:panelsolar/features/weather/domain/weather_analysis.dart';
import 'package:path_provider/path_provider.dart';

/// Carpeta de la caché de clima en el teléfono.
final weatherCacheDirProvider = FutureProvider<String>(
  (ref) async => '${(await getApplicationSupportDirectory()).path}/weather',
);

/// Ejecuta un [WeatherJob]. Por defecto en un isolate; las pruebas lo
/// sustituyen.
final weatherRunnerProvider =
    Provider<Future<WeatherAnalysis> Function(WeatherJob, String)>(
      (ref) =>
          (job, cacheDir) => Isolate.run(() => runWeatherJob(job, cacheDir)),
    );

/// Estado de la pantalla: nulo = sin consultar todavía.
final weatherAnalysisProvider =
    AsyncNotifierProvider<WeatherAnalysisController, WeatherAnalysis?>(
      WeatherAnalysisController.new,
    );

/// Descarga el clima de una coordenada y lo analiza.
class WeatherAnalysisController extends AsyncNotifier<WeatherAnalysis?> {
  @override
  Future<WeatherAnalysis?> build() async => null;

  /// Ejecuta el análisis para [latitude], [longitude].
  Future<void> analyze(
    double latitude,
    double longitude, {
    bool forceRefresh = false,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final dir = await ref.read(weatherCacheDirProvider.future);
      return await ref.read(weatherRunnerProvider)((
        latitude: latitude,
        longitude: longitude,
        forceRefresh: forceRefresh,
      ), dir);
    });
  }
}
