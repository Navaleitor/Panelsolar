import 'package:flutter/material.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:panelsolar/features/roof/presentation/sensors/sensor_dialogs.dart';
import 'package:panelsolar/features/roof/presentation/widgets/number_input_dialog.dart';

/// Altura con el teléfono (B.7.1): h = distancia × tan(ángulo) + altura de
/// ojos. El ángulo se mide apuntando la cámara al tope o se escribe.
Future<double?> showHeightByPhoneDialog(BuildContext context) =>
    showDialog<double>(context: context, builder: (_) => const _HeightDialog());

class _HeightDialog extends StatefulWidget {
  const new();

  @override
  State<_HeightDialog> createState() => _HeightDialogState();
}

class _HeightDialogState extends State<_HeightDialog> {
  final _distance = TextEditingController();
  final _angle = TextEditingController();
  final _eye = TextEditingController(text: '1.5');

  @override
  void dispose() {
    _distance.dispose();
    _angle.dispose();
    _eye.dispose();
    super.dispose();
  }

  double? get _height {
    final d = parseDecimal(_distance.text);
    final a = parseDecimal(_angle.text);
    final e = parseDecimal(_eye.text) ?? 0;
    if (d == null || a == null || d <= 0 || a >= 90) return null;
    return PhoneOrientation.heightByAngle(
      distanceM: d,
      angleDeg: a,
      eyeHeightM: e,
    );
  }

  Future<void> _measure() async {
    final r = await showSensorDialog(context, mode: SensorMode.aim);
    if (r?.elevationDeg case final e?) {
      setState(() => _angle.text = e.toStringAsFixed(1));
    }
  }

  Widget _field(TextEditingController c, String label, String key) => TextField(
    key: Key(key),
    controller: c,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(labelText: label),
    onChanged: (_) => setState(() {}),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final h = _height;
    return AlertDialog(
      title: Text(l10n.roofHeightPhoneTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.roofHeightPhoneHelp),
            _field(_distance, l10n.roofHeightDistance, 'height-distance'),
            Row(
              children: [
                Expanded(
                  child: _field(_angle, l10n.roofHeightAngle, 'height-angle'),
                ),
                IconButton(
                  tooltip: l10n.roofSensorAimTitle,
                  onPressed: _measure,
                  icon: const Icon(Icons.photo_camera),
                ),
              ],
            ),
            _field(_eye, l10n.roofHeightEye, 'height-eye'),
            const SizedBox(height: 12),
            Text(
              h == null
                  ? '—'
                  : l10n.roofHeightResult(
                      RoofFormat.meters(h, formatLocale(context)),
                    ),
              key: const Key('height-result'),
              style: Theme.of(context).textTheme.titleMedium,
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
          key: const Key('height-use'),
          onPressed: h == null || h < 0
              ? null
              : () => Navigator.of(context).pop(h),
          child: Text(l10n.roofSensorUse),
        ),
      ],
    );
  }
}
