import 'package:panelsolar/features/design/domain/design_models.dart';
import 'package:solar_engine/solar_engine.dart';

/// Viento por panel (ficha 26). Indicativo: requiere revisión estructural.
typedef WindDesign = ({
  WindResult result,

  /// Área de un panel (m²).
  double panelAreaM2,

  /// Fuerza de levantamiento de un panel (N).
  double upliftPerPanelN,
});

/// Calcula el viento con los [settings] para un panel de [panelAreaM2].
WindDesign windDesign({
  required WindSettings settings,
  required double panelAreaM2,
  required double siteElevationM,
}) {
  final anchors = settings.anchorsPerPanel < 1 ? 1 : settings.anchorsPerPanel;
  final r = WindPressure.compute(
    WindInput(
      basicSpeedMs: WindPressure.kmhToMs(settings.speedKmh),
      heightM: settings.heightM,
      siteElevationM: siteElevationM,
      exposure: settings.exposure,
      gcrn: settings.gcrn,
      tributaryAreaM2: panelAreaM2 / anchors,
    ),
  );
  return (
    result: r,
    panelAreaM2: panelAreaM2,
    upliftPerPanelN: r.netPressurePa.abs() * panelAreaM2,
  );
}
