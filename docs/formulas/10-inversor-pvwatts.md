# 10 · Inversor (curva PVWatts con recorte)

**Qué calcula:** cuánta potencia en corriente alterna sale del inversor. La eficiencia cambia con la carga y, si el arreglo da más de lo que el inversor soporta, el excedente se pierde (recorte o *clipping*).

**Código:** `packages/solar_engine/lib/src/power/pvwatts_inverter.dart`.

## Ecuación
- Pdc₀ = Pac,máx/ηnom (límite de entrada DC)
- ζ = Pdc/Pdc₀
- η = (ηnom/0.9637)·(−0.0162·ζ − 0.0059/ζ + 0.9858)
- Pac = min(η·Pdc, Pac,máx), nunca negativa.
- Energía recortada = Σ (η·Pdc − Pac) cuando η·Pdc > Pac,máx.

| Variable | Unidad |
|---|---|
| Pdc, Pac, Pac,máx | W |
| ηnom | adimensional (hoja de datos, p. ej. 0.96) |

Relación DC/AC recomendada: 1.1–1.35 (`PvSystem.dcAcRatio`).

## Fuente
Dobos (2014), *PVWatts Version 5 Manual*, ec. 11. Igual que `pvlib.inverter.pvwatts`.

## Caso de prueba (pvlib)
Pac,máx = 5000 W, ηnom = 0.96: Pdc = 3000 W → **2887.55 W**; Pdc = 5200 W → **4992.09 W**; Pdc = 7000 W → **5000 W** (recorta).

**Pruebas:** `test/irradiance/formulas_golden_test.dart` (casos `inverter_pvwatts`), `test/power/power_test.dart`.
