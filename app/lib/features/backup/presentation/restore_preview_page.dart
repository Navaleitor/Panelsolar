import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/features/backup/data/backup_archive.dart';
import 'package:panelsolar/features/backup/data/backup_crypto.dart';
import 'package:panelsolar/features/backup/data/backup_providers.dart';
import 'package:panelsolar/features/backup/domain/backup_manifest.dart';
import 'package:panelsolar/features/backup/presentation/backup_labels.dart';

/// Respaldo a restaurar: archivo .zip local o descargado de Drive.
class RestoreRequest {
  const new({required this.file, required this.fromDrive});

  final File file;
  final bool fromDrive;
}

/// Vista previa antes de restaurar: fecha, versión, conteos y si pide
/// contraseña. Restaurar reemplaza todos los datos actuales.
class RestorePreviewPage extends ConsumerStatefulWidget {
  const new({required this.request, super.key});

  final RestoreRequest request;

  @override
  ConsumerState<RestorePreviewPage> createState() => _RestorePreviewPageState();
}

class _RestorePreviewPageState extends ConsumerState<RestorePreviewPage> {
  final _password = TextEditingController();
  BackupManifest? _manifest;
  bool _invalid = false;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    try {
      _manifest = BackupArchive.readManifest(widget.request.file);
    } on FormatException {
      _invalid = true;
    }
  }

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _restore() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.restoreConfirmTitle,
      message: l10n.restoreConfirmMessage,
      confirmLabel: l10n.restoreAction,
    );
    if (!ok || !mounted) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final service = ref.read(backupServiceProvider);
    try {
      final password = _password.text.isEmpty ? null : _password.text;
      final result = widget.request.fromDrive
          ? await service.restoreDrive(widget.request.file, password: password)
          : await service.restoreZip(widget.request.file, password: password);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            '${l10n.restoreDone(result.filesRestored, result.filesMissing)} '
            '${l10n.restoreSafetyKept}',
          ),
        ),
      );
      if (mounted) context.go(AppRoutes.clients);
    } on WrongPasswordException {
      setState(() => _error = l10n.passwordWrong);
    } on IncompatibleBackupException {
      setState(() => _error = l10n.restoreNewerApp);
    } on Object {
      setState(() => _error = l10n.backupError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final m = _manifest;
    final format = DateFormat.yMMMd(formatLocale(context)).add_Hm();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.restoreTitle)),
      body: _invalid || m == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(l10n.restoreInvalid, textAlign: TextAlign.center),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ListTile(
                  leading: const Icon(Icons.event),
                  title: Text(format.format(m.createdAt.toLocal())),
                  subtitle: Text(l10n.restoreCreatedWith(m.appVersion)),
                ),
                for (final e in m.counts.entries)
                  ListTile(
                    dense: true,
                    title: Text(previewTableLabel(l10n, e.key)),
                    trailing: Text('${e.value}', key: Key('preview-${e.key}')),
                  ),
                ListTile(
                  leading: Icon(m.encrypted ? Icons.lock : Icons.lock_open),
                  title: Text(
                    m.encrypted
                        ? l10n.restoreEncrypted
                        : l10n.restoreNotEncrypted,
                  ),
                ),
                if (m.encrypted)
                  TextField(
                    key: const Key('restore-password'),
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: l10n.passwordLabel,
                      errorText: _error,
                    ),
                  )
                else if (_error != null)
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                const SizedBox(height: 16),
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(l10n.restoreWarning),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  key: const Key('restore-start'),
                  onPressed: _busy ? null : () => unawaited(_restore()),
                  icon: _busy
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.restore),
                  label: Text(l10n.restoreAction),
                ),
              ],
            ),
    );
  }
}
