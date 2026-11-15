import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/features/maintenance/data/reminder_scheduler.dart';
import 'package:panelsolar/features/maintenance/domain/default_template.dart';

/// Programador de notificaciones (se sustituye por uno falso en pruebas).
final reminderSchedulerProvider = Provider<ReminderScheduler>(
  (ref) => LocalNotificationScheduler(),
);

/// Clave de ajuste: recordatorios activados (`true`/`false`).
const remindersEnabledKey = 'maintenance.reminders.enabled';

/// Llena la plantilla con los servicios básicos la primera vez.
final templateSeedProvider = FutureProvider<void>(
  (ref) => ref
      .watch(maintenanceRepositoryProvider)
      .seedTemplateIfEmpty(
        defaultMaintenanceTemplate,
        disabled: optionalByDefault,
      ),
);

/// Recordatorios activados (por omisión, sí).
final remindersEnabledProvider = StreamProvider<bool>(
  (ref) => ref
      .watch(appSettingsRepositoryProvider)
      .watch(remindersEnabledKey)
      .map((v) => v != 'false'),
);
