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
