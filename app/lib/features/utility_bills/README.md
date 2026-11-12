# Recibos de luz

Recibos del cliente por periodo (mensual o bimestral) con kWh, importe y tarifa; resumen de consumo y gráfica. Se muestra dentro de la ficha del cliente.

## Estado
**F1 completa.** La proyección de ahorro (precios y escalones de tarifa) llega en **F5**.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| (ficha del cliente) | `presentation/bills_section.dart` | Resumen, gráfica de barras (últimos 12 recibos, línea punteada = promedio) y lista. |
| `/clients/:id/bills/new` | `presentation/bill_form_page.dart` | Alta: tarifa, periodo, fechas, kWh, importe. Sugiere fechas y tarifa a partir del último recibo. |
| `/clients/:id/bills/:billId` | `presentation/bill_form_page.dart` | Edición y borrado. |

## Cálculos (`domain/`)
- `consumption_summary.dart` — consumo anual estimado = Σ kWh / Σ días × 365 con los recibos del último año (ficha [`docs/formulas/consumo-anual-recibos.md`](../../../../docs/formulas/consumo-anual-recibos.md)); promedio mensual y diario; gasto anual; aviso si cubre menos de 350 días.
- `billing_period_math.dart` — fin sugerido (inicio + 1 o 2 meses − 1 día) y siguiente inicio.
- `money_parser.dart` — acepta `1,540.50`, `1.540,50`, `1540,5`; el importe se guarda en **centavos**.

## Tarifas
Vienen de `packages/regional_packs` (`mexicoTariffs`: CFE 1, 1A–1F, DAC, PDBT). Al elegir tarifa se propone su periodo habitual (domésticas bimestral, PDBT mensual). Si el promedio mensual rebasa el límite de alto consumo de la tarifa del último recibo, se muestra el aviso **DAC**.

## Cómo probar
```bash
cd app
flutter test test/features/utility_bills
```
