import 'dart:math' as math;

/// Categoría de exposición del terreno (ASCE 7-22, 26.7).
enum WindExposure {
  /// B: zonas urbanas y suburbanas.
  b,

  /// C: terreno abierto con obstáculos dispersos.
  c,

  /// D: costas y superficies planas sin obstáculos.
  d,
}

/// Datos del cálculo de viento.
class WindInput {
  /// Crea la entrada.
  const new({
    required this.basicSpeedMs,
    required this.heightM,
    required this.siteElevationM,
    this.exposure = WindExposure.c,
    this.kzt = 1,
    this.kd = 0.85,
    this.gcrn = -1.5,
    this.tributaryAreaM2 = 1,
  });

  /// Velocidad básica (ráfaga de 3 s a 10 m, m/s). En México se toma la
  /// velocidad regional del sitio (editable).
  final double basicSpeedMs;

  /// Altura media del techo z (m).
  final double heightM;

  /// Altitud del sitio sobre el nivel del mar (m).
  final double siteElevationM;

  /// Exposición.
  final WindExposure exposure;

  /// Factor topográfico Kzt (1 en terreno plano).
  final double kzt;

  /// Factor de direccionalidad Kd (0.85 para componentes).
  final double kd;

  /// Coeficiente neto de presión de los paneles (GCrn). Negativo = succión
  /// (levanta los paneles). Indicativo: depende de la zona del techo, el
  /// área y la separación del panel con el techo (ASCE 7-22, 29.4).
  final double gcrn;

  /// Área que toma cada anclaje (m²).
  final double tributaryAreaM2;
}

/// Resultado del viento.
class WindResult {
  /// Crea el resultado.
  const new({
    required this.kz,
    required this.ke,
    required this.qzPa,
    required this.netPressurePa,
    required this.forcePerAnchorN,
  });

  /// Coeficiente de exposición Kz.
  final double kz;

  /// Factor de elevación del terreno Ke.
  final double ke;

  /// Presión de velocidad qz (Pa = N/m²).
  final double qzPa;

  /// Presión neta p = qz·GCrn (Pa).
  final double netPressurePa;

  /// Fuerza por anclaje (N) = |p|·área tributaria.
  final double forcePerAnchorN;
}

/// Carga de viento indicativa sobre paneles en techo (B.6 punto 17).
/// Siempre requiere revisión estructural.
/// Ficha: docs/formulas/26-viento-asce-7-22.md
abstract final class WindPressure {
  /// Constantes α y zg (m) de ASCE 7-22, tabla 26.11-1.
  static ({double alpha, double zg}) terrain(WindExposure e) => switch (e) {
    WindExposure.b => (alpha: 7.5, zg: 3280 * 0.3048),
    WindExposure.c => (alpha: 9.8, zg: 2460 * 0.3048),
    WindExposure.d => (alpha: 11.5, zg: 1935 * 0.3048),
  };

  /// Kz = 2.41·(z/zg)^(2/α), con z mínima de 4.6 m (9.1 m en exposición B).
  static double kz(double heightM, WindExposure e) {
    final t = terrain(e);
    final zMin = e == WindExposure.b ? 30 * 0.3048 : 15 * 0.3048;
    final z = math.min(math.max(heightM, zMin), t.zg);
    return 2.41 * math.pow(z / t.zg, 2 / t.alpha).toDouble();
  }

  /// Ke = e^(−0.000119·zₑ), zₑ en metros sobre el nivel del mar.
  static double ke(double siteElevationM) =>
      math.exp(-0.000119 * math.max(0, siteElevationM));

  /// Cálculo completo: qz = 0.613·Kz·Kzt·Kd·Ke·V² (N/m², V en m/s) y
  /// p = qz·GCrn.
  static WindResult compute(WindInput i) {
    final kzV = kz(i.heightM, i.exposure);
    final keV = ke(i.siteElevationM);
    final qz =
        0.613 * kzV * i.kzt * i.kd * keV * i.basicSpeedMs * i.basicSpeedMs;
    final p = qz * i.gcrn;
    return WindResult(
      kz: kzV,
      ke: keV,
      qzPa: qz,
      netPressurePa: p,
      forcePerAnchorN: p.abs() * i.tributaryAreaM2,
    );
  }

  /// km/h → m/s.
  static double kmhToMs(double kmh) => kmh / 3.6;
}
