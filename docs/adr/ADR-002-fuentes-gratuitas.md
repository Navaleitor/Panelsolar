# ADR-002 — Solo fuentes de datos gratuitas con uso comercial

- Estado: aceptado (2026-11-10)
- Contexto: presupuesto $0 sin tarjeta, producto comercial, alcance mundial.
- Decisión: imagen Esri World Imagery (cuenta gratuita, a verificar) + ortofotos abiertas + dron + modo sin imagen; huellas OSM (Overpass); clima NASA POWER (principal) y PVGIS (TMY, horizonte, validación). Excluidos: Google Maps/Solar API (tarjeta y prohíbe trazar), Bing (retirado), Open-Meteo (no comercial).
- Consecuencias: interfaz `ImageryProvider` intercambiable; atribuciones en reportes; opción BYO key.
