# 20 · Declinación magnética (World Magnetic Model 2025)

**Qué calcula:** cuántos grados se separa el norte de la brújula del norte verdadero en el sitio, para corregir la brújula del teléfono al orientar el techo y medir obstáculos lejanos.

**Código:** `packages/geo_kit/lib/src/magnetic/world_magnetic_model.dart`, coeficientes `wmm2025_coefficients.dart`.

## Ecuaciones (reporte técnico NOAA/BGS del WMM2025)
1. Geodésicas (φ, λ, h) → geocéntricas (WGS84): R_c = a/√(1 − e² sin²φ); p = (R_c + h) cos φ; z = (R_c(1 − e²) + h) sin φ; r = √(p² + z²); φ' = asin(z/r).
2. Coeficientes en el año t: g(t) = g + (t − 2025.0)·ġ, h(t) = h + (t − 2025.0)·ḣ.
3. Campo (grado 12, Legendre semi-normalizadas de Schmidt P̆ₙᵐ(sin φ'), a = 6371.2 km):
   X' = Σ (a/r)^(n+2) Σ (g cos mλ + h sin mλ) dP̆/dθ; Y' = (1/cos φ') Σ (a/r)^(n+2) Σ m (g sin mλ − h cos mλ) P̆; Z' = −Σ (n+1)(a/r)^(n+2) Σ (g cos mλ + h sin mλ) P̆.
4. Rotación a geodésicas con ψ = φ' − φ: X = X' cos ψ − Z' sin ψ; Z = X' sin ψ + Z' cos ψ.
5. Declinación D = atan2(Y, X) (positiva = al este).

Azimut verdadero = azimut magnético + D.

## Fuente y licencia
NOAA NCEI y British Geological Survey, *The US/UK World Magnetic Model for 2025–2030* (2024). Coeficientes `WMM.COF` del 13/11/2024, dominio público. Válido 2025.0–2030.0 (después se debe actualizar al WMM2030).

## Casos de prueba (tolerancia ±1°, valores redondeados de mapas NOAA 2026)
| Sitio | D |
|---|---|
| Boulder (40, −105) | +7.6° |
| Londres | +1.1° |
| Sídney | +12.8° |
| Phoenix | +9.7° |
| Monterrey | +4.4° |
| Bogotá | −8.7° |
Además: intensidad total entre 22 000 y 67 000 nT en todo el mundo; campo hacia abajo en el hemisferio norte.

**Prueba:** `packages/geo_kit/test/magnetic_sensors_test.dart`. Pendiente: comparar contra los valores oficiales de prueba del WMM2025 (no se pudieron descargar desde este entorno).
