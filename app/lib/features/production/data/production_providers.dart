import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/features/production/domain/expected_production_source.dart';
import 'package:persistence/persistence.dart';

/// Fuente de lo esperado. Para conectar el motor de F2 basta con cambiar
/// este provider.
final expectedProductionSourceProvider = Provider<ExpectedProductionSource>(
  (ref) => const ManualExpectedSource(),
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
