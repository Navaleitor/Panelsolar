import 'package:meta/meta.dart';

/// Punto geográfico WGS84 en grados decimales.
@immutable
class LatLng {
  /// Crea un punto. No valida: usa [isValid] o [LatLng.tryCreate].
  const new(this.latitude, this.longitude);

  /// Latitud en grados (−90 a 90, positivo al norte).
  final double latitude;

  /// Longitud en grados (−180 a 180, positivo al este).
  final double longitude;

  /// Devuelve el punto si ambos valores están en rango; si no, `null`.
  static LatLng? tryCreate(double latitude, double longitude) {
    final point = LatLng(latitude, longitude);
    return point.isValid ? point : null;
  }

  /// `true` si la latitud y la longitud están en rango y no son NaN.
  bool get isValid =>
      latitude.isFinite &&
      longitude.isFinite &&
      latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;

  @override
  bool operator ==(Object other) =>
      other is LatLng &&
      other.latitude == latitude &&
      other.longitude == longitude;

  @override
  int get hashCode => Object.hash(latitude, longitude);

  @override
  String toString() => 'LatLng($latitude, $longitude)';
}
