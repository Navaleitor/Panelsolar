import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/phone_sensors.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Sensores reales del teléfono con `sensors_plus` (BSD-3).
class SensorsPlusPhoneSensors implements PhoneSensors {
  /// Crea el adaptador.
  const new();

  @override
  Stream<Vec3> accelerometer() =>
      accelerometerEventStream(samplingPeriod: SensorInterval.uiInterval)
          .map((e) => (x: e.x, y: e.y, z: e.z));

  @override
  Stream<Vec3> magnetometer() =>
      magnetometerEventStream(samplingPeriod: SensorInterval.uiInterval)
          .map((e) => (x: e.x, y: e.y, z: e.z));
}
