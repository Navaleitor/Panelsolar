# Mantenimiento

Plan de servicios, calendario con recordatorios locales y bitácora de visitas.

## Estado
F0: pantalla vacía navegable (`EmptyModuleView`). Contenido real en **F6**.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/maintenance` | `presentation/maintenance_page.dart` | Título, descripción y "Disponible en la fase F6". |

## Capas
- `domain/` — vacío en F0.
- `data/` — vacío en F0.
- `presentation/` — `maintenance_page.dart`.

Dependencias permitidas: `presentation → domain ← data`.

## Cómo probar
```bash
cd app
flutter test test/app_navigation_test.dart
```
Revisión manual: tocar la pestaña **Mantenimiento** en la barra inferior.
