# 25 · Protecciones y puesta a tierra

**Qué calcula:** qué protecciones lleva el sistema y de qué tamaño: fusibles de string, desconectador de CD, DPS (supresores) en CD y CA, interruptor de CA y conductor de puesta a tierra (plan B.6 punto 16).

**Código:** `packages/solar_engine/lib/src/design/electrical/protections.dart`. Capacidades comerciales y tabla de tierra: `packages/regional_packs/lib/src/mx/nom_protections.dart`.

## Reglas
- **Fusibles de string:** solo si hay **más de 2 strings en paralelo** en una entrada. Capacidad ≥ 1.25 × 1.25 × Isc = 1.56·Isc, redondeada a la comercial siguiente, sin pasar el fusible máximo en serie del panel. Uno en positivo y otro en negativo por string.
- **Desconectador de CD:** ≥ 1.56·Isc × strings del inversor; tensión ≥ Voc máx del string con frío.
- **DPS en CD:** Ucpv ≥ 1.2 × Voc máx (IEC 61643-31).
- **Interruptor de CA:** ≥ 1.25 × Iac,máx del inversor, comercial siguiente.
- **DPS en CA:** Uc ≥ 1.1 × tensión de la red.
- **Conductor de tierra de equipos:** por la tabla 250-122 según la protección de CA.

## Fuentes
NOM-001-SEDE-2012 art. 240-6 (capacidades), 250-122 (tierra), 690-9 (sobrecorriente), 690-35; IEC 61643-31/-11.

## Caso de prueba
| Caso | Esperado |
|---|---|
| 3 strings en paralelo, Isc 9 A | fusibles 15 A (14.06 A), 6 piezas |
| 2 strings | sin fusibles |
| Inversor 22.7 A CA | interruptor 30 A, tierra 10 AWG |
| Voc máx 450 V | DPS CD ≥ 540 V |

**Indicativo, requiere revisión de un profesional.**

**Pruebas:** `packages/solar_engine/test/design/electrical_test.dart`.
