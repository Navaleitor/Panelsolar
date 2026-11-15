import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/database_providers.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/backup/presentation/widgets/backup_history.dart';
import 'package:panelsolar/features/backup/presentation/widgets/drive_backup_card.dart';
import 'package:panelsolar/features/backup/presentation/widgets/zip_backup_card.dart';
import 'package:panelsolar/features/maintenance/data/maintenance_providers.dart';

/// Ajustes: respaldo (.zip y Google Drive), recordatorios de
/// mantenimiento, clima de prueba (F2) y estado de la base de datos.
class SettingsPage extends ConsumerWidget {
  const new({super.key});

  Future<void> _toggleReminders(WidgetRef ref, bool on) async {
    if (on) await ref.read(reminderSchedulerProvider).requestPermission();
    await ref
        .read(appSettingsRepositoryProvider)
        .set(remindersEnabledKey, on ? 'true' : 'false');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final health = ref.watch(databaseHealthProvider);
    final reminders = ref.watch(remindersEnabledProvider).value ?? true;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          SectionHeader(title: l10n.backupTitle),
          const ZipBackupCard(),
          const DriveBackupCard(),
          SectionHeader(title: l10n.backupHistoryTitle),
          const BackupHistory(),
          SectionHeader(title: l10n.navMaintenance),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SwitchListTile(
                  key: const Key('reminders-switch'),
                  secondary: const Icon(Icons.notifications),
                  title: Text(l10n.remindersTitle),
                  subtitle: Text(l10n.remindersHint),
                  value: reminders,
                  onChanged: (v) => unawaited(_toggleReminders(ref, v)),
                ),
                ListTile(
                  leading: const Icon(Icons.playlist_add_check),
                  title: Text(l10n.templateTitle),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(AppRoutes.maintenanceTemplate),
                ),
              ],
            ),
          ),
          SectionHeader(title: l10n.weatherEntryTitle),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              key: const Key('settingsWeatherEntry'),
              leading: const Icon(Icons.wb_sunny),
              title: Text(l10n.weatherEntryTitle),
              subtitle: Text(l10n.weatherEntrySubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(AppRoutes.weather),
            ),
          ),
          SectionHeader(title: l10n.settingsDatabaseTitle),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              leading: const Icon(Icons.storage),
              title: Text(l10n.settingsDatabaseTitle),
              subtitle: health.when(
                data: (version) => Text(l10n.settingsDatabaseOk(version)),
                loading: () => const LinearProgressIndicator(),
                error: (_, _) => Text(l10n.settingsDatabaseError),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
