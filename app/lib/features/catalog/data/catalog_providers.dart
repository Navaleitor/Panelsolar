import 'dart:io';
import 'dart:isolate';

import 'package:data_sources/data_sources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistence/persistence.dart';

/// Paneles del catálogo.
final StreamProvider<List<PanelModel>> panelModelsProvider =
    StreamProvider.autoDispose<List<PanelModel>>(
      (ref) => ref.watch(panelModelRepositoryProvider).watchAll(),
    );

/// Inversores del catálogo.
final StreamProvider<List<InverterModel>> inverterModelsProvider =
    StreamProvider.autoDispose<List<InverterModel>>(
      (ref) => ref.watch(inverterModelRepositoryProvider).watchAll(),
    );

/// Optimizadores del catálogo.
final StreamProvider<List<OptimizerModel>> optimizerModelsProvider =
    StreamProvider.autoDispose<List<OptimizerModel>>(
      (ref) => ref.watch(optimizerModelRepositoryProvider).watchAll(),
    );

/// Baterías del catálogo.
final StreamProvider<List<BatteryModel>> batteryModelsProvider =
    StreamProvider.autoDispose<List<BatteryModel>>(
      (ref) => ref.watch(batteryModelRepositoryProvider).watchAll(),
    );

/// Carga el catálogo CEC (descarga una vez, ≈ 6 MB; luego sin conexión).
/// Corre en un isolate; las pruebas lo sustituyen.
final cecCatalogLoaderProvider = Provider<Future<CecCatalog> Function()>(
  (ref) => () async {
    final dir = '${(await getApplicationSupportDirectory()).path}/cec';
    return await Isolate.run(() async {
      final client = http.Client();
      try {
        return await CecCatalogClient(
          client: client,
          cacheDir: Directory(dir),
        ).load();
      } finally {
        client.close();
      }
    });
  },
);

/// Catálogo CEC en memoria mientras la pantalla está abierta.
final FutureProvider<CecCatalog> cecCatalogProvider =
    FutureProvider.autoDispose<CecCatalog>(
      (ref) => ref.watch(cecCatalogLoaderProvider)(),
    );
