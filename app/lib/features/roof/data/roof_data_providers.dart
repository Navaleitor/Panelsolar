import 'dart:isolate';

import 'package:data_sources/data_sources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/features/roof/data/roof_editing_service.dart';
import 'package:panelsolar/features/roof/data/roof_image_importer.dart';
import 'package:panelsolar/features/roof/data/sensors_plus_phone_sensors.dart';
import 'package:panelsolar/features/roof/domain/phone_sensors.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/domain/shade_job.dart';

/// Importador de la imagen del techo.
final roofImageImporterProvider = Provider<RoofImageImporter>(
  (ref) => RoofImageImporter(
    storage: ref.watch(appStorageProvider),
    repository: ref.watch(roofImageRepositoryProvider),
  ),
);

/// Operaciones de edición del techo.
final roofEditingServiceProvider = Provider<RoofEditingService>(
  (ref) => RoofEditingService(
    images: ref.watch(roofImageRepositoryProvider),
    planes: ref.watch(roofPlaneRepositoryProvider),
    obstacles: ref.watch(obstacleRepositoryProvider),
    horizons: ref.watch(horizonProfileRepositoryProvider),
  ),
);

/// Sensores del teléfono (las pruebas usan unos falsos).
final phoneSensorsProvider = Provider<PhoneSensors>(
  (ref) => const SensorsPlusPhoneSensors(),
);

/// Descarga el horizonte del terreno de PVGIS (datos numéricos abiertos,
/// no imágenes: ADR-005).
final terrainHorizonLoaderProvider =
    Provider<Future<List<HorizonPoint>> Function(double lat, double lon)>(
      (ref) => (lat, lon) async {
        final client = http.Client();
        try {
          final h = await PvgisClient(client: client)
              .fetchHorizon(latitude: lat, longitude: lon);
          return h.points;
        } finally {
          client.close();
        }
      },
    );

/// Ejecuta el mapa de calor (en un isolate; las pruebas lo sustituyen).
final shadeRunnerProvider =
    Provider<
      Future<List<PlaneShade>> Function({
        required ShadeSite site,
        required List<RoofPlaneModel> planes,
        required List<ObstacleModel> obstacles,
        required List<HorizonPoint> terrain,
        required List<FarObstacle> far,
      })
    >(
      (ref) =>
          ({
            required site,
            required planes,
            required obstacles,
            required terrain,
            required far,
          }) => Isolate.run(
            () => computeShadeMaps(
              site: site,
              planes: planes,
              obstacles: obstacles,
              terrain: terrain,
              far: far,
            ),
          ),
    );
