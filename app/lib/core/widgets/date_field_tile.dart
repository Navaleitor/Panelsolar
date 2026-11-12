import 'package:flutter/material.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';

/// Campo de fecha con borde: muestra [value] y al tocarlo abre el
/// calendario. Devuelve el día elegido como fecha UTC (sin hora) en
/// [onChanged].
class DateFieldTile extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  Future<void> _pick(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(value.year, value.month, value.day),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onChanged(DateTime.utc(picked.year, picked.month, picked.day));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(4),
      ),
      leading: const Icon(Icons.event),
      title: Text(label),
      subtitle: Text(Formatters.date(value, formatLocale(context))),
      onTap: () => _pick(context),
    );
  }
}
