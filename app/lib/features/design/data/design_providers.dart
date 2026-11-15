import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/features/design/domain/design_inputs.dart';
import 'package:panelsolar/features/design/domain/design_job.dart';
import 'package:persistence/persistence.dart';

/// Diseño del proyecto (nulo si aún no hay).
final StreamProviderFamily<PvDesign?, String> pvDesignProvider = StreamProvider
    .autoDispose
    .family<PvDesign?, String>(
      (ref, id) => ref.watch(pvDesignRepositoryProvider).watchForProject(id),
    );

/// Arreglos (paneles por plano) del proyecto.
final StreamProviderFamily<List<ArrayLayout>, String> arrayLayoutsProvider =
    StreamProvider.autoDispose.family<List<ArrayLayout>, String>(
      (ref, id) => ref.watch(arrayLayoutRepositoryProvider).watchByProject(id),
    );

/// Grupos de strings del proyecto.
final StreamProviderFamily<List<StringConfig>, String> stringConfigsProvider =
    StreamProvider.autoDispose.family<List<StringConfig>, String>(
      (ref, id) => ref.watch(stringConfigRepositoryProvider).watchByProject(id),
    );

/// Tramos de cableado del proyecto.
final StreamProviderFamily<List<ElectricalRun>, String> electricalRunsProvider =
    StreamProvider.autoDispose.family<List<ElectricalRun>, String>(
      (ref, id) =>
          ref.watch(electricalRunRepositoryProvider).watchByProject(id),
    );

/// Último resultado guardado de la simulación.
final StreamProviderFamily<SimulationResultRecord?, String>
latestSimulationProvider = StreamProvider.autoDispose
    .family<SimulationResultRecord?, String>(
      (ref, id) =>
          ref.watch(simulationResultRepositoryProvider).watchLatest(id),
    );

/// Ejecuta el análisis (en un isolate; las pruebas lo sustituyen).
final designRunnerProvider =
    Provider<Future<DesignJobResult> Function(DesignJobInput, String)>(
      (ref) =>
          (job, cacheDir) => Isolate.run(() => runDesignJob(job, cacheDir)),
    );

/// Último análisis de cada proyecto, en memoria mientras la app esté
/// abierta (temperaturas, sombra por panel y producción).
final NotifierProviderFamily<
  DesignAnalysisNotifier,
  AsyncValue<DesignJobResult?>,
  String
>
designAnalysisProvider =
    NotifierProvider.family<
      DesignAnalysisNotifier,
      AsyncValue<DesignJobResult?>,
      String
    >(DesignAnalysisNotifier.new);

/// Guarda el estado del análisis.
class DesignAnalysisNotifier extends Notifier<AsyncValue<DesignJobResult?>> {
  /// Crea el notificador del proyecto [projectId].
  new(this.projectId);

  /// Proyecto.
  final String projectId;

  @override
  AsyncValue<DesignJobResult?> build() => const AsyncData(null);

  /// Cambia el estado (lo usa `DesignService`).
  set result(AsyncValue<DesignJobResult?> value) => state = value;

  /// Estado actual.
  AsyncValue<DesignJobResult?> get result => state;
}
