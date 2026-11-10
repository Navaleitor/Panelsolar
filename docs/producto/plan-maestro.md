# Plan maestro — App de análisis e instalación de paneles solares ("Panelsolar")

## Contexto
El repositorio `navaleitor/panelsolar` está vacío. Se quiere una app móvil (Android primero, iOS después) para instaladores fotovoltaicos que haga, **en el propio dispositivo**:
1. levantamiento del sitio sobre imagen satelital (contorno del techo y obstáculos),
2. análisis solar y meteorológico (producción, inclinación óptima, sombras, máximo de paneles, strings, pérdidas, viento),
3. gestión de clientes (consumo, equipos, unifilar, fotos, mantenimiento, documentos, respaldo en Google Drive).

Decisiones del dueño del proyecto:
- Producto **para otros instaladores** (se publica en las tiendas), modelo **freemium / pago único**.
- Presupuesto **$0 estricto, sin tarjeta** → solo fuentes gratuitas con licencia que permita uso comercial.
- **Alcance mundial**, con México (CFE / NOM) como primer "paquete regional".
- **Android primero**, iOS en una fase posterior.
- El dueño **no programa**: el código lo escribe y mantiene Claude → la arquitectura debe ser modular, documentada y probada para que cualquier corrección sea pequeña y localizada.

Este documento define: (A) el producto, (B) la parte técnica, (C) la forma de desarrollo, (D) las pruebas y (E) las fases.

---

## A. Definición del producto

### A.1 Usuarios y uso
- **Usuario**: instalador o empresa instaladora (técnico de campo, vendedor/diseñador).
- **Dónde corre**: teléfono o tableta Android 8+ (API 26+); luego iOS 15+. Todo el cálculo es local.
- **Conexión**: se usa internet solo para (a) descargar imagen satelital y huella del edificio, (b) descargar clima e irradiancia, (c) respaldo en Drive, (d) compras dentro de la app. Lo descargado se guarda en caché del proyecto → el análisis y su consulta funcionan sin conexión después.
- **Flujo típico**: Cliente → Proyecto → Sitio (ubicación + techo + obstáculos) → Clima → Diseño (paneles, strings, inversor, eléctrico) → Económico → Reporte/Cotización PDF → Instalación (fotos, puesta en marcha) → Mantenimiento y seguimiento de producción.

### A.2 Módulos funcionales
| Módulo | Contenido |
|---|---|
| **Clientes** | Datos de contacto, ubicación, recibos de luz (kWh por periodo, tarifa, historial), gráficas de consumo, proyección y ahorro. Varios proyectos por cliente. |
| **Proyecto / Sitio** | Ubicación (GPS, dirección, pin compartido de Google Maps / Apple Maps), imagen aérea, trazado del techo (polígonos por plano con inclinación y orientación), obstáculos (tinacos, antenas, pretiles, árboles, edificios), áreas libres para mantenimiento. |
| **Clima y recurso solar** | Datos horarios de los últimos 5 años + año típico, estadísticas mensuales/estacionales, trayectoria solar. |
| **Diseño FV** | Inclinación/orientación óptima, separación entre filas, máximo de paneles, sombras, producción esperada, pérdidas, diseño de strings, relación DC/AC, cableado y caída de tensión, protecciones, puesta a tierra, carga de viento. |
| **Catálogo de equipos** | Paneles, inversores, microinversores, baterías, estructuras, protecciones — capturados por el instalador (datasheet) o importados del catálogo público CEC/SAM. |
| **Diagrama unifilar** | Generado automáticamente del diseño, editable, exportable a PDF/SVG. |
| **Económico / Cotización** | Costo por watt, lista de materiales, cotización con logo del instalador, ROI, VPN, TIR, LCOE, escenarios con/sin baterías. |
| **Instalación** | Fotos por etapa, números de serie, checklist de puesta en marcha (IEC 62446‑1: Voc/Isc por string, aislamiento, polaridad), documentos (contrato, trámite de interconexión, garantías). |
| **Mantenimiento** | Plan de servicios (limpieza, inspección visual, apriete, termografía, revisión de inversor), calendario con recordatorios locales, bitácora de visitas. |
| **Seguimiento de producción** | Captura mensual de kWh reales (del inversor) vs. esperado → Performance Ratio y alertas de bajo rendimiento. |
| **Ajustes / Cuenta** | Perfil de empresa (logo, datos para reportes), unidades, idioma, paquete regional (normas y tarifas), respaldo, licencia. |

### A.3 Freemium (propuesta, ajustable)
- **Gratis**: hasta 3 clientes/proyectos activos, análisis completo, reporte con marca de agua.
- **Pro (pago único)**: ilimitado, reportes/cotizaciones con logo, unifilar exportable, respaldo automático en Drive, seguimiento de producción.
- Implementado como un módulo `licensing` aislado con "feature flags"; cambiar qué es gratis/pago es editar una tabla, no el código de cada pantalla.

### A.4 Requisitos no funcionales
- **Offline‑first**; ninguna pantalla depende de red salvo las descargas explícitas.
- **Privacidad**: datos personales de clientes solo en el dispositivo y en el Drive del propio usuario; aviso de privacidad (LFPDPPP México / GDPR); sin servidores propios.
- **Seguridad**: respaldo cifrado (AES‑256 con contraseña opcional); bloqueo de app opcional (biometría).
- **Rendimiento**: simulación horaria de 5 años (~44 000 horas) en < 3 s en un teléfono gama media (se ejecuta en un *isolate* para no congelar la UI).
- **Almacenamiento**: fotos comprimidas (≈ 1600 px, JPEG 80 %) con original opcional.
- **Internacionalización**: español e inglés desde el inicio; unidades SI internamente, visualización métrica/imperial.
- **Accesibilidad** básica y uso en exteriores (alto contraste, botones grandes).
- **Aviso legal**: los cálculos son de apoyo; unifilar y diseño estructural deben ser revisados/firmados por profesional acreditado (p. ej. UVIE en México).

---

## B. Definición técnica

### B.1 Stack (recomendado: Flutter)
Razones: un solo código para Android/iOS, tipado fuerte (errores detectados antes de ejecutar → más seguro para mantenimiento por IA), dibujo 2D de alto rendimiento (techo, unifilar), buen soporte de sensores/cámara, ecosistema maduro.

| Necesidad | Paquete |
|---|---|
| Lenguaje / UI | Flutter estable + Dart 3, Material 3 |
| Estado / inyección | `flutter_riverpod` |
| Navegación | `go_router` |
| Base de datos | `drift` (SQLite) con migraciones versionadas |
| Mapas (sin Google) | `flutter_map` + proveedores de teselas intercambiables |
| Gráficas | `fl_chart` |
| PDF | `pdf` + `printing` |
| Sensores | `geolocator`, `sensors_plus`, `flutter_compass`, `camera` |
| Tareas en 2º plano | `workmanager` |
| Notificaciones locales | `flutter_local_notifications` |
| Drive | `google_sign_in` + `googleapis` (scope `drive.appdata`) |
| Compras | `in_app_purchase` |
| i18n | `flutter gen-l10n` (archivos ARB) |
| Modelos inmutables | `freezed` + `json_serializable` |

### B.2 Arquitectura y estructura del repositorio (pensada para mantenimiento por IA)
Monorepo con **paquetes independientes**; el motor de cálculo es Dart puro (sin Flutter) para que sea 100 % probable con pruebas unitarias.

```
panelsolar/
├── CLAUDE.md                 # Reglas para la IA: estructura, convenciones, cómo probar, qué no tocar
├── README.md
├── docs/
│   ├── producto/             # Requisitos, casos de uso, glosario
│   ├── formulas/             # Una ficha por fórmula: ecuación, unidades, fuente, caso de prueba
│   ├── fuentes-de-datos.md   # APIs, licencias, límites, atribuciones
│   ├── adr/                  # Decisiones de arquitectura (ADR-001-flutter.md, ...)
│   └── pruebas/              # Protocolos de validación de campo
├── app/                      # Aplicación Flutter (solo UI + orquestación)
│   └── lib/
│       ├── core/             # tema, rutas, errores, utilidades, l10n
│       └── features/         # una carpeta por módulo funcional
│           ├── clients/      # data/ domain/ presentation/  + README.md
│           ├── site/         # mapa, trazado de techo, obstáculos
│           ├── weather/
│           ├── design/       # layout, strings, eléctrico
│           ├── single_line/  # unifilar
│           ├── economics/
│           ├── installation/
│           ├── maintenance/
│           ├── backup/
│           ├── licensing/
│           └── settings/
├── packages/
│   ├── solar_engine/         # Dart puro: posición solar, irradiancia, temperatura, potencia, sombras, strings, eléctrico, viento, economía
│   ├── geo_kit/              # Geometría: polígonos, proyección, empaquetado de paneles, parseo de enlaces de mapas
│   ├── data_sources/         # Clientes HTTP: NASA POWER, PVGIS, Overpass, teselas; caché
│   ├── regional_packs/       # Normas, tarifas y factores por país (MX primero) como datos JSON + validadores
│   └── persistence/          # Esquema drift, migraciones, repositorios
└── tools/
    └── golden_data/          # Scripts Python (pvlib) que generan datos de referencia para pruebas
```

Reglas de sostenibilidad:
- Cada `feature` tiene capas `data / domain / presentation` y un `README.md` de una página (qué hace, archivos clave, cómo probar).
- Archivos cortos (< ~300 líneas), una responsabilidad por archivo, nombres en inglés en código y comentarios/documentación en español.
- Toda fórmula en `solar_engine` cita su ficha en `docs/formulas/` y tiene prueba con valores de referencia.
- Dependencias solo hacia adentro: `presentation → domain ← data`; `solar_engine` no depende de nada de la app.
- Lint estricto (`very_good_analysis`), formato automático, CI que bloquea cambios sin pruebas verdes.

### B.3 Modelo de datos (SQLite / drift) — entidades principales
`Company` (perfil del instalador) · `Client` · `UtilityBill` (periodo, kWh, importe, tarifa) · `Project` (cliente, estado, ubicación, fecha) · `Site` (lat, lon, altitud, zona horaria, declinación magnética) · `RoofPlane` (polígono, inclinación, azimut, material opcional) · `Obstacle` (tipo, polígono/punto, altura) · `HorizonProfile` (azimut→elevación, origen: terreno/manual/cámara) · `WeatherDataset` (fuente, rango, resumen + archivo comprimido de serie horaria) · `PanelModel`, `InverterModel`, `BatteryModel` (catálogo) · `ArrayLayout` (paneles colocados, filas) · `StringConfig` · `ElectricalRun` (tramo, longitud, calibre, material, caída) · `ProtectionDevice` · `SingleLineDiagram` (JSON del grafo) · `SimulationResult` · `Quote` + `QuoteItem` · `Photo` (proyecto, etapa, ruta, hash, GPS) · `Document` · `MaintenancePlan`, `MaintenanceVisit` · `ProductionReading` · `BackupLog`.
Identificadores UUID (permiten restaurar/fusionar respaldos), `createdAt/updatedAt` en todas las tablas, borrado lógico.

### B.4 Fase Sitio — imagen satelital y techo ($0, uso comercial, mundial)
**Realidad importante:** Google Maps/Solar API exige tarjeta y prohíbe trazar/derivar datos de su imagen → descartado. Bing Maps para cuentas gratuitas fue retirado. Por eso se usa una **interfaz `ImageryProvider` intercambiable**:

| Prioridad | Proveedor | Por qué | Condición |
|---|---|---|---|
| 1 | **Esri World Imagery** vía cuenta gratuita *ArcGIS Location Platform* | Cobertura mundial, alta resolución (≈0.3–0.5 m urbano), cuota gratuita amplia, uso en apps permitido con atribución | Cada instalador (o la app) usa una API key gratuita. **Verificar en F0** si la cuenta pide tarjeta y si los términos permiten digitalizar techos. |
| 2 | **Ortofotos abiertas nacionales** (WMS): PNOA (España), IGN (Francia), PDOK (Países Bajos), USGS NAIP (EE. UU.), INEGI (México, donde exista) | Licencia abierta (CC‑BY / dominio público), excelente para trazar | Cobertura por país; se agregan como configuración en `regional_packs`. |
| 3 | **Foto de dron / imagen propia** | Licencia del propio usuario, máxima resolución | El usuario georreferencia con 2 puntos o mide una referencia. |
| 4 | **Modo sin imagen** | Trazado por medidas (cinta/AR) | Siempre disponible. |

Modelo de cobro sostenible: la app trae la key del desarrollador para la capa gratuita; si crece el uso, el plan Pro permite que cada instalador ponga su propia key gratuita ("BYO key") → el costo nunca recae en el desarrollador.

**Flujo semiautomático:**
1. Ubicación por GPS, dirección (geocodificación con Nominatim/Photon — gratuitas con límite de uso) o **enlace compartido** de Google Maps / Apple Maps (se extraen lat/lon del URL; enlaces cortos `maps.app.goo.gl` se expanden siguiendo la redirección).
2. Se consulta la **huella del edificio** en OpenStreetMap (API Overpass, ODbL, gratuita) → se propone como polígono inicial del techo. Si no existe, el usuario toca las esquinas.
3. El usuario ajusta vértices (con imán a ángulos de 90°), divide el techo en **planos** y asigna inclinación (medida en sitio con el inclinómetro del teléfono, o por tipo de techo) y orientación (auto desde el borde del polígono).
4. Agrega **obstáculos** (tinaco, antena, domo, pretil, AC, árbol, edificio vecino) con altura, y **zonas de exclusión/pasillos** de mantenimiento y retiros de borde.
5. Todo se guarda en coordenadas locales en metros (proyección ENU sobre el sitio).
Futuro: segmentación automática del techo con modelo ML en el dispositivo (MobileSAM/TFLite).

### B.5 Fuentes de clima e irradiancia (gratuitas, mundiales, uso comercial)
| Fuente | Uso | Datos | Licencia |
|---|---|---|---|
| **NASA POWER** (API sin key) | Serie principal: **últimos 5 años completos**, horaria | GHI, DNI, DHI, temperatura 2 m, viento 10 m, humedad, albedo | Datos abiertos NASA, uso comercial permitido con atribución |
| **PVGIS 5.3** (JRC‑UE, API sin key) | Validación cruzada + año meteorológico típico (TMY) + **horizonte de terreno** (montañas, p. ej. Sierra Madre en Monterrey) | Horaria 2005–2023 (SARAH/NSRDB/ERA5 según región) | Datos abiertos UE, atribución |
| NREL NSRDB (opcional, key gratis por email) | Mayor resolución en América | GHI/DNI/DHI 4 km | Pública |
| Open‑Meteo | **No** se usa: su API gratuita es solo no comercial | — | — |

Se descargan una vez, se guardan comprimidos con el proyecto y se muestra la atribución en reportes. Control de calidad: huecos, valores negativos, GHI > extraterrestre; diferencia NASA vs PVGIS anual > 10 % → advertencia.

### B.6 Fórmulas del motor (`solar_engine`) — para validación
Cada una tendrá su ficha en `docs/formulas/` con unidades y caso de prueba.

1. **Posición solar** — algoritmo **NREL SPA** (Reda & Andreas, 2004; error ±0.0003°). Salidas: cenit θz, elevación α = 90° − θz, azimut γs. Referencia rápida: declinación δ = 23.45°·sin(360/365·(284+n)) (Cooper, solo para explicaciones).
2. **Ángulo de incidencia** sobre el panel (inclinación β, azimut γ):
   cos θ = cos θz·cos β + sin θz·sin β·cos(γs − γ).
3. **Descomposición** (si solo hay GHI): modelo **Erbs** (1982) con índice de claridad kt = GHI / (I0·cos θz).
4. **Transposición al plano (POA)** — modelo **Perez 1990** (con Hay‑Davies como alternativa):
   POA = DNI·cos θ + DHI_difusa(Perez) + GHI·ρ·(1 − cos β)/2, con albedo ρ (NASA POWER o 0.2).
5. **Modificador de ángulo de incidencia (IAM)** — ASHRAE: IAM = 1 − b0·(1/cos θ − 1), b0 = 0.05.
6. **Temperatura de celda** — **Faiman** (PVsyst/IEC 61853): Tc = Ta + POA / (U0 + U1·v), U0 = 25 W/m²K, U1 = 6.84 W·s/m³K; alternativa NOCT.
7. **Potencia DC** — modelo **PVWatts**: Pdc = Pstc·(POA_ef/1000)·[1 + γP·(Tc − 25)], con γP del datasheet (p. ej. −0.35 %/°C). Clave en climas cálidos como Monterrey.
8. **Pérdidas** (desglose editable, multiplicativo): suciedad 2–5 %, desajuste 2 %, cableado DC 2 %, conexiones 0.5 %, LID 1.5 %, disponibilidad 3 %, nameplate 1 %, sombra (calculada), degradación anual 0.4–0.7 %/año.
9. **Inversor** — curva de eficiencia PVWatts (η nominal del datasheet) + **recorte (clipping)** cuando Pdc > Pac,max; relación DC/AC recomendada 1.1–1.35.
10. **Inclinación y azimut óptimos** — búsqueda numérica que maximiza la energía anual simulada (no la regla "inclinación = latitud", que solo se muestra como referencia).
11. **Sombra / separación entre filas**:
    largo de sombra L = h · cos(γs − γ) / tan α; separación d = L evaluada en el **solsticio de invierno entre 9:00 y 15:00 hora solar** (criterio estándar), h = altura del borde superior del panel inclinado sobre el anterior = largo·sin β.
12. **Sombras de obstáculos** — por hora: rayo desde cada panel hacia el sol; si intersecta un obstáculo (prisma extruido) o está bajo el horizonte → se elimina el componente directo; la difusa se reduce por el factor de vista del cielo. Resultado: factor de sombra horario por panel y mapa de calor anual.
13. **Máximo de paneles** — empaquetado rectangular en cada plano útil (polígono − retiros − obstáculos − pasillos), probando orientación vertical/horizontal y desplazamientos de rejilla; se elige la que maximiza energía (no solo cantidad).
14. **Strings** (temperaturas mínima/máxima del sitio a partir de los 5 años):
    - Voc,máx = Voc·[1 + βVoc·(Tmin − 25)]·Nserie ≤ Vmáx del inversor (y ≤ 600/1000/1500 V según norma).
    - Vmp,mín = Vmp·[1 + βVmp·(Tc,máx − 25)]·Nserie ≥ Vmín del MPPT.
    - Isc·1.25 ≤ Imáx de entrada del MPPT; conductores y fusibles a 1.25·1.25·Isc (NOM‑001‑SEDE‑2012 / NEC art. 690).
15. **Caída de tensión** — DC: ΔV = 2·L·I·R/1000 (R en Ω/km del calibre, corregida a temperatura); AC monofásica igual, trifásica √3·L·I·R. Límite: ≤ 3 % por circuito, ≤ 5 % total. Se sugiere el calibre mínimo que cumple ampacidad y caída.
16. **Puesta a tierra y protecciones** — selección de interruptores, fusibles de string (si > 2 strings en paralelo), DPS/SPD en CD y CA, desconectadores, conductor de puesta a tierra por tabla de la norma regional.
17. **Viento** — ASCE 7‑22 genérico: qz = 0.613·Kz·Kzt·Kd·Ke·V² (N/m²) y presión neta p = qz·GCrn (coeficientes para paneles en techo); paquete México: **Manual de Diseño de Obras Civiles CFE – Diseño por Viento (2020)** con velocidad regional por ciudad. Salida: fuerza por anclaje y advertencia de lastre/anclaje. (Siempre "indicativo, requiere validación estructural".)
18. **Económico** — producción anual con degradación; ahorro según tarifa (paquete regional: tarifas CFE 1–1F, DAC, PDBT, GDMTH como tablas editables, con escalones y medición neta/neta‑facturación); VPN, TIR, payback simple y descontado, LCOE = Σ costos descontados / Σ energía descontada; escenario con baterías (autoconsumo horario contra perfil de consumo).

**Cómo se valida la interpretación:** se compara contra **pvlib‑python** (biblioteca de referencia de Sandia/NREL), **NREL SAM / PVWatts** y la calculadora **PVGIS** para los mismos sitios (Monterrey, CDMX, Hermosillo, Madrid, Bogotá, Phoenix). Ver sección D.

### B.7 Sombras reales en sitio — opciones (procesamiento local)
| Opción | Cómo funciona | Dificultad | Fase |
|---|---|---|---|
| **A. Horizonte de terreno (PVGIS)** | Descarga automática del perfil de montañas | Baja | MVP |
| **B. Obstáculo por inclinómetro + brújula** | El técnico apunta el teléfono a la parte alta del árbol/edificio: la app lee azimut (brújula, corregida por declinación magnética con el modelo WMM) y elevación (acelerómetro). Varios puntos forman el perfil. | Baja‑media | MVP |
| **C. Obstáculos del techo en 3D** | Tinacos/pretiles del trazado se extruyen y proyectan sombra hora por hora | Media | MVP |
| **D. Cámara con guías (tipo "Solar Pathfinder" digital)** | Vista de cámara con la trayectoria solar dibujada encima (solsticios y equinoccios, horas). El usuario barre de este a oeste y toca/traza el borde de los obstáculos; opcional: detección automática de cielo por color/brillo. Genera perfil de horizonte y % de pérdida por mes. | Alta | Fase posterior |
| E. LiDAR (iPhone Pro) / ML de segmentación de cielo | Medición automática de distancias/alturas | Alta | Futuro |

### B.7.1 Cómo se calcula la sombra de tinacos, antenas, pretiles y árboles (paso a paso)
No hace falta "ver" la sombra con la cámara: si sabemos **dónde está el objeto, qué tan alto es y dónde está el sol**, la sombra se calcula con geometría, igual que un software profesional (PVsyst, Aurora, SketchUp).

**Paso 1 — Capturar el obstáculo (2 datos: huella y altura)**
- *Huella*: sobre la imagen del techo el usuario toca "Agregar obstáculo" y elige un tipo con forma predefinida: tinaco (círculo; tamaños comunes 450/750/1100/2500 L), antena (punto + altura), pretil (línea + altura), tanque de gas, minisplit, domo, cubo de escalera (rectángulo), árbol (círculo de copa), edificio vecino (polígono). Lo arrastra a su lugar y ajusta el tamaño.
- *Altura*: (a) valor típico del catálogo (tinaco 1100 L ≈ 1.10 m Ø × 1.45 m + base); (b) cinta métrica; (c) **con el teléfono**: el técnico se para a una distancia conocida *d*, apunta al tope del objeto y la app lee el ángulo *a* → altura = d·tan(a) + altura de los ojos. Para árboles/edificios fuera del techo funciona igual.

**Paso 2 — Posición del sol hora por hora**
El motor (algoritmo NREL SPA) calcula para cada hora del año la elevación α y el azimut γs del sol en esa ubicación. Ya considera las estaciones automáticamente.

**Paso 3 — Proyectar la sombra**
Cada obstáculo se trata como un sólido (cilindro, caja o muro). Su sombra sobre el techo plano es su huella **desplazada** en dirección opuesta al sol una distancia
  L = h / tan α
y la sombra completa es la envolvente entre la huella original y la desplazada. En techos inclinados el mismo rayo se interseca con el plano del techo.
*Ejemplo real, Monterrey (lat 25.7°), tinaco de 1.7 m con base:*
| Momento | Elevación del sol | Largo de sombra |
|---|---|---|
| 21 dic, 12:00 solar | 40.9° | 1.7 / tan 40.9° ≈ **1.97 m** hacia el norte |
| 21 dic, 9:00 solar | 24.3° | ≈ **3.77 m** hacia el noroeste |
| 21 jun, 12:00 solar | 87.8° | ≈ **0.07 m** (casi nula) |
Por eso un tinaco puede no afectar en verano y sí en invierno: el cálculo lo detecta solo.

**Paso 4 — ¿Qué paneles toca y cuánto?**
Para cada hora se calcula qué porcentaje de cada panel queda dentro de alguna sombra. Se pondera por la irradiancia directa de esa hora (una sombra a las 7 am pesa poco; a mediodía pesa mucho). Resultado por panel: **% de energía perdida al año** y por mes.

**Paso 5 — Efecto eléctrico**
Un panel parcialmente sombreado afecta a todo su string. Modelo simplificado estándar: cada panel tiene 3 diodos bypass (3 secciones); una sección sombreada se "apaga" y el string pierde ese voltaje. Con microinversores u optimizadores solo pierde el panel afectado. Así la app puede recomendar mover paneles o cambiar a microinversores.

**Paso 6 — Difusa y lo que se ve**
La luz difusa (cielo) se reduce según cuánto cielo tapa el obstáculo (factor de vista de cielo). En pantalla el usuario ve:
- **Deslizador de fecha y hora** que dibuja las sombras animadas sobre el techo (lo más útil para explicarle al cliente).
- **Mapa de calor** anual de sombra sobre el techo.
- Paneles en rojo/amarillo/verde según pérdida; los que superen un umbral (p. ej. 10 %) se excluyen automáticamente al calcular el máximo de paneles.

**Validación**: casos de prueba con resultado conocido (objeto de 1 m con sol a 45° → sombra de 1 m; mediodía de equinoccio en el ecuador → sombra nula) y comparación con pvlib/PVsyst en un proyecto real.

### B.8 Diagrama unifilar
El diseño se guarda como un **grafo** (paneles → strings → caja combinadora/fusibles → desconectador CD → inversor → protección CA → tablero → medidor bidireccional → red). Un generador lo dibuja con símbolos IEC 60617 (opción ANSI), con cuadro de datos (calibres, protecciones, Voc/Isc, potencia, norma). Exporta SVG/PDF. Editable para casos especiales. Incluye checklist de documentos de interconexión del paquete regional (México: solicitud CFE, contrato de contraprestación, medidor bidireccional, dictamen UVIE si aplica).

### B.9 Respaldo en Google Drive (recomendación)
- **Opcional**: el usuario inicia sesión con Google desde Ajustes.
- Se guarda en la carpeta **oculta y privada de la app** en su Drive (`appDataFolder`, scope `drive.appdata`): el usuario no la ve ni la borra por accidente, y el scope no es "restringido" (evita la auditoría de seguridad costosa de Google — **verificar en F0**).
- **Qué se respalda**: instantánea de la base de datos (comprimida y opcionalmente cifrada) + fotos/documentos **incrementales** (solo los nuevos, identificados por hash).
- **Cuándo**: automático **diario** en segundo plano solo con Wi‑Fi y batería suficiente (WorkManager), **al finalizar un proyecto**, y botón **"Respaldar ahora"**. El usuario puede cambiarlo a semanal o manual.
- **Retención**: últimas 7 diarias + 4 semanales.
- **Restaurar**: en dispositivo nuevo, iniciar sesión → elegir respaldo → restaurar.
- Además: **exportar a archivo .zip** (sin Google) para compartir o guardar en cualquier lugar.
- iOS posterior: misma lógica, opción iCloud.

### B.10 Datos adicionales recomendados (para que decidas dónde van)
- **Albedo** del entorno y **nieve** (para uso mundial).
- **Paneles bifaciales**, microinversores y optimizadores.
- **Apagado rápido** (rapid shutdown, NEC 690.12) donde aplique.
- **DPS/pararrayos** según nivel ceráunico de la zona.
- **Cargas futuras** (vehículo eléctrico, minisplits) en el dimensionamiento.
- **Límites de interconexión** del país (México: ≤ 500 kW generación distribuida) y capacidad del transformador/acometida.
- **Números de serie y garantías** de cada equipo, con etiqueta QR del proyecto.
- **Protocolo de puesta en marcha IEC 62446‑1** como checklist (ya incluido en Instalación).
- **Seguimiento real vs. esperado** (Performance Ratio) — ya incluido.
- **Material y estado del techo**, carga admisible, anclaje e impermeabilización — pendiente para fase futura como acordamos.

---

## C. Forma de desarrollo

- **Metodología**: iterativa por fases (sección E); cada fase termina con una versión instalable (APK) que el dueño prueba.
- **Ramas**: `main` siempre estable; trabajo en ramas por tarea; integración vía Pull Request con CI verde.
- **Commits**: Conventional Commits (`feat(site): ...`, `fix(engine): ...`) → historial legible y changelog automático.
- **CI (GitHub Actions, gratuito)**: formato + análisis estático + pruebas unitarias/widget + cobertura mínima del motor 90 % + compilación del APK como artefacto descargable.
- **Versionado**: SemVer (`1.4.2`), migraciones de BD numeradas y probadas.
- **Documentación viva**: `CLAUDE.md` (cómo trabajar en el repo), `README.md` por módulo, ADRs para cada decisión, fichas de fórmulas, changelog.
- **Cómo pedir cambios en el futuro**: abrir un *issue* con plantilla ("qué pasa", "qué esperabas", captura, versión de la app) → Claude ubica el módulo por su README, escribe primero una prueba que reproduce el problema, corrige y abre PR.
- **Publicación**: Google Play (cuenta de desarrollador: pago único de 25 USD — único costo inevitable) con canal de prueba interna → producción. iOS en fase posterior (cuenta Apple 99 USD/año + compilación en la nube con Codemagic o GitHub Actions macOS).

## D. Pruebas

| Nivel | Qué | Herramienta |
|---|---|---|
| Unitarias del motor | Cada fórmula contra **datos "golden" generados con pvlib** (tolerancias: posición solar ±0.01°, POA ±1 %, energía anual ±2 %) | `test` (Dart) + `tools/golden_data` (Python/pvlib) |
| Validación cruzada | Energía anual vs **PVWatts (NREL)** y **PVGIS** para 6 sitios de referencia (±5 %) | Pruebas de integración |
| Geometría | Polígonos, empaquetado, sombras con casos conocidos (solsticios, mediodía) | Unitarias |
| Base de datos | Cada migración desde la versión anterior sin pérdida | `drift` migration tests |
| UI | Pantallas y flujos principales | widget tests + `integration_test` en emulador |
| Visuales | Unifilar y reportes PDF (imagen de referencia) | golden tests |
| Respaldo | Respaldar → borrar → restaurar = mismos datos | integración |
| Campo | Comparar la predicción contra **tus instalaciones reales con monitoreo** (objetivo: error anual ≤ ±10 %) y medición de sombras en sitio | Protocolo en `docs/pruebas/` |
| Aceptación | Lista de verificación por fase que firma el dueño | Manual |

## E. Fases (orden recomendado)

| Fase | Entregable | Incluye |
|---|---|---|
| **F0 Cimientos** | Repo y APK vacío navegable | Estructura de paquetes, CLAUDE.md, CI, tema/UI base, i18n es/en, BD + migraciones, verificación de licencias (Esri, Drive scopes), ADRs |
| **F1 Clientes y proyectos** | App útil desde el día 1 | CRUD clientes/proyectos, ubicación (GPS/dirección/enlace), fotos, documentos, recibos y gráfica de consumo |
| **F2 Motor solar + clima** | Producción estimada | `solar_engine` (B.6 1–10, 18 parcial), NASA POWER + PVGIS, caché, estadísticas por estación, validación golden |
| **F3 Sitio y techo** | Plano del techo | Mapa satelital, huella OSM, trazado de planos, inclinómetro, obstáculos, horizonte (B.7 A–C) |
| **F4 Diseño FV** | Arreglo completo | Máximo de paneles, separación de filas, sombras, catálogo de equipos (+ importación CEC), strings, DC/AC, cableado, protecciones, viento |
| **F5 Unifilar y reportes** | PDF profesional | Unifilar automático, reporte técnico, cotización, ROI/escenarios con baterías, paquete regional México (CFE/NOM) |
| **F6 Operación** | Postventa | Puesta en marcha IEC 62446‑1, plan y calendario de mantenimiento, seguimiento de producción/PR, respaldo Drive + exportar .zip |
| **F7 Producto** | Publicación | Freemium (in_app_purchase), pruebas de campo, Google Play |
| **F8 iOS** | Versión iPhone | Ajustes de plataforma, iCloud opcional, App Store |
| **Futuro** | — | Cámara con trayectoria solar (B.7 D), ML de techo, material/estado del techo, más paquetes regionales, integración con APIs de inversores |

## Verificación del plan
- Al cerrar F0: `flutter analyze` y `flutter test` en verde en CI, APK descargable desde GitHub Actions instalado en un Android real.
- Al cerrar F2: reporte de comparación motor vs pvlib/PVWatts/PVGIS para los 6 sitios dentro de tolerancia.
- En cada fase: lista de aceptación en `docs/pruebas/fase-N.md` revisada por el dueño en su teléfono.

## Primer paso tras aprobar
Escribir este plan dentro del repo como `docs/producto/plan-maestro.md` + ADRs iniciales, y comenzar F0 en la rama `ccr-4f7d63d4-px61ld`.
