import 'dart:math' as math;

/// Vector de tres componentes en el sistema del teléfono (Android/iOS):
/// x a la derecha de la pantalla, y hacia arriba de la pantalla, z saliendo
/// de la pantalla hacia el usuario.
typedef Vec3 = ({double x, double y, double z});

/// Dirección del borde superior del teléfono (para apoyarlo en una arista).
const Vec3 phoneTopEdge = (x: 0, y: 1, z: 0);

/// Dirección hacia donde mira la cámara trasera (para apuntar a un objeto).
const Vec3 phoneBackCamera = (x: 0, y: 0, z: -1);

/// Cálculos con el acelerómetro y el magnetómetro del teléfono:
/// inclinómetro, ángulo de elevación, brújula con compensación de
/// inclinación y altura por ángulo.
///
/// El acelerómetro en reposo mide la reacción a la gravedad: un vector que
/// apunta **hacia arriba** (≈ 9.81 m/s²).
/// Ficha: docs/formulas/21-inclinometro-y-brujula.md
abstract final class PhoneOrientation {
  /// Inclinación (grados) de la superficie donde está apoyado el teléfono
  /// con la pantalla hacia arriba: ángulo entre el eje z y la vertical.
  static double surfaceTiltDeg(Vec3 accel) {
    final horizontal = math.sqrt(accel.x * accel.x + accel.y * accel.y);
    return math.atan2(horizontal, accel.z.abs()) * 180 / math.pi;
  }

  /// Elevación (grados sobre el horizonte) de la dirección [direction] del
  /// teléfono. Con [phoneBackCamera]: el ángulo al que apunta la cámara.
  static double elevationDeg(Vec3 accel, {Vec3 direction = phoneBackCamera}) {
    final up = _unit(accel);
    final d = _unit(direction);
    final sinE = (d.x * up.x + d.y * up.y + d.z * up.z).clamp(-1.0, 1.0);
    return math.asin(sinE) * 180 / math.pi;
  }

  /// Azimut **magnético** (grados desde el norte magnético, horario) de la
  /// dirección [direction] del teléfono, compensando la inclinación:
  /// este = campo × arriba, norte = arriba × este.
  static double magneticAzimuthDeg(
    Vec3 accel,
    Vec3 magnetic, {
    Vec3 direction = phoneTopEdge,
  }) {
    final up = _unit(accel);
    final east = _unit(_cross(magnetic, up));
    final north = _cross(up, east);
    final e = _dot(direction, east);
    final n = _dot(direction, north);
    final az = math.atan2(e, n) * 180 / math.pi;
    return az < 0 ? az + 360 : az;
  }

  /// Azimut verdadero = magnético + declinación (WMM), entre 0 y 360.
  static double trueAzimuthDeg(double magneticAzimuth, double declinationDeg) {
    final v = (magneticAzimuth + declinationDeg) % 360;
    return v < 0 ? v + 360 : v;
  }

  /// Altura de un objeto midiendo con el teléfono: h = d·tan(a) + ojos.
  /// [distanceM]: distancia horizontal al objeto; [angleDeg]: elevación al
  /// tope; [eyeHeightM]: altura de los ojos (o del teléfono) sobre el piso
  /// donde está parada la persona.
  static double heightByAngle({
    required double distanceM,
    required double angleDeg,
    double eyeHeightM = 1.5,
  }) {
    if (!(distanceM > 0)) {
      throw ArgumentError.value(distanceM, 'distanceM', 'debe ser > 0');
    }
    if (angleDeg <= -90 || angleDeg >= 90) {
      throw ArgumentError.value(
        angleDeg,
        'angleDeg',
        'debe estar en (−90, 90)',
      );
    }
    return distanceM * math.tan(angleDeg * math.pi / 180) + eyeHeightM;
  }

  static Vec3 _unit(Vec3 v) {
    final l = math.sqrt(_dot(v, v));
    if (l == 0) return v;
    return (x: v.x / l, y: v.y / l, z: v.z / l);
  }

  static double _dot(Vec3 a, Vec3 b) => a.x * b.x + a.y * b.y + a.z * b.z;

  static Vec3 _cross(Vec3 a, Vec3 b) => (
    x: a.y * b.z - a.z * b.y,
    y: a.z * b.x - a.x * b.z,
    z: a.x * b.y - a.y * b.x,
  );
}
