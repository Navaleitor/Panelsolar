import 'package:persistence/persistence.dart';

/// Fechas sugeridas al capturar recibos.
abstract final class BillingPeriodMath {
  /// Número de meses del periodo.
  static int months(BillingPeriod period) => switch (period) {
    BillingPeriod.monthly => 1,
    BillingPeriod.bimonthly => 2,
  };

  /// Fin sugerido (inclusivo) para un periodo que empieza en [start]:
  /// el día anterior a `start + meses` (p. ej. 15 ene + 2 meses → 14 mar).
  static DateTime defaultEnd(DateTime start, BillingPeriod period) {
    final next = DateTime.utc(
      start.year,
      start.month + months(period),
      start.day,
    );
    return next.subtract(const Duration(days: 1));
  }

  /// Inicio sugerido para el recibo siguiente a uno que terminó en
  /// [previousEnd]: el día después.
  static DateTime nextStart(DateTime previousEnd) =>
      DateTime.utc(previousEnd.year, previousEnd.month, previousEnd.day + 1);
}
