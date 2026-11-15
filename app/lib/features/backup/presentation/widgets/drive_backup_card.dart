import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/features/backup/data/backup_providers.dart';
import 'package:panelsolar/features/backup/data/backup_settings.dart';
import 'package:panelsolar/features/backup/data/drive/remote_store.dart';
import 'package:panelsolar/features/backup/presentation/backup_labels.dart';
import 'package:panelsolar/features/backup/presentation/restore_preview_page.dart';
import 'package:panelsolar/features/backup/presentation/widgets/password_dialog.dart';
import 'package:persistence/persistence.dart';

/// Respaldo opcional en Google Drive: conectar, frecuencia, contraseña,
/// "Respaldar ahora", restaurar y desconectar.
class DriveBackupCard extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<DriveBackupCard> createState() => _DriveBackupCardState();
}

class _DriveBackupCardState extends ConsumerState<DriveBackupCard> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      await action();
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(l10n.backupError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _connect() => _run(() async {
    await ref.read(backupServiceProvider).connectDrive();
  });

  Future<void> _backupNow() => _run(() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final r = await ref
        .read(backupServiceProvider)
        .backupToDrive(trigger: BackupTrigger.manual, interactive: true);
    if (r != null) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.driveBackupDone(r.uploadedFiles))),
      );
    }
  });

  Future<void> _password() async {
    final l10n = AppLocalizations.of(context);
    final password = await showNewPasswordDialog(
      context,
      title: l10n.drivePasswordTitle,
      message: l10n.drivePasswordHint,
    );
    if (password == null) return;
    await ref.read(backupServiceProvider).setDrivePassword(password);
  }

  Future<void> _restore() => _run(() async {
    final service = ref.read(backupServiceProvider);
    final snapshots = await service.driveSnapshots();
    if (!mounted) return;
    final chosen = await _chooseSnapshot(snapshots);
    if (chosen == null) return;
    final file = await service.downloadDriveSnapshot(chosen);
    if (!mounted) return;
    await context.push(
      AppRoutes.restorePreview,
      extra: RestoreRequest(file: file, fromDrive: true),
    );
  });

  Future<RemoteFile?> _chooseSnapshot(List<RemoteFile> snapshots) {
    final l10n = AppLocalizations.of(context);
    final format = DateFormat.yMMMd(formatLocale(context)).add_Hm();
    return showModalBottomSheet<RemoteFile>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(title: Text(l10n.driveChooseBackup)),
            if (snapshots.isEmpty) ListTile(title: Text(l10n.driveNoBackups)),
            for (final s in snapshots)
              ListTile(
                leading: const Icon(Icons.cloud_done),
                title: Text(format.format(s.createdAt.toLocal())),
                onTap: () => Navigator.of(context).pop(s),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _disconnect() async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.driveDisconnect,
      message: l10n.driveDisconnectMessage,
      confirmLabel: l10n.driveDisconnect,
    );
    if (ok) await _run(ref.read(backupServiceProvider).disconnectDrive);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(driveAuthProvider);
    final enabled =
        ref.watch(settingProvider(BackupSettingKeys.driveEnabled)).value ==
        'true';
    final email = ref
        .watch(settingProvider(BackupSettingKeys.driveEmail))
        .value;
    final freqName = ref
        .watch(settingProvider(BackupSettingKeys.driveFrequency))
        .value;
    final frequency =
        BackupFrequency.values.where((f) => f.name == freqName).firstOrNull ??
        BackupFrequency.daily;
    final encrypted =
        ref.watch(settingProvider(BackupSettingKeys.driveSalt)).value != null;

    final List<Widget> children;
    if (!auth.isConfigured) {
      children = [
        ListTile(
          key: const Key('drive-not-configured'),
          leading: const Icon(Icons.cloud_off),
          title: const Text('Google Drive'),
          subtitle: Text(l10n.driveNotConfigured),
        ),
      ];
    } else if (!enabled) {
      children = [
        ListTile(
          key: const Key('drive-connect'),
          leading: const Icon(Icons.cloud_upload),
          title: Text(l10n.driveConnect),
          subtitle: Text(l10n.driveConnectHint),
          enabled: !_busy,
          onTap: _connect,
        ),
        ListTile(
          key: const Key('drive-restore'),
          leading: const Icon(Icons.cloud_download),
          title: Text(l10n.driveRestore),
          enabled: !_busy,
          onTap: _restore,
        ),
      ];
    } else {
      children = [
        ListTile(
          leading: const Icon(Icons.cloud_done),
          title: const Text('Google Drive'),
          subtitle: Text(email ?? ''),
          trailing: _busy
              ? const SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(),
                )
              : null,
        ),
        ListTile(
          key: const Key('drive-backup-now'),
          leading: const Icon(Icons.backup),
          title: Text(l10n.driveBackupNow),
          enabled: !_busy,
          onTap: _backupNow,
        ),
        ListTile(
          leading: const Icon(Icons.schedule),
          title: Text(l10n.driveFrequency),
          trailing: DropdownButton<BackupFrequency>(
            key: const Key('drive-frequency'),
            value: frequency,
            items: [
              for (final f in BackupFrequency.values)
                DropdownMenuItem(
                  value: f,
                  child: Text(backupFrequencyLabel(l10n, f)),
                ),
            ],
            onChanged: (f) => unawaited(
              ref.read(backupServiceProvider).setFrequency(f ?? frequency),
            ),
          ),
        ),
        ListTile(
          key: const Key('drive-password'),
          leading: Icon(encrypted ? Icons.lock : Icons.lock_open),
          title: Text(l10n.drivePasswordTitle),
          subtitle: Text(
            encrypted ? l10n.driveEncryptedOn : l10n.driveEncryptedOff,
          ),
          onTap: _password,
        ),
        ListTile(
          key: const Key('drive-restore'),
          leading: const Icon(Icons.cloud_download),
          title: Text(l10n.driveRestore),
          enabled: !_busy,
          onTap: _restore,
        ),
        ListTile(
          key: const Key('drive-disconnect'),
          leading: const Icon(Icons.logout),
          title: Text(l10n.driveDisconnect),
          enabled: !_busy,
          onTap: _disconnect,
        ),
      ];
    }
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(children: children),
    );
  }
}
