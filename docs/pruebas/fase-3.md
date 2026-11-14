# Aceptación — Fase F3 (Sitio y techo)

Lista para el dueño. Marca cada casilla en tu teléfono Android. Si algo falla, abre un *issue* con la plantilla **Error (bug)** e incluye una captura.

> El APK con F3 aparece en el enlace fijo **cuando el chat principal integre la rama `fase-3-sitio-techo`** en la rama base (ADR-006):
> **https://github.com/Navaleitor/Panelsolar/releases/latest/download/panelsolar.apk**
> Se instala encima de la versión anterior y conserva tus datos.

Necesitas: un proyecto con ubicación guardada, una **cinta métrica** y, para la prueba de precisión, un techo que conozcas (el tuyo sirve).

## 1. Entrar al módulo Techo
1. **Proyectos** → abre un proyecto → toca la tarjeta **Techo** (debajo de la ubicación).
   - [ ] Dice "Importa una imagen vista desde arriba o dibuja un croquis…".

## 2. Importar tu imagen
1. Toca **Importar imagen**.
   - [ ] Aparece el aviso **"Usa solo imágenes que tengas derecho a usar."** y las opciones Galería y Cámara.
   - [ ] Ningún texto de la app menciona a Google, Esri ni otro proveedor.
2. Elige una imagen **vista desde arriba** de tu techo (captura, foto de dron o plano).
   - [ ] Se abre el editor en **Calibrar** y arriba dice "Primero calibra la escala…".

## 3. Calibrar la escala
1. Haz zoom con dos dedos. Toca los dos extremos de un lado que hayas medido con cinta (por ejemplo, el frente).
2. Escribe la medida real en metros → **Guardar**.
   - [ ] Abajo aparece "Escala: 1 píxel = … cm (… píxeles por metro)".
3. **Verificar:** toca la herramienta **Verificar** y traza otro lado que también hayas medido. Escribe su medida.
   - [ ] Aparece "Mide X m contra Y m reales: ±Z %". Si Z pasa de 5 %, sale un aviso en rojo (la imagen está inclinada o una medida está mal).
4. Puedes recalibrar cuando quieras: vuelve a **Calibrar** y traza otra línea. Lo ya dibujado se ajusta solo.

## 4. Orientar al norte
1. Herramienta **Norte**. La flecha de arriba a la derecha empieza apuntando hacia arriba.
   - [ ] Al mover el deslizador la flecha gira; dice "girado a mano".
2. **En el techo:** toca dos puntos de una orilla de la imagen (de izquierda a derecha). Toca **Confirmar con brújula**, acuesta el teléfono sobre esa orilla real, con la parte de arriba apuntando del primer punto al segundo, lejos de tinacos o varillas.
   - [ ] El diálogo muestra el rumbo y la declinación magnética (en Monterrey ≈ 4° al este).
   - [ ] Al tocar **Usar**, la flecha queda girada y dice "confirmado con brújula".

## 5. Trazar el techo
1. Herramienta **Trazar**. Toca cada esquina del techo.
   - [ ] En cada lado aparece su medida en metros; en las esquinas, el ángulo; abajo, los lados y el área.
   - [ ] Con **Imán** encendido, las esquinas casi rectas quedan exactamente a 90° y los puntos cercanos a otro vértice se pegan.
2. Toca la primera esquina (o **Cerrar plano**).
   - [ ] Aparece "Plano 1" con su área.
3. **Elegir** → toca el plano.
   - [ ] Abajo: área vista desde arriba, área real inclinada, área útil, inclinación y azimut.
   - [ ] Toca **Editar**: cambia la inclinación escribiéndola o con **Inclinómetro** (apoya el teléfono en el techo). El valor coincide con un nivel de burbuja o un transportador (±1°).
   - [ ] En **Orilla baja (alero)** elige el lado donde escurre el agua: el azimut cambia (180° = sur).
   - [ ] Escribe un **retiro de borde** (p. ej. 0.5 m): aparece una línea verde por dentro y el área útil baja.
   - [ ] **Dividir:** elige dos esquinas no vecinas y toca Dividir: quedan dos planos.
   - [ ] Para mover una esquina: tócala (se pone roja) y luego toca su nuevo lugar.
4. **Pasillos:** toca los dos extremos de un pasillo dentro del plano y escribe su ancho (0.6 m).
   - [ ] Aparece una franja verde y el área útil baja.

## 6. Prueba de precisión (±5 %)
Mide con cinta dos lados de tu techo (largo y ancho de un plano rectangular).
- [ ] Los lados trazados en la app difieren **menos de 5 %** de la cinta.
- [ ] El área difiere menos de 5 % de largo × ancho medidos.

## 7. Obstáculos
1. Herramienta **Obstáculos** → elige **Tinaco** → toca donde está.
   - [ ] Puedes elegir 450, 750, 1100 o 2500 L: cambian diámetro y altura típica (1100 L → 1.70 m con base).
   - [ ] Al escribir otra altura queda como "Cinta".
   - [ ] **Teléfono:** escribe la distancia (p. ej. 10 m), apunta la cámara al tope (o escribe el ángulo, p. ej. 30°) y tu altura de ojos (1.5 m) → "Altura: 7.27 m".
2. Agrega también una antena, un pretil (toca sus dos extremos), un minisplit y un cubo de escalera.
   - [ ] Cada uno se dibuja en naranja con su forma. En **Elegir**, tocar uno abre su edición; ahí se puede borrar.

## 8. Sombras
1. Regresa a **Techo** → **Sombras**.
   - [ ] Arriba de los deslizadores dice "Sol: X° de altura, azimut Y°".
   - [ ] Al mover la **hora**, las sombras negras giran: en la mañana hacia el oeste, en la tarde hacia el este.
   - [ ] En **diciembre** al mediodía la sombra del tinaco es más larga que en **junio** (en Monterrey casi no hay sombra en junio a mediodía).
   - [ ] De noche dice que el sol está abajo y no hay sombras.
2. Toca **Mapa de calor anual** (tarda unos segundos, sin congelar la pantalla).
   - [ ] El techo se pinta de verde a rojo; lo más rojo queda junto y al norte de los obstáculos altos.
   - [ ] Abajo: "Plano 1: pierde X % del sol directo al año (diciembre …, junio …)", con diciembre mayor que junio.

## 9. Horizonte
1. **Techo** → **Horizonte** → **Descargar** (necesita Internet).
   - [ ] Dice "Descargado · altura máxima …" y la gráfica muestra el perfil de las montañas (en Monterrey, alto hacia el sur y el oeste) con la atribución de PVGIS.
2. **Obstáculo lejano:** escribe un nombre ("Árbol del vecino"), apunta la cámara al borde de arriba de un árbol de izquierda a derecha y toca **Medir punto** varias veces (o escribe azimut y altura).
   - [ ] Aparece en la lista y en la gráfica; el mapa de calor lo toma en cuenta.

## 10. Modo sin imagen
1. En otro proyecto: **Techo** → **Croquis con cinta**. Escribe 10, 8, 10, 8 (giros de 90°).
   - [ ] Dice "Área: 80 m² · cierre: 0 m" y al guardar aparece "Plano 1" de 80 m² en una cuadrícula de 1 m.
   - [ ] Si escribes 10, 8, 9.8, 8 avisa que las medidas no cierran.
   - [ ] Para una "L" usa −90 en la esquina que va hacia adentro.

## 11. Idioma
- [ ] Con el teléfono en inglés, los textos del módulo Techo están traducidos.

## Para revisión técnica (GitHub)
- Pruebas automáticas: `packages/geo_kit/test`, `packages/solar_engine/test/shading`, `packages/persistence/test` (migración v3 → v5) y `app/test/features/roof` (incluye la **aceptación automática**: techo de 12 × 9 m con toques imprecisos dentro de ±5 %).
- Fichas: `docs/formulas/16` a `21`.
