# 01 · Posición solar (NREL SPA)

**Qué calcula:** dónde está el Sol en el cielo, visto desde el sitio, en un instante dado: qué tan alto (cenit o elevación) y hacia qué dirección (azimut).

**Código:** `packages/solar_engine/lib/src/position/spa.dart` (tablas en `spa_earth_terms.dart`, `spa_nutation_terms.dart`; ΔT en `delta_t.dart`).

## Ecuación (resumen)
El algoritmo NREL SPA sigue 15 pasos astronómicos:
1. Día juliano JD a partir de la hora UTC; JDE = JD + ΔT/86 400 (ΔT = diferencia entre el tiempo de la Tierra y el atómico, ≈ 69–75 s hoy).
2. Posición de la Tierra alrededor del Sol (longitud L, latitud B, distancia R) con sumas de cosenos A·cos(B + C·JME).
3. Nutación (bamboleo del eje) Δψ, Δε y oblicuidad ε.
4. Aberración, longitud aparente λ, ascensión recta α y declinación δ del Sol.
5. Ángulo horario H con el tiempo sidéreo y la longitud del sitio.
6. Paralaje (el observador no está en el centro de la Tierra) → δ′, H′.
7. Elevación sin atmósfera e₀ = asin(sin φ·sin δ′ + cos φ·cos δ′·cos H′).
8. Refracción: Δe = (P/1010)·(283/(273 + T))·1.02 / (60·tan(e₀ + 10.3/(e₀ + 5.11))).
9. **Cenit aparente** θz = 90° − (e₀ + Δe); **azimut** γs = atan2(sin H′, cos H′·sin φ − tan δ′·cos φ) + 180°.

| Variable | Unidad | Nota |
|---|---|---|
| φ, longitud | grados | norte y este positivos |
| altitud | m | |
| P | hPa | presión estándar a la altitud del sitio |
| T | °C | 12 °C (promedio), solo afecta la refracción |
| θz, γs | grados | azimut desde el norte, sentido horario (180 = sur) |

## Fuente
Reda, I. y Andreas, A. (2004). *Solar Position Algorithm for Solar Radiation Applications*. NREL/TP-560-34302. Error declarado ±0.0003°. ΔT: polinomios de Espenak y Meeus (NASA).

## Supuestos y límites
- ΔT se estima por polinomio desde 1900; antes se usa la parábola de largo plazo (sin efecto práctico para FV).
- En la simulación horaria se evalúa a la mitad del intervalo del dato (ver ficha 12).

## Caso de prueba
- Ejemplo del artículo (17-oct-2003 12:30:30, UTC−7, Golden, Colorado, φ = 39.742476°, λ = −105.1786°, 1830.14 m, 820 hPa, 11 °C, ΔT = 67 s): **cenit 50.11162°, azimut 194.34024°**. El motor da lo mismo con error < 0.00001°.
- 2 286 instantes en los 6 sitios contra pvlib 0.16.1: error máximo **5×10⁻⁹°** (tolerancia del plan: 0.01°).

**Prueba:** `packages/solar_engine/test/position/spa_test.dart`.
