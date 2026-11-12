# Consumo anual a partir de recibos de luz

- **Dónde**: `app/lib/features/utility_bills/domain/consumption_summary.dart` (F1).
- **Prueba**: `app/test/features/utility_bills/consumption_summary_test.dart`.

## Ecuación
Sea *R* el conjunto de recibos cuyo fin cae en los 365 días previos al fin del recibo más reciente. Para cada recibo *i*: energía *Eᵢ* (kWh) y días *dᵢ* = fin − inicio + 1 (ambos días incluidos).

- Consumo diario: *e* = Σ*Eᵢ* / Σ*dᵢ*  [kWh/día]
- Consumo anual: *E_año* = *e* · 365  [kWh/año]
- Promedio mensual: *E_mes* = *E_año* / 12  [kWh/mes]
- Gasto anual (solo recibos con importe *Cᵢ*, en centavos): Σ*Cᵢ* / Σ*dᵢ* · 365

## Supuestos y límites
- Normalizar por días permite mezclar recibos mensuales y bimestrales y periodos de duración irregular.
- Si Σ*dᵢ* < 350 días, el resultado es una **extrapolación** y la app lo advierte (no considera la estacionalidad, p. ej. el verano con aire acondicionado).
- Aviso DAC (CFE): *E_mes* > límite de alto consumo de la tarifa (p. ej. 250 kWh/mes en tarifa 1). CFE usa el promedio móvil de 12 meses; aquí se usa el último año de recibos capturados.

## Caso de prueba
6 recibos bimestrales de 600 kWh que cubren 2025 completo (365 días):
*e* = 3600 / 365 = 9.863 kWh/día → *E_año* = 3600 kWh → *E_mes* = 300 kWh (> 250: aviso DAC en tarifa 1).
