import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/photos/data/photo_importer.dart';
import 'package:panelsolar/features/photos/data/photo_providers.dart';
import 'package:panelsolar/features/photos/presentation/photo_list_providers.dart';
import 'package:persistence/persistence.dart';

/// Fotos de evidencia ligadas a un registro (visita de mantenimiento o
/// puesta en marcha): miniaturas y botón para agregar desde cámara o
/// galería. Las fotos también aparecen en la galería del proyecto, en la
/// etapa [stage].
class LinkedPhotosSection extends ConsumerStatefulWidget {
  const new({
    required this.projectId,
    required this.recordId,
    required this.stage,
    required this.title,
    super.key,
  });

  final String projectId;
  final String recordId;
  final PhotoStage stage;
  final String title;

  @override
  ConsumerState<LinkedPhotosSection> createState() =>
      _LinkedPhotosSectionState();
}

class _LinkedPhotosSectionState extends ConsumerState<LinkedPhotosSection> {
  bool _busy = false;

  Future<void> _add(ImageSource source) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final picker = ref.read(imagePickerProvider);
    final fromCamera = source == ImageSource.camera;
    final files = fromCamera
        ? [?await picker.pickImage(source: ImageSource.camera)]
        : await picker.pickMultiImage();
    if (files.isEmpty) return;
    setState(() => _busy = true);
    final importer = ref.read(photoImporterProvider);
    final outcomes = <PhotoImportOutcome>[];
    for (final file in files) {
      outcomes.add(
        await importer.import(
          projectId: widget.projectId,
          stage: widget.stage,
          bytes: await file.readAsBytes(),
          fromCamera: fromCamera,
          linkedRecordId: widget.recordId,
        ),
      );
    }
    if (!mounted) return;
    setState(() => _busy = false);
    int n(PhotoImportOutcome o) => outcomes.where((x) => x == o).length;
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          l10n.photosImported(
            n(PhotoImportOutcome.saved),
            n(PhotoImportOutcome.duplicate),
            n(PhotoImportOutcome.invalid),
          ),
        ),
      ),
    );
  }

  void _chooseSource() {
    final l10n = AppLocalizations.of(context);
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                key: const Key('linked-photo-camera'),
                leading: const Icon(Icons.photo_camera),
                title: Text(l10n.photoFromCamera),
                onTap: () {
                  Navigator.of(context).pop();
                  unawaited(_add(ImageSource.camera));
                },
              ),
              ListTile(
                key: const Key('linked-photo-gallery'),
                leading: const Icon(Icons.photo_library),
                title: Text(l10n.photoFromGallery),
                onTap: () {
                  Navigator.of(context).pop();
                  unawaited(_add(ImageSource.gallery));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final storage = ref.watch(appStorageProvider);
    final photos =
        ref.watch(linkedPhotosProvider(widget.recordId)).value ?? const [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: widget.title,
          action: TextButton.icon(
            key: const Key('linked-photo-add'),
            onPressed: _busy ? null : _chooseSource,
            icon: _busy
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.add_a_photo),
            label: Text(l10n.actionAdd),
          ),
        ),
        if (photos.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(l10n.photosEmpty),
          )
        else
          SizedBox(
            height: 96,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              separatorBuilder: (_, _) => const SizedBox(width: 4),
              itemBuilder: (context, i) => InkWell(
                onTap: () => context.push(
                  AppRoutes.photoView(widget.projectId, photos[i].id),
                ),
                child: Image.file(
                  File(storage.file(photos[i].filePath).path),
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                  cacheWidth: 200,
                  errorBuilder: (_, _, _) => const SizedBox.square(
                    dimension: 96,
                    child: Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
