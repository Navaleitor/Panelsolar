# <Nombre del módulo>

<Una o dos frases: qué hace este módulo para el usuario.>

## Estado
<Fase en la que está y qué falta.>

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/<ruta>` | `presentation/<x>_page.dart` | <...> |

## Capas
- `domain/` — modelos y reglas del negocio (sin Flutter ni base de datos).
- `data/` — repositorios que hablan con `packages/persistence` o `packages/data_sources`.
- `presentation/` — pantallas, widgets y *providers* de Riverpod.

Dependencias permitidas: `presentation → domain ← data`.

## Archivos clave
- <archivo> — <para qué>

## Cómo probar
```bash
cd app
flutter test test/features/<modulo>
```
Revisión manual en el teléfono: <pasos>.

## Errores conocidos / notas
<...>
