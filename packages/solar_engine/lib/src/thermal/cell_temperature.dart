/// Modelos de temperatura de celda.
/// Ficha: docs/formulas/07-temperatura-de-celda.md
sealed class CellTemperatureModel {
  const new();

  /// Temperatura de celda (°C) para irradiancia en el plano [poaGlobal]
  /// (W/m²), temperatura ambiente [tempAir] (°C) y viento [windSpeed] (m/s).
  double cellTemperature(double poaGlobal, double tempAir, double windSpeed);
}

/// Modelo de Faiman (2008), usado por PVsyst e IEC 61853-2:
/// Tc = Ta + POA/(U0 + U1·v). Igual que `pvlib.temperature.faiman`.
class FaimanModel extends CellTemperatureModel {
  /// Crea el modelo; valores por defecto de pvlib.
  const new({this.u0 = 25.0, this.u1 = 6.84});

  /// Coeficiente de pérdida de calor constante U0 (W/m²·K).
  final double u0;

  /// Coeficiente de pérdida de calor por viento U1 (W·s/m³·K).
  final double u1;

  @override
  double cellTemperature(double poaGlobal, double tempAir, double windSpeed) =>
      tempAir + poaGlobal / (u0 + u1 * windSpeed);
}

/// Modelo NOCT simple (Ross, 1980): Tc = Ta + (NOCT − 20)/800·POA.
/// No usa el viento. Igual que `pvlib.temperature.ross` con `noct`.
class NoctModel extends CellTemperatureModel {
  /// Crea el modelo; [noct] en °C (típico 42–48 °C, de la hoja de datos).
  const new({this.noct = 45});

  /// Temperatura nominal de operación de la celda (°C).
  final double noct;

  @override
  double cellTemperature(double poaGlobal, double tempAir, double windSpeed) =>
      tempAir + (noct - 20.0) / 800.0 * poaGlobal;
}
