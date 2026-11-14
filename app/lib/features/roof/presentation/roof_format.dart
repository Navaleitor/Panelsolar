import 'package:panelsolar/core/formatting/formatters.dart';

/// Formatos de medidas del techo.
abstract final class RoofFormat {
  /// Metros con 2 decimales: `3.45 m`.
  static String meters(double v, String locale) =>
      '${Formatters.number(v, locale, decimals: 2)} m';

  /// Área: `80.5 m²`.
  static String area(double v, String locale) =>
      '${Formatters.number(v, locale, decimals: 1)} m²';

  /// Ángulo entero: `90°`.
  static String degrees(double v, String locale, {int decimals = 0}) =>
      '${Formatters.number(v, locale, decimals: decimals)}°';

  /// Porcentaje con signo: `+3.0 %`.
  static String signedPercent(double v, String locale) =>
      '${v >= 0 ? '+' : ''}${Formatters.number(v, locale, decimals: 1)} %';

  /// Porcentaje: `12 %`.
  static String percent(double fraction, String locale) =>
      '${Formatters.number(fraction * 100, locale)} %';
}
