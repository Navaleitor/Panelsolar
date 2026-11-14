/// Datos eléctricos de un panel para diseñar strings (hoja de datos, STC).
/// Coeficientes de temperatura en %/°C (negativos en Voc, Vmp y Pmax).
class StringModule {
  /// Crea el panel.
  const new({
    required this.pmaxW,
    required this.vocV,
    required this.iscA,
    required this.vmpV,
    required this.impA,
    this.betaVocPct = -0.29,
    this.betaVmpPct = -0.38,
    this.gammaPmaxPct = -0.35,
    this.maxSeriesFuseA,
  });

  /// Potencia máxima en STC (W).
  final double pmaxW;

  /// Tensión de circuito abierto en STC (V).
  final double vocV;

  /// Corriente de cortocircuito en STC (A).
  final double iscA;

  /// Tensión en el punto de máxima potencia en STC (V).
  final double vmpV;

  /// Corriente en el punto de máxima potencia en STC (A).
  final double impA;

  /// Coeficiente de Voc (%/°C).
  final double betaVocPct;

  /// Coeficiente de Vmp (%/°C).
  final double betaVmpPct;

  /// Coeficiente de Pmax (%/°C).
  final double gammaPmaxPct;

  /// Fusible máximo en serie de la hoja de datos (A), si se conoce.
  final double? maxSeriesFuseA;
}

/// Entrada DC de un inversor (o de un microinversor/optimizador).
class StringInverter {
  /// Crea el inversor.
  const new({
    required this.pacW,
    required this.vdcMaxV,
    required this.mpptMinV,
    required this.mpptMaxV,
    required this.mpptCount,
    required this.imaxPerMpptA,
    this.iscMaxPerMpptA,
  });

  /// Potencia AC nominal (W).
  final double pacW;

  /// Tensión DC máxima de entrada (V).
  final double vdcMaxV;

  /// Tensión mínima del rango MPPT (V).
  final double mpptMinV;

  /// Tensión máxima del rango MPPT (V).
  final double mpptMaxV;

  /// Número de entradas MPPT.
  final int mpptCount;

  /// Corriente máxima de entrada por MPPT (A).
  final double imaxPerMpptA;

  /// Corriente de cortocircuito máxima por MPPT (A), si la hoja la da.
  final double? iscMaxPerMpptA;
}

/// Temperaturas de diseño del sitio (°C): la mínima registrada y la máxima
/// del ambiente (decisión del dueño: las más extremas de NASA y PVGIS).
typedef StringTemperatures = ({double minAmbientC, double maxAmbientC});
