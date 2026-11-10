import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/router/app_routes.dart';
import 'package:panelsolar/features/clients/domain/contact_validators.dart';
import 'package:panelsolar/features/clients/presentation/contact_error_text.dart';
import 'package:persistence/persistence.dart';

/// Alta ([clientId] nulo) o edición de un cliente.
class ClientFormPage extends ConsumerStatefulWidget {
  const new({this.clientId, super.key});

  final String? clientId;

  @override
  ConsumerState<ClientFormPage> createState() => _ClientFormPageState();
}

class _ClientFormPageState extends ConsumerState<ClientFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _notes = TextEditingController();
  bool _loading = false;
  bool _saving = false;

  bool get _isEdit => widget.clientId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) unawaited(_load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final client = await ref
        .read(clientRepositoryProvider)
        .findById(widget.clientId!);
    if (!mounted) return;
    if (client != null) _fill(client);
    setState(() => _loading = false);
  }

  void _fill(Client c) {
    _name.text = c.name;
    _phone.text = c.phone ?? '';
    _email.text = c.email ?? '';
    _address.text = c.address ?? '';
    _notes.text = c.notes ?? '';
  }

  @override
  void dispose() {
    for (final c in [_name, _phone, _email, _address, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repo = ref.read(clientRepositoryProvider);
    if (_isEdit) {
      await repo.update(
        widget.clientId!,
        name: _name.text,
        phone: _phone.text,
        email: _email.text,
        address: _address.text,
        notes: _notes.text,
      );
      if (mounted) context.pop();
    } else {
      final client = await repo.create(
        name: _name.text,
        phone: _phone.text,
        email: _email.text,
        address: _address.text,
        notes: _notes.text,
      );
      if (mounted) context.pushReplacement(AppRoutes.clientDetail(client.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? l10n.clientEdit : l10n.clientNew)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _field(
                    key: 'client-name',
                    controller: _name,
                    label: l10n.fieldName,
                    icon: Icons.person,
                    validator: (v) =>
                        contactErrorText(l10n, ContactValidators.name(v)),
                    capitalization: TextCapitalization.words,
                  ),
                  _field(
                    key: 'client-phone',
                    controller: _phone,
                    label: l10n.fieldPhone,
                    icon: Icons.phone,
                    keyboard: TextInputType.phone,
                    validator: (v) =>
                        contactErrorText(l10n, ContactValidators.phone(v)),
                  ),
                  _field(
                    key: 'client-email',
                    controller: _email,
                    label: l10n.fieldEmail,
                    icon: Icons.email,
                    keyboard: TextInputType.emailAddress,
                    validator: (v) =>
                        contactErrorText(l10n, ContactValidators.email(v)),
                  ),
                  _field(
                    key: 'client-address',
                    controller: _address,
                    label: l10n.fieldAddress,
                    icon: Icons.home,
                    maxLines: 2,
                  ),
                  _field(
                    key: 'client-notes',
                    controller: _notes,
                    label: l10n.fieldNotes,
                    icon: Icons.notes,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    key: const Key('client-save'),
                    onPressed: _saving ? null : _save,
                    icon: const Icon(Icons.save),
                    label: Text(l10n.actionSave),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _field({
    required String key,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboard,
    int maxLines = 1,
    TextCapitalization capitalization = TextCapitalization.sentences,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        key: Key(key),
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        keyboardType: keyboard,
        maxLines: maxLines,
        textCapitalization: capitalization,
      ),
    );
  }
}
