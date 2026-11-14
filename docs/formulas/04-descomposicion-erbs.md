# 04 · Descomposición de Erbs (directa y difusa a partir de la global)

**Qué calcula:** si una fuente solo trae la irradiancia global horizontal (GHI), estima cuánto es directo (DNI, del disco solar) y cuánto difuso (DHI, del resto del cielo).

**Código:** `packages/solar_engine/lib/src/irradiance/erbs.dart`. El simulador la usa cuando faltan DNI o DHI.

## Ecuación
Índice de claridad: kt = GHI / (I₀·max(cos θz, 0.065)), limitado a [0, 1].

Fracción difusa DF:
- kt ≤ 0.22: DF = 1 − 0.09·kt
- 0.22 < kt ≤ 0.80: DF = 0.9511 − 0.1604·kt + 4.388·kt² − 16.638·kt³ + 12.336·kt⁴
- kt > 0.80: DF = 0.165

DHI = DF·GHI; DNI = (GHI − DHI)/cos θz. Si θz > 87°: DNI = 0 y DHI = GHI.

| Variable | Unidad |
|---|---|
| GHI, DNI, DHI, I₀ | W/m² |
| kt, DF | adimensional |

## Fuente
Erbs, D. G., Klein, S. A. y Duffie, J. A. (1982). *Solar Energy* 28(4):293-302. Igual que `pvlib.irradiance.erbs`.

## Caso de prueba (pvlib)
| GHI | θz | día | DNI | DHI | kt |
|---|---|---|---|---|---|
| 600 | 40° | 172 | **426.27** | **273.46** | **0.5926** |
| 950 | 15° | 200 | **798.29** | **178.91** | **0.7441** |
| 400 | 88° | 10 | **0** | **400** | 1 |

**Prueba:** `test/irradiance/formulas_golden_test.dart` (casos `erbs_*`).
