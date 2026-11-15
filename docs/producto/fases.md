# Fases del proyecto — estado

Cada fase se trabaja en su propio chat (sesión) y en su propia rama `fase-N-...`; el chat principal coordina y revisa.

| Fase | Rama | Depende de | Estado |
|---|---|---|---|
| F0 Cimientos | `fase-0-cimientos` | — | Completada (2026-11-10) — lista de aceptación: [`docs/pruebas/fase-0.md`](../pruebas/fase-0.md) |
| F1 Clientes y proyectos | `fase-1-clientes` | F0 | Integrada (2026-11-12) — aceptación: [`docs/pruebas/fase-1.md`](../pruebas/fase-1.md) |
| F2 Motor solar + clima | `fase-2-motor-clima` | F0 | Integrada (2026-11-14) — aceptación: [`docs/pruebas/fase-2.md`](../pruebas/fase-2.md); validación: [`validacion-motor.md`](../pruebas/validacion-motor.md) |
| F3 Sitio y techo | `fase-3-sitio-techo` | F0, F2 (posición solar) | Integrada (2026-11-14) — aceptación: [`docs/pruebas/fase-3.md`](../pruebas/fase-3.md) |
| F4 Diseño FV | `fase-4-diseno-fv` | F2, F3 | En curso (reanudada 2026-11-15) |
| F5 Unifilar y reportes | `fase-5-unifilar-reportes` | F4 | Pendiente |
| F6 Operación (mantenimiento, respaldo) | `fase-6-operacion` | F1 | Integrada (2026-11-15) — aceptación: [`docs/pruebas/fase-6.md`](../pruebas/fase-6.md) |
| F7 Producto (freemium, Play Store) | `fase-7-producto` | F1–F6 | Pendiente |
| F8 iOS | `fase-8-ios` | F7 | Pendiente |

## Notas de F0
- Monorepo con Dart pub workspaces ([ADR-003](../adr/ADR-003-monorepo-pub-workspaces.md)); Flutter 3.47.9.
- CI en `.github/workflows/ci.yml`: formato, análisis, pruebas y APK debug como artefacto.
- Verificación de licencias: [`docs/fuentes-de-datos.md`](../fuentes-de-datos.md). [ADR-004](../adr/ADR-004-licencias-fuentes-verificacion-f0.md) **aceptado**: geocodificación y Overpass públicos detrás de interfaces; la solución comercial se decide en F7.
- Techo: [ADR-005](../adr/ADR-005-estrategia-techo-por-capas.md) **aceptado**: solo imágenes que importa el usuario + calibración + trazado. La app no obtiene imágenes de ningún proveedor.

## Notas de F1
- Esquema de base **v3** (migración v2→v3 con prueba): `clients`, `projects`, `sites`, `utility_bills`, `photos`, `documents`.
- Ubicación solo por coordenadas (GPS, dirección con Nominatim detrás de `Geocoder`, enlace de Google/Apple Maps con `MapLinkParser` en `geo_kit`, o a mano), siempre con confirmación. Sin mapa (ADR-005).
- Geocodificación en `packages/data_sources/lib/geocoding.dart` (biblioteca aparte para no chocar con F2).
- Tarifas CFE 1–1F, DAC y PDBT en `regional_packs` (solo identificación y límite DAC; precios en F5).
- Fotos comprimidas a 1600 px / JPEG 80 % con SHA-256 y GPS del EXIF; documentos PDF/imagen detectados por firma.

## Notas de F2
- `solar_engine`: plan B.6 puntos 1–10, simulación horaria, estadísticas y carta solar. Fichas 01–14 en [`docs/formulas/`](../formulas/README.md). Cobertura 99.7 % (CI exige ≥ 90 %); 5 años horarios ≈ 0.3 s.
- Golden con pvlib 0.16.1 en 6 sitios: diferencias < 1×10⁻⁶ %. Validación cruzada contra PVWatts y PVGIS: las 6 ciudades dentro de ±5 %.
- `data_sources`: NASA POWER y PVGIS 5.3 (TMY y horizonte), caché gzip por proyecto, control de calidad con cierre de componentes, atribuciones.
- App: "Clima y producción" desde la ficha del proyecto (`/projects/:id/weather`, usa su ubicación y altitud) y, para pruebas, desde Ajustes (`/settings/weather`).
- Decisiones del dueño (2026-11-14) aplicadas: temperaturas de diseño = la más extrema de NASA y PVGIS (`SiteDesignTemperatures`); zona horaria deducida sin conexión (`geo_kit` `TimeZoneLocator`, ≈ 1.2 MB, ODbL) propuesta al confirmar la ubicación y usada por el motor; altitud opcional (sin altitud el motor usa la de la fuente internamente).

## Notas de F3
- Módulo **Techo** (`app/lib/features/roof`) en la ficha del proyecto: imagen propia (aviso de derechos, sin proveedores, ADR-005) o croquis con cinta; calibración con verificación (% de diferencia); norte con flecha o brújula corregida por declinación **WMM2025**; trazado con imán a 90°/vértices y medidas en vivo; planos con inclinación (manual o inclinómetro), azimut desde el alero, retiros y pasillos; obstáculos de B.7.1 con altura típica, cinta o teléfono.
- Sombras en `solar_engine/shading` (L = h / tan α, también sobre planos inclinados), deslizador de fecha y hora, mapa de calor anual en un isolate, horizonte PVGIS + obstáculos lejanos. Fichas 16–21.
- Esquema **v5**: `roof_images`, `roof_planes`, `obstacles`, `horizon_profiles` (metros, coordenadas locales). **v4 queda reservada para F6** (en esta rama `from3To4` no cambia nada); al integrar, el chat principal pone la v4 de F6 y regenera la foto de la v5.
- Dependencia nueva: `sensors_plus` (BSD-3). Prueba de aceptación automática: techo de 12 × 9 m dentro de ±5 %.

## Notas de F6
- Esquema de base **v6** (`from5To6`, con pruebas v3→v6 y v5→v6; la v4 quedó vacía): `installed_equipment`, `commissioning_records`, `string_tests`, `maintenance_template_items`, `maintenance_plan_items`, `maintenance_visits`, `production_readings`, `production_settings`, `backup_logs`, `app_settings` y `photos.linkedRecordId`.
- Módulos nuevos: `installation`, `production`, `backup`; `maintenance` y `settings` dejan de ser pantallas vacías.
- Puesta en marcha IEC 62446-1: Voc ±5 %, Isc ±10 %, aislamiento ≥ 1 MΩ; la app sugiere el estado y el instalador decide.
- Recordatorios: `flutter_local_notifications` con alarmas inexactas (7 días antes y el día, 9:00).
- Producción: lo esperado se precarga con el motor de F2 (kWh/kWp típico del mes × kWp del proyecto) y es editable; `ExpectedProductionSource` permite cambiar a F4 después.
- Respaldo .zip con manifiesto sin cifrar (vista previa) y AES-256-GCM por archivo (PBKDF2-SHA256). Restaurar **reemplaza** todo excepto `backup_logs` y `app_settings`; antes guarda automáticamente una copia local para "Deshacer la última restauración".
- Drive (`drive.appdata`) con blobs por hash y retención 7+4. **Pendiente del dueño**: crear los IDs de OAuth ([`docs/guias/respaldo-google.md`](../guias/respaldo-google.md)) y pasar el ID web a Claude.

## Sub-chats (sesiones) por fase
Chat principal (coordinador): `session_01WWCD8p6kSS93PVRjPCoDeK`.

| Fase | Sesión |
|---|---|
| F0 | `session_01WWCD8ktTRhr2b9gZUQfRY8` |
| F1 | `session_01WWCD8k8V1Xc3QPnKzKASNc` (entorno panelsolar) |
| F2 | `session_01WWCD8oZt4AdV3NdkTVsnwf` (entorno panelsolar) |
| F3 | `session_01WWCD8khQf1erhr86FAi84j` (entorno panelsolar) |
| F4 | `session_01WWCD8krc3yMiKeizV6YafY` (entorno panelsolar) |
| F5 | `session_01WWCD8oed4tQwkDPMVeGy2X` |
| F6 | `session_01WWCD8jvCLJhSBAuszgZwA5` (entorno panelsolar) |
| F7 | `session_01WWCD8mfSNStprxgu3zS6jr` |
| F8 | `session_01WWCD8oNiMADxWpSKng9tBY` |

## Reglas de coordinación
1. Un sub-chat recibe instrucciones solo cuando sus dependencias están integradas en la rama base `ccr-4f7d63d4-px61ld`.
2. Al terminar una fase, el principal revisa la rama, abre PR hacia la rama base (con permiso del dueño), verifica CI e integra.
3. **Una sola fase activa a la vez** (decisión del dueño, 2026-11-15). Orden: F6 → F4 → F5 → F7 → F8.
4. Cada sub-chat entrega resumen, bloqueos y `docs/pruebas/fase-N.md`.
5. Las decisiones de producto se escalan al chat principal.
6. Las fases que programan usan el entorno cloud "panelsolar" (Flutter + Android SDK). F3–F8 se recrean en ese entorno cuando les toque.

## Decisiones del dueño (2026-11-14)
- **Temperaturas para strings (F2/F4):** por defecto, la más extrema de NASA y PVGIS (Tmin más fría, Tmax más caliente); ambas visibles.
- **Zona horaria:** automática desde las coordenadas, sin conexión (la implementa F2); editable.
- **Moneda:** solo MXN por ahora; monedas configurables se revisan antes de publicar (F7).
- **Altitud del sitio:** opcional y manual. Si falta, el motor usa un valor interno por defecto sin mostrar error.

## Numeración del esquema de BD (2026-11-14)
- v4: vacía (reservada originalmente para F6). v5: techo (F3). **v6: F6** (equipos, puesta en marcha, mantenimiento, producción, respaldo). **v7: F4** (catálogo, arreglo, strings, cableado, simulación).
- Regla: una versión ya publicada en un APK nunca se reutiliza; la fase que integra después toma el siguiente número.
