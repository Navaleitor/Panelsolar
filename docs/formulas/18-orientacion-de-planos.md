# 18 · Orientación e inclinación de los planos

**Qué calcula:** el azimut (hacia dónde baja el agua) a partir de la arista elegida como alero, y las áreas y largos reales de un plano inclinado a partir de lo visto desde arriba.

**Código:** `packages/geo_kit/lib/src/roof/plane_orientation.dart`.

## Ecuaciones
- Azimut: normal hacia afuera de la arista a→b, d = b − a: n = (d_y, −d_x) si el polígono es antihorario (o el opuesto si es horario). γ = atan2(nₓ, n_y) en grados, 0–360 (0 = N, 90 = E, 180 = S).
- Área real: A = A_horizontal / cos β.
- Largo real de una arista que sube por la pendiente: L = L_h / cos β.

## Supuestos
La imagen muestra la proyección horizontal. La inclinación β la da el usuario o el inclinómetro (ficha 21).

## Casos de prueba
| Caso | Esperado |
|---|---|
| Rectángulo, alero = lado sur | 180° |
| Alero = lado este | 90° |
| 80 m² a 30° | 92.38 m² |

**Pruebas:** `packages/geo_kit/test/roof_planes_obstacles_test.dart`.
