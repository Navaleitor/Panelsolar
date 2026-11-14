import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_kit/geo_kit.dart';
import 'package:panelsolar/core/formatting/format_locale.dart';
import 'package:panelsolar/core/l10n/gen/app_localizations.dart';
import 'package:panelsolar/features/roof/data/roof_providers.dart';
import 'package:panelsolar/features/roof/domain/plane_summary.dart';
import 'package:panelsolar/features/roof/domain/roof_codec.dart';
import 'package:panelsolar/features/roof/presentation/editor/editor_north_panel.dart';
import 'package:panelsolar/features/roof/presentation/editor/editor_tool.dart';
import 'package:panelsolar/features/roof/presentation/editor/roof_editor_page.dart';
import 'package:panelsolar/features/roof/presentation/roof_format.dart';
import 'package:panelsolar/features/roof/presentation/widgets/obstacle_labels.dart';

/// Panel inferior del editor según la herramienta.
class EditorPanel extends ConsumerWidget {
  /// Crea el panel.
  const new({required this.state, required this.layout, super.key});

  /// Estado del editor.
  final RoofEditorPageState state;

  /// Techo.
  final RoofLayout layout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = formatLocale(context);
    final r = layout.record;
    switch (state.tool) {
      case EditorTool.calibrate:
        final mpp = r?.metersPerPixel;
        return _Info(
          help: l10n.roofCalibrateHelp,
          detail: mpp == null
              ? l10n.roofScaleNone
              : l10n.roofScaleValue(
                  RoofFormat.meters(mpp * 100, locale).replaceAll(' m', ' cm'),
                  (1 / mpp).toStringAsFixed(1),
                ),
          detailKey: 'scale-value',
        );
      case EditorTool.verify:
        final cal = RoofCodec.decodeLine(r?.calibrationLine);
        final check = RoofCodec.decodeLine(r?.verificationLine);
        String? detail;
        var warn = false;
        if (r?.metersPerPixel case final mpp?
            when check != null && cal != null) {
          final d = ScaleCalibration.verificationDifferencePercent(mpp, check);
          warn = d.abs() > ScaleCalibration.warnDifferencePercent;
          detail = l10n.roofVerifyResult(
            RoofFormat.meters(check.lengthPx * mpp, locale),
            RoofFormat.meters(check.lengthM, locale),
            RoofFormat.signedPercent(d, locale),
          );
        }
        return _Info(
          help: l10n.roofVerifyHelp,
          detail: detail,
          warning: warn ? l10n.roofVerifyWarning : null,
          detailKey: 'verify-value',
        );
      case EditorTool.north:
        return EditorNorthPanel(state: state, layout: layout);
      case EditorTool.draw:
        return _drawPanel(context, l10n, locale);
      case EditorTool.obstacle:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.roofObstacleHelp),
            const SizedBox(height: 4),
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final t in ObstacleType.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        key: Key('obstacle-type-${t.name}'),
                        label: Text(obstacleTypeLabel(l10n, t)),
                        selected: state.obstacleType == t,
                        onSelected: (_) => state.refresh(() {
                          state.obstacleType = t;
                          state.linePts.clear();
                        }),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      case EditorTool.walkway:
        return _Info(help: l10n.roofWalkwayHelp);
      case EditorTool.select:
        final plane = layout.planes
            .where((p) => p.id == state.selectedPlaneId)
            .firstOrNull;
        if (plane == null) return _Info(help: l10n.roofSelectHelp);
        final obstaclesOn = [
          for (final o in layout.obstacles)
            if (PolygonMetrics.contains(plane.polygon, o.center)) o,
        ];
        final s = summarizePlane(plane, obstacles: obstaclesOn);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(plane.name, style: Theme.of(context).textTheme.titleMedium),
            Text(
              l10n.roofPlaneSummary(
                RoofFormat.area(s.horizontalArea, locale),
                RoofFormat.area(s.slopedArea, locale),
                RoofFormat.area(s.usableArea, locale),
                RoofFormat.degrees(plane.tiltDeg, locale),
                RoofFormat.degrees(plane.azimuthDeg, locale),
              ),
              key: const Key('plane-summary'),
            ),
            Text(
              l10n.roofMoveVertexHelp,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                key: const Key('plane-edit'),
                onPressed: () => state.editSelectedPlane(layout),
                icon: const Icon(Icons.edit),
                label: Text(l10n.actionEdit),
              ),
            ),
          ],
        );
    }
  }

  Widget _drawPanel(
    BuildContext context,
    AppLocalizations l10n,
    String locale,
  ) {
    final frame = layout.space.frame;
    final pts = state.drawing.points;
    final local = frame == null ? <Vec2>[] : pts.map(frame.toLocal).toList();
    final sides = [
      for (var i = 0; i + 1 < local.length; i++)
        local[i].distanceTo(local[i + 1]),
    ];
    final live = local.length < 2
        ? l10n.roofDrawHelp
        : l10n.roofDrawLive(
            sides.map((d) => RoofFormat.meters(d, locale)).join(' · '),
            local.length >= 3
                ? RoofFormat.area(PolygonMetrics.area(local), locale)
                : '—',
          );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(live, key: const Key('draw-live')),
        Wrap(
          spacing: 8,
          alignment: WrapAlignment.end,
          children: [
            FilterChip(
              key: const Key('draw-snap'),
              label: Text(l10n.roofSnap),
              selected: state.drawing.snapEnabled,
              onSelected: (v) =>
                  state.refresh(() => state.drawing.snapEnabled = v),
            ),
            TextButton.icon(
              key: const Key('draw-undo'),
              onPressed: pts.isEmpty
                  ? null
                  : () => state.refresh(state.drawing.undo),
              icon: const Icon(Icons.undo),
              label: Text(l10n.roofUndo),
            ),
            FilledButton.icon(
              key: const Key('draw-close'),
              onPressed: state.drawing.canClose
                  ? () => state.closePolygon(layout)
                  : null,
              icon: const Icon(Icons.check),
              label: Text(l10n.roofClosePolygon),
            ),
          ],
        ),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const new({required this.help, this.detail, this.warning, this.detailKey});

  final String help;
  final String? detail;
  final String? warning;
  final String? detailKey;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(help),
      if (detail != null)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            detail!,
            key: detailKey == null ? null : Key(detailKey!),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      if (warning != null)
        Text(
          warning!,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
    ],
  );
}
