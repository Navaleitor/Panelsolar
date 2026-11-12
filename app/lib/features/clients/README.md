# Clientes

Lista de clientes con búsqueda, alta, edición y borrado lógico. La ficha del cliente reúne contacto, sus proyectos y sus recibos de luz.

## Estado
**F1 completa.** Recibos de luz: módulo `utility_bills` (se muestra dentro de la ficha). Proyección de ahorro: F5.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/clients` | `presentation/clients_page.dart` | Lista ordenada por nombre + buscador (nombre, teléfono, correo, dirección). Botón "Nuevo cliente". |
| `/clients/new` | `presentation/client_form_page.dart` | Alta; al guardar abre la ficha. |
| `/clients/:id/edit` | `presentation/client_form_page.dart` | Edición. |
| `/clients/:id` | `presentation/client_detail_page.dart` | Contacto (mantener presionado copia), proyectos, recibos. Menú ⋮ → Borrar. |

## Capas
- `domain/contact_validators.dart` — reglas: nombre obligatorio, correo `a@b.c`, teléfono ≥ 7 dígitos.
- `data/` — no hace falta código propio: usa `ClientRepository` de `packages/persistence` vía `core/database/repository_providers.dart`.
- `presentation/` — pantallas, `client_providers.dart` (Riverpod) y `widgets/`.

Dependencias permitidas: `presentation → domain ← data`.

## Reglas importantes
- **Borrado lógico en cascada**: borrar un cliente marca también sus proyectos y recibos (`ClientRepository.softDelete`). Nada se borra físicamente.
- Los campos vacíos se guardan como "sin dato" (`null`).

## Cómo probar
```bash
cd app
flutter test test/features/clients
```
Revisión manual: ver `docs/pruebas/fase-1.md`, sección Clientes.
