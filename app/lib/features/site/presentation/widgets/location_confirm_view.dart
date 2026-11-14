import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/formatting/formatters.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/site/data/site_data_providers.dart';
import 'package:panelsolar/features/site/domain/coordinate_format.dart';
import 'package:panelsolar/features/site/domain/location_candidate.dart';
import 'package:panelsolar/features/site/presentation/location_source_label.dart';

/// Muestra las coordenadas encontradas y pide confirmación. Permite
/// ajustar altitud y zona horaria antes de guardar.
class LocationConfirmView extends ConsumerStatefulWidget {
  const new({
    required this.candidate,
    required this.onConfirm,
    required this.onCancel,
    super.key,
  });

  final LocationCandidate candidate;
  final void Function(double? altitudeM, String? timeZone) onConfirm;
  final VoidCallback onCancel;

  @override
  ConsumerState<LocationConfirmView> createState() =>
      _LocationConfirmViewState();
}

class _LocationConfirmViewState extends ConsumerState<LocationConfirmView> {
  final _formKey = GlobalKey<FormState>();
  late final _altitude = TextEditingController(
    text: widget.candidate.altitudeM?.toStringAsFixed(0) ?? '',
  );
  final _timeZone = TextEditingController();

  @override
  void initState() {
    super.initState();
    unawaited(_loadDeviceTimeZone());
  }

  /// Propone la zona deducida de las coordenadas (sin conexión); si no se
  /// puede, la del teléfono. El usuario puede editarla.
  Future<void> _loadDeviceTimeZone() async {
    final service = ref.read(timeZoneServiceProvider);
    final c = widget.candidate;
    final tz =
        await service.timeZoneAt(c.latitude, c.longitude) ??
        await service.deviceTimeZone();
    if (mounted && tz != null && _timeZone.text.isEmpty) _timeZone.text = tz;
  }

  @override
  void dispose() {
    _altitude.dispose();
    _timeZone.dispose();
    super.dispose();
  }

  void _confirm() {
    if (!_formKey.currentState!.validate()) return;
    final altitude = double.tryParse(_altitude.text.replaceAll(',', '.'));
    final tz = _timeZone.text.trim();
    widget.onConfirm(altitude, tz.isEmpty ? null : tz);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final c = widget.candidate;
    final decimal = CoordinateFormat.decimal(c.latitude, c.longitude);
    final timeZones = ref.read(timeZoneServiceProvider);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.locationConfirmTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                if (c.label != null)
                  ListTile(
                    leading: const Icon(Icons.place),
                    title: Text(c.label!),
                  ),
                ListTile(
                  key: const Key('confirm-decimal'),
                  leading: const Icon(Icons.gps_fixed),
                  title: SelectableText(decimal),
                  subtitle: Text(CoordinateFormat.dms(c.latitude, c.longitude)),
                  trailing: IconButton(
                    tooltip: l10n.actionCopy,
                    icon: const Icon(Icons.copy),
                    onPressed: () =>
                        Clipboard.setData(ClipboardData(text: decimal)),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(locationSourceLabel(l10n, c.source)),
                  subtitle: c.accuracyM == null
                      ? null
                      : Text(
                          l10n.gpsAccuracy(
                            Formatters.number(c.accuracyM!, locale),
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(l10n.locationConfirmHint),
          const SizedBox(height: 16),
          TextFormField(
            key: const Key('confirm-altitude'),
            controller: _altitude,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            decoration: InputDecoration(
              labelText: l10n.fieldAltitude,
              suffixText: 'm',
              prefixIcon: const Icon(Icons.terrain),
              border: const OutlineInputBorder(),
            ),
            validator: (v) {
              final text = v?.trim() ?? '';
              if (text.isEmpty) return null;
              final value = double.tryParse(text.replaceAll(',', '.'));
              return (value == null || value < -500 || value > 9000)
                  ? l10n.validationNumber
                  : null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: const Key('confirm-timezone'),
            controller: _timeZone,
            decoration: InputDecoration(
              labelText: l10n.fieldTimeZone,
              helperText: l10n.timeZoneHelp,
              helperMaxLines: 2,
              prefixIcon: const Icon(Icons.schedule),
              border: const OutlineInputBorder(),
            ),
            validator: (v) {
              final text = v?.trim() ?? '';
              if (text.isEmpty || timeZones.isValid(text)) return null;
              return l10n.validationTimeZone;
            },
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            key: const Key('confirm-location'),
            onPressed: _confirm,
            icon: const Icon(Icons.check),
            label: Text(l10n.locationConfirmAction),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            key: const Key('confirm-cancel'),
            onPressed: widget.onCancel,
            child: Text(l10n.locationChooseAnother),
          ),
        ],
      ),
    );
  }
}
