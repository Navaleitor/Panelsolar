import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/text_input_dialog.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_labels.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_list_providers.dart';
import 'package:panelsolar/features/photos/presentation/linked_photos_section.dart';
import 'package:persistence/persistence.dart';

/// Una visita de la bitácora: fecha, técnico, servicios, notas y fotos.
class VisitDetailPage extends ConsumerWidget {
  const new({required this.projectId, required this.visitId, super.key});

  final String projectId;
  final String visitId;

  Future<void> _editNotes(
    BuildContext context,
    WidgetRef ref,
    MaintenanceVisit v,
  ) async {
    final l10n = AppLocalizations.of(context);
    final text = await showTextInputDialog(
      context,
      title: l10n.fieldNotes,
      fieldKey: const Key('visit-notes-edit'),
      initialValue: v.notes ?? '',
      maxLines: 5,
    );
    if (text == null) return;
    await ref
        .read(maintenanceVisitRepositoryProvider)
        .updateVisit(
          v.id,
          visitDate: v.visitDate,
          technician: v.technician,
          notes: text,
        );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.visitDeleteTitle,
      message: l10n.visitDeleteMessage,
    );
    if (!ok) return;
    await ref.read(maintenanceVisitRepositoryProvider).softDeleteVisit(visitId);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final visits = ref.watch(visitsProvider(projectId)).value;
    final plan = ref.watch(planProvider(projectId)).value ?? const [];
    final visit = visits?.where((v) => v.id == visitId).firstOrNull;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.visitTitle),
        actions: [
          IconButton(
            tooltip: l10n.actionDelete,
            icon: const Icon(Icons.delete),
            onPressed: () => unawaited(_delete(context, ref)),
          ),
        ],
      ),
      body: visit == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                ListTile(
                  leading: const Icon(Icons.event),
                  title: Text(Formatters.date(visit.visitDate, locale)),
                  subtitle: Text(visit.technician ?? l10n.visitDate),
                ),
                for (final id in visit.doneItemIds.split(','))
                  if (plan.where((p) => p.id == id).firstOrNull case final p?)
                    ListTile(
                      leading: const Icon(Icons.check),
                      title: Text(serviceLabel(l10n, p.kind, p.title)),
                    ),
                ListTile(
                  key: const Key('visit-notes-tile'),
                  leading: const Icon(Icons.notes),
                  title: Text(visit.notes ?? l10n.visitNoNotes),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _editNotes(context, ref, visit),
                ),
                LinkedPhotosSection(
                  projectId: projectId,
                  recordId: visit.id,
                  stage: PhotoStage.maintenance,
                  title: l10n.visitPhotos,
                ),
              ],
            ),
    );
  }
}
