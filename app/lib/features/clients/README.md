# Clientes

Datos de contacto, ubicación, recibos de luz (kWh, tarifa, historial), gráficas de consumo y proyectos de cada cliente.

## Estado
F0: pantalla vacía navegable (`EmptyModuleView`). Contenido real en **F1**.

## Pantallas
| Ruta | Archivo | Qué muestra |
|---|---|---|
| `/clients` | `presentation/clients_page.dart` | Título, descripción y "Disponible en la fase F1". |

## Capas
- `domain/` — vacío en F0.
- `data/` — vacío en F0.
- `presentation/` — `clients_page.dart`.

Dependencias permitidas: `presentation → domain ← data`.

## Cómo probar
```bash
cd app
flutter test test/app_navigation_test.dart
```
Revisión manual: tocar la pestaña **Clientes** en la barra inferior.
