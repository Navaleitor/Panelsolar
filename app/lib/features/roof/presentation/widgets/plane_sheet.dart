import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/database/repository_providers.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/core/widgets/confirm_dialog.dart';
import 'package:panelsolar/features/roof/data/roof_data_providers.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:panelsolar/features/roof/presentation/sensors/sensor_dialogs.dart';
import 'package:panelsolar/features/roof/presentation/widgets/number_input_dialog.dart';
import 'package:persistence/persistence.dart';

/// Hoja para editar un plano: nombre, inclinación (a mano o con el
/// inclinómetro), alero (→ azimut), retiro, pasillos, dividir y borrar.
Future<void> showPlaneSheet(
  BuildContext context, {
  required String projectId,
  required RoofPlaneModel plane,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  builder: (_) => _PlaneSheet(projectId: projectId, plane: plane),
);

class _PlaneSheet extends ConsumerStatefulWidget {
  const new({required this.projectId, required this.plane});

  final String projectId;
  final RoofPlaneModel plane;

  @override
  ConsumerState<_PlaneSheet> createState() => _PlaneSheetState();
}

class _PlaneSheetState extends ConsumerState<_PlaneSheet> {
  late RoofPlaneModel _p = widget.plane;
  late final _name = TextEditingController(text: _p.name);
  late final _tilt = TextEditingController(text: _p.tiltDeg.toStringAsFixed(1));
  late final _setback = TextEditingController(
    text: _p.edgeSetbackM.toStringAsFixed(2),
  );
  int? _splitA;
  int? _splitB;

  @override
  void dispose() {
    _name.dispose();
    _tilt.dispose();
    _setback.dispose();
    super.dispose();
  }

  Future<void> _inclinometer() async {
    final r = await showSensorDialog(context, mode: SensorMode.tilt);
    if (r?.tiltDeg case final t?) {
      setState(() {
        _tilt.text = t.toStringAsFixed(1);
        _p = _p.copyWith(tiltDeg: t, tiltSource: TiltSource.inclinometer);
      });
    }
  }

  void _edge(int? i) {
    if (i == null) return;
    setState(
      () => _p = _p.copyWith(
        azimuthEdgeIndex: i,
        azimuthDeg: PlaneOrientation.azimuthFromEdge(_p.polygon, i),
      ),
    );
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final tilt = parseDecimal(_tilt.text);
    final setback = parseDecimal(_setback.text) ?? 0;
    if (tilt == null || tilt < 0 || tilt >= 90 || setback < 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.roofInvalidNumber)));
      return;
    }
    final changedTilt = (tilt - _p.tiltDeg).abs() > 0.05;
    final updated = _p.copyWith(
      name: _name.text.trim().isEmpty ? _p.name : _name.text.trim(),
      tiltDeg: tilt,
      tiltSource: changedTilt ? TiltSource.manual : _p.tiltSource,
      edgeSetbackM: setback,
    );
    await ref
        .read(roofEditingServiceProvider)
        .updatePlane(widget.projectId, updated);
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _split() async {
    final l10n = AppLocalizations.of(context);
    if (_splitA == null || _splitB == null) return;
    final ok = await ref
        .read(roofEditingServiceProvider)
        .splitPlane(
          projectId: widget.projectId,
          plane: _p,
          i: _splitA!,
          j: _splitB!,
          newName: '${_p.name} b',
        );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.roofSplitInvalid)));
    }
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.roofPlaneDeleteTitle,
      message: l10n.roofPlaneDeleteMessage,
    );
    if (!ok) return;
    await ref.read(roofPlaneRepositoryProvider).softDelete(_p.id);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final sides = PolygonMetrics.sideLengths(_p.polygon);
    final n = _p.polygon.length;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              key: const Key('plane-name'),
              controller: _name,
              decoration: InputDecoration(labelText: l10n.roofPlaneName),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('plane-tilt'),
                    controller: _tilt,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: l10n.roofPlaneTilt),
                  ),
                ),
                TextButton.icon(
                  key: const Key('plane-inclinometer'),
                  onPressed: _inclinometer,
                  icon: const Icon(Icons.screen_rotation_alt),
                  label: Text(l10n.roofPlaneInclinometer),
                ),
              ],
            ),
            DropdownButtonFormField<int>(
              key: const Key('plane-edge'),
              isExpanded: true,
              initialValue: _p.azimuthEdgeIndex,
              decoration: InputDecoration(labelText: l10n.roofPlaneEave),
              items: [
                for (var i = 0; i < n; i++)
                  DropdownMenuItem(
                    value: i,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      l10n.roofPlaneEdgeItem(
                        i + 1,
                        RoofFormat.meters(sides[i], locale),
                        RoofFormat.degrees(
                          PlaneOrientation.azimuthFromEdge(_p.polygon, i),
                          locale,
                        ),
                      ),
                    ),
                  ),
              ],
              onChanged: _edge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                l10n.roofPlaneAzimuth(
                  RoofFormat.degrees(_p.azimuthDeg, locale),
                ),
                key: const Key('plane-azimuth'),
              ),
            ),
            TextField(
              key: const Key('plane-setback'),
              controller: _setback,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(labelText: l10n.roofPlaneSetback),
            ),
            for (final (i, w) in _p.walkways.indexed)
              ListTile(
                dense: true,
                leading: const Icon(Icons.linear_scale),
                title: Text(
                  l10n.roofWalkwayItem(
                    RoofFormat.meters(w.start.distanceTo(w.end), locale),
                    RoofFormat.meters(w.widthM, locale),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => setState(
                    () => _p = _p.copyWith(
                      walkways: List.of(_p.walkways)..removeAt(i),
                    ),
                  ),
                ),
              ),
            const Divider(),
            Text(l10n.roofSplitHelp),
            Row(
              children: [
                for (final isA in [true, false])
                  Expanded(
                    child: DropdownButton<int>(
                      key: Key(isA ? 'split-a' : 'split-b'),
                      isExpanded: true,
                      value: isA ? _splitA : _splitB,
                      hint: Text(l10n.roofSplitVertex),
                      items: [
                        for (var i = 0; i < n; i++)
                          DropdownMenuItem(value: i, child: Text('${i + 1}')),
                      ],
                      onChanged: (v) =>
                          setState(() => isA ? _splitA = v : _splitB = v),
                    ),
                  ),
                TextButton(
                  key: const Key('plane-split'),
                  onPressed: _split,
                  child: Text(l10n.roofSplit),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                TextButton(
                  key: const Key('plane-delete'),
                  onPressed: _delete,
                  child: Text(l10n.actionDelete),
                ),
                const Spacer(),
                FilledButton(
                  key: const Key('plane-save'),
                  onPressed: _save,
                  child: Text(l10n.actionSave),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
