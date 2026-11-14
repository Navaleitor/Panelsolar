# 24 · Caída de tensión y calibre mínimo

**Qué calcula:** cuántos volts se pierden en cada tramo de cable y el calibre más delgado que aguanta la corriente (ampacidad) y deja la caída dentro del límite (plan B.6 punto 15).

**Código:** `packages/solar_engine/lib/src/design/electrical/` (`voltage_drop.dart`, `conductor_selection.dart`). Tablas: `packages/regional_packs/lib/src/mx/nom_conductors.dart`.

## Ecuaciones
- Resistencia a la temperatura del conductor: R_T = R_75·[1 + α·(T − 75)], α = 0.00323 (Cu), 0.00330 (Al) 1/°C.
- DC y CA monofásica: ΔV = 2·L·I·R / 1000 (L en m, un sentido; I en A; R en Ω/km).
- CA trifásica: ΔV = √3·L·I·R / 1000.
- Caída % = ΔV / V × 100. Límites: **≤ 3 % por tramo** y **≤ 5 % en total**.
- Corriente para la ampacidad: DC del string **1.25 × 1.25 × Isc** (por irradiancia alta y por servicio continuo); CA a la salida del inversor **1.25 × Iac,máx**.
- Ampacidad corregida = ampacidad a 90 °C × factor de temperatura × factor por número de conductores, sin pasar la de 75 °C (temperatura de las terminales). Con tubo expuesto al sol en azotea se suma la temperatura de la tabla 310-15(b)(3)(c).
- Calibre mínimo: el primero (de menor sección) que cumple ampacidad y caída.

## Fuentes
NOM-001-SEDE-2012: tabla 310-15(b)(16) (ampacidades), 310-15(b)(2)(a) (temperatura), 310-15(b)(3)(a) (agrupamiento), 310-15(b)(3)(c) (azotea), capítulo 10 tabla 8 (resistencia); art. 690-8. Equivalente NEC 2011.

## Caso de prueba
| Caso | Esperado |
|---|---|
| DC 50 m, 20 A, 3.28 Ω/km | 6.56 V |
| Monofásica, lo mismo a 240 V | 2.73 % |
| String Isc 9 A, Imp 8.5 A, 300 V, 40 m | diseño 14.06 A; 14 AWG → 2.33 % |
| Igual a 80 m | 14 AWG 4.67 % ✗ → **12 AWG** 2.95 % ✓ |
| Salida CA 28.4 A con factor 0.82 | 10 AWG (35 × 0.82 = 28.7 A) |

**Indicativo, requiere revisión de un profesional (UVIE en México).**

**Pruebas:** `packages/solar_engine/test/design/electrical_test.dart`, `packages/regional_packs/test/nom_conductors_test.dart`.
