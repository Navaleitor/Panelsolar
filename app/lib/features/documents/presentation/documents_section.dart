import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/core/widgets/text_input_dialog.dart';
import 'package:panelsolar/features/documents/data/document_providers.dart';
import 'package:panelsolar/features/documents/presentation/document_list_providers.dart';
import 'package:persistence/persistence.dart';

/// Documentos del proyecto (PDF o imagen): agregar, abrir, renombrar y
/// borrar.
class DocumentsSection extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final picked = await ref.read(documentPickerProvider)();
    if (picked == null) return;
    final doc = await ref
        .read(documentImporterProvider)
        .import(
          projectId: projectId,
          fileName: picked.name,
          bytes: picked.bytes,
        );
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          doc == null ? l10n.documentUnsupported : l10n.documentAdded,
        ),
      ),
    );
  }

  Future<void> _open(BuildContext context, WidgetRef ref, Document doc) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final path = ref.read(appStorageProvider).file(doc.filePath).path;
    final ok = await ref.read(fileOpenerProvider)(path, doc.mimeType);
    if (!ok) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.documentCannotOpen)));
    }
  }

  Future<void> _rename(
    BuildContext context,
    WidgetRef ref,
    Document doc,
  ) async {
    final l10n = AppLocalizations.of(context);
    final result = await showTextInputDialog(
      context,
      title: l10n.actionRename,
      fieldKey: const Key('document-title'),
      initialValue: doc.title,
    );
    if (result != null && result.trim().isNotEmpty) {
      await ref.read(documentRepositoryProvider).rename(doc.id, result);
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    Document doc,
  ) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.documentDeleteTitle,
      message: doc.title,
    );
    if (ok) await ref.read(documentRepositoryProvider).softDelete(doc.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final docs = ref.watch(documentsProvider(projectId)).value ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l10n.documentsTitle,
          action: TextButton.icon(
            key: const Key('document-add'),
            onPressed: () => _add(context, ref),
            icon: const Icon(Icons.attach_file),
            label: Text(l10n.actionAdd),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              if (docs.isEmpty)
                ListTile(
                  leading: const Icon(Icons.folder_open),
                  title: Text(l10n.documentsEmpty),
                ),
              for (final doc in docs)
                ListTile(
                  leading: Icon(
                    doc.kind == DocumentKind.pdf
                        ? Icons.picture_as_pdf
                        : Icons.image,
                  ),
                  title: Text(doc.title),
                  subtitle: Text(
                    '${Formatters.date(doc.createdAt, locale)} · '
                    '${Formatters.number(doc.sizeBytes / 1024, locale)} KB',
                  ),
                  onTap: () => _open(context, ref, doc),
                  trailing: PopupMenuButton<void>(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () => _rename(context, ref, doc),
                        child: Text(l10n.actionRename),
                      ),
                      PopupMenuItem(
                        onTap: () => _delete(context, ref, doc),
                        child: Text(l10n.actionDelete),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
