# 11 · Inclinación y azimut óptimos

**Qué calcula:** la inclinación y la dirección del panel que dan la mayor energía AC en el año, simulando de verdad cada opción (no la regla "inclinación = latitud", que solo se muestra como referencia).

**Código:** `packages/solar_engine/lib/src/optimization/orientation_optimizer.dart`.

## Método
1. Se preparan una sola vez los datos horarios que no dependen de la orientación (posición solar, extraterrestre, DNI/DHI) → cada simulación tarda milisegundos.
2. Búsqueda por **sección áurea** (cada paso descarta el 38 % del intervalo):
   - inclinación β ∈ [0°, 90°] mirando al ecuador (sur en el hemisferio norte, norte en el sur);
   - azimut γ ∈ ecuador ± 90° con esa inclinación;
   - de nuevo la inclinación con el nuevo azimut.
3. Precisión: 0.5° en inclinación y 1° en azimut; unas 40 simulaciones.

Objetivo: E(β, γ) = energía AC del año típico (ficha 12), con pérdidas, temperatura y recorte del inversor.

## Fuente
Kiefer, J. (1953), "Sequential minimax search for a maximum", *Proc. AMS* 4:502-506 (sección áurea). Criterio del plan maestro B.6 punto 10.

## Supuestos y límites
- La energía en función de (β, γ) es suave y con un solo máximo para un plano fijo sin sombras; con sombras (F4) podría haber máximos locales.
- En la app la búsqueda se hace con el TMY de PVGIS (8760 h) y la producción se informa con los 5 años de NASA.

## Caso de prueba
- Monterrey y Madrid (TMY): óptimo a menos de 12° de la latitud y a menos de 25° del sur; ninguna orientación vecina (±5° de inclinación, ±10° de azimut) produce más.
- Sitio del hemisferio sur: el óptimo mira al norte.
- Monterrey con datos reales (NASA 2021–2025 + TMY): **26.5° / 172°**, 1770 kWh/kWp.

**Prueba:** `test/simulation/sun_path_and_optimizer_test.dart`.
