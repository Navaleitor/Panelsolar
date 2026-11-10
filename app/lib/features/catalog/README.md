# Catálogo de equipos

Paneles, inversores, microinversores, baterías, estructuras y protecciones; captura de datasheet o importación CEC/SAM.

## Estado
F0: pantalla vacía navegable (`EmptyModuleView`). Contenido real en **F4**.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/catalog` | `presentation/catalog_page.dart` | Título, descripción y "Disponible en la fase F4". |

## Capas
- `domain/` — vacío en F0.
- `data/` — vacío en F0.
- `presentation/` — `catalog_page.dart`.

Dependencias permitidas: `presentation → domain ← data`.

## Cómo probar
```bash
cd app
flutter test test/app_navigation_test.dart
```
Revisión manual: tocar la pestaña **Catálogo** en la barra inferior.
