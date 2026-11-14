/// Suma [months] meses a un día calendario UTC. Si el día no existe en el
/// mes destino (p. ej. 31 → febrero) se usa el último día de ese mes.
DateTime addMonthsUtc(DateTime date, int months) {
  final total = date.year * 12 + (date.month - 1) + months;
  final year = total ~/ 12;
  final month = total % 12 + 1;
  final lastDay = DateTime.utc(year, month + 1, 0).day;
  final day = date.day > lastDay ? lastDay : date.day;
  return DateTime.utc(year, month, day);
}

/// Día calendario (UTC, sin hora) de [date].
DateTime calendarDayUtc(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day);

/// Primer día del mes (UTC) de [date].
DateTime monthStartUtc(DateTime date) => DateTime.utc(date.year, date.month);
