# Instalación

Equipos instalados por proyecto (marca, modelo, número de serie, garantía) y checklist de **puesta en marcha IEC 62446-1**: Voc/Isc por string contra lo esperado, polaridad, aislamiento, puesta a tierra, etiquetado, estado y fotos de evidencia.

## Estado
**F6 completa.** Los valores esperados de Voc/Isc se escriben a mano; en F4 podrán venir del diseño de strings.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| (ficha del proyecto) | `presentation/installation_summary_card.dart` | Número de equipos y estado de la puesta en marcha. |
| `/projects/:id/installation` | `presentation/installation_page.dart` | Estado de la puesta en marcha y lista de equipos (⚠ si la garantía venció). |
| `/projects/:id/equipment/new`, `/projects/:id/equipment/:eid` | `presentation/equipment_form_page.dart` | Alta/edición/borrado de un equipo. |
| `/projects/:id/commissioning` | `presentation/commissioning_page.dart` | Strings, revisiones, resultado, sugerencia y fotos de evidencia. |

## Reglas (`domain/`)
- `commissioning_evaluation.dart` — desviación % y tolerancias: Voc ±5 %, Isc ±10 %, aislamiento ≥ 1 MΩ. Estado sugerido: falla → *Con observaciones*; falta algo → *Pendiente*; todo bien → *Aprobado*. Ficha: [`docs/formulas/puesta-en-marcha-iec62446.md`](../../../../docs/formulas/puesta-en-marcha-iec62446.md).
- `warranty.dart` — vigente / vence en ≤ 90 días / vencida.
- El estado final lo elige el instalador; la sugerencia usa lo **guardado**.

## Datos
- Tablas (persistence v6): `installed_equipment`, `commissioning_records` (uno por proyecto), `string_tests`.
- Repositorios: `InstalledEquipmentRepository`, `CommissioningRepository`.
- Fotos de evidencia: tabla `photos` con etapa *Instalación* y `linkedRecordId` = id del checklist (widget `photos/presentation/linked_photos_section.dart`).

## Capas
- `domain/` — evaluación y garantía (sin Flutter).
- `data/` — sin código propio: usa los repositorios vía `core/database/repository_providers.dart`.
- `presentation/` — pantallas, `installation_providers.dart`, `installation_labels.dart`, `widgets/` (diálogo de string, revisión de 3 estados).

## Cómo probar
```bash
cd app
flutter test test/features/installation
```
Revisión manual: `docs/pruebas/fase-6.md`, sección 1.
