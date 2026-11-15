import 'package:flutter/material.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/date_field_tile.dart';
import 'package:panelsolar/features/maintenance/presentation/maintenance_labels.dart';
import 'package:persistence/persistence.dart';

/// Resultado del diálogo de servicio. `nextDueAt` solo si se pidió.
typedef ServiceDialogResult = ({ServiceInput service, DateTime? nextDueAt});

/// Diálogo para agregar o editar un servicio: tipo, nombre opcional,
/// frecuencia en meses y (en el plan de un proyecto) la próxima fecha.
Future<ServiceDialogResult?> showServiceDialog(
  BuildContext context, {
  MaintenanceServiceKind kind = MaintenanceServiceKind.cleaning,
  String? title,
  int intervalMonths = 6,
  DateTime? nextDueAt,
  bool askNextDue = false,
}) => showDialog<ServiceDialogResult>(
  context: context,
  builder: (context) => _ServiceDialog(
    kind: kind,
    title: title,
    intervalMonths: intervalMonths,
    nextDueAt: nextDueAt ?? DateTime.now().toUtc(),
    askNextDue: askNextDue,
  ),
);

class _ServiceDialog extends StatefulWidget {
  const new({
    required this.kind,
    required this.title,
    required this.intervalMonths,
    required this.nextDueAt,
    required this.askNextDue,
  });

  final MaintenanceServiceKind kind;
  final String? title;
  final int intervalMonths;
  final DateTime nextDueAt;
  final bool askNextDue;

  @override
  State<_ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<_ServiceDialog> {
  late MaintenanceServiceKind _kind = widget.kind;
  late final _title = TextEditingController(text: widget.title ?? '');
  late final _months = TextEditingController(
    text: widget.intervalMonths.toString(),
  );
  late DateTime _nextDue = widget.nextDueAt;
  String? _error;

  @override
  void dispose() {
    _title.dispose();
    _months.dispose();
    super.dispose();
  }

  void _save() {
    final months = int.tryParse(_months.text.trim());
    if (months == null || months < 1 || months > 120) {
      setState(
        () => _error = AppLocalizations.of(context).serviceIntervalInvalid,
      );
      return;
    }
    Navigator.of(context).pop((
      service: (kind: _kind, title: _title.text, intervalMonths: months),
      nextDueAt: widget.askNextDue ? _nextDue : null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.serviceTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<MaintenanceServiceKind>(
              key: const Key('service-kind'),
              initialValue: _kind,
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.serviceKind),
              items: [
                for (final k in MaintenanceServiceKind.values)
                  DropdownMenuItem(
                    value: k,
                    child: Text(serviceLabel(l10n, k, null)),
                  ),
              ],
              onChanged: (k) => setState(() => _kind = k ?? _kind),
            ),
            TextField(
              key: const Key('service-title'),
              controller: _title,
              decoration: InputDecoration(labelText: l10n.serviceCustomName),
            ),
            TextField(
              key: const Key('service-months'),
              controller: _months,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.serviceIntervalMonths,
                errorText: _error,
              ),
            ),
            if (widget.askNextDue) ...[
              const SizedBox(height: 12),
              DateFieldTile(
                label: l10n.serviceNextDue,
                value: _nextDue,
                onChanged: (d) => setState(() => _nextDue = d),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('service-save'),
          onPressed: _save,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
