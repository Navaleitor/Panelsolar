import 'dart:math' as math;

import 'package:solar_engine/src/simulation/pv_system.dart';
import 'package:solar_engine/src/simulation/simulation_inputs.dart';
import 'package:solar_engine/src/simulation/simulator.dart';

/// Orientación óptima encontrada.
typedef OptimalOrientation = ({
  double tilt,
  double azimuth,
  double annualEnergy,
  int evaluations,
});

/// Búsqueda numérica de la inclinación y el azimut que maximizan la energía
/// AC anual simulada (plan B.6 punto 10).
/// Ficha: docs/formulas/11-orientacion-optima.md
///
/// Método: búsqueda por coordenadas con sección áurea. Primero se optimiza
/// la inclinación mirando al ecuador, luego el azimut con esa inclinación y
/// por último se reajusta la inclinación. La función energía(β, γ) es suave
/// y unimodal para un plano fijo, por lo que el método converge con unas
/// pocas decenas de simulaciones.
class OrientationOptimizer {
  /// Crea el buscador.
  ///
  /// - [tiltTolerance] y [azimuthTolerance]: precisión final (grados).
  /// - [maxAzimuthDeviation]: desvío máximo respecto al ecuador (grados).
  new({
    required this.inputs,
    required this.system,
    this.tiltTolerance = 0.5,
    this.azimuthTolerance = 1,
    this.maxAzimuthDeviation = 90,
  });

  /// Entradas ya preparadas.
  final SimulationInputs inputs;

  /// Sistema base (se cambia solo la orientación).
  final PvSystem system;

  /// Precisión de inclinación (grados).
  final double tiltTolerance;

  /// Precisión de azimut (grados).
  final double azimuthTolerance;

  /// Desvío máximo del azimut respecto al ecuador (grados).
  final double maxAzimuthDeviation;

  int _evaluations = 0;

  /// Energía AC anual (kWh, año típico) con la orientación dada.
  double energyAt(double tilt, double azimuth) {
    _evaluations++;
    return Simulator.run(
      inputs,
      system.withOrientation(tilt: tilt, azimuth: azimuth),
    ).annualAcEnergy;
  }

  /// Ejecuta la búsqueda.
  OptimalOrientation optimize() {
    _evaluations = 0;
    final equator = inputs.site.equatorFacingAzimuth;
    var azimuth = equator;
    var tilt = _goldenMax((t) => energyAt(t, azimuth), 0, 90, tiltTolerance);
    azimuth = _goldenMax(
      (a) => energyAt(tilt, a),
      equator - maxAzimuthDeviation,
      equator + maxAzimuthDeviation,
      azimuthTolerance,
    );
    tilt = _goldenMax((t) => energyAt(t, azimuth), 0, 90, tiltTolerance);
    return (
      tilt: tilt,
      azimuth: (azimuth % 360 + 360) % 360,
      annualEnergy: energyAt(tilt, azimuth),
      evaluations: _evaluations,
    );
  }

  /// Máximo de [f] en [[lo], [hi]] por sección áurea.
  static double _goldenMax(
    double Function(double) f,
    double lo,
    double hi,
    double tolerance,
  ) {
    final invPhi = (math.sqrt(5) - 1) / 2;
    var a = lo;
    var b = hi;
    var c = b - invPhi * (b - a);
    var d = a + invPhi * (b - a);
    var fc = f(c);
    var fd = f(d);
    while ((b - a).abs() > tolerance) {
      if (fc > fd) {
        b = d;
        d = c;
        fd = fc;
        c = b - invPhi * (b - a);
        fc = f(c);
      } else {
        a = c;
        c = d;
        fc = fd;
        d = a + invPhi * (b - a);
        fd = f(d);
      }
    }
    return (a + b) / 2;
  }
}
