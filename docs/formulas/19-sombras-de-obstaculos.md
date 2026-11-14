# 19 · Sombras de obstáculos, horizonte y mapa de calor

**Qué calcula:** la sombra de tinacos, antenas, pretiles, árboles y edificios sobre el techo a cualquier fecha y hora, el horizonte combinado (terreno + obstáculos lejanos) y el % anual de sol directo perdido en cada punto del techo (plan B.6 punto 12, B.7, B.7.1).

**Código:** `packages/solar_engine/lib/src/shading/` (`shadow_caster.dart`, `horizon_builder.dart`, `sun_samples.dart`, `shade_heatmap.dart`). Huellas: `packages/geo_kit/lib/src/roof/obstacle_footprint.dart`, catálogo `obstacle_catalog.dart`.

## Ecuaciones
- Techo plano: largo de sombra L = h / tan α; dirección opuesta al Sol: Δ = (−L·sin γs, −L·cos γs) (este, norte).
- Techo inclinado (β, azimut de bajada γ): vector al Sol s = (sin γs cos α, cos γs cos α, sin α); u = (sin γ, cos γ).
  t = h / (s_z + tan β·(s_xy·u));  Δ = −t·s_xy. Si el denominador ≤ 0 el Sol está detrás del plano.
- Polígono de sombra = envolvente convexa de la huella y la huella desplazada (exacto para huellas convexas).
- Horizonte combinado: en cada azimut (paso 1°), el máximo entre el terreno PVGIS y los obstáculos lejanos (interpolados entre sus puntos; fuera de su rango no tapan).
- Muestras del año: un día cada 7 días, cada 30 min; peso w = DNI_despejado · cos θ (incidencia sobre el plano), DNI de Meinel: 1353 · 0.7^(AM^0.678).
- Pérdida de la celda = Σ w·[sombra u horizonte] / Σ w. Rejilla de 0.25 m (máx. 2 500 celdas por plano en la app).

## Supuestos y límites
Obstáculos como prismas verticales con altura sobre el techo en su base. Solo componente directa (la difusa y el efecto eléctrico por diodos se calculan en F4). Huellas no convexas se aproximan por su envolvente.

## Casos de prueba
| Caso | Esperado |
|---|---|
| Objeto 1 m, Sol a 45° | sombra 1 m |
| Monterrey, tinaco 1.7 m, 21 dic 12:00 solar (40.9°) | 1.97 m al norte |
| Monterrey, 21 dic 9:00 solar (24.3°) | 3.77 m al noroeste |
| Monterrey, 21 jun 12:00 solar (87.8°) | 0.07 m |
| Ecuador, mediodía de equinoccio | < 0.012 m |
| Plano 30° al sur, Sol al sur a 60°, h = 1 | 0.433 m cuesta arriba |
| Sin obstáculos / horizonte a 90° | 0 % / 100 % |
| Cubo de escalera al sur | más pérdida junto a él y en diciembre que en junio |

**Pruebas:** `packages/solar_engine/test/shading/`; `app/test/features/roof/roof_domain_test.dart`.
