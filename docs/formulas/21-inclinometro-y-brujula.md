# 21 · Inclinómetro, brújula y altura con el teléfono

**Qué calcula:** la inclinación del techo con el teléfono apoyado, el rumbo y la elevación hacia donde apunta el teléfono, y la altura de un objeto midiendo un ángulo.

**Código:** `packages/geo_kit/lib/src/sensors/phone_orientation.dart`. Sensores: `sensors_plus` (BSD-3) en `app/lib/features/roof/data/sensors_plus_phone_sensors.dart`.

## Ecuaciones (ejes del teléfono: x derecha, y arriba de la pantalla, z hacia el usuario; acelerómetro a = vector "arriba")
- Inclinación de la superficie: β = atan2(√(aₓ² + a_y²), |a_z|).
- Elevación de una dirección d del teléfono (cámara: d = (0,0,−1)): e = asin(d · â).
- Brújula compensada: este E = m × â, norte N = â × Ê; azimut magnético = atan2(d·Ê, d·N). Con el teléfono acostado se usa el borde superior d = (0,1,0).
- Azimut verdadero = magnético + declinación (ficha 20).
- Altura: h = d·tan(a) + altura de ojos (plan B.7.1, opción c).

## Casos de prueba
| Caso | Esperado |
|---|---|
| Teléfono plano | 0° |
| Apoyado en techo de 30° | 30° |
| Cámara inclinada 40° hacia arriba | 40° |
| Punta al norte magnético, también inclinado 20° de lado | 0° |
| 10 m × tan 30° + 1.5 m | 7.27 m |

**Pruebas:** `packages/geo_kit/test/magnetic_sensors_test.dart`; en la app `app/test/features/roof/roof_editor_test.dart` (sensores falsos).
