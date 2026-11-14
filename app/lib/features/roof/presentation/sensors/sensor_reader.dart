import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/features/roof/domain/phone_sensors.dart';

/// Última lectura (suavizada) del acelerómetro y del magnetómetro.
class SensorReader extends ChangeNotifier {
  /// Empieza a escuchar [sensors]. Con [magnetic] = false no usa la
  /// brújula (inclinómetro).
  new(PhoneSensors sensors, {bool magnetic = true}) {
    _subs.add(
      sensors.accelerometer().listen(
        (v) {
          accel = _smooth(accel, v);
          notifyListeners();
        },
        onError: (Object _) {
          failed = true;
          notifyListeners();
        },
      ),
    );
    if (magnetic) {
      _subs.add(
        sensors.magnetometer().listen(
          (v) {
            mag = _smooth(mag, v);
            notifyListeners();
          },
          onError: (Object _) {
            failed = true;
            notifyListeners();
          },
        ),
      );
    }
  }

  final _subs = <StreamSubscription<Vec3>>[];

  /// Acelerómetro (null hasta la primera lectura).
  Vec3? accel;

  /// Magnetómetro (null hasta la primera lectura).
  Vec3? mag;

  /// `true` si el teléfono no tiene el sensor o falló.
  bool failed = false;

  /// Filtro paso bajo (α = 0.2) para que el número no "tiemble".
  static Vec3 _smooth(Vec3? prev, Vec3 v) {
    if (prev == null) return v;
    const a = 0.2;
    return (
      x: prev.x + a * (v.x - prev.x),
      y: prev.y + a * (v.y - prev.y),
      z: prev.z + a * (v.z - prev.z),
    );
  }

  @override
  void dispose() {
    for (final s in _subs) {
      unawaited(s.cancel());
    }
    super.dispose();
  }
}
