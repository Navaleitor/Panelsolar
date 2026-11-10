# Fases del proyecto — estado

Cada fase se trabaja en su propio chat (sesión) y en su propia rama `fase-N-...`; el chat principal coordina y revisa.

| Fase | Rama | Depende de | Estado |
|---|---|---|---|
| F0 Cimientos | `fase-0-cimientos` | — | Completada (2026-11-10) — aceptación del dueño pendiente: [`docs/pruebas/fase-0.md`](../pruebas/fase-0.md) |
| F1 Clientes y proyectos | `fase-1-clientes` | F0 | Pendiente |
| F2 Motor solar + clima | `fase-2-motor-clima` | F0 | Pendiente |
| F3 Sitio y techo | `fase-3-sitio-techo` | F0, F2 (posición solar) | Pendiente |
| F4 Diseño FV | `fase-4-diseno-fv` | F2, F3 | Pendiente |
| F5 Unifilar y reportes | `fase-5-unifilar-reportes` | F4 | Pendiente |
| F6 Operación (mantenimiento, respaldo) | `fase-6-operacion` | F1 | Pendiente |
| F7 Producto (freemium, Play Store) | `fase-7-producto` | F1–F6 | Pendiente |
| F8 iOS | `fase-8-ios` | F7 | Pendiente |

## Notas de F0
- Monorepo con Dart pub workspaces ([ADR-003](../adr/ADR-003-monorepo-pub-workspaces.md)); Flutter 3.47.9.
- CI en `.github/workflows/ci.yml`: formato, análisis, pruebas y APK debug como artefacto.
- Verificación de licencias: [`docs/fuentes-de-datos.md`](../fuentes-de-datos.md) y [ADR-004](../adr/ADR-004-licencias-fuentes-verificacion-f0.md) (**propuesto**: afecta el orden de proveedores de imagen en F3 y exige Overpass propio o de pago antes de F7; requiere aprobación del dueño). Confirmado contra páginas oficiales el 2026-11-10, salvo el permiso de Esri para guardar techos trazados.
