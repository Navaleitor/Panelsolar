# 22 · Dimensionamiento de strings

**Qué calcula:** cuántos paneles se pueden poner en serie (un *string*) y cuántos strings en paralelo por entrada MPPT del inversor, sin pasar la tensión máxima con frío, sin caer bajo el MPPT con calor y sin pasar la corriente de la entrada (plan B.6 punto 14).

**Código:** `packages/solar_engine/lib/src/design/strings/` (`string_sizing.dart`, `string_design.dart`, `string_validation.dart`).

## Ecuaciones
- Valor a una temperatura: X(T) = X_STC·[1 + β/100·(T − 25)], β en %/°C (negativo).
- **Voc máximo** (frío): Voc,máx = Voc·[1 + βVoc·(Tmin − 25)]. Máximo en serie: N ≤ ⌊V_lím / Voc,máx⌋, con V_lím = mín(Vdc máx del inversor, 600 V de la norma en vivienda; editable a 1000/1500 V).
- **Vmp mínimo** (calor): Tc,máx = Tmax + 1000/(U0 + U1·1) = Tmax + 31.4 °C (Faiman, 1000 W/m², 1 m/s). Vmp,mín = Vmp·[1 + βVmp·(Tc,máx − 25)]. Mínimo en serie: N ≥ ⌈MPPT mín / Vmp,mín⌉.
- **Vmp con frío** (aviso): N·Vmp(Tmin) ≤ MPPT máx; si no, el inversor no sigue el punto óptimo en días fríos.
- **Corriente**: Isc·1.25·P ≤ Imax del MPPT (o Isc máx si la hoja la da) → P ≤ ⌊Imax / (1.25·Isc)⌋.
- Temperaturas: Tmin y Tmax más extremas de NASA POWER y PVGIS (`SiteDesignTemperatures.mostExtreme`, decisión del dueño 2026-11-14).

## Propuesta automática
Para cada N válido: strings = mín(⌊paneles/N⌋, inversores × MPPT × P). Se elige el N que conecta más paneles; a igualdad, el mayor N (menos corriente y cable). Los strings se reparten por igual entre las entradas. Con microinversores cada entrada lleva un panel. Todo es editable; cada cambio se vuelve a validar.

## Validaciones (en rojo = error, en ámbar = aviso)
| Código | Condición |
|---|---|
| `vocOverLimit` (error) | N·Voc,máx > V_lím |
| `vmpBelowMppt` (error) | N·Vmp,mín < MPPT mín |
| `vmpAboveMppt` (aviso) | N·Vmp(Tmin) > MPPT máx |
| `currentOverMppt` (error) | Σ P·1.25·Isc en la entrada > Imax |
| `mixedSeriesInMppt` (error) | strings de distinta longitud en la misma entrada |
| `invalidInput` (error) | inversor o MPPT inexistente |

## Fuentes
NOM-001-SEDE-2012 art. 690-7 y 690-8 (equivalentes a NEC 690.7 y 690.8); hojas de datos IEC 61215; modelo térmico Faiman (ficha 07).

## Caso de prueba (de libro)
Panel Voc 37.8 V, Vmp 31.0 V, Isc 9.0 A, βVoc −0.30 %/°C, βVmp −0.40 %/°C; inversor 600 V, MPPT 150–500 V, 12 A, 2 MPPT; Tmin −5 °C, Tmax 40 °C.

| Cálculo | Esperado |
|---|---|
| Voc a −5 °C | 37.8 × 1.09 = **41.20 V** → máx. **14** en serie (15 → 618 V, error) |
| Vmp a 71.4 °C | 31.0 × 0.8144 = **25.25 V** → mín. **6** en serie |
| Isc × 1.25 | 11.25 A ≤ 12 A → **1** string por MPPT |
| 20 paneles | 2 strings de 10 |

**Pruebas:** `packages/solar_engine/test/design/strings_test.dart`.
