import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/features/backup/data/backup_files.dart';
import 'package:panelsolar/features/backup/data/backup_providers.dart';
import 'package:panelsolar/features/backup/domain/backup_file_name.dart';
import 'package:panelsolar/features/backup/presentation/restore_preview_page.dart';
import 'package:panelsolar/features/backup/presentation/widgets/password_dialog.dart';
import 'package:path/path.dart' as p;

/// Exportar todo a un .zip (opcionalmente cifrado) e importar uno. Funciona
/// sin cuenta de Google.
class ZipBackupCard extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ZipBackupCard> createState() => _ZipBackupCardState();
}

class _ZipBackupCardState extends ConsumerState<ZipBackupCard> {
  bool _busy = false;

  Future<void> _export() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final password = await showNewPasswordDialog(
      context,
      title: l10n.backupExportTitle,
      message: l10n.backupExportPasswordHint,
    );
    if (password == null) return;
    setState(() => _busy = true);
    final storage = ref.read(appStorageProvider);
    final name = backupFileName(DateTime.now());
    final out = File(p.join(storage.root.path, 'tmp', name));
    try {
      await out.parent.create(recursive: true);
      await ref.read(backupServiceProvider).exportZip(out, password: password);
      final saved = await ref.read(backupFileSaverProvider)(
        name,
        await out.readAsBytes(),
      );
      messenger.showSnackBar(
        SnackBar(
          content: Text(saved ? l10n.backupExported : l10n.backupNotSaved),
        ),
      );
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(l10n.backupError)));
    } finally {
      if (out.existsSync()) out.deleteSync();
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _import() async {
    final file = await ref.read(backupFilePickerProvider)();
    if (file == null || !mounted) return;
    await context.push(
      AppRoutes.restorePreview,
      extra: RestoreRequest(file: file, fromDrive: false),
    );
  }

  Future<void> _undo() async {
    final file = ref.read(backupServiceProvider).safetyFile;
    if (!file.existsSync()) return;
    await context.push(
      AppRoutes.restorePreview,
      extra: RestoreRequest(file: file, fromDrive: false),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasSafety = ref.watch(backupServiceProvider).safetyFile.existsSync();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ListTile(
            key: const Key('backup-export'),
            leading: _busy
                ? const SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(),
                  )
                : const Icon(Icons.archive),
            title: Text(l10n.backupExportTitle),
            subtitle: Text(l10n.backupExportSubtitle),
            enabled: !_busy,
            onTap: _export,
          ),
          ListTile(
            key: const Key('backup-import'),
            leading: const Icon(Icons.unarchive),
            title: Text(l10n.backupImportTitle),
            subtitle: Text(l10n.backupImportSubtitle),
            enabled: !_busy,
            onTap: _import,
          ),
          if (hasSafety)
            ListTile(
              key: const Key('backup-undo-restore'),
              leading: const Icon(Icons.undo),
              title: Text(l10n.restoreUndoTitle),
              subtitle: Text(l10n.restoreUndoSubtitle),
              enabled: !_busy,
              onTap: _undo,
            ),
        ],
      ),
    );
  }
}
