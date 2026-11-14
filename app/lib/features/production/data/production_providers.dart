import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/features/production/data/engine_expected_source.dart';
import 'package:panelsolar/features/production/domain/expected_production_source.dart';
import 'package:panelsolar/features/weather/data/weather_providers.dart';
import 'package:persistence/persistence.dart';

/// Fuente de lo esperado: el motor de F2 (energía típica del mes × kWp).
/// Para volver a solo captura manual, usar `ManualExpectedSource`.
final expectedProductionSourceProvider = Provider<ExpectedProductionSource>(
  (ref) => EngineExpectedSource(
    sites: ref.watch(siteRepositoryProvider),
    production: ref.watch(productionRepositoryProvider),
    analyze: (job) async {
      final dir = await ref.read(weatherCacheDirProvider.future);
      final analysis = await ref.read(weatherRunnerProvider)(job, dir);
      return analysis.monthlyEnergy;
    },
  ),
);

/// Lecturas del proyecto (orden cronológico).
final StreamProviderFamily<List<ProductionReading>, String> readingsProvider =
    StreamProvider.autoDispose.family<List<ProductionReading>, String>(
      (ref, projectId) =>
          ref.watch(productionRepositoryProvider).watchReadings(projectId),
    );

/// Ajustes de producción del proyecto (o `null`).
final StreamProviderFamily<ProductionSetting?, String>
productionSettingsProvider = StreamProvider.autoDispose
    .family<ProductionSetting?, String>(
      (ref, projectId) =>
          ref.watch(productionRepositoryProvider).watchSettings(projectId),
    );
