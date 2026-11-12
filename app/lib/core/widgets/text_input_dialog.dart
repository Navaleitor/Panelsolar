import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Pide un texto en un diálogo. Devuelve el texto o `null` si cancela.
///
/// El diálogo es dueño de su `TextEditingController` (se libera cuando el
/// diálogo termina de cerrarse, no antes).
Future<String?> showTextInputDialog(
  BuildContext context, {
  required String title,
  required Key fieldKey,
  String initialValue = '',
  int maxLines = 1,
}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _TextInputDialog(
      title: title,
      fieldKey: fieldKey,
      initialValue: initialValue,
      maxLines: maxLines,
    ),
  );
}

class _TextInputDialog extends StatefulWidget {
  const new({
    required this.title,
    required this.fieldKey,
    required this.initialValue,
    required this.maxLines,
  });

  final String title;
  final Key fieldKey;
  final String initialValue;
  final int maxLines;

  @override
  State<_TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<_TextInputDialog> {
  late final _controller = TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        key: widget.fieldKey,
        controller: _controller,
        autofocus: true,
        maxLines: widget.maxLines,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
