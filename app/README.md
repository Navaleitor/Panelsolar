# app — aplicación Flutter

Solo UI y orquestación. Los cálculos viven en `packages/`.

## Estructura
```
lib/
├── main.dart              # arranque: carpeta de archivos + ProviderScope + PanelsolarApp
├── app.dart               # MaterialApp.router: tema, idiomas, rutas
├── core/
│   ├── app_info.dart      # versión y User-Agent
│   ├── database/          # providers de la base y de los repositorios (persistence)
│   ├── files/             # AppStorage: carpeta de fotos/documentos (rutas relativas)
│   ├── formatting/        # fechas, números y dinero según el idioma/región
│   ├── l10n/arb/          # textos es/en (EDITAR AQUÍ)
│   ├── l10n/gen/          # código generado por gen-l10n (no editar)
│   ├── router/            # go_router: rutas y barra inferior (AppShell)
│   ├── theme/             # tema Material 3 claro/oscuro de alto contraste
│   └── widgets/           # widgets compartidos (diálogos, encabezados, vacíos)
└── features/<modulo>/{data,domain,presentation}/ + README.md
```
Módulos actuales: `clients`, `projects`, `site` (ubicación), `photos`, `documents`, `utility_bills` (recibos), `catalog`, `maintenance`, `settings`. Plantilla de README: `docs/plantillas/README-feature.md`.

## Textos (es/en)
1. Agrega la clave en `lib/core/l10n/arb/app_es.arb` (plantilla) **y** en `app_en.arb`.
2. `flutter pub get` (o cualquier `flutter run/test`) regenera `lib/core/l10n/gen/`.
3. Úsala con `AppLocalizations.of(context).<clave>`.

## Navegación
`core/router/app_router.dart`: un `StatefulShellRoute` con una rama por pestaña (las listas). Las pantallas de detalle/edición están en `core/router/detail_routes.dart` como rutas planas que se abren **encima** de la barra inferior con `context.push(AppRoutes.xxx(...))`. Para una pantalla nueva: agrega su ruta en `detail_routes.dart` (las específicas como `/new` antes que las de `:id`) y su función en `app_routes.dart`.

## Android
`applicationId` = `com.panelsolar.app`, `minSdk` = 26 (Android 8.0). Ver `android/app/build.gradle.kts`.
Permisos (`android/app/src/main/AndroidManifest.xml`): Internet (dirección, enlaces cortos) y ubicación (GPS del sitio y de fotos). La cámara se usa a través de la app de cámara del sistema (no requiere permiso propio).

## Pruebas de widgets
`test/helpers/pump_app.dart` arranca la app con base SQLite en memoria, carpeta temporal y servicios falsos (GPS, geocodificador, redirecciones; `test/helpers/fakes.dart`). Las operaciones directas sobre la base dentro de `testWidgets` van envueltas en `tester.runAsync(...)`.

## Cómo probar
```bash
flutter pub get        # en la raíz del repo (workspace)
cd app
flutter analyze
flutter test
flutter build apk --debug   # requiere Android SDK; CI lo hace siempre
```
