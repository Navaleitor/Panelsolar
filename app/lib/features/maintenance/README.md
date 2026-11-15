# Mantenimiento

Plan de servicios por proyecto (con plantilla editable), calendario de próximas visitas, recordatorios con notificaciones locales y bitácora de visitas con fotos y notas.

## Estado
**F6 completa.**

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/maintenance` (pestaña) | `presentation/maintenance_page.dart` | Calendario de todos los proyectos: vencidas, próximos 30 días, más adelante. |
| `/maintenance/template` | `presentation/maintenance_template_page.dart` | Plantilla: servicios, frecuencia, incluido sí/no. Mantener presionado = borrar. |
| (ficha del proyecto) | `presentation/maintenance_summary_card.dart` | Próxima visita. |
| `/projects/:id/maintenance` | `presentation/project_maintenance_page.dart` | Plan (crear desde plantilla, agregar, editar fecha/frecuencia) y bitácora. |
| `/projects/:id/visits/new` | `presentation/visit_form_page.dart` | Registrar visita: fecha, técnico, servicios hechos (se marcan solos los vencidos/próximos), notas. |
| `/projects/:id/visits/:visitId` | `presentation/visit_detail_page.dart` | Detalle, notas editables, fotos de la visita, borrar. |

## Reglas
- Plantilla inicial (`domain/default_template.dart`): limpieza 6 m, inspección visual 6 m, apriete 12 m, inversor 12 m, protecciones 12 m, termografía 24 m (**desactivada**: opcional). Se carga una sola vez (`templateSeedProvider`).
- Crear plan: copia los servicios activos; primera fecha = hoy + frecuencia.
- Registrar visita: los servicios hechos quedan con `lastDoneAt` = fecha de la visita y `nextDueAt` = fecha + frecuencia (`MaintenanceVisitRepository.logVisit`). Borrar una visita **no** regresa las fechas.
- Vencimiento (`domain/due_status.dart`): vencida si la fecha pasó; "próxima" si faltan ≤ 30 días.
- Recordatorios (`domain/reminder.dart`): 7 días antes y el mismo día a las 9:00 locales, solo fechas futuras, máximo 60. Id de notificación estable (FNV-1a del id del servicio).

## Notificaciones
- `data/reminder_scheduler.dart` — interfaz `ReminderScheduler`; implementación con `flutter_local_notifications` (alarmas **inexactas**: no pide el permiso de alarmas exactas).
- `presentation/reminder_sync.dart` — `reminderSyncProvider` (se activa en `app.dart`): cada cambio del calendario o del interruptor reprograma todo.
- Interruptor en Ajustes (`maintenance.reminders.enabled` en `app_settings`). Al encenderlo pide el permiso de Android 13+.
- Versión fijada a 22.3.x: la 23 exige compilar con Android SDK 37 y el Gradle de Flutter actual llega a 36 (subir cuando Flutter lo soporte).
- Android: receptores y permisos en `android/app/src/main/AndroidManifest.xml`; *desugaring* en `android/app/build.gradle.kts`.

## Datos
Tablas (persistence v6): `maintenance_template_items`, `maintenance_plan_items`, `maintenance_visits`. Fotos de la visita: `photos` con etapa *Mantenimiento* y `linkedRecordId` = id de la visita.

## Cómo probar
```bash
cd app
flutter test test/features/maintenance
```
Las pruebas usan `FakeReminderScheduler` (`test/helpers/fakes.dart`). Revisión manual: `docs/pruebas/fase-6.md`, sección 2.
