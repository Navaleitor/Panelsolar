import 'package:solar_engine/src/design/shading/bypass_model.dart';
import 'package:solar_engine/src/design/shading/panel_shade.dart';
import 'package:solar_engine/src/design/shading/sky_view.dart';
import 'package:solar_engine/src/shading/plane_geometry.dart';
import 'package:solar_engine/src/shading/shadow_caster.dart';
import 'package:solar_engine/src/shading/sun_samples.dart';
import 'package:solar_engine/src/simulation/horizon_profile.dart';

/// Sombra por panel (B.7.1 pasos 4–6).
/// Ficha: docs/formulas/27-sombra-por-panel-y-diodos.md
abstract final class PanelShadeCalculator {
  /// Calcula la sombra de cada panel y del arreglo.
  ///
  /// - [samples]: posiciones del Sol con peso = directa de cielo
  ///   despejado × cos θ ([SunSamples.year]).
  /// - [strings]: índices de los paneles de cada string (en serie).
  /// - [diffuseShare]: parte difusa de la luz en el plano (0–1).
  static ArrayShadeResult compute({
    required List<ShadePanel> panels,
    required List<ShadingObstacle> obstacles,
    required List<SunSample> samples,
    HorizonProfile? horizon,
    RoofSurface surface = RoofSurface.flat,
    List<List<int>> strings = const [],
    double diffuseShare = 0.3,
    int pointsAcross = 2,
    int pointsAlong = 4,
  }) {
    const sections = BypassModel.sectionsPerPanel;
    final n = panels.length;
    final points = [
      for (final p in panels)
        [
          for (var s = 0; s < sections; s++)
            p.sectionPoints(s, sections, pointsAcross, pointsAlong),
        ],
    ];
    final boxes = [for (final p in panels) PlaneGeometry.bounds(p.corners)];
    final svf = [
      for (final p in panels)
        SkyView.factor(p.center, obstacles, horizon: horizon),
    ];
    final d = diffuseShare.clamp(0.0, 1.0);
    final gShade = [for (final v in svf) d * v];
    final gSun = [for (final v in svf) (1 - d) + d * v];
    final perPanel = pointsAcross * pointsAlong * sections;

    final beamLost = List.generate(n, (_) => List<double>.filled(12, 0));
    final elecLost = List.generate(n, (_) => List<double>.filled(12, 0));
    final monthW = List<double>.filled(12, 0);
    var totalW = 0.0;
    var stringLostW = 0.0;
    final stringLost = List<double>.filled(strings.length, 0);
    final inString = List<bool>.filled(n, false);
    for (final s in strings) {
      for (final i in s) {
        if (i >= 0 && i < n) inString[i] = true;
      }
    }

    for (final s in samples) {
      final w = s.weight;
      if (w <= 0) continue;
      totalW += w;
      final m = s.month - 1;
      monthW[m] += w;
      final hidden = horizon != null && horizon.blocks(s.elevation, s.azimuth);
      final shadows = hidden
          ? const <List<XY>>[]
          : ShadowCaster.sceneShadows(
              obstacles,
              sunAzimuthDeg: s.azimuth,
              sunElevationDeg: s.elevation,
              surface: surface,
            );
      final sBoxes = [for (final sh in shadows) PlaneGeometry.bounds(sh)];
      final sectionG = List.generate(
        n,
        (_) => List<double>.filled(sections, 0),
      );
      final panelPower = List<double>.filled(n, 0);
      for (var i = 0; i < n; i++) {
        var shadedPts = 0;
        final b = boxes[i];
        final near = <int>[
          for (var k = 0; k < shadows.length; k++)
            if (!(sBoxes[k].$3 < b.$1 ||
                sBoxes[k].$1 > b.$3 ||
                sBoxes[k].$4 < b.$2 ||
                sBoxes[k].$2 > b.$4))
              k,
        ];
        for (var sec = 0; sec < sections; sec++) {
          var secShaded = hidden ? points[i][sec].length : 0;
          if (!hidden && near.isNotEmpty) {
            for (final pt in points[i][sec]) {
              for (final k in near) {
                if (PlaneGeometry.contains(shadows[k], pt)) {
                  secShaded++;
                  break;
                }
              }
            }
          }
          shadedPts += secShaded;
          sectionG[i][sec] = secShaded > 0 ? gShade[i] : gSun[i];
        }
        beamLost[i][m] += w * shadedPts / perPanel;
        panelPower[i] = BypassModel.seriesPower(sectionG[i]);
        elecLost[i][m] += w * (1 - panelPower[i]);
      }
      var lost = 0.0;
      for (final (k, st) in strings.indexed) {
        final secs = <double>[
          for (final i in st)
            if (i >= 0 && i < n) ...sectionG[i],
        ];
        if (secs.isEmpty) continue;
        final count = secs.length / sections;
        final pStr = BypassModel.seriesPower(secs) / count;
        stringLost[k] += w * (1 - pStr);
        lost += (1 - pStr) * count;
      }
      for (var i = 0; i < n; i++) {
        if (!inString[i]) lost += 1 - panelPower[i];
      }
      stringLostW += w * lost;
    }

    double ratio(double a, double b) => b <= 0 ? 0 : a / b;
    final results = [
      for (var i = 0; i < n; i++)
        PanelShadeResult(
          beamLoss: ratio(_sum(beamLost[i]), totalW),
          monthlyBeamLoss: [
            for (var m = 0; m < 12; m++)
              if (monthW[m] == 0) double.nan else beamLost[i][m] / monthW[m],
          ],
          skyViewFactor: svf[i],
          loss: ratio(_sum(elecLost[i]), totalW),
          monthlyLoss: [
            for (var m = 0; m < 12; m++)
              if (monthW[m] == 0) double.nan else elecLost[i][m] / monthW[m],
          ],
        ),
    ];
    final independent = n == 0
        ? 0.0
        : results.fold<double>(0, (s, r) => s + r.loss) / n;
    return ArrayShadeResult(
      panels: results,
      independentLoss: independent,
      stringLoss: n == 0 ? 0 : ratio(stringLostW, totalW * n),
      stringLosses: [for (final v in stringLost) ratio(v, totalW)],
    );
  }

  static double _sum(List<double> v) => v.fold(0, (s, x) => s + x);
}
