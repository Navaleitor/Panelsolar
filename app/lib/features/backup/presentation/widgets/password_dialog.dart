import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Pide una contraseña opcional para cifrar un respaldo (con
/// confirmación). Devuelve `''` si se deja sin contraseña y `null` si se
/// cancela.
Future<String?> showNewPasswordDialog(
  BuildContext context, {
  required String title,
  required String message,
}) => showDialog<String>(
  context: context,
  builder: (context) => _PasswordDialog(title: title, message: message),
);

class _PasswordDialog extends StatefulWidget {
  const new({required this.title, required this.message});

  final String title;
  final String message;

  @override
  State<_PasswordDialog> createState() => _PasswordDialogState();
}

class _PasswordDialogState extends State<_PasswordDialog> {
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _ok() {
    final l10n = AppLocalizations.of(context);
    if (_password.text != _confirm.text) {
      setState(() => _error = l10n.passwordMismatch);
      return;
    }
    if (_password.text.isNotEmpty && _password.text.length < 6) {
      setState(() => _error = l10n.passwordTooShort);
      return;
    }
    Navigator.of(context).pop(_password.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.message),
            TextField(
              key: const Key('password-new'),
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(labelText: l10n.passwordOptional),
            ),
            TextField(
              key: const Key('password-confirm'),
              controller: _confirm,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.passwordConfirm,
                errorText: _error,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('password-ok'),
          onPressed: _ok,
          child: Text(l10n.actionContinue),
        ),
      ],
    );
  }
}
