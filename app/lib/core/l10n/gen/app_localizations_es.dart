// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Panelsolar';

  @override
  String get navClients => 'Clientes';

  @override
  String get navProjects => 'Proyectos';

  @override
  String get navCatalog => 'Catálogo';

  @override
  String get navMaintenance => 'Mantenimiento';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get clientsDescription =>
      'Datos de contacto, recibos de luz y consumo de cada cliente.';

  @override
  String get projectsDescription =>
      'Sitio, techo, clima, diseño y reportes de cada instalación.';

  @override
  String get catalogDescription =>
      'Paneles, inversores, baterías y estructuras.';

  @override
  String get maintenanceDescription =>
      'Plan de servicios, recordatorios y bitácora de visitas.';

  @override
  String get settingsDescription =>
      'Perfil de empresa, idioma, unidades y respaldo.';

  @override
  String comingInPhase(String phase) {
    return 'Disponible en la fase $phase.';
  }

  @override
  String get settingsDatabaseTitle => 'Base de datos';

  @override
  String settingsDatabaseOk(int version) {
    return 'Funcionando · esquema v$version';
  }

  @override
  String get settingsDatabaseError => 'Error al abrir la base de datos';

  @override
  String get actionAdd => 'Agregar';

  @override
  String get actionCancel => 'Cancelar';

  @override
  String get actionChange => 'Cambiar';

  @override
  String get actionContinue => 'Continuar';

  @override
  String get actionCopy => 'Copiar';

  @override
  String get actionDelete => 'Borrar';

  @override
  String get actionEdit => 'Editar';

  @override
  String get actionOpen => 'Abrir';

  @override
  String get actionPaste => 'Pegar';

  @override
  String get actionRename => 'Renombrar';

  @override
  String get actionSave => 'Guardar';

  @override
  String get actionSearch => 'Buscar';

  @override
  String get errorGeneric => 'Algo salió mal. Intenta de nuevo.';

  @override
  String get copied => 'Copiado';

  @override
  String get filterAll => 'Todos';

  @override
  String get validationRequired => 'Obligatorio';

  @override
  String get validationEmail => 'Correo no válido';

  @override
  String get validationPhone => 'Teléfono no válido (mínimo 7 dígitos)';

  @override
  String get validationNumber => 'Número no válido';

  @override
  String get validationPeriod =>
      'El fin del periodo no puede ser antes del inicio';

  @override
  String get validationTimeZone =>
      'Zona horaria desconocida (ej. America/Monterrey)';

  @override
  String get fieldName => 'Nombre';

  @override
  String get fieldPhone => 'Teléfono';

  @override
  String get fieldEmail => 'Correo';

  @override
  String get fieldAddress => 'Dirección';

  @override
  String get fieldNotes => 'Notas';

  @override
  String get fieldClient => 'Cliente';

  @override
  String get fieldProjectName => 'Nombre del proyecto';

  @override
  String get fieldStatus => 'Estado';

  @override
  String get fieldDate => 'Fecha';

  @override
  String get fieldAltitude => 'Altitud (opcional)';

  @override
  String get fieldTimeZone => 'Zona horaria';

  @override
  String get fieldTariff => 'Tarifa';

  @override
  String get fieldPeriodStart => 'Inicio del periodo';

  @override
  String get fieldPeriodEnd => 'Fin del periodo';

  @override
  String get fieldEnergyKwh => 'Consumo';

  @override
  String get fieldAmount => 'Importe (opcional)';

  @override
  String get clientsSearchHint =>
      'Buscar por nombre, teléfono, correo o dirección';

  @override
  String get clientsEmpty => 'Aún no hay clientes. Toca «Nuevo cliente».';

  @override
  String get clientsNoMatches => 'Ningún cliente coincide con la búsqueda.';

  @override
  String get clientNew => 'Nuevo cliente';

  @override
  String get clientEdit => 'Editar cliente';

  @override
  String get clientNotFound => 'Este cliente ya no existe.';

  @override
  String get clientNoContact => 'Sin datos de contacto';

  @override
  String get clientProjectsTitle => 'Proyectos';

  @override
  String get clientNoProjects => 'Sin proyectos';

  @override
  String get clientDeleteTitle => '¿Borrar cliente?';

  @override
  String get clientDeleteMessage =>
      'También se ocultarán sus proyectos y recibos. Se puede recuperar desde un respaldo.';

  @override
  String get projectsSearchHint => 'Buscar por proyecto o cliente';

  @override
  String get projectsEmpty => 'No hay proyectos.';

  @override
  String get projectNew => 'Nuevo proyecto';

  @override
  String get projectEdit => 'Editar proyecto';

  @override
  String get projectNotFound => 'Este proyecto ya no existe.';

  @override
  String get projectNeedsClient => 'Primero da de alta un cliente.';

  @override
  String get projectDeleteTitle => '¿Borrar proyecto?';

  @override
  String get projectDeleteMessage =>
      'Se ocultará junto con sus fotos y documentos. Se puede recuperar desde un respaldo.';

  @override
  String get statusProspect => 'Prospecto';

  @override
  String get statusDesign => 'Diseño';

  @override
  String get statusQuoted => 'Cotizado';

  @override
  String get statusInstalled => 'Instalado';

  @override
  String get statusMaintenance => 'Mantenimiento';

  @override
  String get locationTitle => 'Ubicación';

  @override
  String get locationNone => 'Sin ubicación';

  @override
  String get locationIntro =>
      'Elige cómo obtener las coordenadas del sitio. Solo se guardan latitud y longitud; la app no muestra mapas.';

  @override
  String get locationOptionGps => 'Usar el GPS del teléfono';

  @override
  String get locationOptionGpsHint => 'Estando en el sitio';

  @override
  String get locationOptionAddress => 'Buscar una dirección';

  @override
  String get locationOptionAddressHint => 'Calle, número, colonia y ciudad';

  @override
  String get locationOptionLink => 'Pegar un enlace de mapa';

  @override
  String get locationOptionLinkHint =>
      'Compartido desde Google Maps o Apple Maps';

  @override
  String get locationOptionManual => 'Escribir coordenadas';

  @override
  String get locationOptionManualHint =>
      'Decimales o grados, minutos y segundos';

  @override
  String get locationSourceGps => 'GPS';

  @override
  String get locationSourceAddress => 'Dirección';

  @override
  String get locationSourceLink => 'Enlace de mapa';

  @override
  String get locationSourceManual => 'Escritas a mano';

  @override
  String get locationConfirmTitle => '¿Es correcta esta ubicación?';

  @override
  String get locationConfirmHint =>
      'Revisa las coordenadas. Puedes copiarlas y comprobarlas en tu app de mapas antes de guardar.';

  @override
  String get locationConfirmAction => 'Sí, guardar ubicación';

  @override
  String get locationChooseAnother => 'No, elegir otra';

  @override
  String get locationSaved => 'Ubicación guardada';

  @override
  String get timeZoneHelp =>
      'Por defecto, la del teléfono. Formato IANA, p. ej. America/Monterrey o America/Hermosillo.';

  @override
  String get coordinatesHelp =>
      'Ej.: 25.6866, -100.3161  o  25°41\'11.8\"N 100°18\'58.0\"W';

  @override
  String get coordinatesInvalid => 'No se reconocen las coordenadas.';

  @override
  String get addressHint => 'Ej.: Av. Constitución 100, Monterrey';

  @override
  String get addressNoResults =>
      'Sin resultados. Prueba con menos detalle o agrega la ciudad.';

  @override
  String get geocodeErrorNetwork =>
      'Sin conexión. Revisa internet e intenta de nuevo.';

  @override
  String get geocodeErrorBusy =>
      'El servicio de búsqueda está ocupado. Espera un momento.';

  @override
  String get geocodeErrorService =>
      'El servicio de búsqueda respondió con un error.';

  @override
  String get mapLinkInstructions =>
      'En Google Maps o Apple Maps toca «Compartir» → «Copiar», y pégalo aquí.';

  @override
  String get mapLinkErrorShort =>
      'No se pudo abrir el enlace corto. Revisa la conexión o usa el enlace completo.';

  @override
  String get mapLinkErrorUnrecognized =>
      'No se encontraron coordenadas en ese texto.';

  @override
  String get gpsErrorDisabled =>
      'La ubicación del teléfono está apagada. Actívala e intenta de nuevo.';

  @override
  String get gpsErrorDenied => 'Se necesita permiso de ubicación.';

  @override
  String get gpsErrorDeniedForever =>
      'El permiso de ubicación está bloqueado. Actívalo en Ajustes del teléfono → Apps → Panelsolar.';

  @override
  String get gpsErrorTimeout =>
      'El GPS no respondió a tiempo. Sal a cielo abierto e intenta de nuevo.';

  @override
  String get photosTitle => 'Fotos';

  @override
  String get photosEmpty => 'Sin fotos en esta etapa';

  @override
  String get photoAdd => 'Agregar foto';

  @override
  String get photoFromCamera => 'Tomar con la cámara';

  @override
  String get photoFromGallery => 'Elegir de la galería';

  @override
  String get photoCaption => 'Descripción';

  @override
  String get photoNoGps => 'Sin ubicación GPS';

  @override
  String get photoDeleteTitle => '¿Borrar foto?';

  @override
  String get photoDeleteMessage => 'Se ocultará del proyecto.';

  @override
  String get stageSurvey => 'Levantamiento';

  @override
  String get stageInstallation => 'Instalación';

  @override
  String get stageMaintenance => 'Mantenimiento';

  @override
  String get documentsTitle => 'Documentos';

  @override
  String get documentsEmpty => 'Sin documentos (PDF o imagen)';

  @override
  String get documentAdded => 'Documento agregado';

  @override
  String get documentUnsupported =>
      'Solo se aceptan PDF o imágenes (JPG, PNG, WEBP).';

  @override
  String get documentCannotOpen => 'No hay una app para abrir este archivo.';

  @override
  String get documentDeleteTitle => '¿Borrar documento?';

  @override
  String get billsTitle => 'Recibos de luz';

  @override
  String get billsEmpty => 'Sin recibos. Agrega al menos los del último año.';

  @override
  String get billNew => 'Nuevo recibo';

  @override
  String get billEdit => 'Editar recibo';

  @override
  String get billDeleteTitle => '¿Borrar recibo?';

  @override
  String get billDeleteMessage => 'Dejará de contar en el consumo.';

  @override
  String get tariffNone => 'Sin especificar';

  @override
  String get periodMonthly => 'Mensual';

  @override
  String get periodBimonthly => 'Bimestral';

  @override
  String get consumptionAnnual => 'Consumo anual estimado';

  @override
  String get consumptionMonthly => 'Promedio mensual';

  @override
  String get consumptionDaily => 'diario';

  @override
  String get consumptionAnnualCost => 'Gasto anual estimado';

  @override
  String altitudeValue(String meters) {
    return '$meters m s. n. m.';
  }

  @override
  String gpsAccuracy(String meters) {
    return 'Precisión: ±$meters m';
  }

  @override
  String projectAdvanceTo(String status) {
    return 'Pasar a «$status»';
  }

  @override
  String photosImported(int saved, int duplicates, int invalid) {
    String _temp0 = intl.Intl.pluralLogic(
      saved,
      locale: localeName,
      other: '$saved fotos guardadas',
      one: '1 foto guardada',
      zero: 'Ninguna foto nueva',
    );
    String _temp1 = intl.Intl.pluralLogic(
      duplicates,
      locale: localeName,
      other: ' · $duplicates repetidas',
      one: ' · 1 repetida',
      zero: '',
    );
    String _temp2 = intl.Intl.pluralLogic(
      invalid,
      locale: localeName,
      other: ' · $invalid no válidas',
      one: ' · 1 no válida',
      zero: '',
    );
    return '$_temp0$_temp1$_temp2';
  }

  @override
  String consumptionPartialYear(int days) {
    return 'Con $days días de recibos: el anual es una estimación. Agrega el año completo.';
  }

  @override
  String consumptionDacWarning(String tariff, String limit) {
    return 'El promedio mensual rebasa el límite de la tarifa $tariff ($limit kWh/mes): riesgo de pasar a DAC.';
  }

  @override
  String get weatherTitle => 'Clima y producción';

  @override
  String get weatherEntryTitle => 'Clima y producción (prueba F2)';

  @override
  String get weatherEntrySubtitle =>
      'Descarga el clima de una coordenada y estima la producción.';

  @override
  String get weatherIntro =>
      'Producción estimada de un sistema de 1 kWp con la orientación óptima. Datos: NASA POWER (5 años) y PVGIS.';

  @override
  String get weatherLatitude => 'Latitud (°)';

  @override
  String get weatherLongitude => 'Longitud (°)';

  @override
  String get weatherInvalidCoordinate => 'Escribe un número válido';

  @override
  String get weatherAnalyze => 'Descargar clima y calcular';

  @override
  String get weatherRefresh => 'Volver a descargar';

  @override
  String get weatherLoading => 'Descargando clima y simulando…';

  @override
  String weatherError(String message) {
    return 'No se pudo obtener el clima: $message';
  }

  @override
  String weatherSource(String source) {
    return 'Serie: $source';
  }

  @override
  String get weatherAnnualTitle => 'Producción anual';

  @override
  String weatherAnnualValue(String value) {
    return '$value kWh por kWp al año';
  }

  @override
  String weatherPerformanceRatio(String value) {
    return 'Performance ratio: $value';
  }

  @override
  String get weatherMonthlyTitle => 'Producción mensual (kWh por kWp)';

  @override
  String get weatherOptimalTitle => 'Orientación óptima';

  @override
  String weatherOptimalValue(String tilt, String azimuth) {
    return 'Inclinación $tilt° · azimut $azimuth°';
  }

  @override
  String weatherLatitudeRule(String value, String diff) {
    return 'Con inclinación = latitud: $value kWh/kWp ($diff %)';
  }

  @override
  String get weatherTemperaturesTitle => 'Temperaturas del sitio';

  @override
  String get weatherSunPathTitle => 'Trayectoria solar';

  @override
  String get weatherSunPathAxis => 'Azimut (°) vs. altura solar (°)';

  @override
  String get weatherJuneSolstice => 'Solsticio de junio';

  @override
  String get weatherEquinox => 'Equinoccios';

  @override
  String get weatherDecemberSolstice => 'Solsticio de diciembre';

  @override
  String get weatherWarningsTitle => 'Advertencias';

  @override
  String get weatherAttributionsTitle => 'Fuentes de datos';

  @override
  String get weatherProjectLocation => 'Ubicación guardada del proyecto:';

  @override
  String get weatherNoProjectLocation =>
      'Este proyecto todavía no tiene ubicación. Escribe las coordenadas aquí, o agrégala en la ficha del proyecto.';

  @override
  String get weatherProjectEntryTitle => 'Clima y producción';

  @override
  String get weatherProjectEntrySubtitle =>
      'Cuánta energía daría 1 kWp aquí y la mejor inclinación';

  @override
  String weatherTimeZone(String zone, String offset) {
    return 'Zona horaria: $zone ($offset)';
  }

  @override
  String weatherDesignMin(String value, String source) {
    return 'Mínima para diseño: $value °C ($source)';
  }

  @override
  String weatherDesignMax(String value, String source) {
    return 'Máxima para diseño: $value °C ($source)';
  }

  @override
  String get weatherDesignHint =>
      'Para diseñar los strings se usa la más extrema de las dos fuentes.';

  @override
  String weatherTemperaturesBySource(String source, String min, String max) {
    return '$source: mínima $min °C · máxima $max °C';
  }

  @override
  String get actionClear => 'Borrar';

  @override
  String get dateNotSet => 'Sin fecha';

  @override
  String get savedMessage => 'Guardado';

  @override
  String get fieldTechnician => 'Técnico';

  @override
  String get installationTitle => 'Instalación';

  @override
  String get equipmentTitle => 'Equipos instalados';

  @override
  String get equipmentEmpty =>
      'Aún no hay equipos. Agrega paneles, inversor y protecciones con su número de serie.';

  @override
  String equipmentCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count equipos',
      one: '1 equipo',
      zero: 'Sin equipos',
    );
    return '$_temp0';
  }

  @override
  String get equipmentNewTitle => 'Nuevo equipo';

  @override
  String get equipmentEditTitle => 'Editar equipo';

  @override
  String get equipmentDeleteTitle => '¿Borrar este equipo?';

  @override
  String get equipmentKind => 'Tipo';

  @override
  String get equipmentBrand => 'Marca';

  @override
  String get equipmentModel => 'Modelo';

  @override
  String get equipmentSerial => 'Número de serie';

  @override
  String equipmentSerialShort(String serial) {
    return 'S/N $serial';
  }

  @override
  String get equipmentInstalledAt => 'Fecha de instalación';

  @override
  String get equipmentWarrantyUntil => 'Garantía hasta';

  @override
  String warrantyUntil(String date) {
    return 'Garantía hasta $date';
  }

  @override
  String warrantyExpired(String date) {
    return 'Garantía vencida el $date';
  }

  @override
  String get equipmentPanel => 'Panel';

  @override
  String get equipmentInverter => 'Inversor';

  @override
  String get equipmentMicroinverter => 'Microinversor';

  @override
  String get equipmentOptimizer => 'Optimizador';

  @override
  String get equipmentBattery => 'Batería';

  @override
  String get equipmentMeter => 'Medidor';

  @override
  String get equipmentProtection => 'Protección';

  @override
  String get equipmentStructure => 'Estructura';

  @override
  String get equipmentOther => 'Otro';

  @override
  String get commissioningTitle => 'Puesta en marcha';

  @override
  String get commissioningHint =>
      'Checklist IEC 62446-1: strings, polaridad, aislamiento, tierra y etiquetado.';

  @override
  String get commissioningPending => 'Pendiente';

  @override
  String get commissioningApproved => 'Aprobado';

  @override
  String get commissioningObservations => 'Con observaciones';

  @override
  String get commissioningChecks => 'Revisiones';

  @override
  String get commissioningDate => 'Fecha de la prueba';

  @override
  String get commissioningNotes => 'Observaciones';

  @override
  String get commissioningResult => 'Resultado';

  @override
  String commissioningSuggested(String status) {
    return 'Según lo guardado, la app sugiere: $status';
  }

  @override
  String get commissioningSaveForPhotos =>
      'Guarda el checklist para poder agregar fotos de evidencia.';

  @override
  String get evidencePhotos => 'Fotos de evidencia';

  @override
  String get checkOk => 'Bien';

  @override
  String get checkFail => 'Falla';

  @override
  String get checkNotChecked => 'Sin revisar';

  @override
  String get checkPolarity => 'Polaridad correcta';

  @override
  String get checkPolarityAll => 'Polaridad de todos los strings';

  @override
  String get checkGrounding => 'Continuidad de puesta a tierra';

  @override
  String get checkLabeling => 'Etiquetado y señalización';

  @override
  String get insulationMohm => 'Resistencia de aislamiento (MΩ)';

  @override
  String get insulationTestVoltage => 'Tensión de prueba (V)';

  @override
  String get insulationHint =>
      'Mínimo 1 MΩ (IEC 62446-1). Prueba a 500 V si el sistema es de 120–500 V; a 1000 V si es mayor.';

  @override
  String get groundingOhm => 'Resistencia de tierra (Ω), si se midió';

  @override
  String get stringsTitle => 'Strings (Voc e Isc)';

  @override
  String get stringsHint =>
      'Captura lo esperado (de la hoja de datos o el diseño) y lo medido. Tolerancia: Voc ±5 %, Isc ±10 %.';

  @override
  String get stringsEmpty => 'Sin strings medidos';

  @override
  String get stringTestTitle => 'String';

  @override
  String get stringLabel => 'Nombre (p. ej. S1)';

  @override
  String get stringDeleteTitle => '¿Borrar este string?';

  @override
  String get expectedVoc => 'Voc esperado (V)';

  @override
  String get measuredVoc => 'Voc medido (V)';

  @override
  String get expectedIsc => 'Isc esperado (A)';

  @override
  String get measuredIsc => 'Isc medido (A)';

  @override
  String get calendarEmpty =>
      'No hay visitas programadas. Abre un proyecto → Mantenimiento → \"Crear plan\".';

  @override
  String get calendarOverdue => 'Vencidas';

  @override
  String get calendarSoon => 'Próximos 30 días';

  @override
  String get calendarLater => 'Más adelante';

  @override
  String get templateTitle => 'Plantilla de servicios';

  @override
  String get templateHint =>
      'Estos servicios se copian al crear el plan de un proyecto. Toca uno para cambiar su frecuencia; mantén presionado para borrarlo. El interruptor indica si se incluye.';

  @override
  String get serviceTitle => 'Servicio';

  @override
  String get serviceKind => 'Tipo de servicio';

  @override
  String get serviceCustomName => 'Nombre personalizado (opcional)';

  @override
  String get serviceIntervalMonths => 'Cada cuántos meses';

  @override
  String get serviceIntervalInvalid => 'Escribe de 1 a 120 meses';

  @override
  String get serviceNextDue => 'Próxima visita';

  @override
  String get serviceDeleteTitle => '¿Borrar este servicio?';

  @override
  String get serviceCleaning => 'Limpieza de paneles';

  @override
  String get serviceVisualInspection => 'Inspección visual';

  @override
  String get serviceTightening => 'Apriete de conexiones';

  @override
  String get serviceInverter => 'Revisión del inversor';

  @override
  String get serviceProtections => 'Revisión de protecciones';

  @override
  String get serviceThermography => 'Termografía';

  @override
  String get serviceOther => 'Otro servicio';

  @override
  String everyMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: 'Cada $months meses',
      one: 'Cada mes',
    );
    return '$_temp0';
  }

  @override
  String nextOn(String date) {
    return 'Próxima: $date';
  }

  @override
  String get planTitle => 'Plan de servicios';

  @override
  String get planEmpty => 'Este proyecto aún no tiene plan de mantenimiento.';

  @override
  String get planEmptyShort => 'Sin plan de mantenimiento';

  @override
  String get planFromTemplate => 'Crear plan desde la plantilla';

  @override
  String get visitsTitle => 'Bitácora de visitas';

  @override
  String get visitsEmpty => 'Aún no hay visitas registradas.';

  @override
  String get visitLog => 'Registrar visita';

  @override
  String get visitTitle => 'Visita';

  @override
  String get visitDate => 'Fecha de la visita';

  @override
  String get visitServicesDone => 'Servicios hechos';

  @override
  String get visitNoNotes => 'Sin notas (toca para escribir)';

  @override
  String get visitPhotos => 'Fotos de la visita';

  @override
  String get visitDeleteTitle => '¿Borrar esta visita?';

  @override
  String get visitDeleteMessage =>
      'Se borra de la bitácora. Las próximas fechas del plan no cambian.';

  @override
  String servicesDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count servicios',
      one: '1 servicio',
      zero: 'Sin servicios',
    );
    return '$_temp0';
  }

  @override
  String get remindersTitle => 'Recordatorios de mantenimiento';

  @override
  String get remindersHint => 'Aviso 7 días antes y el mismo día, a las 9:00.';

  @override
  String reminderTitle(String service) {
    return 'Mantenimiento: $service';
  }

  @override
  String reminderBodyToday(String project, String client) {
    return 'Hoy toca en $project ($client).';
  }

  @override
  String reminderBodyBefore(int days, String project, String client) {
    return 'En $days días en $project ($client).';
  }

  @override
  String get productionTitle => 'Producción';

  @override
  String get productionEmpty =>
      'Captura cada mes los kWh que marca el inversor para compararlos con lo esperado.';

  @override
  String get productionEmptyShort => 'Sin lecturas';

  @override
  String get productionActual => 'Real';

  @override
  String get productionExpected => 'Esperado';

  @override
  String get productionBelow => 'Bajo el umbral';

  @override
  String get productionLast12 => 'Últimos 12 meses con lectura';

  @override
  String get productionSettings => 'Ajustes de seguimiento';

  @override
  String get productionKwp => 'Potencia instalada (kWp), para el PR';

  @override
  String get productionThreshold => 'Umbral de alerta (% por debajo)';

  @override
  String get productionThresholdHint =>
      'Ejemplo: 15 = avisar si lo real queda 15 % o más por debajo de lo esperado.';

  @override
  String productionAlertTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meses por debajo de lo esperado',
      one: '1 mes por debajo de lo esperado',
    );
    return '$_temp0';
  }

  @override
  String productionAlertBody(String threshold) {
    return 'Más de $threshold % abajo. Revisa limpieza, sombras, strings e inversor.';
  }

  @override
  String get readingsTitle => 'Lecturas mensuales';

  @override
  String get readingAdd => 'Agregar lectura';

  @override
  String get readingTitle => 'Lectura del mes';

  @override
  String get readingMonth => 'Mes';

  @override
  String get readingYear => 'Año';

  @override
  String get readingActual => 'kWh reales (del inversor)';

  @override
  String get readingExpected => 'kWh esperados (opcional)';

  @override
  String get readingPoa =>
      'Irradiación en el plano, kWh/m² (opcional, para PR)';

  @override
  String get readingDeleteTitle => '¿Borrar esta lectura?';

  @override
  String readingVsExpected(String expected, String deviation) {
    return 'Esperado $expected kWh ($deviation %)';
  }

  @override
  String get backupTitle => 'Respaldo';

  @override
  String get backupExportTitle => 'Exportar a archivo .zip';

  @override
  String get backupExportSubtitle =>
      'Base de datos, fotos y documentos. Guárdalo donde quieras.';

  @override
  String get backupExportPasswordHint =>
      'Si pones contraseña, el archivo va cifrado (AES-256). Sin ella no se puede restaurar: guárdala bien. Déjala vacía para no cifrar.';

  @override
  String get backupExported => 'Respaldo guardado';

  @override
  String get backupNotSaved => 'No se guardó el respaldo';

  @override
  String get backupError => 'No se pudo completar. Intenta de nuevo.';

  @override
  String get backupImportTitle => 'Restaurar desde archivo .zip';

  @override
  String get backupImportSubtitle =>
      'Verás una vista previa antes de reemplazar los datos.';

  @override
  String get backupHistoryTitle => 'Últimos respaldos';

  @override
  String get backupHistoryEmpty => 'Aún no hay respaldos.';

  @override
  String get backupFailed => 'Falló';

  @override
  String get backupTriggerManual => 'Manual';

  @override
  String get backupTriggerAuto => 'Automático';

  @override
  String get backupTriggerProject => 'Proyecto finalizado';

  @override
  String get backupTriggerRestore => 'Restauración';

  @override
  String get frequencyDaily => 'Diario';

  @override
  String get frequencyWeekly => 'Semanal';

  @override
  String get frequencyManual => 'Solo manual';

  @override
  String get driveNotConfigured =>
      'Falta configurar la cuenta de Google de la app (ver docs/guias/respaldo-google.md). El respaldo .zip funciona sin esto.';

  @override
  String get driveConnect => 'Respaldar en Google Drive';

  @override
  String get driveConnectHint =>
      'Inicia sesión con Google. Se guarda en una carpeta privada de la app en tu Drive.';

  @override
  String get driveBackupNow => 'Respaldar ahora';

  @override
  String driveBackupDone(int count) {
    return 'Respaldo en Drive listo ($count archivos nuevos)';
  }

  @override
  String get driveFrequency => 'Respaldo automático (con Wi-Fi)';

  @override
  String get drivePasswordTitle => 'Contraseña del respaldo en Drive';

  @override
  String get drivePasswordHint =>
      'Cifra los respaldos de Drive (AES-256). Necesitarás la contraseña para restaurar en otro teléfono. Déjala vacía para quitar el cifrado.';

  @override
  String get driveEncryptedOn => 'Cifrado activado';

  @override
  String get driveEncryptedOff => 'Sin cifrado';

  @override
  String get driveRestore => 'Restaurar desde Google Drive';

  @override
  String get driveChooseBackup => 'Elige un respaldo';

  @override
  String get driveNoBackups => 'No hay respaldos en esta cuenta.';

  @override
  String get driveDisconnect => 'Desconectar Google Drive';

  @override
  String get driveDisconnectMessage =>
      'Se detiene el respaldo automático. Los respaldos ya subidos se quedan en tu Drive.';

  @override
  String get passwordOptional => 'Contraseña (opcional)';

  @override
  String get passwordConfirm => 'Repite la contraseña';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordMismatch => 'Las contraseñas no coinciden';

  @override
  String get passwordTooShort => 'Usa al menos 6 caracteres';

  @override
  String get passwordWrong => 'Contraseña incorrecta';

  @override
  String get restoreTitle => 'Restaurar respaldo';

  @override
  String get restoreInvalid =>
      'Este archivo no es un respaldo de Panelsolar o está dañado.';

  @override
  String restoreCreatedWith(String version) {
    return 'Hecho con la versión $version';
  }

  @override
  String get restoreEncrypted => 'Cifrado: pide contraseña';

  @override
  String get restoreNotEncrypted => 'Sin cifrar';

  @override
  String get restoreWarning =>
      'Restaurar reemplaza TODOS los datos de este teléfono por los del respaldo.';

  @override
  String get restoreAction => 'Restaurar';

  @override
  String get restoreConfirmTitle => '¿Reemplazar todos los datos?';

  @override
  String get restoreConfirmMessage =>
      'Los clientes, proyectos y fotos actuales se cambian por los del respaldo. No se puede deshacer.';

  @override
  String restoreDone(int restored, int missing) {
    return 'Restaurado. Archivos: $restored recuperados, $missing faltantes.';
  }

  @override
  String get restoreNewerApp =>
      'El respaldo es de una versión más nueva de la app. Actualiza la app primero.';

  @override
  String get restoreUndoTitle => 'Deshacer la última restauración';

  @override
  String get restoreUndoSubtitle =>
      'Vuelve a los datos que había antes de restaurar (copia automática en este teléfono).';

  @override
  String get restoreSafetyKept =>
      'Tus datos anteriores quedaron guardados: Ajustes → \"Deshacer la última restauración\".';

  @override
  String get readingExpectedFromEngine =>
      'Propuesto por el motor solar (clima del sitio × kWp). Puedes cambiarlo.';
}
