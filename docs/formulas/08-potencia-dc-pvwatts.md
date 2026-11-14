# 08 · Potencia DC (PVWatts)

**Qué calcula:** cuánta potencia en corriente directa entrega el arreglo según la luz efectiva y la temperatura de celda.

**Código:** `packages/solar_engine/lib/src/power/pvwatts_dc.dart`.

## Ecuación
Pdc = Pstc·(E_ef/1000)·[1 + γP·(Tc − 25)]

| Variable | Unidad | Nota |
|---|---|---|
| Pstc | W | potencia de placa del arreglo |
| E_ef | W/m² | ficha 06 |
| Tc | °C | ficha 07 |
| γP | 1/°C | de la hoja de datos, p. ej. −0.0035 (−0.35 %/°C) |

## Fuente
Dobos, A. P. (2014). *PVWatts Version 5 Manual*, NREL/TP-6A20-62641. Igual que `pvlib.pvsystem.pvwatts_dc`.

## Caso de prueba (pvlib)
Pstc = 5000 W, γP = −0.0035: E = 1000, Tc = 25 °C → **5000 W**; E = 800, Tc = 50 °C → **3650 W**; E = 200, Tc = 10 °C → **1052.5 W**.

**Prueba:** `test/irradiance/formulas_golden_test.dart` (casos `pvwatts_dc`) y `test/power/power_test.dart`.
