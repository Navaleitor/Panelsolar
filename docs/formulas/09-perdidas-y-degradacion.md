# 09 · Pérdidas del sistema y degradación

**Qué calcula:** las pérdidas "del mundo real" que el modelo físico no ve (polvo, cables, conexiones…), y cuánto pierde el panel cada año por envejecimiento.

**Código:** `packages/solar_engine/lib/src/power/losses.dart` (clase `SystemLosses`, editable).

## Ecuaciones
- Pérdida total (multiplicativa): L = 100·[1 − Π(1 − pᵢ/100)] %.
- Potencia después de pérdidas: P = Pdc·(1 − L/100).
- Degradación en el año de operación n (0 = primer año): f = (1 − d/100)ⁿ.

Valores por defecto (plan B.6 punto 8, %):

| Suciedad | Sombra | Nieve | Desajuste | Cableado DC | Conexiones | LID | Placa | Disponibilidad | Degradación anual |
|---|---|---|---|---|---|---|---|---|---|
| 2 | 0 (F4 la calcula) | 0 | 2 | 2 | 0.5 | 1.5 | 1 | 3 | 0.5 %/año |

## Fuente
Dobos (2014), *PVWatts Version 5 Manual*, sección 3.3. Igual que `pvlib.pvsystem.pvwatts_losses`.

## Caso de prueba
- Desglose por defecto: **11.418 %** de pérdida total (pvlib da 11.418207 %).
- Degradación 0.5 %/año: año 1 → 0.995; año 25 → **0.8822**.

**Pruebas:** `test/irradiance/formulas_golden_test.dart` (`losses_default`), `test/power/power_test.dart`.
