// Enumeraciones que se guardan en la base como texto (`Enum.name`).
//
// IMPORTANTE: el nombre de cada valor es lo que queda escrito en SQLite.
// Nunca renombrar ni borrar un valor sin una migración que convierta los
// datos existentes; agregar valores nuevos al final sí es seguro.

/// Estado comercial/técnico de un proyecto (plan A.2, F1).
enum ProjectStatus {
  /// Cliente interesado, sin diseño.
  prospect,

  /// En diseño (sitio, techo, arreglo).
  design,

  /// Cotización entregada.
  quoted,

  /// Sistema instalado.
  installed,

  /// En postventa / mantenimiento.
  maintenance,
}

/// Cómo se obtuvo la ubicación de un sitio.
enum LocationSource {
  /// GPS del teléfono.
  gps,

  /// Dirección convertida a coordenadas (geocodificación).
  address,

  /// Enlace compartido de Google Maps o Apple Maps.
  mapLink,

  /// Coordenadas escritas a mano.
  manual,
}

/// Etapa del proyecto a la que pertenece una foto.
enum PhotoStage {
  /// Levantamiento (visita inicial).
  survey,

  /// Instalación.
  installation,

  /// Mantenimiento.
  maintenance,
}

/// Tipo de archivo de un documento adjunto.
enum DocumentKind {
  /// Archivo PDF.
  pdf,

  /// Imagen (JPEG, PNG, ...).
  image,
}

/// Duración del periodo de facturación de un recibo de luz.
enum BillingPeriod {
  /// Un mes.
  monthly,

  /// Dos meses (residencial CFE).
  bimonthly,
}

/// Cómo se obtuvo el plano del techo (F3).
enum RoofMode {
  /// Imagen importada por el usuario (vista desde arriba) y calibrada.
  image,

  /// Croquis a escala con medidas de cinta (sin imagen).
  sketch,
}

/// De dónde salió la orientación al norte del plano del techo.
enum NorthSource {
  /// Norte arriba (valor por defecto, sin confirmar).
  imageUp,

  /// El usuario giró la flecha a mano.
  manual,

  /// Confirmada con la brújula del teléfono (corregida por declinación).
  compass,
}

/// De dónde salió la inclinación de un plano del techo.
enum TiltSource {
  /// Escrita a mano.
  manual,

  /// Medida con el inclinómetro del teléfono apoyado en el techo.
  inclinometer,
}

/// Tipo de obstáculo (B.7.1). Mismos nombres que `ObstacleType` de geo_kit.
enum ObstacleKind {
  /// Tinaco.
  waterTank,

  /// Antena o mástil.
  antenna,

  /// Pretil.
  parapet,

  /// Tanque de gas.
  gasTank,

  /// Condensadora de minisplit.
  minisplit,

  /// Domo o tragaluz.
  dome,

  /// Cubo de escalera.
  stairwell,

  /// Árbol.
  tree,

  /// Edificio vecino.
  neighborBuilding,
}

/// Forma de la huella de un obstáculo. Mismos nombres que `ObstacleShape`
/// de geo_kit.
enum ObstacleOutline {
  /// Círculo.
  circle,

  /// Rectángulo.
  rectangle,

  /// Línea con espesor.
  line,

  /// Punto.
  point,

  /// Polígono libre.
  polygon,
}

/// De dónde salió la altura de un obstáculo.
enum HeightSource {
  /// Valor típico del catálogo.
  typical,

  /// Medida con cinta.
  tape,

  /// Medida con el teléfono (distancia × tan(ángulo) + altura de ojos).
  phone,
}

/// Origen de un perfil de horizonte (B.3).
enum HorizonSource {
  /// Terreno (montañas), descargado de PVGIS.
  terrain,

  /// Obstáculo lejano medido con brújula e inclinómetro.
  manual,

  /// Cámara con guías (fase posterior).
  camera,
}

/// De dónde salió un equipo del catálogo (F4).
enum EquipmentSource {
  /// Capturado a mano por el instalador (hoja de datos).
  manual,

  /// Importado del catálogo público CEC/SAM.
  cec,
}

/// Tipo de celda de un panel (F4).
enum CellType {
  /// Silicio monocristalino.
  mono,

  /// Silicio policristalino.
  poly,

  /// Película delgada.
  thinFilm,

  /// Otro.
  other,
}

/// Tipo de inversor (F4).
enum InverterKind {
  /// Inversor de string (central).
  string,

  /// Microinversor (uno por panel o por pocos paneles).
  micro,

  /// Híbrido (con baterías).
  hybrid,
}

/// Química de una batería (F4).
enum BatteryChemistry {
  /// Litio hierro fosfato.
  lfp,

  /// Litio níquel manganeso cobalto.
  nmc,

  /// Plomo ácido.
  leadAcid,

  /// Otra.
  other,
}

/// Orientación de los paneles en el arreglo (F4).
enum LayoutOrientation {
  /// Vertical: el lado largo sube con la pendiente.
  portrait,

  /// Horizontal.
  landscape,
}

/// Montaje de los paneles (F4).
enum MountType {
  /// Pegados al techo (paralelos al plano).
  flush,

  /// Estructura inclinada sobre techo plano, en filas.
  tiltedRack,
}

/// Tramo de cableado (F4).
enum RunKind {
  /// Del string al inversor (CD).
  dcString,

  /// Del inversor al tablero (CA).
  acOutput,
}

/// Material del cable (F4).
enum CableMaterial {
  /// Cobre.
  copper,

  /// Aluminio.
  aluminum,
}

/// Tipo de canalización (F4).
enum RacewayKind {
  /// Tubo en azotea al sol, a menos de 13 mm del techo.
  rooftopUnder13mm,

  /// Tubo en azotea al sol, de 13 a 90 mm.
  rooftop13to90mm,

  /// Tubo en azotea al sol, de 90 a 300 mm.
  rooftop90to300mm,

  /// Tubo en azotea al sol, de 300 a 900 mm.
  rooftop300to900mm,

  /// Tubo en interior o a la sombra.
  indoorConduit,

  /// Charola o al aire libre a la sombra.
  freeAir,

  /// Enterrado.
  buried,
}

/// Tipo de protección (F4).
enum ProtectionDeviceKind {
  /// Fusible de string.
  stringFuse,

  /// Desconectador de CD.
  dcDisconnect,

  /// DPS en CD.
  dcSpd,

  /// Interruptor de CA.
  acBreaker,

  /// DPS en CA.
  acSpd,

  /// Conductor de puesta a tierra.
  groundingConductor,
}
