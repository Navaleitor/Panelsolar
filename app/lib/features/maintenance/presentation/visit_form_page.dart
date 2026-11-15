import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/date_field_tile.dart';
import 'package:panelsolar/core/widgets/section_header.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_labels.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_list_providers.dart';

/// Registrar una visita: fecha, técnico, servicios hechos y notas. Al
/// guardar se recorren las próximas fechas del plan y se abre la visita
/// para agregar fotos.
class VisitFormPage extends ConsumerStatefulWidget {
  const new({required this.projectId, super.key});

  final String projectId;

  @override
  ConsumerState<VisitFormPage> createState() => _VisitFormPageState();
}

class _VisitFormPageState extends ConsumerState<VisitFormPage> {
  final _technician = TextEditingController();
  final _notes = TextEditingController();
  DateTime _date = DateTime.now().toUtc();
  Set<String>? _done;

  @override
  void dispose() {
    _technician.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final visit = await ref
        .read(maintenanceVisitRepositoryProvider)
        .logVisit(
          projectId: widget.projectId,
          visitDate: _date,
          doneItemIds: (_done ?? {}).toList(),
          technician: _technician.text,
          notes: _notes.text,
        );
    if (!mounted) return;
    context.pushReplacement(AppRoutes.visitDetail(widget.projectId, visit.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final plan = ref.watch(planProvider(widget.projectId)).value ?? const [];
    final today = DateTime.now();
    // Por omisión se marcan los servicios vencidos o de los próximos 30 días.
    final done = _done ??= {
      for (final p in plan)
        if (p.nextDueAt.difference(today).inDays <= 30) p.id,
    };
    return Scaffold(
      appBar: AppBar(title: Text(l10n.visitLog)),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('visit-save'),
        onPressed: _save,
        icon: const Icon(Icons.check),
        label: Text(l10n.actionSave),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          DateFieldTile(
            label: l10n.visitDate,
            value: _date,
            onChanged: (d) => setState(() => _date = d),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('visit-technician'),
            controller: _technician,
            decoration: InputDecoration(labelText: l10n.fieldTechnician),
          ),
          SectionHeader(title: l10n.visitServicesDone),
          if (plan.isEmpty) Text(l10n.planEmpty),
          for (final p in plan)
            CheckboxListTile(
              key: Key('visit-done-${p.id}'),
              value: done.contains(p.id),
              title: Text(serviceLabel(l10n, p.kind, p.title)),
              onChanged: (v) => setState(
                () => v ?? false ? done.add(p.id) : done.remove(p.id),
              ),
            ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('visit-notes'),
            controller: _notes,
            maxLines: 4,
            decoration: InputDecoration(labelText: l10n.fieldNotes),
          ),
        ],
      ),
    );
  }
}
