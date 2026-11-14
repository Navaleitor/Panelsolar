import 'dart:async';

import 'package:flutter_riverpod/misc.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/domain/phone_sensors.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/domain/shade_job.dart';

/// Sensores falsos: emiten lo que la prueba ponga en [accel] y [mag].
class FakePhoneSensors implements PhoneSensors {
  /// Acelerómetro que se emite al escuchar.
  Vec3 accel = (x: 0, y: 0, z: 9.81);

  /// Magnetómetro que se emite al escuchar.
  Vec3 mag = (x: 0, y: 25, z: -35);

  @override
  Stream<Vec3> accelerometer() => Stream.value(accel);

  @override
  Stream<Vec3> magnetometer() => Stream.value(mag);
}

/// Dependencias falsas del módulo Techo (sin red ni isolates).
class RoofFakes {
  /// Sensores.
  final sensors = FakePhoneSensors();

  /// Horizonte del terreno que "descarga" PVGIS.
  List<HorizonPoint> terrain = const [
    (azimuth: 0, elevation: 2),
    (azimuth: 90, elevation: 4),
    (azimuth: 180, elevation: 6),
    (azimuth: 270, elevation: 3),
  ];

  /// Descargas pedidas.
  int terrainCalls = 0;

  /// Sustituciones de providers.
  List<Override> get overrides => [
    phoneSensorsProvider.overrideWithValue(sensors),
    terrainHorizonLoaderProvider.overrideWithValue((lat, lon) async {
      terrainCalls++;
      return terrain;
    }),
    shadeRunnerProvider.overrideWithValue(
      ({
        required site,
        required planes,
        required obstacles,
        required terrain,
        required far,
      }) async => computeShadeMaps(
        site: site,
        planes: planes,
        obstacles: obstacles,
        terrain: terrain,
        far: far,
        dayStep: 30,
        minuteStep: 120,
      ),
    ),
  ];
}
