# 16 · Polígonos del techo: lados, área, ángulos, imán, retiros y croquis

**Qué calcula:** las medidas de cada plano trazado: largo de cada lado, área, ángulo de cada esquina; ayuda a trazar esquinas rectas ("imán"); el retiro de borde; la división de un plano; el croquis a partir de medidas con cinta.

**Código:** `packages/geo_kit/lib/src/geometry/` (`polygon_metrics.dart`, `polygon_ops.dart`) y `lib/src/roof/` (`snapping.dart`, `tape_sketch.dart`). Área útil: `app/lib/features/roof/domain/plane_summary.dart`.

## Ecuaciones (coordenadas locales en metros: x = este, y = norte)
- Lado i: Lᵢ = √((xᵢ₊₁ − xᵢ)² + (yᵢ₊₁ − yᵢ)²).
- Área (fórmula del agrimensor): A = ½ |Σ (xᵢ·yᵢ₊₁ − xᵢ₊₁·yᵢ)|.
- Ángulo interior en el vértice i: ángulo entre (vᵢ₋₁ − vᵢ) y (vᵢ₊₁ − vᵢ) medido hacia el interior (0–360°; > 180° = esquina hacia adentro). Suma = (n − 2)·180°.
- Imán a 90°: si el nuevo lado forma con el anterior un ángulo a menos de 8° de un múltiplo de 90°, se gira a ese múltiplo conservando su largo. Imán a vértice: radio de 24 px en pantalla.
- Retiro d: cada lado se desplaza d hacia adentro (normal interior) y las esquinas se recalculan cruzando lados vecinos. Si un lado se invierte, el retiro no cabe.
- Croquis con cinta: se parte de (0,0) hacia el este; tras cada lado se gira θ a la izquierda (90° = esquina normal, −90° = hacia adentro). Error de cierre = distancia del último punto al inicio.
- Área útil = (área con retiro − pasillos − huellas de obstáculos) / cos β.

## Fuente
Geometría plana estándar (Bourke, *Calculating the area and centroid of a polygon*, 1988; Andrew, 1979, envolvente convexa).

## Casos de prueba
| Caso | Esperado |
|---|---|
| Rectángulo 10 × 8 | lados 10, 8, 10, 8; área 80 m²; ángulos 90° |
| "L" 10 × 8 menos 4 × 4 | 64 m², una esquina de 270° |
| Triángulo 3-4-5 | área 6 m², ángulo 36.87° |
| Retiro 0.5 m en 10 × 8 | 9 × 7 = 63 m² |
| Croquis 10, 8, 9.8, 8 con 90° | error de cierre 0.2 m |

**Pruebas:** `packages/geo_kit/test/polygon_test.dart`, `roof_planes_obstacles_test.dart`, `roof_calibration_test.dart` (imán); `app/test/features/roof/roof_domain_test.dart` (área útil).
