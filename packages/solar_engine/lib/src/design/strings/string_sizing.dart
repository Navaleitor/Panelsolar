import 'dart:math' as math;

import 'package:solar_engine/src/design/strings/string_equipment.dart';

/// Factor de la norma para la corriente de cortocircuito de un string
/// (NOM-001-SEDE-2012 / NEC 690.8(A)): 1.25 por irradiancia alta.
const double iscSafetyFactor = 1.25;

/// Tensión máxima del sistema por norma más usada en vivienda (V).
const double defaultSystemVoltageLimit = 600;

/// Límites de un string (B.6 punto 14).
/// Ficha: docs/formulas/22-dimensionamiento-de-strings.md
class StringLimits {
  /// Crea el resultado (normalmente con [StringSizing.limits]).
  const new({
    required this.vocColdV,
    required this.vmpHotV,
    required this.vmpColdV,
    required this.cellTempHotC,
    required this.minSeries,
    required this.maxSeries,
    required this.maxParallelPerMppt,
    required this.stringDesignCurrentA,
  });

  /// Voc de un panel a la temperatura mínima (V).
  final double vocColdV;

  /// Vmp de un panel a la temperatura de celda máxima (V).
  final double vmpHotV;

  /// Vmp de un panel a la temperatura mínima (V).
  final double vmpColdV;

  /// Temperatura de celda máxima usada (°C).
  final double cellTempHotC;

  /// Mínimo de paneles en serie para no salir del MPPT con calor.
  final int minSeries;

  /// Máximo de paneles en serie sin pasar la tensión máxima con frío.
  final int maxSeries;

  /// Máximo de strings en paralelo por MPPT (Isc × 1.25 ≤ Imax).
  final int maxParallelPerMppt;

  /// Corriente de diseño de un string: Isc × 1.25 (A).
  final double stringDesignCurrentA;

  /// `true` si existe al menos un número de paneles en serie válido.
  bool get feasible => minSeries <= maxSeries && maxParallelPerMppt >= 1;
}

/// Cálculos de strings.
abstract final class StringSizing {
  /// Aumento de la temperatura de celda sobre el ambiente a 1000 W/m² con
  /// viento de 1 m/s (Faiman, U0 = 25, U1 = 6.84): 1000/31.84 ≈ 31.4 °C.
  static const double cellRiseAt1000 = 1000 / (25 + 6.84);

  /// Valor a la temperatura [tempC]: x·[1 + β/100·(T − 25)].
  static double atTemperature(double stcValue, double coeffPct, double tempC) =>
      stcValue * (1 + coeffPct / 100 * (tempC - 25));

  /// Límites para el panel [module] en el inversor [inverter].
  ///
  /// - Voc,máx = Voc·[1 + βVoc·(Tmin − 25)] → máximo en serie con la menor
  ///   de la Vdc máxima del inversor y [systemVoltageLimit].
  /// - Vmp,mín = Vmp·[1 + βVmp·(Tc,máx − 25)], Tc,máx = Tmax + 31.4 °C →
  ///   mínimo en serie para quedar sobre el MPPT.
  /// - Isc × 1.25 ≤ Imax por MPPT → máximo de strings en paralelo.
  static StringLimits limits({
    required StringModule module,
    required StringInverter inverter,
    required StringTemperatures temps,
    double systemVoltageLimit = defaultSystemVoltageLimit,
  }) {
    final tcHot = temps.maxAmbientC + cellRiseAt1000;
    final vocCold = atTemperature(
      module.vocV,
      module.betaVocPct,
      temps.minAmbientC,
    );
    final vmpHot = atTemperature(module.vmpV, module.betaVmpPct, tcHot);
    final vmpCold = atTemperature(
      module.vmpV,
      module.betaVmpPct,
      temps.minAmbientC,
    );
    final vLimit = math.min(inverter.vdcMaxV, systemVoltageLimit);
    final iDesign = module.iscA * iscSafetyFactor;
    final iLimit = inverter.iscMaxPerMpptA == null
        ? inverter.imaxPerMpptA
        : math.min(inverter.imaxPerMpptA, inverter.iscMaxPerMpptA!);
    return StringLimits(
      vocColdV: vocCold,
      vmpHotV: vmpHot,
      vmpColdV: vmpCold,
      cellTempHotC: tcHot,
      minSeries: vmpHot <= 0
          ? 1 << 20
          : math.max(1, (inverter.mpptMinV / vmpHot - 1e-9).ceil()),
      maxSeries: vocCold <= 0 ? 0 : (vLimit / vocCold + 1e-9).floor(),
      maxParallelPerMppt: (iLimit / iDesign + 1e-9).floor(),
      stringDesignCurrentA: iDesign,
    );
  }
}
