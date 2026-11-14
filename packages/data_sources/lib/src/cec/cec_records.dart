/// Tecnología de celda de un panel CEC.
enum CecTechnology {
  /// Monocristalino.
  mono,

  /// Policristalino.
  poly,

  /// Película delgada (CdTe, CIGS, a-Si).
  thinFilm,

  /// Otra.
  other,
}

/// Panel del catálogo público CEC (archivo de NREL SAM).
class CecModule {
  /// Crea el panel.
  const new({
    required this.name,
    required this.manufacturer,
    required this.technology,
    required this.bifacial,
    required this.pmaxW,
    required this.vocV,
    required this.iscA,
    required this.vmpV,
    required this.impA,
    required this.betaVocPct,
    required this.alphaIscPct,
    required this.gammaPmaxPct,
    required this.lengthM,
    required this.widthM,
    required this.cells,
  });

  /// Nombre completo ("Marca Modelo").
  final String name;

  /// Fabricante.
  final String manufacturer;

  /// Tecnología.
  final CecTechnology technology;

  /// Bifacial.
  final bool bifacial;

  /// Pmax STC (W).
  final double pmaxW;

  /// Voc (V).
  final double vocV;

  /// Isc (A).
  final double iscA;

  /// Vmp (V).
  final double vmpV;

  /// Imp (A).
  final double impA;

  /// Coeficiente de Voc (%/°C) = β_oc / Voc × 100.
  final double betaVocPct;

  /// Coeficiente de Isc (%/°C) = α_sc / Isc × 100.
  final double alphaIscPct;

  /// Coeficiente de Pmax (%/°C).
  final double gammaPmaxPct;

  /// Largo (m; 0 si no viene).
  final double lengthM;

  /// Ancho (m; 0 si no viene).
  final double widthM;

  /// Celdas en serie.
  final int cells;

  /// Modelo sin el fabricante al inicio.
  String get model => name.startsWith(manufacturer)
      ? name.substring(manufacturer.length).trim()
      : name;

  /// Coeficiente de Vmp estimado (%/°C): γPmax − αIsc (Pmp = Vmp·Imp y
  /// Imp varía casi como Isc). La hoja CEC no lo trae.
  double get betaVmpPctEstimate => gammaPmaxPct - alphaIscPct;
}

/// Inversor del catálogo público CEC (modelo de Sandia en NREL SAM).
class CecInverter {
  /// Crea el inversor.
  const new({
    required this.name,
    required this.manufacturer,
    required this.model,
    required this.acVoltageV,
    required this.pacW,
    required this.pdcW,
    required this.vdcMaxV,
    required this.idcMaxA,
    required this.mpptMinV,
    required this.mpptMaxV,
  });

  /// Nombre completo ("Marca: Modelo {240V}").
  final String name;

  /// Fabricante (antes de ":").
  final String manufacturer;

  /// Modelo.
  final String model;

  /// Tensión AC (V).
  final double acVoltageV;

  /// Potencia AC nominal Paco (W).
  final double pacW;

  /// Potencia DC nominal Pdco (W).
  final double pdcW;

  /// Tensión DC máxima (V).
  final double vdcMaxV;

  /// Corriente DC máxima (A).
  final double idcMaxA;

  /// MPPT mínimo (V).
  final double mpptMinV;

  /// MPPT máximo (V).
  final double mpptMaxV;

  /// Eficiencia aproximada Paco / Pdco (%).
  double get efficiencyPct => pdcW <= 0 ? 96 : pacW / pdcW * 100;

  /// `true` si parece microinversor (≤ 1 kW).
  bool get isMicro => pacW <= 1000;
}
