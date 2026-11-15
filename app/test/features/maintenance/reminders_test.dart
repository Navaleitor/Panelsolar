import 'package:flutter_test/flutter_test.dart';
import 'package:panelsolar/features/maintenance/domain/due_status.dart';
import 'package:panelsolar/features/maintenance/domain/reminder.dart';
import 'package:persistence/persistence.dart';

UpcomingService service(String id, DateTime due) => (
  item: MaintenancePlanItem(
    id: id,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
    projectId: 'p1',
    kind: MaintenanceServiceKind.cleaning,
    intervalMonths: 6,
    nextDueAt: due,
    sortOrder: 0,
  ),
  projectName: 'Casa',
  clientName: 'Ana',
);

void main() {
  test('vencido, próximo (≤ 30 días) o después', () {
    final today = DateTime(2026, 11, 14, 18);
    expect(dueStatus(DateTime.utc(2026, 11, 13), today), DueStatus.overdue);
    expect(dueStatus(DateTime.utc(2026, 11, 14), today), DueStatus.soon);
    expect(dueStatus(DateTime.utc(2026, 12, 14), today), DueStatus.soon);
    expect(dueStatus(DateTime.utc(2026, 12, 15), today), DueStatus.later);
  });

  test('dos avisos por servicio (7 días antes y el día) a las 9:00', () {
    final now = DateTime(2026, 11, 14, 10);
    final reminders = buildReminders(
      [
        service('a', DateTime.utc(2026, 12, 2)),
        // Ya pasó el aviso de 7 días antes: solo queda el del día.
        service('b', DateTime.utc(2026, 11, 18)),
        // Vencido: sin avisos.
        service('c', DateTime.utc(2026, 11, 2)),
      ],
      now,
      titleOf: (s) => 'T',
      bodyOf: (s, d) => '$d',
    );
    expect(reminders.map((r) => r.at), [
      DateTime(2026, 11, 18, 9),
      DateTime(2026, 11, 25, 9),
      DateTime(2026, 12, 2, 9),
    ]);
    expect(reminders.map((r) => r.body), ['0', '7', '0']);
    expect(reminders.map((r) => r.id).toSet(), hasLength(3));
  });

  test('id de notificación estable y positivo', () {
    expect(reminderId('abc', 0), reminderId('abc', 0));
    expect(reminderId('abc', 0), isNot(reminderId('abc', 1)));
    expect(reminderId('x' * 40, 1), inInclusiveRange(0, 0x7fffffff));
  });
}
