# 26 · Carga de viento sobre paneles (ASCE 7-22, indicativo)

**Qué calcula:** la presión del viento sobre los paneles y la fuerza que debe resistir cada anclaje (plan B.6 punto 17). **Siempre indicativo: requiere validación estructural.**

**Código:** `packages/solar_engine/lib/src/design/wind/wind_pressure.dart`. Velocidades regionales de México: `packages/regional_packs/lib/src/mx/wind_speeds.dart`.

## Ecuaciones
- Presión de velocidad: qz = 0.613·Kz·Kzt·Kd·Ke·V² (N/m², V en m/s, ráfaga de 3 s a 10 m).
- Kz = 2.41·(z/zg)^(2/α) (tabla 26.10-1), con z ≥ 4.6 m (≥ 9.1 m en exposición B). Constantes (tabla 26.11-1): B α = 7.5, zg = 1000 m; C α = 9.8, zg = 750 m; D α = 11.5, zg = 590 m.
- Ke = e^(−0.000119·zₑ) (tabla 26.9-1), zₑ altitud del sitio en m.
- Kzt = 1 (terreno plano), Kd = 0.85.
- Presión neta: p = qz·GCrn. Por defecto GCrn = −1.5 (succión; panel paralelo al techo, zona interior). Es editable porque depende de la zona del techo (orillas y esquinas más), del área y de la separación con el techo (ASCE 7-22 29.4).
- Fuerza por anclaje: F = |p|·área tributaria.
- México: la velocidad regional sale del **Manual de Diseño de Obras Civiles CFE – Diseño por Viento (2020)**; la app trae valores de referencia por ciudad que el instalador **debe verificar y puede editar**.

## Caso de prueba
| Caso | Esperado |
|---|---|
| Exposición C a 10 m | Kz ≈ 1.00 |
| Monterrey, 540 m | Ke ≈ 0.938 |
| V = 40 m/s, C, 10 m, nivel del mar | qz ≈ 834 Pa; p = −1 251 Pa |
| 0.8 m² por anclaje | F ≈ 1 000 N |

**Pruebas:** `packages/solar_engine/test/design/wind_test.dart`.
