# 05 · Irradiancia en el plano del panel (POA): Perez 1990 y Hay-Davies

**Qué calcula:** cuánta luz recibe el panel inclinado, sumando tres partes: la directa del Sol, la difusa del cielo y la reflejada por el suelo.

**Código:** `packages/solar_engine/lib/src/irradiance/poa.dart` y `sky_diffuse.dart`.

## Ecuación
POA = DNI·max(cos θ, 0) + E_cielo + GHI·ρ·(1 − cos β)/2

**Difusa del cielo, Perez 1990 (modelo principal):**
E_cielo = DHI·[(1 − F1)·(1 + cos β)/2 + F1·a/b + F2·sin β]
- a = max(0, cos θ); b = max(cos 85°, cos θz)
- Claridad ε = ((DHI + DNI)/DHI + 1.041·θz³)/(1 + 1.041·θz³) (θz en radianes) → define uno de 8 intervalos.
- Brillo Δ = DHI·AM/I₀
- F1 = max(0, f11 + f12·Δ + f13·θz); F2 = f21 + f22·Δ + f23·θz, con los coeficientes "allsitescomposite1990".

**Difusa del cielo, Hay-Davies (alternativa):**
E_cielo = DHI·[A·Rb + (1 − A)·(1 + cos β)/2], A = DNI/I₀, Rb = max(cos θ, 0)/max(cos θz, 0.01745).

| Variable | Unidad |
|---|---|
| DNI, DHI, GHI, I₀, POA | W/m² |
| ρ (albedo) | 0–1 (NASA POWER; si falta, 0.2) |
| β, θ, θz | grados |

Convención del motor: si el Sol está bajo el horizonte (θz ≥ 90°) la directa y la difusa del cielo valen 0.

## Fuente
Perez, R., Ineichen, P., Seals, R., Michalsky, J. y Stewart, R. (1990). *Solar Energy* 44(5):271-289. Hay, J. E. y Davies, J. A. (1980), *Proc. First Canadian Solar Radiation Data Workshop*. Igual que `pvlib.irradiance.perez` y `haydavies`.

## Caso de prueba (pvlib)
β = 30°, γ = 180°, DHI = 120, DNI = 700, I₀ = 1400 W/m², θz = 35°, γs = 170°: **Perez 147.98 W/m²**, **Hay-Davies 128.63 W/m²**.
Golden horario en 6 sitios (2 sistemas, 5 300 horas): diferencia máxima de POA contra pvlib **< 1×10⁻⁶ %** (tolerancia del plan: 1 %).

**Pruebas:** `test/irradiance/formulas_golden_test.dart`, `test/simulation/golden_simulation_test.dart`.
