# 03 · Irradiancia extraterrestre, masa de aire y presión

**Qué calcula:** cuánta energía solar llega al tope de la atmósfera (varía ±3 % en el año porque la órbita es elíptica), cuánta atmósfera atraviesa el rayo (masa de aire) y la presión a la altitud del sitio.

**Código:** `packages/solar_engine/lib/src/irradiance/atmosphere.dart`.

## Ecuaciones
- Extraterrestre normal (Spencer, 1971): I₀ = 1366.1·(1.00011 + 0.034221·cos B + 0.00128·sin B + 0.000719·cos 2B + 0.000077·sin 2B), con B = 2π·(n − 1)/365 y n = día del año.
- Extraterrestre horizontal: I₀h = I₀·cos θz (0 de noche).
- Masa de aire relativa (Kasten y Young, 1989): AM = 1 / (cos θz + 0.50572·(6.07995 + 90 − θz)^−1.6364). Sin definir si θz > 90°.
- Presión estándar: P = 100·((44 331.514 − h)/11 880.516)^(1/0.1902632) Pa.

| Variable | Unidad |
|---|---|
| I₀, I₀h | W/m² |
| θz | grados |
| h | m |
| P | Pa |

## Fuente
Spencer, J. W. (1971), *Search* 2(5):172. Kasten, F. y Young, A. T. (1989), *Applied Optics* 28:4735. Igual que pvlib (`get_extra_radiation`, `get_relative_airmass`, `alt2pres`).

## Caso de prueba (pvlib)
- I₀: día 1 → **1413.98 W/m²**; día 172 → **1321.62 W/m²**.
- AM: θz = 60° → **1.99429**; θz = 85° → **10.3058**.
- P: 2240 m (CDMX) → **77 155.1 Pa**.

**Prueba:** `test/irradiance/formulas_golden_test.dart`.
