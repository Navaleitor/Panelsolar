import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/core/widgets/date_field_tile.dart';
import 'package:panelsolar/features/clients/presentation/client_providers.dart';
import 'package:panelsolar/features/projects/domain/project_status_flow.dart';
import 'package:panelsolar/features/projects/presentation/widgets/project_status_label.dart';
import 'package:persistence/persistence.dart';

/// Alta ([projectId] nulo) o edición de un proyecto. En el alta, si no se
/// da [clientId], se elige el cliente de una lista.
class ProjectFormPage extends ConsumerStatefulWidget {
  const new({this.projectId, this.clientId, super.key});

  final String? projectId;
  final String? clientId;

  @override
  ConsumerState<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends ConsumerState<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _notes = TextEditingController();
  String? _clientId;
  ProjectStatus _status = ProjectStatus.prospect;
  DateTime _date = _today();
  bool _loading = false;
  bool _saving = false;

  bool get _isEdit => widget.projectId != null;

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime.utc(now.year, now.month, now.day);
  }

  @override
  void initState() {
    super.initState();
    _clientId = widget.clientId;
    if (_isEdit) unawaited(_load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final p = await ref
        .read(projectRepositoryProvider)
        .findById(widget.projectId!);
    if (!mounted) return;
    if (p != null) {
      _name.text = p.name;
      _notes.text = p.notes ?? '';
      _clientId = p.clientId;
      _status = p.status;
      _date = p.projectDate;
    }
    setState(() => _loading = false);
  }

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repo = ref.read(projectRepositoryProvider);
    if (_isEdit) {
      await repo.update(
        widget.projectId!,
        name: _name.text,
        status: _status,
        projectDate: _date,
        notes: _notes.text,
      );
      if (mounted) context.pop();
    } else {
      final project = await repo.create(
        clientId: _clientId!,
        name: _name.text,
        status: _status,
        projectDate: _date,
        notes: _notes.text,
      );
      if (mounted) {
        context.pushReplacement(AppRoutes.projectDetail(project.id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? l10n.projectEdit : l10n.projectNew)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (!_isEdit && widget.clientId == null) _clientSelector(l10n),
            TextFormField(
              key: const Key('project-name'),
              controller: _name,
              decoration: InputDecoration(
                labelText: l10n.fieldProjectName,
                prefixIcon: const Icon(Icons.solar_power),
                border: const OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? l10n.validationRequired
                  : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProjectStatus>(
              key: const Key('project-status'),
              initialValue: _status,
              decoration: InputDecoration(
                labelText: l10n.fieldStatus,
                prefixIcon: const Icon(Icons.flag),
                border: const OutlineInputBorder(),
              ),
              items: [
                for (final s in ProjectStatusFlow.ordered)
                  DropdownMenuItem(
                    value: s,
                    child: Text(projectStatusLabel(l10n, s)),
                  ),
              ],
              onChanged: (s) => setState(() => _status = s ?? _status),
            ),
            const SizedBox(height: 16),
            DateFieldTile(
              key: const Key('project-date'),
              label: l10n.fieldDate,
              value: _date,
              onChanged: (d) => setState(() => _date = d),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notes,
              decoration: InputDecoration(
                labelText: l10n.fieldNotes,
                prefixIcon: const Icon(Icons.notes),
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              key: const Key('project-save'),
              onPressed: _saving ? null : _save,
              icon: const Icon(Icons.save),
              label: Text(l10n.actionSave),
            ),
          ],
        ),
      ),
    );
  }

  Widget _clientSelector(AppLocalizations l10n) {
    final clients = ref.watch(clientListProvider('')).value ?? const [];
    if (clients.isEmpty) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.info_outline),
          title: Text(l10n.projectNeedsClient),
          trailing: TextButton(
            onPressed: () => context.push(AppRoutes.clientNew),
            child: Text(l10n.clientNew),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        key: const Key('project-client'),
        initialValue: _clientId,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: l10n.fieldClient,
          prefixIcon: const Icon(Icons.person),
          border: const OutlineInputBorder(),
        ),
        items: [
          for (final c in clients)
            DropdownMenuItem(value: c.id, child: Text(c.name)),
        ],
        validator: (v) => v == null ? l10n.validationRequired : null,
        onChanged: (v) => setState(() => _clientId = v),
      ),
    );
  }
}
