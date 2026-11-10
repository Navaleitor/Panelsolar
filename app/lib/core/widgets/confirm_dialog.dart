import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Pregunta "¿Seguro?" antes de una acción. Devuelve `true` si confirma.
Future<bool> confirmAction(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmLabel,
}) async {
  final l10n = AppLocalizations.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel ?? l10n.actionDelete),
        ),
      ],
    ),
  );
  return result ?? false;
}
