# 29 · Máximo de paneles en un plano

**Qué calcula:** cuántos paneles caben en cada plano útil del techo y dónde van, probando orientación vertical u horizontal y desplazamientos de la rejilla, y se queda con el arreglo que da **más energía**, no solo más paneles (plan B.6 punto 13).

**Código:** `packages/geo_kit/lib/src/layout/panel_packer.dart` (+ `region_tests.dart`). Orquestación en la app: `app/lib/features/design/domain/array_planner.dart`.

## Procedimiento
1. **Plano útil** = polígono del plano − retiro de borde (`PolygonOps.inset`) − obstáculos (huella + holgura de mantenimiento) − pasillos (franjas). Datos de F3.
2. **Ejes del plano:** las filas corren perpendiculares al azimut (horizontal, paralelas al alero); "arriba" es cuesta arriba.
3. **Medidas en planta** de un panel de ancho W y largo L, separación s entre paneles y r entre filas:
   - Techo inclinado β (paneles pegados al techo): vertical → a = W, b = L·cos β; horizontal → a = L, b = W·cos β; paso de fila = b + r·cos β.
   - Techo plano con estructura inclinada β_e: igual con β_e, y el paso de fila sale de la **separación entre filas** (ficha 23).
4. **Rejilla:** se prueban 4 × 4 desplazamientos (fracciones del paso) y, en cada fila, una variante que corre cada panel al primer lugar libre (pasos de 5 cm). Un panel entra si sus 4 esquinas están dentro del plano útil y no toca ninguna exclusión (con 1 mm de tolerancia).
5. **Puntaje:** Σ (1 − pérdida por sombra del mapa de calor de F3 en el centro del panel). Los paneles que superan el umbral de sombra (10 %) valen 0. Se comparan ambas orientaciones.

## Casos de prueba
| Caso | Esperado |
|---|---|
| Techo 10 × 8 m, panel 1.1 × 2.2 m, 2 cm | vertical 8 × 3 = **24**; horizontal 4 × 7 = **28** |
| Plano al este | filas norte–sur, 24 paneles |
| Tinaco en medio | menos paneles, ninguno encima |
| Techo en L | ningún panel en el hueco |

**Pruebas:** `packages/geo_kit/test/panel_packer_test.dart`, `app/test/features/design/array_planner_test.dart`.
