# Fases del proyecto — estado

Cada fase se trabaja en su propio chat (sesión) y en su propia rama `fase-N-...`; el chat principal coordina y revisa.

| Fase | Rama | Depende de | Estado |
|---|---|---|---|
| F0 Cimientos | `fase-0-cimientos` | — | En curso |
| F1 Clientes y proyectos | `fase-1-clientes` | F0 | Pendiente |
| F2 Motor solar + clima | `fase-2-motor-clima` | F0 | Pendiente |
| F3 Sitio y techo | `fase-3-sitio-techo` | F0, F2 (posición solar) | Pendiente |
| F4 Diseño FV | `fase-4-diseno-fv` | F2, F3 | Pendiente |
| F5 Unifilar y reportes | `fase-5-unifilar-reportes` | F4 | Pendiente |
| F6 Operación (mantenimiento, respaldo) | `fase-6-operacion` | F1 | Pendiente |
| F7 Producto (freemium, Play Store) | `fase-7-producto` | F1–F6 | Pendiente |
| F8 iOS | `fase-8-ios` | F7 | Pendiente |

## Sub-chats (sesiones) por fase
Chat principal (coordinador): `session_01WWCD8p6kSS93PVRjPCoDeK`.

| Fase | Sesión |
|---|---|
| F0 | `session_01WWCD8ktTRhr2b9gZUQfRY8` |
| F1 | `session_01WWCD8jrKeyB7BU9m9RcgWX` |
| F2 | `session_01WWCD8kDpEm67NYY4HGHjej` |
| F3 | `session_01WWCD8mp42zQxhXVJeaCzBP` |
| F4 | `session_01WWCD8oK1MwbxZThDeSnurd` |
| F5 | `session_01WWCD8oed4tQwkDPMVeGy2X` |
| F6 | `session_01WWCD8nXxgjE9yPP8tLoaWp` |
| F7 | `session_01WWCD8mfSNStprxgu3zS6jr` |
| F8 | `session_01WWCD8oNiMADxWpSKng9tBY` |

## Reglas de coordinación
1. Un sub-chat recibe instrucciones solo cuando sus dependencias están integradas en la rama base `ccr-4f7d63d4-px61ld`.
2. Al terminar una fase, el principal revisa la rama, abre PR hacia la rama base (con permiso del dueño), verifica CI e integra.
3. Paralelismo tras F0: F1 + F2; luego F3 + F6; luego F4 → F5 → F7 → F8.
4. Cada sub-chat entrega resumen, bloqueos y `docs/pruebas/fase-N.md`.
5. Las decisiones de producto se escalan al chat principal.
