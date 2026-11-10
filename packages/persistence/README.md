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
| `clients` | `Client` | v3 | Contacto: nombre, teléfono, correo, dirección, notas. |
| `projects` | `Project` | v3 | Cliente, nombre, estado (`ProjectStatus`), fecha, notas. |
| `sites` | `Site` | v3 | Uno por proyecto: lat, lon, altitud, zona horaria IANA, origen (`LocationSource`). |
| `utility_bills` | `UtilityBill` | v3 | Recibo: periodo, `BillingPeriod`, kWh, importe en **centavos**, moneda, código de tarifa. |
| `photos` | `Photo` | v3 | Proyecto, etapa (`PhotoStage`), ruta relativa, SHA-256, tamaño, GPS, fecha. |
| `documents` | `Document` | v3 | Proyecto, título, `DocumentKind` (pdf/imagen), ruta relativa, MIME, tamaño, SHA-256. |

Versión de esquema actual: **3**.

### Enumeraciones (`lib/src/model/enums.dart`)
Se guardan como texto con el nombre del valor (`prospect`, `bimonthly`...). **Nunca renombrar un valor** sin migración; agregar al final sí es seguro.

### Repositorios
| Clase | Qué hace |
|---|---|
| `ClientRepository` | Búsqueda (`watchActive(query:)`), alta, edición, borrado lógico (en cascada a proyectos y recibos). |
| `ProjectRepository` | Lista con cliente (`ProjectWithClient`), filtro por estado/texto, por cliente, alta, edición, borrado lógico. |
| `SiteRepository` | `save` crea o reemplaza la ubicación del proyecto; valida rangos de lat/lon. |
| `UtilityBillRepository` | Recibos del cliente en orden cronológico; valida periodo y kWh. |
| `PhotoRepository` | Fotos por proyecto y etapa; `existsHash` evita duplicados. |
| `DocumentRepository` | Documentos por proyecto; renombrar y borrado lógico. |
| `CompanyRepository` | Perfil de la empresa (F0). |

Las rutas de fotos y documentos son **relativas** al directorio de archivos de la app (así sobreviven a un respaldo/restauración en otro teléfono).

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
