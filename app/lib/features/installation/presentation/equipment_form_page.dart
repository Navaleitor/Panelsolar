import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/core/widgets/optional_date_tile.dart';
import 'package:panelsolar/features/installation/presentation/installation_labels.dart';
import 'package:persistence/persistence.dart';

/// Alta ([equipmentId] nulo) o edición de un equipo instalado.
class EquipmentFormPage extends ConsumerStatefulWidget {
  const new({required this.projectId, this.equipmentId, super.key});

  final String projectId;
  final String? equipmentId;

  @override
  ConsumerState<EquipmentFormPage> createState() => _EquipmentFormPageState();
}

class _EquipmentFormPageState extends ConsumerState<EquipmentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _brand = TextEditingController();
  final _model = TextEditingController();
  final _serial = TextEditingController();
  final _notes = TextEditingController();
  EquipmentKind _kind = EquipmentKind.panel;
  DateTime? _installedAt;
  DateTime? _warrantyUntil;
  bool _loading = true;

  bool get _isEdit => widget.equipmentId != null;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    if (_isEdit) {
      final e = await ref
          .read(installedEquipmentRepositoryProvider)
          .findById(widget.equipmentId!);
      if (e != null) {
        _kind = e.kind;
        _brand.text = e.brand;
        _model.text = e.model ?? '';
        _serial.text = e.serialNumber ?? '';
        _notes.text = e.notes ?? '';
        _installedAt = e.installedAt;
        _warrantyUntil = e.warrantyUntil;
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _brand.dispose();
    _model.dispose();
    _serial.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final repo = ref.read(installedEquipmentRepositoryProvider);
    final EquipmentInput data = (
      kind: _kind,
      brand: _brand.text,
      model: _model.text,
      serialNumber: _serial.text,
      installedAt: _installedAt,
      warrantyUntil: _warrantyUntil,
      notes: _notes.text,
    );
    if (_isEdit) {
      await repo.update(widget.equipmentId!, data);
    } else {
      await repo.create(widget.projectId, data);
    }
    if (mounted) context.pop();
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.equipmentDeleteTitle,
      message: _brand.text,
    );
    if (!ok) return;
    await ref
        .read(installedEquipmentRepositoryProvider)
        .softDelete(widget.equipmentId!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? l10n.equipmentEditTitle : l10n.equipmentNewTitle),
        actions: [
          if (_isEdit)
            IconButton(
              tooltip: l10n.actionDelete,
              icon: const Icon(Icons.delete),
              onPressed: _delete,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('equipment-save'),
        onPressed: _loading ? null : _save,
        icon: const Icon(Icons.check),
        label: Text(l10n.actionSave),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                children: [
                  DropdownButtonFormField<EquipmentKind>(
                    key: const Key('equipment-kind'),
                    initialValue: _kind,
                    decoration: InputDecoration(labelText: l10n.equipmentKind),
                    items: [
                      for (final k in EquipmentKind.values)
                        DropdownMenuItem(
                          value: k,
                          child: Text(equipmentKindLabel(l10n, k)),
                        ),
                    ],
                    onChanged: (k) => setState(() => _kind = k ?? _kind),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('equipment-brand'),
                    controller: _brand,
                    decoration: InputDecoration(labelText: l10n.equipmentBrand),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l10n.validationRequired
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('equipment-model'),
                    controller: _model,
                    decoration: InputDecoration(labelText: l10n.equipmentModel),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('equipment-serial'),
                    controller: _serial,
                    decoration: InputDecoration(
                      labelText: l10n.equipmentSerial,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OptionalDateTile(
                    label: l10n.equipmentInstalledAt,
                    value: _installedAt,
                    onChanged: (d) => setState(() => _installedAt = d),
                  ),
                  const SizedBox(height: 12),
                  OptionalDateTile(
                    key: const Key('equipment-warranty'),
                    label: l10n.equipmentWarrantyUntil,
                    value: _warrantyUntil,
                    onChanged: (d) => setState(() => _warrantyUntil = d),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _notes,
                    maxLines: 3,
                    decoration: InputDecoration(labelText: l10n.fieldNotes),
                  ),
                ],
              ),
            ),
    );
  }
}
