import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:panelsolar/core/files/app_storage.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/core/widgets/empty_state.dart';
import 'package:panelsolar/features/photos/data/photo_importer.dart';
import 'package:panelsolar/features/photos/data/photo_providers.dart';
import 'package:panelsolar/features/photos/presentation/photo_list_providers.dart';
import 'package:panelsolar/features/photos/presentation/photo_stage_label.dart';
import 'package:persistence/persistence.dart';

/// Fotos del proyecto en pestañas por etapa. Botón para tomar con la
/// cámara o elegir de la galería (se guardan en la etapa visible).
class PhotosPage extends ConsumerStatefulWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends ConsumerState<PhotosPage>
    with SingleTickerProviderStateMixin {
  late final _tabs = TabController(
    length: PhotoStage.values.length,
    vsync: this,
  );
  bool _busy = false;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _add(ImageSource source) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final stage = PhotoStage.values[_tabs.index];
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
          stage: stage,
          bytes: await file.readAsBytes(),
          fromCamera: fromCamera,
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
                key: const Key('photo-camera'),
                leading: const Icon(Icons.photo_camera),
                title: Text(l10n.photoFromCamera),
                onTap: () {
                  Navigator.of(context).pop();
                  unawaited(_add(ImageSource.camera));
                },
              ),
              ListTile(
                key: const Key('photo-gallery'),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.photosTitle),
        bottom: TabBar(
          controller: _tabs,
          tabs: [
            for (final s in PhotoStage.values)
              Tab(text: photoStageLabel(l10n, s)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'photos-fab',
        key: const Key('photos-add'),
        onPressed: _busy ? null : _chooseSource,
        icon: _busy
            ? const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(),
              )
            : const Icon(Icons.add_a_photo),
        label: Text(l10n.photoAdd),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          for (final s in PhotoStage.values)
            _StageGrid(projectId: widget.projectId, stage: s),
        ],
      ),
    );
  }
}

class _StageGrid extends ConsumerWidget {
  const new({required this.projectId, required this.stage});

  final String projectId;
  final PhotoStage stage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final storage = ref.watch(appStorageProvider);
    final photos = ref.watch(
      photosProvider((projectId: projectId, stage: stage)),
    );
    return AsyncValueView(
      value: photos,
      data: (list) => list.isEmpty
          ? EmptyState(icon: Icons.photo_outlined, message: l10n.photosEmpty)
          : GridView.builder(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 96),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final photo = list[index];
                return InkWell(
                  onTap: () =>
                      context.push(AppRoutes.photoView(projectId, photo.id)),
                  child: Image.file(
                    File(storage.file(photo.filePath).path),
                    fit: BoxFit.cover,
                    cacheWidth: 320,
                    errorBuilder: (_, _, _) =>
                        const Center(child: Icon(Icons.broken_image)),
                  ),
                );
              },
            ),
    );
  }
}
