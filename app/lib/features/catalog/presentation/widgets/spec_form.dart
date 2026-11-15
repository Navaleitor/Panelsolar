import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Tipo de campo de un formulario de hoja de datos.
enum SpecKind {
  /// Texto libre.
  text,

  /// Número decimal (acepta coma).
  number,

  /// Número entero.
  integer,

  /// Sí / no.
  toggle,

  /// Opción de una lista.
  choice,
}

/// Un campo del formulario.
class SpecField {
  /// Crea el campo.
  const new({
    required this.id,
    required this.label,
    this.kind = SpecKind.number,
    this.required = true,
    this.unit,
    this.help,
    this.choices = const [],
    this.allowNegative = false,
  });

  /// Clave del valor (y de la `Key` del campo: `spec-<id>`).
  final String id;

  /// Etiqueta.
  final String label;

  /// Tipo.
  final SpecKind kind;

  /// Obligatorio.
  final bool required;

  /// Unidad que se muestra al final.
  final String? unit;

  /// Ayuda en español sencillo.
  final String? help;

  /// Opciones (valor, etiqueta) para [SpecKind.choice].
  final List<(String, String)> choices;

  /// Acepta negativos (coeficientes de temperatura).
  final bool allowNegative;
}

/// Valores del formulario por id.
typedef SpecValues = Map<String, Object?>;

/// Formulario genérico de hoja de datos. [onSave] devuelve un mensaje de
/// error o `null` si se guardó.
class SpecForm extends StatefulWidget {
  /// Crea el formulario.
  const new({
    required this.fields,
    required this.initial,
    required this.onSave,
    super.key,
  });

  /// Campos en orden.
  final List<SpecField> fields;

  /// Valores iniciales.
  final SpecValues initial;

  /// Guardar.
  final Future<String?> Function(SpecValues values) onSave;

  @override
  State<SpecForm> createState() => _SpecFormState();
}

class _SpecFormState extends State<SpecForm> {
  final _form = GlobalKey<FormState>();
  late final Map<String, TextEditingController> _text = {
    for (final f in widget.fields)
      if (f.kind == SpecKind.text ||
          f.kind == SpecKind.number ||
          f.kind == SpecKind.integer)
        f.id: TextEditingController(text: _show(widget.initial[f.id])),
  };
  late final SpecValues _other = {
    for (final f in widget.fields)
      if (f.kind == SpecKind.toggle)
        f.id: widget.initial[f.id] as bool? ?? false
      else if (f.kind == SpecKind.choice)
        f.id: widget.initial[f.id] ?? f.choices.first.$1,
  };
  bool _saving = false;
  String? _error;

  static String _show(Object? v) {
    if (v == null) return '';
    if (v is double) {
      return v == v.roundToDouble() ? v.toStringAsFixed(0) : '$v';
    }
    return '$v';
  }

  @override
  void dispose() {
    for (final c in _text.values) {
      c.dispose();
    }
    super.dispose();
  }

  Object? _parse(SpecField f, String s) {
    final t = s.trim().replaceAll(',', '.');
    if (t.isEmpty) return null;
    return switch (f.kind) {
      SpecKind.number => double.tryParse(t),
      SpecKind.integer => int.tryParse(t),
      _ => s.trim(),
    };
  }

  String? _validate(SpecField f, String? s, AppLocalizations l10n) {
    final v = _parse(f, s ?? '');
    if (v == null) {
      if ((s ?? '').trim().isNotEmpty) return l10n.specInvalidNumber;
      return f.required ? l10n.specRequired : null;
    }
    if (v is num && !f.allowNegative && v <= 0) return l10n.specPositive;
    return null;
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    final values = <String, Object?>{
      for (final f in widget.fields)
        if (_text.containsKey(f.id))
          f.id: _parse(f, _text[f.id]!.text)
        else
          f.id: _other[f.id],
    };
    setState(() {
      _saving = true;
      _error = null;
    });
    final err = await widget.onSave(values);
    if (!mounted) return;
    setState(() {
      _saving = false;
      _error = err;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        children: [
          for (final f in widget.fields) ...[
            _field(f, l10n),
            const SizedBox(height: 12),
          ],
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          FilledButton.icon(
            key: const Key('spec-save'),
            onPressed: _saving ? null : _save,
            icon: const Icon(Icons.save),
            label: Text(l10n.actionSave),
          ),
        ],
      ),
    );
  }

  Widget _field(SpecField f, AppLocalizations l10n) {
    switch (f.kind) {
      case SpecKind.toggle:
        return SwitchListTile(
          key: Key('spec-${f.id}'),
          contentPadding: EdgeInsets.zero,
          title: Text(f.label),
          subtitle: f.help == null ? null : Text(f.help!),
          value: _other[f.id]! as bool,
          onChanged: (v) => setState(() => _other[f.id] = v),
        );
      case SpecKind.choice:
        return DropdownButtonFormField<String>(
          key: Key('spec-${f.id}'),
          initialValue: _other[f.id]! as String,
          decoration: InputDecoration(labelText: f.label, helperText: f.help),
          items: [
            for (final (v, label) in f.choices)
              DropdownMenuItem(value: v, child: Text(label)),
          ],
          onChanged: (v) => setState(() => _other[f.id] = v),
        );
      case SpecKind.text || SpecKind.number || SpecKind.integer:
        return TextFormField(
          key: Key('spec-${f.id}'),
          controller: _text[f.id],
          keyboardType: f.kind == SpecKind.text
              ? TextInputType.text
              : const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
          decoration: InputDecoration(
            labelText: f.required ? '${f.label} *' : f.label,
            suffixText: f.unit,
            helperText: f.help,
            helperMaxLines: 3,
          ),
          validator: (s) => _validate(f, s, l10n),
        );
    }
  }
}
