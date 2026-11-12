# Proyectos

Cada instalación de un cliente: nombre, estado, fecha y notas. La ficha del proyecto reúne ubicación (`site`), fotos (`photos`) y documentos (`documents`). Se irá llenando de F1 a F5 (techo, clima, diseño, reportes).

## Estado
**F1 completa**: alta, edición, estado, fecha, borrado lógico.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/projects` | `presentation/projects_page.dart` | Todos los proyectos (más reciente primero) con buscador (proyecto o cliente) y filtro por estado. |
| `/projects/new?clientId=` | `presentation/project_form_page.dart` | Alta. Sin `clientId` pide elegir cliente. |
| `/projects/:id/edit` | `presentation/project_form_page.dart` | Edición. |
| `/projects/:id` | `presentation/project_detail_page.dart` | Cliente, fecha, estado (botón "Pasar a …"), ubicación, fotos, documentos. |

## Estados
`prospect → design → quoted → installed → maintenance` (Prospecto, Diseño, Cotizado, Instalado, Mantenimiento). Orden en `domain/project_status_flow.dart`. Se guardan como texto en la base: **no renombrar** valores (ver `packages/persistence/lib/src/model/enums.dart`).

## Capas
- `domain/project_status_flow.dart` — orden y "siguiente estado".
- `data/` — usa `ProjectRepository` (persistence) vía `core/database/repository_providers.dart`.
- `presentation/` — pantallas, `project_providers.dart`, `widgets/` (etiqueta de estado).

## Cómo probar
```bash
cd app
flutter test test/features/projects
```
