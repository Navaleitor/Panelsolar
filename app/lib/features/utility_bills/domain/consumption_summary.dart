/// Datos mínimos de un recibo para calcular el consumo.
class BillPeriodData {
  const new({
    required this.start,
    required this.end,
    required this.energyKwh,
    this.amountCents,
  });

  /// Inicio del periodo (día calendario, UTC).
  final DateTime start;

  /// Fin del periodo, inclusivo (día calendario, UTC).
  final DateTime end;

  /// kWh del periodo.
  final double energyKwh;

  /// Importe en centavos, si se capturó.
  final int? amountCents;

  /// Días que cubre (inicio y fin incluidos).
  int get days => end.difference(start).inDays + 1;
}

/// Resumen de consumo del último año de recibos.
///
/// Fórmula (ficha `docs/formulas/consumo-anual.md`):
/// se toman los recibos cuyo fin cae en los 365 días previos al último
/// recibo; consumo diario = Σ kWh / Σ días; anual = diario × 365;
/// mensual promedio = anual / 12. Así se pueden mezclar recibos
/// mensuales y bimestrales.
class ConsumptionSummary {
  const new({
    required this.billCount,
    required this.coveredDays,
    required this.annualKwh,
    this.annualAmountCents,
  });

  /// Días mínimos para considerar que hay un año completo de recibos.
  static const int fullYearDays = 350;

  /// Recibos usados en el cálculo.
  final int billCount;

  /// Días cubiertos por esos recibos.
  final int coveredDays;

  /// Consumo anual estimado (kWh/año).
  final double annualKwh;

  /// Gasto anual estimado en centavos (solo con recibos que traen
  /// importe), o `null`.
  final int? annualAmountCents;

  /// Promedio mensual (kWh/mes).
  double get avgMonthlyKwh => annualKwh / 12;

  /// Promedio diario (kWh/día).
  double get avgDailyKwh => annualKwh / 365;

  /// `true` si los recibos cubren (casi) un año; si no, el anual es una
  /// extrapolación y la UI lo advierte.
  bool get coversFullYear => coveredDays >= fullYearDays;

  /// Calcula el resumen; `null` si no hay recibos o no cubren días.
  static ConsumptionSummary? fromBills(List<BillPeriodData> bills) {
    if (bills.isEmpty) return null;
    final latestEnd = bills
        .map((b) => b.end)
        .reduce((a, b) => a.isAfter(b) ? a : b);
    final windowStart = latestEnd.subtract(const Duration(days: 365));
    final recent = bills.where((b) => b.end.isAfter(windowStart)).toList();

    var days = 0;
    var kwh = 0.0;
    var amountDays = 0;
    var amount = 0;
    for (final b in recent) {
      if (b.days <= 0) continue;
      days += b.days;
      kwh += b.energyKwh;
      final cents = b.amountCents;
      if (cents != null) {
        amountDays += b.days;
        amount += cents;
      }
    }
    if (days == 0) return null;
    return ConsumptionSummary(
      billCount: recent.length,
      coveredDays: days,
      annualKwh: kwh / days * 365,
      annualAmountCents: amountDays == 0
          ? null
          : (amount / amountDays * 365).round(),
    );
  }
}
