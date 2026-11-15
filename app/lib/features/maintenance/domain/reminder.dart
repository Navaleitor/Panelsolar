import 'package:persistence/persistence.dart';

/// Notificación local programada para un servicio de mantenimiento.
class Reminder {
  const new({
    required this.id,
    required this.at,
    required this.projectId,
    required this.title,
    required this.body,
  });

  /// Id estable de la notificación (entero de 31 bits).
  final int id;

  /// Momento local en que se muestra.
  final DateTime at;

  /// Proyecto al que lleva al tocarla.
  final String projectId;

  final String title;
  final String body;
}

/// Hora local de los recordatorios.
const int reminderHour = 9;

/// Días de anticipación del primer aviso.
const int reminderDaysBefore = 7;

/// Máximo de notificaciones programadas (Android limita las alarmas).
const int maxReminders = 60;

/// Arma los recordatorios de [services]: uno [reminderDaysBefore] días
/// antes y otro el mismo día, a las [reminderHour] h locales. Solo fechas
/// futuras respecto de [now], las más próximas primero.
List<Reminder> buildReminders(
  List<UpcomingService> services,
  DateTime now, {
  required String Function(UpcomingService s) titleOf,
  required String Function(UpcomingService s, int daysBefore) bodyOf,
}) {
  final result = <Reminder>[];
  for (final s in services) {
    final due = s.item.nextDueAt;
    for (final (slot, daysBefore) in [(0, reminderDaysBefore), (1, 0)]) {
      final at = DateTime(
        due.year,
        due.month,
        due.day - daysBefore,
        reminderHour,
      );
      if (!at.isAfter(now)) continue;
      result.add(
        Reminder(
          id: reminderId(s.item.id, slot),
          at: at,
          projectId: s.item.projectId,
          title: titleOf(s),
          body: bodyOf(s, daysBefore),
        ),
      );
    }
  }
  result.sort((a, b) => a.at.compareTo(b.at));
  return result.take(maxReminders).toList();
}

/// Id entero estable para la notificación [slot] del servicio [itemId]
/// (FNV-1a de 31 bits; no depende de `hashCode`, que cambia entre
/// ejecuciones).
int reminderId(String itemId, int slot) {
  var hash = 0x811c9dc5;
  for (final unit in '$itemId#$slot'.codeUnits) {
    hash = ((hash ^ unit) * 0x01000193) & 0xffffffff;
  }
  return hash & 0x7fffffff;
}
