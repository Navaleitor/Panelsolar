import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Lee un número escrito con punto o coma decimal (`3.5`, `3,5`).
double? parseDecimal(String text) =>
    double.tryParse(text.trim().replaceAll(',', '.'));

/// Pide un número positivo. Devuelve `null` si cancela.
Future<double?> showNumberDialog(
  BuildContext context, {
  required String title,
  required String label,
  required Key fieldKey,
  double? initialValue,
  String? help,
  bool allowZero = false,
}) => showDialog<double>(
  context: context,
  builder: (_) => _NumberDialog(
    title: title,
    label: label,
    fieldKey: fieldKey,
    initialValue: initialValue,
    help: help,
    allowZero: allowZero,
  ),
);

class _NumberDialog extends StatefulWidget {
  const new({
    required this.title,
    required this.label,
    required this.fieldKey,
    required this.initialValue,
    required this.help,
    required this.allowZero,
  });

  final String title;
  final String label;
  final Key fieldKey;
  final double? initialValue;
  final String? help;
  final bool allowZero;

  @override
  State<_NumberDialog> createState() => _NumberDialogState();
}

class _NumberDialogState extends State<_NumberDialog> {
  late final _text = TextEditingController(
    text: widget.initialValue?.toString() ?? '',
  );
  String? _error;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _submit() {
    final v = parseDecimal(_text.text);
    final ok = v != null && v.isFinite && (widget.allowZero ? v >= 0 : v > 0);
    if (!ok) {
      setState(() => _error = AppLocalizations.of(context).roofInvalidNumber);
      return;
    }
    Navigator.of(context).pop(v);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.help != null) ...[
            Text(widget.help!),
            const SizedBox(height: 12),
          ],
          TextField(
            key: widget.fieldKey,
            controller: _text,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
            ],
            decoration: InputDecoration(
              labelText: widget.label,
              errorText: _error,
            ),
            onSubmitted: (_) => _submit(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('number-ok'),
          onPressed: _submit,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
