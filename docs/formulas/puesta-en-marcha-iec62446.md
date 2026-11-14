# Puesta en marcha: comparación de Voc/Isc y aislamiento (IEC 62446-1)

- **Dónde**: `app/lib/features/installation/domain/commissioning_evaluation.dart` (F6).
- **Prueba**: `app/test/features/installation/commissioning_evaluation_test.dart`.
- **Fuente**: IEC 62446-1:2016+A1:2018, cap. 6 (verificación de strings: Voc, Isc, polaridad; resistencia de aislamiento, tabla de valores mínimos).

## Ecuaciones
- Desviación de una medición: *Δ* = (medido − esperado) / esperado × 100 [%].
- Voc correcto si |*Δ*| ≤ 5 %. Isc correcto si |*Δ*| ≤ 10 % (la Isc depende de la irradiancia del momento; si se mide con poca luz, se corrige el esperado: *Isc_esp* = *Isc_STC* · *G* / 1000).
- Aislamiento correcto si *R_iso* ≥ 1 MΩ (sistemas de 120 V a 1500 V; tensión de prueba 500 V hasta 500 V de sistema y 1000 V arriba).

Unidades: V, A, MΩ, Ω. Los valores esperados los escribe el instalador (hoja de datos o diseño); F4 podrá llenarlos solos.

## Estado sugerido
- **Observaciones** si cualquier revisión falla (aunque falten otras).
- **Pendiente** si falta algún dato o no hay strings.
- **Aprobado** si todo está medido y dentro de tolerancia.
El instalador elige el estado final; la app solo sugiere.

## Caso de prueba
String S1: Voc esperado 400 V, medido 380 V → *Δ* = −5.0 % → correcto. Medido 379 V → −5.25 % → fuera. Isc esperado 10 A, medido 8.9 A → −11 % → fuera. Aislamiento 0.8 MΩ → fuera.
