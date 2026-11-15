import 'package:flutter/material.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Campo de fecha opcional: muestra la fecha o "sin fecha"; al tocarlo
/// abre el calendario y la ✕ la borra. Devuelve días UTC sin hora.
class OptionalDateTile extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  Future<void> _pick(BuildContext context) async {
    final initial = value ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(initial.year, initial.month, initial.day),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onChanged(DateTime.utc(picked.year, picked.month, picked.day));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(4),
      ),
      leading: const Icon(Icons.event),
      title: Text(label),
      subtitle: Text(
        value == null
            ? l10n.dateNotSet
            : Formatters.date(value!, formatLocale(context)),
      ),
      trailing: value == null
          ? null
          : IconButton(
              tooltip: l10n.actionClear,
              icon: const Icon(Icons.clear),
              onPressed: () => onChanged(null),
            ),
      onTap: () => _pick(context),
    );
  }
}
