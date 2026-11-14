# Respaldo

Exportar e importar **todo** (base de datos + fotos + documentos) a un archivo **.zip** con cifrado opcional, y respaldo opcional en **Google Drive** (carpeta privada `appDataFolder`, scope `drive.appdata`): diario en segundo plano con Wi-Fi, al finalizar un proyecto y con "Respaldar ahora". Restauración con vista previa. Plan B.9.

## Estado
**F6 completa.** El .zip funciona sin configuración. Drive necesita el ID de cliente web de Google: guía [`docs/guias/respaldo-google.md`](../../../../docs/guias/respaldo-google.md) (hasta entonces Ajustes muestra "Falta configurar…").

## Pantallas
| Dónde | Archivo | Qué hace |
|---|---|---|
| Ajustes | `presentation/widgets/zip_backup_card.dart` | Exportar (.zip, contraseña opcional) y elegir un .zip para restaurar. |
| Ajustes | `presentation/widgets/drive_backup_card.dart` | Conectar, Respaldar ahora, frecuencia, contraseña, restaurar, desconectar. |
| Ajustes | `presentation/widgets/backup_history.dart` | Últimos 10 respaldos/restauraciones (✓ / ✗). |
| `/settings/restore` | `presentation/restore_preview_page.dart` | Vista previa (fecha, versión, conteos, cifrado) → contraseña → confirmar → reemplaza todo. |

## Formato del .zip (`data/backup_archive.dart`)
```text
manifest.json               sin cifrar: fechas, versiones, conteos, hashes (sin datos personales)
database.sqlite[.enc]       foto de la base con VACUUM INTO
files/<ruta relativa>[.enc] fotos y documentos (en Drive van aparte)
```
- Cifrado: AES-256-GCM por archivo, llave PBKDF2-SHA256 (150 000 iteraciones) — `data/backup_crypto.dart`, ficha [`docs/formulas/cifrado-respaldo.md`](../../../../docs/formulas/cifrado-respaldo.md).
- Restaurar (`data/database_snapshot.dart`): se abre la foto con `AppDatabase` (aplica migraciones si es de una versión vieja), se escriben los archivos verificando SHA-256 y luego, en **una transacción**, se reemplazan todas las tablas (`ATTACH` + `INSERT … SELECT`). **No** se reemplazan `backup_logs` ni `app_settings` (propios del teléfono). Un respaldo de una versión más nueva se rechaza.

## Google Drive (`data/drive/`)
- `drive_auth.dart` — `google_sign_in` 7 + `googleServerClientId` (vacío = no configurado).
- `drive_remote_store.dart` — `RemoteStore` sobre `appDataFolder`.
- `drive_backup_service.dart` — sube `blob-<sha256>[-<sal>.enc]` solo si no existe (incremental por hash) y un `snapshot-<fecha>.zip` sin fotos; retención 7 diarias + 4 semanales (`domain/retention.dart`). Los blobs viejos no se borran (pendiente: limpieza de huérfanos).
- Contraseña de Drive en `flutter_secure_storage` (`data/secret_store.dart`); sal fija en `app_settings` para reutilizar blobs.

## Automático
- `data/background_backup.dart` — despachador de WorkManager (se registra en `main.dart`). `data/backup_schedule.dart` programa diario/semanal con red **no medida** (Wi-Fi) y batería no baja; "Solo manual" lo cancela.
- Al pasar un proyecto a **Instalado** (`projects/.../project_detail_page.dart`) → `projectFinishedBackupProvider` (no hace nada si Drive está apagado).
- `data/backup_service.dart` orquesta todo y registra cada intento en `backup_logs`.

## Capas
- `domain/` — manifiesto, retención, nombre de archivo.
- `data/` — zip, cifrado, base, Drive, programación, servicio y providers (todos sustituibles en pruebas).
- `presentation/` — tarjetas de Ajustes y vista previa.

## Cómo probar
```bash
cd app
flutter test test/features/backup
```
- `backup_roundtrip_test.dart` — respaldar → borrar → restaurar = mismos datos (con y sin contraseña).
- `drive_backup_service_test.dart` — Drive en memoria: incremental, retención y restaurar en "otro teléfono".
- `backup_settings_flow_test.dart` — flujo en pantalla.
Revisión manual: `docs/pruebas/fase-6.md`, sección 4.
