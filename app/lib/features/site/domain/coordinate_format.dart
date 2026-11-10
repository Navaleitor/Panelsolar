/// Formatos de coordenadas para mostrar al usuario.
abstract final class CoordinateFormat {
  /// Decimal con 6 decimales (~10 cm): `25.686614, -100.316113`.
  static String decimal(double latitude, double longitude) =>
      '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';

  /// Grados, minutos y segundos: `25°41'11.8" N, 100°18'58.0" W`.
  static String dms(double latitude, double longitude) =>
      '${_dms(latitude, 'N', 'S')}, ${_dms(longitude, 'E', 'W')}';

  static String _dms(double value, String positive, String negative) {
    final hemisphere = value < 0 ? negative : positive;
    // Se redondea a décimas de segundo antes de separar para evitar 60.0".
    final tenths = (value.abs() * 36000).round();
    final degrees = tenths ~/ 36000;
    final minutes = (tenths % 36000) ~/ 600;
    final seconds = (tenths % 600) / 10;
    return "$degrees°${minutes.toString().padLeft(2, '0')}'"
        '${seconds.toStringAsFixed(1).padLeft(4, '0')}" $hemisphere';
  }
}
