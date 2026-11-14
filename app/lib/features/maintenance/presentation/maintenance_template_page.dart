import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/async_value_view.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/features/maintenance/data/maintenance_providers.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_labels.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_list_providers.dart';
import 'package:panelsolar/features/maintenance/presentation/widgets/service_dialog.dart';
import 'package:persistence/persistence.dart';

/// Plantilla editable de servicios: se copia al crear el plan de un
/// proyecto. El interruptor indica si el servicio se incluye.
class MaintenanceTemplatePage extends ConsumerWidget {
  const new({super.key});

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final r = await showServiceDialog(context);
    if (r != null) {
      await ref.read(maintenanceRepositoryProvider).addTemplateItem(r.service);
    }
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    MaintenanceTemplateItem t,
  ) async {
    final r = await showServiceDialog(
      context,
      kind: t.kind,
      title: t.title,
      intervalMonths: t.intervalMonths,
    );
    if (r != null) {
      await ref
          .read(maintenanceRepositoryProvider)
          .updateTemplateItem(t.id, r.service, enabled: t.enabled);
    }
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    MaintenanceTemplateItem t,
  ) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.serviceDeleteTitle,
      message: serviceLabel(l10n, t.kind, t.title),
    );
    if (ok) {
      await ref
          .read(maintenanceRepositoryProvider)
          .softDeleteTemplateItem(t.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    ref.watch(templateSeedProvider);
    final template = ref.watch(templateProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.templateTitle)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('template-add'),
        onPressed: () => _add(context, ref),
        icon: const Icon(Icons.add),
        label: Text(l10n.actionAdd),
      ),
      body: AsyncValueView(
        value: template,
        data: (items) => ListView(
          padding: const EdgeInsets.only(bottom: 96),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(l10n.templateHint),
            ),
            for (final t in items)
              ListTile(
                title: Text(serviceLabel(l10n, t.kind, t.title)),
                subtitle: Text(l10n.everyMonths(t.intervalMonths)),
                onTap: () => _edit(context, ref, t),
                onLongPress: () => _delete(context, ref, t),
                trailing: Switch(
                  value: t.enabled,
                  onChanged: (v) => ref
                      .read(maintenanceRepositoryProvider)
                      .updateTemplateItem(t.id, (
                        kind: t.kind,
                        title: t.title,
                        intervalMonths: t.intervalMonths,
                      ), enabled: v),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
