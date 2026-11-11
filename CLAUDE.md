# CLAUDE.md — Reglas del proyecto Panelsolar

El dueño del proyecto **no programa**. Todo el código lo escribe y mantiene Claude, así que la prioridad es que cada cambio sea pequeño, localizado, probado y documentado.

## Fuente de verdad
- Plan maestro aprobado: `docs/producto/plan-maestro.md` (no contradecirlo sin un ADR nuevo en `docs/adr/`).
- Estado de fases: `docs/producto/fases.md`.

## Stack
Flutter estable + Dart 3, Riverpod, go_router, drift (SQLite), flutter_map, fl_chart, pdf. Android primero (API 26+).

## Estructura (ver plan, sección B.2)
- `app/` UI y orquestación; `app/lib/features/<modulo>/{data,domain,presentation}` + `README.md` por módulo.
- `packages/solar_engine` (Dart puro, sin Flutter), `geo_kit`, `data_sources`, `regional_packs`, `persistence`.
- `docs/formulas/` una ficha por fórmula (ecuación, unidades, fuente, caso de prueba).
- `tools/golden_data/` scripts pvlib que generan datos de referencia.

## Convenciones
- Código e identificadores en inglés; comentarios, documentación y textos de UI en español (UI vía ARB es/en).
- Archivos < ~300 líneas, una responsabilidad por archivo.
- Dependencias solo hacia adentro: `presentation → domain ← data`. `solar_engine` no depende de la app.
- Unidades SI internamente.
- Toda fórmula nueva: ficha en `docs/formulas/` + prueba con valores de referencia.
- Lint `very_good_analysis`; `dart format` obligatorio.
- Conventional Commits: `feat(site): ...`, `fix(engine): ...`, `docs: ...`.
- Solo fuentes de datos gratuitas con licencia comercial (ver plan B.4/B.5). Nunca Google Maps ni Open-Meteo.

## Comandos
- Workspace (ADR-003): `flutter pub get` **en la raíz**; nunca en un paquete suelto.
- App: `cd app && flutter analyze && flutter test`. Paquetes: `cd packages/<p> && dart analyze --fatal-infos && dart test`.
- Esquema de BD: receta en `packages/persistence/README.md` (`make-migrations` + `build_runner`). El código generado se versiona.
- Textos de UI: `app/lib/core/l10n/arb/app_es.arb` + `app_en.arb`.
- Plantilla de README de módulo: `docs/plantillas/README-feature.md`.

## APK de prueba (ADR-006)
- Cada push a la rama base publica una Release `build-N` con `panelsolar.apk`; enlace fijo: `https://github.com/Navaleitor/Panelsolar/releases/latest/download/panelsolar.apk`.
- **No cambiar ni regenerar** `app/android/keystore/panelsolar-debug.jks`: si cambia, el dueño tendría que desinstalar y perdería sus datos. La llave de Google Play (F7) es otra y va en GitHub Secrets.

## Antes de entregar
- `flutter analyze` y `flutter test` (o `dart test` en paquetes puros) en verde.
- Migración de BD nueva ⇒ prueba de migración.
- Actualizar el `README.md` del módulo tocado y `docs/producto/fases.md`.

## Flujo para corregir errores
1. Ubicar el módulo por su README. 2. Escribir prueba que reproduce el fallo. 3. Corregir. 4. PR con CI verde.
