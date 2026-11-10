import 'package:intl/intl.dart';

/// Formatos de fecha, número y dinero según el idioma de la app.
abstract final class Formatters {
  /// Fecha corta (p. ej. `10 nov 2026`). Las fechas UTC se muestran como
  /// día calendario (sin desplazar por zona horaria).
  static String date(DateTime value, String locale) =>
      DateFormat.yMMMd(locale).format(_calendarDay(value));

  /// Mes y año abreviados para ejes de gráficas (p. ej. `nov 26`).
  static String monthYear(DateTime value, String locale) =>
      DateFormat('MMM yy', locale).format(_calendarDay(value));

  /// Número con separador de miles y hasta [decimals] decimales.
  static String number(num value, String locale, {int decimals = 0}) {
    final format = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = decimals;
    return format.format(value);
  }

  /// Importe en centavos como moneda (p. ej. `$1,540.50`).
  static String money(int cents, String currency, String locale) =>
      NumberFormat.simpleCurrency(
        locale: locale,
        name: currency,
      ).format(cents / 100);

  static DateTime _calendarDay(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
