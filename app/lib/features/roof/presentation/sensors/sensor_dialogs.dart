import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:panelsolar/features/roof/presentation/sensors/sensor_reader.dart';

/// Qué mide el diálogo de sensores.
enum SensorMode {
  /// Inclinación del techo con el teléfono apoyado (pantalla arriba).
  tilt,

  /// Rumbo verdadero del borde superior del teléfono acostado.
  compass,

  /// Rumbo y elevación hacia donde apunta la cámara trasera.
  aim,
}

/// Lectura que devuelve el diálogo.
typedef SensorResult = ({
  double? tiltDeg,
  double? azimuthDeg,
  double? elevationDeg,
});

/// Abre el diálogo de sensores. [declinationDeg] corrige la brújula al
/// norte verdadero (WMM).
Future<SensorResult?> showSensorDialog(
  BuildContext context, {
  required SensorMode mode,
  double declinationDeg = 0,
}) => showDialog<SensorResult>(
  context: context,
  builder: (_) => _SensorDialog(mode: mode, declinationDeg: declinationDeg),
);

class _SensorDialog extends ConsumerStatefulWidget {
  const new({required this.mode, required this.declinationDeg});

  final SensorMode mode;
  final double declinationDeg;

  @override
  ConsumerState<_SensorDialog> createState() => _SensorDialogState();
}

class _SensorDialogState extends ConsumerState<_SensorDialog> {
  late final SensorReader _reader = SensorReader(
    ref.read(phoneSensorsProvider),
    magnetic: widget.mode != SensorMode.tilt,
  );

  @override
  void dispose() {
    _reader.dispose();
    super.dispose();
  }

  SensorResult? _result() {
    final a = _reader.accel;
    if (a == null) return null;
    switch (widget.mode) {
      case SensorMode.tilt:
        return (
          tiltDeg: PhoneOrientation.surfaceTiltDeg(a),
          azimuthDeg: null,
          elevationDeg: null,
        );
      case SensorMode.compass:
      case SensorMode.aim:
        final m = _reader.mag;
        if (m == null) return null;
        final dir = widget.mode == SensorMode.aim
            ? phoneBackCamera
            : phoneTopEdge;
        final magAz = PhoneOrientation.magneticAzimuthDeg(a, m, direction: dir);
        return (
          tiltDeg: null,
          azimuthDeg: PhoneOrientation.trueAzimuthDeg(
            magAz,
            widget.declinationDeg,
          ),
          elevationDeg: widget.mode == SensorMode.aim
              ? PhoneOrientation.elevationDeg(a)
              : null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final (title, help) = switch (widget.mode) {
      SensorMode.tilt => (l10n.roofSensorTiltTitle, l10n.roofSensorTiltHelp),
      SensorMode.compass => (
        l10n.roofSensorCompassTitle,
        l10n.roofSensorCompassHelp,
      ),
      SensorMode.aim => (l10n.roofSensorAimTitle, l10n.roofSensorAimHelp),
    };
    return ListenableBuilder(
      listenable: _reader,
      builder: (context, _) {
        final r = _result();
        final lines = <String>[
          if (r?.tiltDeg case final t?)
            l10n.roofSensorTiltValue(
              RoofFormat.degrees(t, locale, decimals: 1),
            ),
          if (r?.azimuthDeg case final az?)
            l10n.roofSensorAzimuthValue(RoofFormat.degrees(az, locale)),
          if (r?.elevationDeg case final e?)
            l10n.roofSensorElevationValue(
              RoofFormat.degrees(e, locale, decimals: 1),
            ),
        ];
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(help),
              const SizedBox(height: 16),
              if (_reader.failed)
                Text(l10n.roofSensorUnavailable)
              else if (r == null)
                Text(l10n.roofSensorWaiting)
              else
                for (final l in lines)
                  Text(
                    l,
                    key: const Key('sensor-reading'),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
              if (widget.mode != SensorMode.tilt) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.roofSensorDeclination(
                    RoofFormat.degrees(
                      widget.declinationDeg,
                      locale,
                      decimals: 1,
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.actionCancel),
            ),
            FilledButton(
              key: const Key('sensor-use'),
              onPressed: r == null ? null : () => Navigator.of(context).pop(r),
              child: Text(l10n.roofSensorUse),
            ),
          ],
        );
      },
    );
  }
}
