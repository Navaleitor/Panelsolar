/// Qué tan cerca está un servicio programado.
enum DueStatus {
  /// La fecha ya pasó.
  overdue,

  /// Vence en los próximos [soonDays] días.
  soon,

  /// Más adelante.
  later,
}

/// Días que cuentan como "próximo".
const int soonDays = 30;

/// Clasifica la fecha [due] (día UTC) respecto de [today].
DueStatus dueStatus(DateTime due, DateTime today) {
  final day = DateTime.utc(today.year, today.month, today.day);
  final d = DateTime.utc(due.year, due.month, due.day);
  if (d.isBefore(day)) return DueStatus.overdue;
  if (d.difference(day).inDays <= soonDays) return DueStatus.soon;
  return DueStatus.later;
}
