import 'package:flutter/material.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:panelsolar/features/roof/presentation/sensors/sensor_dialogs.dart';
import 'package:panelsolar/features/roof/presentation/widgets/number_input_dialog.dart';

/// Obstáculo lejano nuevo.
typedef FarObstacleDraft = ({String name, List<HorizonPoint> points});

/// Mide un obstáculo lejano (árbol, edificio): el técnico apunta la cámara
/// al borde superior de izquierda a derecha y agrega puntos (B.7 opción B).
/// También se pueden escribir.
Future<FarObstacleDraft?> showFarObstacleDialog(
  BuildContext context, {
  double declinationDeg = 0,
}) => showDialog<FarObstacleDraft>(
  context: context,
  builder: (_) => _FarDialog(declinationDeg: declinationDeg),
);

class _FarDialog extends StatefulWidget {
  const new({required this.declinationDeg});

  final double declinationDeg;

  @override
  State<_FarDialog> createState() => _FarDialogState();
}

class _FarDialogState extends State<_FarDialog> {
  final _name = TextEditingController();
  final _az = TextEditingController();
  final _el = TextEditingController();
  final _points = <HorizonPoint>[];

  @override
  void dispose() {
    _name.dispose();
    _az.dispose();
    _el.dispose();
    super.dispose();
  }

  Future<void> _measure() async {
    final r = await showSensorDialog(
      context,
      mode: SensorMode.aim,
      declinationDeg: widget.declinationDeg,
    );
    if (r case (azimuthDeg: final az?, elevationDeg: final el?, tiltDeg: _)) {
      setState(() => _points.add((azimuth: az, elevation: el < 0 ? 0 : el)));
    }
  }

  void _addTyped() {
    final az = parseDecimal(_az.text);
    final el = parseDecimal(_el.text);
    if (az == null || el == null || az >= 360 || el >= 90) return;
    setState(() {
      _points.add((azimuth: az, elevation: el));
      _az.clear();
      _el.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    return AlertDialog(
      title: Text(l10n.roofFarAdd),
      content: SizedBox(
        width: 360,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                key: const Key('far-name'),
                controller: _name,
                decoration: InputDecoration(labelText: l10n.roofFarName),
              ),
              const SizedBox(height: 8),
              Text(l10n.roofFarHelp),
              FilledButton.tonalIcon(
                key: const Key('far-measure'),
                onPressed: _measure,
                icon: const Icon(Icons.photo_camera),
                label: Text(l10n.roofFarMeasure),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('far-az'),
                      controller: _az,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.roofFarAzimuth,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      key: const Key('far-el'),
                      controller: _el,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.roofFarElevation,
                      ),
                    ),
                  ),
                  IconButton(
                    key: const Key('far-add-point'),
                    onPressed: _addTyped,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              for (final (i, p) in _points.indexed)
                Text(
                  '${i + 1}. ${RoofFormat.degrees(p.azimuth, locale)} · '
                  '${RoofFormat.degrees(p.elevation, locale, decimals: 1)}',
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        FilledButton(
          key: const Key('far-save'),
          onPressed: _points.isEmpty
              ? null
              : () => Navigator.of(context).pop((
                  name: _name.text.trim().isEmpty
                      ? l10n.roofFarDefaultName
                      : _name.text.trim(),
                  points: List.of(_points),
                )),
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
