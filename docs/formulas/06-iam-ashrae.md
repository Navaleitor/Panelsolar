# 06 · Modificador del ángulo de incidencia (IAM, ASHRAE)

**Qué calcula:** cuando el Sol pega muy de lado, el vidrio del panel refleja más luz. El IAM es la fracción de la luz directa que sí entra.

**Código:** `packages/solar_engine/lib/src/optics/iam.dart`.

## Ecuación
IAM = 1 − b₀·(1/cos θ − 1), con b₀ = 0.05. Si θ ≥ 90° o el resultado es negativo, IAM = 0.

Irradiancia efectiva: E_ef = POA_directa·IAM + POA_difusa (como pvlib ModelChain).

| Variable | Unidad |
|---|---|
| θ | grados |
| b₀, IAM | adimensional |

## Fuente
Souka, A. F. y Safwat, H. H. (1966), *Solar Energy* 10(4):170-174 (modelo adoptado por ASHRAE 93-77). Igual que `pvlib.iam.ashrae`.

## Caso de prueba (pvlib)
θ = 60° → **0.95**; θ = 80° → **0.76206**; θ = 87° → **0.09463**; θ = 95° → **0**.

**Prueba:** `test/irradiance/formulas_golden_test.dart` (casos `iam_ashrae`).
