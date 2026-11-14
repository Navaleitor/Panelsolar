/// Potencia DC del arreglo, modelo PVWatts (Dobos, 2014), igual que
/// `pvlib.pvsystem.pvwatts_dc`.
/// Ficha: docs/formulas/08-potencia-dc-pvwatts.md
///
/// Pdc = Pdc0·(Eef/1000)·[1 + γ·(Tc − Tref)]
///
/// - [effectiveIrradiance]: irradiancia efectiva Eef (W/m²) ya corregida por
///   IAM.
/// - [cellTemperature]: Tc (°C).
/// - [pdc0]: potencia nominal en condiciones STC (W).
/// - [gammaPdc]: coeficiente de temperatura de potencia (1/°C), p. ej.
///   −0.0035 para −0.35 %/°C.
/// - [tempRef]: temperatura de referencia (25 °C).
///
/// Devuelve W (nunca negativo).
double pvwattsDc({
  required double effectiveIrradiance,
  required double cellTemperature,
  required double pdc0,
  required double gammaPdc,
  double tempRef = 25,
}) {
  final p =
      effectiveIrradiance *
      0.001 *
      pdc0 *
      (1 + gammaPdc * (cellTemperature - tempRef));
  return p < 0 ? 0 : p;
}
