# Seguimiento de producción: índice real/esperado y Performance Ratio

- **Dónde**: `app/lib/features/production/domain/performance.dart` (F6).
- **Prueba**: `app/test/features/production/performance_test.dart`.
- **Fuente**: IEC 61724-1:2021, sección 10 (Performance Ratio).

## Ecuaciones
- Índice de rendimiento: *I* = *E_real* / *E_esperada* (adimensional; 1 = lo esperado).
- Desviación: *Δ* = (*I* − 1) × 100 [%].
- Alerta si *Δ* < umbral (por omisión −15 %, editable por proyecto).
- Performance Ratio simple: *PR* = *E_real* / (*P₀* · *H_POA* / *G_STC*), con *E* en kWh, *P₀* potencia pico en kWp, *H_POA* irradiación del mes en el plano de los paneles en kWh/m² y *G_STC* = 1 kW/m².

## Supuestos y límites
- *E_esperada* hoy se captura a mano (del reporte de diseño o de PVGIS). Cuando F2 esté integrado, `ExpectedProductionSource` la calculará (y *H_POA*) sin cambiar pantallas.
- El PR solo se muestra si hay kWp (ajustes del proyecto) e irradiación del mes. Un PR típico de un sistema sano está entre 75 % y 85 %.
- Sin corrección por temperatura (PR "simple", no el PR corregido de IEC 61724-1).

## Caso de prueba
5 kWp, *H_POA* = 150 kWh/m², *E_real* = 600 kWh → *PR* = 600 / (5 × 150) = 0.80.
*E_esperada* = 700 kWh, *E_real* = 595 kWh → *Δ* = −15 % (justo en el umbral: sin alerta); 594 kWh → alerta.
