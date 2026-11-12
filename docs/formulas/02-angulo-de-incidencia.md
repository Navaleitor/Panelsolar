# 02 · Ángulo de incidencia

**Qué calcula:** el ángulo θ entre los rayos del Sol y la perpendicular al panel. Con θ = 0° el Sol pega de frente; con θ ≥ 90° el Sol está detrás del panel.

**Código:** `packages/solar_engine/lib/src/irradiance/incidence.dart`.

## Ecuación
cos θ = cos β·cos θz + sin β·sin θz·cos(γs − γ)

| Variable | Unidad | Significado |
|---|---|---|
| β | grados | inclinación del panel (0 = horizontal) |
| γ | grados | azimut del panel (180 = mira al sur) |
| θz, γs | grados | cenit y azimut del Sol (ficha 01) |

El resultado se limita a [−1, 1] antes del arco coseno.

## Fuente
Duffie, J. A. y Beckman, W. A. (2013). *Solar Engineering of Thermal Processes*, 4.ª ed., ec. 1.6.3. Igual que `pvlib.irradiance.aoi`.

## Caso de prueba (pvlib)
| β | γ | θz | γs | θ esperado |
|---|---|---|---|---|
| 25° | 180° | 30° | 160° | **10.4381°** |
| 40° | 180° | 70° | 250° | **62.0572°** |
| 90° | 270° | 20° | 100° | **109.6835°** (Sol detrás) |

**Prueba:** `test/irradiance/formulas_golden_test.dart` (casos `aoi`) e `irradiance_test.dart`.
