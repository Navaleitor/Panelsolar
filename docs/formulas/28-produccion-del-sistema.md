# 28 · Producción del sistema diseñado (primer año y 25 años)

**Qué calcula:** la energía que dará el sistema real (los paneles colocados, el inversor elegido, sombras y pérdidas) en el primer año y en su vida útil, la relación DC/AC y el recorte del inversor (plan B.6 puntos 8 y 9).

**Código:** `packages/solar_engine/lib/src/design/production/design_production.dart`. Usa la simulación horaria de la ficha 12 con el clima en caché del proyecto.

## Ecuaciones
- Potencia DC: Pdc = Σ paneles × Pmax (STC). Potencia AC: Pac = Σ inversores × Pac nominal.
- **Relación DC/AC** = Pdc / Pac; recomendada **1.1–1.35**.
- Cada grupo de paneles con la misma inclinación y azimut se simula con su parte del inversor: Pac,i = Pac·Pdc,i/Pdc (recorte proporcional).
- Pérdidas: desglose editable de la ficha 09 (suciedad, desajuste, cableado, conexiones, LID, placa, disponibilidad) con la **sombra calculada** (ficha 27, con el efecto eléctrico) en lugar del valor fijo.
- Primer año: E₁ = Σ grupos (año típico).
- Año n (1 = primero): Eₙ = E₁·(1 − d)^(n−1), d = degradación anual (0.5 %/año por defecto).
- 25 años: Σ Eₙ.
- Recorte anual = recorte de la serie × E_año / E_serie.

## Caso de prueba
10 paneles de 550 W y 5 kW en Monterrey (TMY): DC/AC = 1.10; rendimiento 1 500–2 100 kWh/kWp; PR 0.7–0.9; año 25 / año 1 = 0.995²⁴; 10 % de sombra → −10 % de energía; inversor de 3 kW → más recorte.

**Pruebas:** `packages/solar_engine/test/design/design_production_test.dart`.
