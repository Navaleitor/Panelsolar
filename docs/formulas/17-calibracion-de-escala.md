# 17 · Calibración de escala y marco de la imagen

**Qué calcula:** cuántos metros mide un píxel de la imagen del techo que importó el usuario, la diferencia de una línea de verificación y cómo pasar de píxeles a metros locales con el norte girado.

**Código:** `packages/geo_kit/lib/src/roof/scale_calibration.dart`, `image_frame.dart`.

## Ecuaciones
- Escala: m/px = L_real / L_px, con L_px = distancia en píxeles de la línea trazada. Se exige L_px ≥ 20 px.
- Verificación: Δ% = (L_px,2 · m/px − L_real,2) / L_real,2 × 100. Si |Δ| > 5 % se avisa (imagen inclinada o medida errónea).
- Píxel (u, v) → local (x este, y norte), con norte a θ grados (horario desde arriba de la imagen) y origen (u₀, v₀) al centro:
  r = (u − u₀)·s, f = −(v − v₀)·s;  x = r·cos θ − f·sin θ;  y = r·sin θ + f·cos θ.
- Norte con brújula: si una línea tiene rumbo φ en la imagen y la brújula marca azimut verdadero A, θ = φ − A.

| Variable | Unidad |
|---|---|
| s = m/px | m/píxel |
| θ | grados |

## Supuestos
Imagen cenital (vista desde arriba) sin distorsión. Error típico ±2–5 % (ADR-005). Al recalibrar o girar el norte, lo dibujado se mueve con la imagen (`app/.../domain/reframe.dart`).

## Casos de prueba
| Caso | Esperado |
|---|---|
| 400 px = 10 m | 0.025 m/px |
| Verificación 200 px a 0.025 con cinta 4.854 m | +3.0 % |
| Norte 90°: arriba de la imagen | apunta al oeste |
| Línea con rumbo 90° y brújula 120° | θ = 330° |
| Aceptación: techo 12 × 9 m con toques imprecisos | área dentro de ±5 % |

**Pruebas:** `packages/geo_kit/test/roof_calibration_test.dart`; aceptación `app/test/features/roof/roof_editor_test.dart`.
