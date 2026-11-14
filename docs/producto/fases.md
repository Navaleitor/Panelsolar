# Fases del proyecto — estado

Cada fase se trabaja en su propio chat (sesión) y en su propia rama `fase-N-...`; el chat principal coordina y revisa.

| Fase | Rama | Depende de | Estado |
|---|---|---|---|
| F0 Cimientos | `fase-0-cimientos` | — | Completada (2026-11-10) — lista de aceptación: [`docs/pruebas/fase-0.md`](../pruebas/fase-0.md) |
| F1 Clientes y proyectos | `fase-1-clientes` | F0 | Integrada (2026-11-12) — aceptación: [`docs/pruebas/fase-1.md`](../pruebas/fase-1.md) |
| F2 Motor solar + clima | `fase-2-motor-clima` | F0 | Integrada (2026-11-14) — aceptación: [`docs/pruebas/fase-2.md`](../pruebas/fase-2.md); validación: [`validacion-motor.md`](../pruebas/validacion-motor.md) |
| F3 Sitio y techo | `fase-3-sitio-techo` | F0, F2 (posición solar) | Pendiente |
| F4 Diseño FV | `fase-4-diseno-fv` | F2, F3 | Pendiente |
| F5 Unifilar y reportes | `fase-5-unifilar-reportes` | F4 | Pendiente |
| F6 Operación (mantenimiento, respaldo) | `fase-6-operacion` | F1 | En curso |
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

## Sub-chats (sesiones) por fase
Chat principal (coordinador): `session_01WWCD8p6kSS93PVRjPCoDeK`.

| Fase | Sesión |
|---|---|
| F0 | `session_01WWCD8ktTRhr2b9gZUQfRY8` |
| F1 | `session_01WWCD8k8V1Xc3QPnKzKASNc` (entorno panelsolar) |
| F2 | `session_01WWCD8oZt4AdV3NdkTVsnwf` (entorno panelsolar) |
| F3 | `session_01WWCD8mp42zQxhXVJeaCzBP` |
| F4 | `session_01WWCD8oK1MwbxZThDeSnurd` |
| F5 | `session_01WWCD8oed4tQwkDPMVeGy2X` |
| F6 | `session_01WWCD8jvCLJhSBAuszgZwA5` (entorno panelsolar) |
| F7 | `session_01WWCD8mfSNStprxgu3zS6jr` |
| F8 | `session_01WWCD8oNiMADxWpSKng9tBY` |

## Reglas de coordinación
1. Un sub-chat recibe instrucciones solo cuando sus dependencias están integradas en la rama base `ccr-4f7d63d4-px61ld`.
2. Al terminar una fase, el principal revisa la rama, abre PR hacia la rama base (con permiso del dueño), verifica CI e integra.
3. Paralelismo tras F0: F1 + F2; luego F3 + F6; luego F4 → F5 → F7 → F8.
4. Cada sub-chat entrega resumen, bloqueos y `docs/pruebas/fase-N.md`.
5. Las decisiones de producto se escalan al chat principal.
6. Las fases que programan usan el entorno cloud "panelsolar" (Flutter + Android SDK). F3–F8 se recrean en ese entorno cuando les toque.

## Decisiones del dueño (2026-11-14)
- **Temperaturas para strings (F2/F4):** por defecto, la más extrema de NASA y PVGIS (Tmin más fría, Tmax más caliente); ambas visibles.
- **Zona horaria:** automática desde las coordenadas, sin conexión (la implementa F2); editable.
- **Moneda:** solo MXN por ahora; monedas configurables se revisan antes de publicar (F7).
- **Altitud del sitio:** opcional y manual. Si falta, el motor usa un valor interno por defecto sin mostrar error.
