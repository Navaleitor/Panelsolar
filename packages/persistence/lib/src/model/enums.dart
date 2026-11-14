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

/// Tipo de equipo instalado en un proyecto (F6).
enum EquipmentKind {
  /// Panel / módulo fotovoltaico.
  panel,

  /// Inversor de string o central.
  inverter,

  /// Microinversor.
  microinverter,

  /// Optimizador de potencia.
  optimizer,

  /// Batería.
  battery,

  /// Medidor.
  meter,

  /// Protección (interruptor, fusible, DPS...).
  protection,

  /// Estructura de montaje.
  structure,

  /// Otro equipo.
  other,
}

/// Resultado de la puesta en marcha (IEC 62446-1).
enum CommissioningStatus {
  /// Aún no se revisa o falta información.
  pending,

  /// Sin fallas.
  approved,

  /// Aprobada con observaciones por corregir.
  observations,
}

/// Tipo de servicio de mantenimiento (F6).
enum MaintenanceServiceKind {
  /// Limpieza de paneles.
  cleaning,

  /// Inspección visual.
  visualInspection,

  /// Apriete de conexiones.
  connectionTightening,

  /// Revisión del inversor.
  inverterCheck,

  /// Revisión de protecciones.
  protectionsCheck,

  /// Termografía (opcional).
  thermography,

  /// Servicio personalizado.
  other,
}

/// Destino de un respaldo.
enum BackupTarget {
  /// Archivo .zip local.
  zip,

  /// Carpeta privada de la app en Google Drive.
  drive,
}

/// Qué inició un respaldo.
enum BackupTrigger {
  /// Botón "Respaldar ahora" o exportación manual.
  manual,

  /// Tarea diaria en segundo plano.
  daily,

  /// Al pasar un proyecto a Instalado.
  projectFinished,

  /// Restauración (se registra también).
  restore,
}

/// Resultado de un respaldo.
enum BackupStatus {
  /// Terminó bien.
  success,

  /// Falló (ver mensaje).
  failed,
}
