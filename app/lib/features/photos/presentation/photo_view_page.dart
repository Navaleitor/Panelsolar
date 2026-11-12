import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/text_input_dialog.dart';
import 'package:panelsolar/features/photos/presentation/photo_list_providers.dart';
import 'package:panelsolar/features/photos/presentation/photo_stage_label.dart';
import 'package:panelsolar/features/site/domain/coordinate_format.dart';
import 'package:persistence/persistence.dart';

/// Una foto en pantalla completa (con zoom), sus datos, descripción y
/// opción de borrar.
class PhotoViewPage extends ConsumerWidget {
  const new({required this.projectId, required this.photoId, super.key});

  final String projectId;
  final String photoId;

  Future<void> _editCaption(
    BuildContext context,
    WidgetRef ref,
    Photo photo,
  ) async {
    final l10n = AppLocalizations.of(context);
    final result = await showTextInputDialog(
      context,
      title: l10n.photoCaption,
      fieldKey: const Key('photo-caption'),
      initialValue: photo.caption ?? '',
      maxLines: 3,
    );
    if (result != null) {
      await ref.read(photoRepositoryProvider).updateCaption(photo.id, result);
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.photoDeleteTitle,
      message: l10n.photoDeleteMessage,
    );
    if (!ok) return;
    await ref.read(photoRepositoryProvider).softDelete(photoId);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final storage = ref.watch(appStorageProvider);
    final photos = ref
        .watch(photosProvider((projectId: projectId, stage: null)))
        .value;
    final photo = photos?.where((f) => f.id == photoId).firstOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          photo == null ? l10n.photosTitle : photoStageLabel(l10n, photo.stage),
        ),
        actions: [
          if (photo != null)
            IconButton(
              tooltip: l10n.photoCaption,
              icon: const Icon(Icons.edit_note),
              onPressed: () => _editCaption(context, ref, photo),
            ),
          IconButton(
            tooltip: l10n.actionDelete,
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _delete(context, ref),
          ),
        ],
      ),
      body: photo == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: InteractiveViewer(
                    maxScale: 6,
                    child: Center(
                      child: Image.file(
                        File(storage.file(photo.filePath).path),
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.broken_image, size: 64),
                      ),
                    ),
                  ),
                ),
                if (photo.caption != null)
                  ListTile(
                    leading: const Icon(Icons.notes),
                    title: Text(photo.caption!),
                  ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(
                    [
                      '${photo.widthPx}×${photo.heightPx} px',
                      if (photo.takenAt != null)
                        Formatters.date(photo.takenAt!, locale),
                    ].join(' · '),
                  ),
                  subtitle: Text(
                    photo.latitude == null
                        ? l10n.photoNoGps
                        : CoordinateFormat.decimal(
                            photo.latitude!,
                            photo.longitude!,
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
