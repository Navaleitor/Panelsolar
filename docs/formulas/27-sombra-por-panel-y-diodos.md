# 27 · Sombra por panel, diodos bypass y vista de cielo

**Qué calcula:** cuánta energía pierde cada panel por sombras al año y por mes, con el efecto eléctrico de los diodos bypass y la luz difusa que tapan los obstáculos (plan B.7.1 pasos 4–6).

**Código:** `packages/solar_engine/lib/src/design/shading/` (`panel_shade.dart`, `panel_shade_calculator.dart`, `bypass_model.dart`, `sky_view.dart`). Reutiliza `ShadowCaster` y `SunSamples` (ficha 19).

## Paso 4 — sombra geométrica ponderada por la directa
Cada panel se divide en 3 secciones (una por diodo) a lo ancho y cada sección en 2 × 4 puntos de muestra. Para cada posición del Sol del año (un día cada 7, cada 30 min) con peso w = DNI de cielo despejado · cos θ:
- f = puntos en sombra / puntos del panel (o 1 si el horizonte tapa el Sol).
- Pérdida directa anual = Σ w·f / Σ w; mensual igual con las muestras de cada mes.

## Paso 6 — difusa y factor de vista de cielo
SVF = 1 − (1/N)·Σ sin²(e_máx), con N = 72 sectores de 5° y e_máx la mayor elevación (obstáculos u horizonte) vista desde el centro del panel; e = atan(h / distancia a la huella). Cielo isótropo sobre superficie horizontal. Con una parte difusa D (0.3 por defecto):
- Luz de una sección **con** sombra: g_s = D·SVF.
- Luz de una sección **sin** sombra: g_u = (1 − D) + D·SVF.

## Paso 5 — efecto eléctrico (3 diodos bypass)
Una sección con cualquier punto en sombra queda limitada a g_s. Las secciones en serie (de un panel o de todo un string) dan P = máx_c [c · (# secciones con g ≥ c)] / 3: el inversor escoge entre puentear las secciones sombreadas (con su diodo) o bajar la corriente de todas.
- **Microinversor u optimizador:** cada panel se calcula solo → solo pierde el panel afectado.
- **Inversor de string:** se calcula el string completo → un panel sombreado arrastra al resto.

## Colores y exclusión
Verde < 3 % (por defecto), amarillo entre 3 % y el umbral, rojo ≥ umbral (10 % por defecto, editable). Los rojos se excluyen del máximo de paneles.

## Supuestos y límites
Obstáculos como prismas (ficha 19). Las filas de estructura se modelan como un muro en la orilla alta de la fila de enfrente. La difusa es isótropa y se evalúa en el centro del panel.

## Casos de prueba
| Caso | Esperado |
|---|---|
| Sin obstáculos | 0 % |
| Horizonte a 90° | SVF = 0, pérdida 100 % |
| Muro de 1 m a 1 m | se ve a 45° |
| Franja de sombra abajo del panel (25 % del área) | panel solo pierde **100 %**; en string con otro sin sombra, el string pierde 50 % |
| Sombra en 1 de 3 secciones | panel pierde 1/3; string de 2 pierde 1/6 |
| Secciones [1, 1, 0.3] | 2/3 |

**Pruebas:** `packages/solar_engine/test/design/panel_shading_test.dart`.
