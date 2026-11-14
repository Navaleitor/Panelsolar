import 'package:geo_kit/geo_kit.dart';

/// Sensores del teléfono que usa el módulo Techo (inclinómetro y
/// brújula). La app real usa `sensors_plus`; las pruebas, uno falso.
abstract interface class PhoneSensors {
  /// Acelerómetro (m/s², con gravedad) en el sistema del teléfono.
  Stream<Vec3> accelerometer();

  /// Magnetómetro (µT) en el sistema del teléfono.
  Stream<Vec3> magnetometer();
}
