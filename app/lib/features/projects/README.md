# Proyectos

Cada instalación: estado, sitio, techo, clima, diseño FV, unifilar y reportes. Se llena de F1 a F5.

## Estado
F0: pantalla vacía navegable (`EmptyModuleView`). Contenido real en **F1**.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/projects` | `presentation/projects_page.dart` | Título, descripción y "Disponible en la fase F1". |

## Capas
- `domain/` — vacío en F0.
- `data/` — vacío en F0.
- `presentation/` — `projects_page.dart`.

Dependencias permitidas: `presentation → domain ← data`.

## Cómo probar
```bash
cd app
flutter test test/app_navigation_test.dart
```
Revisión manual: tocar la pestaña **Proyectos** en la barra inferior.
