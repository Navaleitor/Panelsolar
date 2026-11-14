# 07 · Temperatura de celda (Faiman y NOCT)

**Qué calcula:** qué tan caliente está la celda solar. Un panel caliente produce menos (ficha 08), por eso importa mucho en Monterrey o Hermosillo.

**Código:** `packages/solar_engine/lib/src/thermal/cell_temperature.dart`.

## Ecuaciones
- **Faiman (principal):** Tc = Ta + POA/(U₀ + U₁·v), con U₀ = 25 W/m²K y U₁ = 6.84 W·s/m³K.
- **NOCT (alternativa):** Tc = Ta + (NOCT − 20)/800·POA, con NOCT de la hoja de datos (típico 45 °C). No usa el viento.

| Variable | Unidad |
|---|---|
| Tc, Ta, NOCT | °C |
| POA | W/m² |
| v (viento) | m/s (NASA y PVGIS dan viento a 10 m) |

## Fuente
Faiman, D. (2008), *Progress in Photovoltaics* 16:307-315 (modelo de PVsyst e IEC 61853-2). Ross, R. G. (1980), *14th IEEE PVSC*. Igual que `pvlib.temperature.faiman` y `ross`.

## Caso de prueba (pvlib)
POA = 800 W/m², Ta = 30 °C, v = 2 m/s: **Faiman 50.68 °C**, **NOCT 55.00 °C**.

**Prueba:** `test/irradiance/formulas_golden_test.dart` (casos `faiman`, `ross_noct45`).
