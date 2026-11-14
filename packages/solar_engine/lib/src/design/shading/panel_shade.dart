import 'package:solar_engine/src/shading/plane_geometry.dart';

/// Un panel visto desde arriba: 4 esquinas en metros locales. La orilla
/// `corners[0] → corners[1]` es la que se divide en las 3 secciones de los
/// diodos bypass (el lado corto en un panel común de 60/72/120/144 celdas);
/// `corners[0] → corners[3]` es el lado largo.
class ShadePanel {
  /// Crea el panel.
  const new(this.corners);

  /// Esquinas en orden.
  final List<XY> corners;

  /// Centro.
  XY get center {
    var x = 0.0;
    var y = 0.0;
    for (final c in corners) {
      x += c.x;
      y += c.y;
    }
    return (x: x / corners.length, y: y / corners.length);
  }

  /// Puntos de muestra de la sección [section] (0–2): [across] × [along].
  List<XY> sectionPoints(int section, int sections, int across, int along) {
    final c0 = corners[0];
    final a = (x: corners[1].x - c0.x, y: corners[1].y - c0.y);
    final b = (x: corners[3].x - c0.x, y: corners[3].y - c0.y);
    return [
      for (var i = 0; i < across; i++)
        for (var j = 0; j < along; j++)
          (
            x:
                c0.x +
                a.x * ((section + (i + 0.5) / across) / sections) +
                b.x * ((j + 0.5) / along),
            y:
                c0.y +
                a.y * ((section + (i + 0.5) / across) / sections) +
                b.y * ((j + 0.5) / along),
          ),
    ];
  }
}

/// Sombra de un panel.
class PanelShadeResult {
  /// Crea el resultado.
  const new({
    required this.beamLoss,
    required this.monthlyBeamLoss,
    required this.skyViewFactor,
    required this.loss,
    required this.monthlyLoss,
  });

  /// Fracción (0–1) de la luz directa del año que la sombra quita al
  /// panel, ponderada por la irradiancia directa.
  final double beamLoss;

  /// Igual por mes (índice 0 = enero; `NaN` sin Sol ese mes).
  final List<double> monthlyBeamLoss;

  /// Factor de vista de cielo (0–1) en el centro del panel.
  final double skyViewFactor;

  /// Pérdida de energía del panel solo (microinversor u optimizador),
  /// con diodos y difusa reducida (0–1).
  final double loss;

  /// Igual por mes.
  final List<double> monthlyLoss;
}

/// Sombra del arreglo completo.
class ArrayShadeResult {
  /// Crea el resultado.
  const new({
    required this.panels,
    required this.independentLoss,
    required this.stringLoss,
    required this.stringLosses,
  });

  /// Un resultado por panel, en el mismo orden de entrada.
  final List<PanelShadeResult> panels;

  /// Pérdida del sistema si cada panel trabaja solo (micro/optimizador).
  final double independentLoss;

  /// Pérdida del sistema con strings en serie (inversor de string): un
  /// panel sombreado arrastra a su string.
  final double stringLoss;

  /// Pérdida de cada string (0–1), en el orden de entrada.
  final List<double> stringLosses;
}
