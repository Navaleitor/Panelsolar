import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/domain/roof_models.dart';
import 'package:panelsolar/features/roof/presentation/widgets/height_by_phone_dialog.dart';
import 'package:panelsolar/features/roof/presentation/widgets/number_input_dialog.dart';
import 'package:panelsolar/features/roof/presentation/widgets/obstacle_labels.dart';
import 'package:persistence/persistence.dart';

/// Resultado de la hoja: el obstáculo editado o la orden de borrarlo.
typedef ObstacleSheetResult = ({ObstacleModel model, bool delete});

/// Hoja para dar tamaño y altura a un obstáculo (B.7.1 paso 1).
Future<ObstacleSheetResult?> showObstacleSheet(
  BuildContext context,
  ObstacleModel model,
) => showModalBottomSheet<ObstacleSheetResult>(
  context: context,
  isScrollControlled: true,
  builder: (_) => _ObstacleSheet(model: model),
);

class _ObstacleSheet extends StatefulWidget {
  const new({required this.model});

  final ObstacleModel model;

  @override
  State<_ObstacleSheet> createState() => _ObstacleSheetState();
}

class _ObstacleSheetState extends State<_ObstacleSheet> {
  late ObstacleModel _m = widget.model;
  late final _width = TextEditingController(text: _fmt(_m.widthM));
  late final _depth = TextEditingController(text: _fmt(_m.depthM));
  late final _height = TextEditingController(text: _fmt(_m.heightM));
  late final _rotation = TextEditingController(text: _fmt(_m.rotationDeg));

  static String _fmt(double? v) => v == null
      ? ''
      : (v * 100).roundToDouble() / 100 == v.roundToDouble()
      ? v.toStringAsFixed(0)
      : v.toStringAsFixed(2);

  @override
  void dispose() {
    for (final c in [_width, _depth, _height, _rotation]) {
      c.dispose();
    }
    super.dispose();
  }

  void _tank(int liters) {
    final s = ObstacleCatalog.waterTankSize(liters);
    setState(() {
      _m = _m.copyWith(
        tankLiters: liters,
        widthM: s.diameterM,
        heightM: ObstacleCatalog.waterTankHeight(liters),
        heightSource: HeightSource.typical,
      );
      _width.text = _fmt(_m.widthM);
      _height.text = _fmt(_m.heightM);
    });
  }

  Future<void> _phone() async {
    final h = await showHeightByPhoneDialog(context);
    if (h == null) return;
    setState(() {
      _m = _m.copyWith(heightM: h, heightSource: HeightSource.phone);
      _height.text = _fmt(h);
    });
  }

  void _save() {
    final w = parseDecimal(_width.text);
    final h = parseDecimal(_height.text);
    if (w == null || w <= 0 || h == null || h < 0) return;
    Navigator.of(context).pop((
      model: _m.copyWith(
        widthM: w,
        heightM: h,
        depthM: parseDecimal(_depth.text) ?? _m.depthM,
        rotationDeg: parseDecimal(_rotation.text) ?? _m.rotationDeg,
      ),
      delete: false,
    ));
  }

  Widget _num(
    TextEditingController c,
    String label,
    String key, {
    VoidCallback? onEdit,
  }) => TextField(
    key: Key(key),
    controller: c,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(labelText: label),
    onChanged: (_) => onEdit?.call(),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final shape = _m.shape;
    final sources = {
      HeightSource.typical: l10n.roofHeightTypical,
      HeightSource.tape: l10n.roofHeightTape,
      HeightSource.phone: l10n.roofHeightPhone,
    };
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
            Text(
              obstacleTypeLabel(l10n, _m.type),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (_m.type == ObstacleType.waterTank)
              Wrap(
                spacing: 8,
                children: [
                  for (final s in ObstacleCatalog.waterTankSizes)
                    ChoiceChip(
                      key: Key('tank-${s.liters}'),
                      label: Text('${s.liters} L'),
                      selected: _m.tankLiters == s.liters,
                      onSelected: (_) => _tank(s.liters),
                    ),
                ],
              ),
            _num(_width, switch (shape) {
              ObstacleShape.circle ||
              ObstacleShape.point => l10n.roofObstacleDiameter,
              ObstacleShape.line => l10n.roofObstacleThickness,
              _ => l10n.roofObstacleWidth,
            }, 'obstacle-width'),
            if (shape == ObstacleShape.rectangle) ...[
              _num(_depth, l10n.roofObstacleDepth, 'obstacle-depth'),
              _num(_rotation, l10n.roofObstacleRotation, 'obstacle-rotation'),
            ],
            _num(
              _height,
              l10n.roofObstacleHeight,
              'obstacle-height',
              onEdit: () => setState(
                () => _m = _m.copyWith(heightSource: HeightSource.tape),
              ),
            ),
            const SizedBox(height: 8),
            SegmentedButton<HeightSource>(
              segments: [
                for (final e in sources.entries)
                  ButtonSegment(value: e.key, label: Text(e.value)),
              ],
              selected: {_m.heightSource},
              onSelectionChanged: (s) {
                if (s.first == HeightSource.phone) {
                  unawaited(_phone());
                } else {
                  setState(() => _m = _m.copyWith(heightSource: s.first));
                }
              },
            ),
            Text(
              l10n.roofObstacleHeightHelp,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (widget.model.id.isNotEmpty)
                  TextButton(
                    key: const Key('obstacle-delete'),
                    onPressed: () =>
                        Navigator.of(context).pop((model: _m, delete: true)),
                    child: Text(l10n.actionDelete),
                  ),
                const Spacer(),
                FilledButton(
                  key: const Key('obstacle-save'),
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
