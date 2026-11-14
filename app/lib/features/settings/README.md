# Ajustes

Respaldo (.zip y Google Drive), recordatorios de mantenimiento y estado de la base de datos. Perfil de empresa, unidades, idioma y licencia llegan en fases posteriores (F5/F7).

## Estado
F6: respaldo y recordatorios. La tarjeta **Base de datos** (`databaseHealthProvider`) enseña la versión de esquema (v4).

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/settings` | `presentation/settings_page.dart` | Respaldo (módulo `backup`), historial, recordatorios + plantilla (módulo `maintenance`), base de datos. |

## Capas
- `presentation/settings_page.dart` — solo arma secciones; la lógica vive en `features/backup` y `features/maintenance`.

## Cómo probar
```bash
cd app
flutter test test/app_navigation_test.dart test/features/backup
```
