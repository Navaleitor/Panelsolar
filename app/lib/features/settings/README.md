# Ajustes

Perfil de empresa, unidades, idioma, paquete regional, respaldo y licencia.

## Estado
F0: pantalla vacía navegable (`EmptyModuleView`). Contenido real en **F1**.

En F0 muestra la tarjeta **Base de datos** (`databaseHealthProvider` de `core/database/`): abre SQLite, aplica migraciones y enseña la versión de esquema. Sirve al dueño para comprobar en su teléfono que la base funciona.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/settings` | `presentation/settings_page.dart` | Título, descripción y "Disponible en la fase F1". |

## Capas
- `domain/` — vacío en F0.
- `data/` — vacío en F0.
- `presentation/` — `settings_page.dart`.

Dependencias permitidas: `presentation → domain ← data`.

## Cómo probar
```bash
cd app
flutter test test/app_navigation_test.dart
```
Revisión manual: tocar la pestaña **Ajustes** en la barra inferior.
