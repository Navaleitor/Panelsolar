import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/maintenance/data/maintenance_providers.dart';
import 'package:panelsolar/features/maintenance/domain/reminder.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_labels.dart';

/// Mantiene las notificaciones al día: cada vez que cambia el calendario
/// (plan, visitas, proyectos) reprograma todos los recordatorios.
/// Se activa desde la raíz de la app (`PanelsolarApp`).
final reminderSyncProvider = Provider<void>((ref) {
  final scheduler = ref.watch(reminderSchedulerProvider);
  final enabled = ref.watch(remindersEnabledProvider).value ?? true;
  final l10n = lookupAppLocalizations(
    PlatformDispatcher.instance.locale.languageCode == 'en'
        ? const Locale('en')
        : const Locale('es'),
  );
  final sub = ref.watch(maintenanceRepositoryProvider).watchUpcoming().listen((
    services,
  ) async {
    final reminders = enabled
        ? buildReminders(
            services,
            DateTime.now(),
            titleOf: (s) => l10n.reminderTitle(
              serviceLabel(l10n, s.item.kind, s.item.title),
            ),
            bodyOf: (s, days) => days == 0
                ? l10n.reminderBodyToday(s.projectName, s.clientName)
                : l10n.reminderBodyBefore(days, s.projectName, s.clientName),
          )
        : const <Reminder>[];
    try {
      await scheduler.replaceAll(reminders);
    } on Object {
      // Sin permiso o sin plugin: la app sigue funcionando sin avisos.
    }
  });
  ref.onDispose(sub.cancel);
});
