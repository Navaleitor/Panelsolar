import 'package:flutter/material.dart';
import 'package:panelsolar/core/formatting/decimal_parser.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';

/// Ajustes de seguimiento: kWp instalados y umbral de alerta (%).
typedef ProductionSettingsInput = ({double? systemKwp, double thresholdPct});

/// Diálogo de ajustes de producción. Devuelve `null` si se cancela.
Future<ProductionSettingsInput?> showProductionSettingsDialog(
  BuildContext context, {
  required double? systemKwp,
  required double thresholdPct,
}) => showDialog<ProductionSettingsInput>(
  context: context,
  builder: (context) =>
      _SettingsDialog(systemKwp: systemKwp, thresholdPct: thresholdPct),
);

class _SettingsDialog extends StatefulWidget {
  const new({required this.systemKwp, required this.thresholdPct});

  final double? systemKwp;
  final double thresholdPct;

  @override
  State<_SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<_SettingsDialog> {
  late final _kwp = TextEditingController(text: decimalText(widget.systemKwp));
  // Se muestra positivo ("15") y se guarda negativo (−15 %).
  late final _threshold = TextEditingController(
    text: decimalText(widget.thresholdPct.abs()),
  );
  String? _error;

  @override
  void dispose() {
    _kwp.dispose();
    _threshold.dispose();
    super.dispose();
  }

  void _save() {
    final l10n = AppLocalizations.of(context);
    final kwp = parseDecimal(_kwp.text);
    final threshold = parseDecimal(_threshold.text);
    if ((kwp != null && kwp <= 0) ||
        threshold == null ||
        threshold < 0 ||
        threshold > 100) {
      setState(() => _error = l10n.validationNumber);
      return;
    }
    Navigator.of(context).pop((systemKwp: kwp, thresholdPct: -threshold));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.productionSettings),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('production-kwp'),
            controller: _kwp,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: l10n.productionKwp),
          ),
          TextField(
            key: const Key('production-threshold'),
            controller: _threshold,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.productionThreshold,
              helperText: l10n.productionThresholdHint,
              helperMaxLines: 3,
              errorText: _error,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('production-settings-save'),
          onPressed: _save,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
