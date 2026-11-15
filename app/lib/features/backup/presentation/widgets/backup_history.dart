import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/backup/data/backup_providers.dart';
import 'package:panelsolar/features/backup/presentation/backup_labels.dart';
import 'package:persistence/persistence.dart';

/// Últimos respaldos y restauraciones (para saber si todo va bien).
class BackupHistory extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final logs = ref.watch(backupLogsProvider).value ?? const [];
    final format = DateFormat.yMMMd(formatLocale(context)).add_Hm();
    if (logs.isEmpty) {
      return ListTile(title: Text(l10n.backupHistoryEmpty));
    }
    return Column(
      children: [
        for (final log in logs)
          ListTile(
            dense: true,
            leading: Icon(
              log.status == BackupStatus.success
                  ? Icons.check_circle
                  : Icons.error,
              color: log.status == BackupStatus.success
                  ? Colors.green.shade700
                  : Theme.of(context).colorScheme.error,
            ),
            title: Text(
              '${log.target == BackupTarget.drive ? 'Google Drive' : '.zip'} · '
              '${backupTriggerLabel(l10n, log.trigger)}',
            ),
            subtitle: Text(
              [
                format.format(log.createdAt.toLocal()),
                if (log.status == BackupStatus.failed) l10n.backupFailed,
              ].join(' · '),
            ),
          ),
      ],
    );
  }
}
