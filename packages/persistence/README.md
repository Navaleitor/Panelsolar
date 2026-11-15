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
| `roof_images` | `RoofImage` | v5 | Uno por proyecto: modo (`RoofMode` imagen/croquis), imagen importada por el usuario, metros por píxel, líneas de calibración y verificación (JSON en píxeles), norte (`NorthSource`) y declinación usada. |
| `roof_planes` | `RoofPlane` | v5 | Polígono en **metros locales** (JSON `[[x,y],...]`, x = este, y = norte), inclinación (`TiltSource`), azimut, arista del alero, retiro de borde y pasillos (JSON). |
| `obstacles` | `Obstacle` | v5 | `ObstacleKind`, `ObstacleOutline`, centro/medidas/giro o puntos (m), altura sobre el techo (`HeightSource`), litros del tinaco. |
| `horizon_profiles` | `HorizonProfileRecord` | v5 | `HorizonSource` (terreno PVGIS / manual / cámara), nombre y puntos `[[azimut, elevación], ...]`. La clase no se llama `HorizonProfile` para no chocar con la del motor. |

| `installed_equipment` | `InstalledEquipmentItem` | v6 | Equipo instalado: `EquipmentKind`, marca, modelo, serie, instalación, garantía. |
| `commissioning_records` | `CommissioningRecord` | v6 | Uno por proyecto: `CommissioningStatus`, polaridad, aislamiento (MΩ, V), tierra, etiquetado. `null` = sin revisar. |
| `string_tests` | `StringTest` | v6 | Voc/Isc esperados y medidos por string, polaridad. |
| `maintenance_template_items` | `MaintenanceTemplateItem` | v6 | Plantilla editable de servicios (`MaintenanceServiceKind`, meses, incluido). |
| `maintenance_plan_items` | `MaintenancePlanItem` | v6 | Servicio del plan de un proyecto: meses, última vez, próxima fecha. |
| `maintenance_visits` | `MaintenanceVisit` | v6 | Bitácora: fecha, técnico, ids de servicios hechos (separados por coma), notas. |
| `production_readings` | `ProductionReading` | v6 | kWh reales del mes, esperados y POA (kWh/m²). Una activa por mes. |
| `production_settings` | `ProductionSetting` | v6 | Uno por proyecto: kWp y umbral de alerta (%). |
| `backup_logs` | `BackupLog` | v6 | Historial: destino, motivo, resultado, tamaño, archivos. |
| `app_settings` | `AppSetting` | v6 | Ajustes clave → valor (Drive, recordatorios). |

v6 también agregó `photos.linkedRecordId` (foto de una visita o de la puesta en marcha).


Versión de esquema actual: **6**. La **v4 quedó vacía** (`from3To4` no hace nada: estaba reservada para F6, pero F3 se integró antes con v5). F6 está en v6 (`from5To6`). No cambiar: hay teléfonos con v5.

### Enumeraciones (`lib/src/model/enums.dart`)
Se guardan como texto con el nombre del valor (`prospect`, `bimonthly`...). **Nunca renombrar un valor** sin migración; agregar al final sí es seguro.

### Repositorios
| Clase | Qué hace |
|---|---|
| `ClientRepository` | Búsqueda (`watchActive(query:)`), alta, edición, borrado lógico (en cascada a proyectos y recibos). |
| `ProjectRepository` | Lista con cliente (`ProjectWithClient`), filtro por estado/texto, por cliente, alta, edición, borrado lógico. |
| `SiteRepository` | `save` crea o reemplaza la ubicación del proyecto; valida rangos de lat/lon. |
| `UtilityBillRepository` | Recibos del cliente en orden cronológico (`watchByClient` / `listByClient`); valida periodo y kWh. |
| `PhotoRepository` | Fotos por proyecto y etapa; `existsHash` evita duplicados. |
| `DocumentRepository` | Documentos por proyecto; renombrar y borrado lógico. |
| `RoofImageRepository` | Base del techo: `saveImage` (borra calibración y norte), `startSketch`, `saveCalibration`, `saveNorth`. |
| `RoofPlaneRepository` | Planos por proyecto en orden; `update(plane)` con `copyWith`; valida inclinación [0, 90). |
| `ObstacleRepository` | Obstáculos por proyecto; valida ancho > 0 y altura ≥ 0. |
| `HorizonProfileRepository` | Un terreno por proyecto (`saveTerrain`) y obstáculos lejanos (`addManual`). |
| `CompanyRepository` | Perfil de la empresa (F0). |
| `InstalledEquipmentRepository` | Equipos por proyecto. |
| `CommissioningRepository` | Checklist (crea o reemplaza) y strings. |
| `MaintenanceRepository` | Plantilla (`seedTemplateIfEmpty`), plan por proyecto, calendario (`watchUpcoming`). |
| `MaintenanceVisitRepository` | Bitácora; `logVisit` recorre las próximas fechas en una transacción. |
| `ProductionRepository` | Lecturas mensuales y ajustes. |
| `BackupLogRepository` / `AppSettingsRepository` | Historial de respaldos y ajustes. |

`model/date_math.dart`: `addMonthsUtc` (31 ene + 1 mes = 28 feb), `calendarDayUtc`, `monthStartUtc`.

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
