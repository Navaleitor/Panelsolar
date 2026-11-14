# 23 · Separación entre filas en techo plano

**Qué calcula:** la distancia libre entre filas de paneles inclinados (en estructura sobre techo plano) para que una fila no haga sombra a la siguiente en el peor día del año (plan B.6 punto 11).

**Código:** `packages/solar_engine/lib/src/design/layout/row_spacing.dart`.

## Ecuaciones
- Altura del borde superior: h = largo·sin β (largo = lado del panel que sube con la inclinación, m).
- Sombra en la dirección de la fila: L = h·cos(γs − γ) / tan α (α elevación y γs azimut del Sol; γ azimut de la fila). Si cos(γs − γ) ≤ 0 el Sol está detrás y L = 0.
- Separación d = máx L en el **solsticio de invierno** (21 dic en el norte, 21 jun en el sur) **entre las 9:00 y las 15:00 hora solar** (criterio estándar), cada 10 min. La hora solar se toma desde el mediodía solar real (máxima elevación, posición NREL SPA).
- Paso entre filas = largo·cos β + d. Cobertura del suelo GCR = largo / paso.

## Supuestos y límites
Filas largas y paralelas en un techo plano; no considera la pendiente del techo ni las sombras antes de las 9 h o después de las 15 h (se aceptan por norma de práctica).

## Fuentes
Plan maestro B.6 punto 11; Duffie & Beckman, *Solar Engineering of Thermal Processes*, cap. 1 (geometría solar); NREL SPA (ficha 01).

## Caso de prueba (de libro)
Monterrey (25.67 N, −100.31), panel de 2 m a 25° al sur → h = 0.845 m. A las 9:00 solar del 21 dic: δ = −23.45°, ω = −45° → α = 24.33°, azimut 134.6° → **d ≈ 1.31 m** (paso ≈ 3.12 m). Otros: h = 1 m con Sol al frente a 45° → d = 1 m; Sol a 45° de lado → 0.707 m.

**Pruebas:** `packages/solar_engine/test/design/row_spacing_test.dart`.
