# persistence

Esquema de base de datos (SQLite con [drift](https://drift.simonbinder.eu)), migraciones versionadas y repositorios. Dart puro: lo usa la app, pero no depende de Flutter.

## Convenciones (plan B.3) — todas las tablas
Cada tabla usa el mixin `BaseColumns` (`lib/src/tables/base_columns.dart`):

| Columna | Tipo | Regla |
|---|---|---|
| `id` | texto (UUID v4) | Se genera solo al insertar. Permite fusionar respaldos. |
| `createdAt` | fecha UTC | Se pone al insertar. |
| `updatedAt` | fecha UTC | El repositorio la renueva en **cada** cambio. |
| `deletedAt` | fecha UTC o vacío | **Borrado lógico**: vacío = activo. La UI nunca borra físicamente. |

Las fechas se guardan como texto ISO-8601 (`build.yaml`).

## Tablas
| Tabla | Clase de fila | Desde | Notas |
|---|---|---|---|
| `companies` | `Company` | v1 | Perfil del instalador. v2 agregó `taxId`, `logoPath`. |

Versión de esquema actual: **2**.

## Archivos clave
- `lib/src/tables/` — una tabla por archivo.
- `lib/src/database/app_database.dart` — lista de tablas, `schemaVersion` y migraciones.
- `lib/src/database/*.g.dart`, `*.steps.dart` — **generados**, no editar a mano.
- `lib/src/repositories/` — acceso a datos aplicando las convenciones.
- `drift_schemas/` — foto JSON de cada versión del esquema (no borrar nunca).
- `test/generated_migrations/` — pruebas de migración (+ código generado en `generated/`).

## Cómo cambiar el esquema (receta)
1. Edita/crea la tabla en `lib/src/tables/` y anota la versión en su comentario.
2. Sube `schemaVersion` en `app_database.dart`.
3. Ejecuta: `dart run drift_dev make-migrations` (guarda la nueva foto en `drift_schemas/` y regenera `app_database.steps.dart` y `test/generated_migrations/generated/`).
4. Agrega el paso `fromNToM` en `stepByStep(...)` de `app_database.dart`.
5. Ejecuta `dart run build_runner build`.
6. Agrega a `test/generated_migrations/app_database/migration_test.dart` una prueba de datos `vN → vM` (ver la de v1 → v2).
7. `dart test` en verde. Actualiza la tabla de arriba.

## Cómo probar
```bash
cd packages/persistence
dart test
```
