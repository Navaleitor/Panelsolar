import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/photos/presentation/photo_list_providers.dart';
import 'package:panelsolar/features/photos/presentation/photo_stage_label.dart';
import 'package:persistence/persistence.dart';

/// Conteo de fotos por etapa en la ficha del proyecto.
class PhotosSummaryCard extends ConsumerWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final photos =
        ref.watch(photosProvider((projectId: projectId, stage: null))).value ??
        const <Photo>[];
    int count(PhotoStage s) => photos.where((f) => f.stage == s).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: l10n.photosTitle,
          action: TextButton.icon(
            key: const Key('project-open-photos'),
            onPressed: () => context.push(AppRoutes.projectPhotos(projectId)),
            icon: const Icon(Icons.photo_library),
            label: Text(l10n.actionOpen),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              for (final stage in PhotoStage.values)
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(photoStageLabel(l10n, stage)),
                  trailing: Text(
                    '${count(stage)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () => context.push(AppRoutes.projectPhotos(projectId)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
