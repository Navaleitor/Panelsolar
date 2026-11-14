/// Respaldo remoto identificado por id y fecha.
typedef DatedBackup = ({String id, DateTime createdAt});

/// Política de retención (plan B.9): se conserva el más reciente de cada
/// uno de los últimos [daily] días con respaldo y el más reciente de cada
/// una de las últimas [weekly] semanas (lunes a domingo, UTC). Devuelve los
/// ids que se deben **borrar**.
Set<String> backupsToDelete(
  List<DatedBackup> backups, {
  int daily = 7,
  int weekly = 4,
}) {
  final sorted = [...backups]
    ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  final keep = <String>{};
  final days = <DateTime>{};
  final weeks = <DateTime>{};
  for (final b in sorted) {
    final t = b.createdAt.toUtc();
    final day = DateTime.utc(t.year, t.month, t.day);
    final week = day.subtract(Duration(days: day.weekday - 1));
    if (!days.contains(day) && days.length < daily) {
      days.add(day);
      keep.add(b.id);
    }
    if (!weeks.contains(week) && weeks.length < weekly) {
      weeks.add(week);
      keep.add(b.id);
    }
  }
  return {
    for (final b in backups)
      if (!keep.contains(b.id)) b.id,
  };
}
