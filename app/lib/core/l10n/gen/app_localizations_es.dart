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
  String get obstacleWaterTank => 'Tinaco';

  @override
  String get obstacleAntenna => 'Antena';

  @override
  String get obstacleParapet => 'Pretil';

  @override
  String get obstacleGasTank => 'Tanque de gas';

  @override
  String get obstacleMinisplit => 'Minisplit';

  @override
  String get obstacleDome => 'Domo';

  @override
  String get obstacleStairwell => 'Cubo de escalera';

  @override
  String get obstacleTree => 'Árbol';

  @override
  String get obstacleNeighborBuilding => 'Edificio vecino';

  @override
  String get roofTitle => 'Techo';

  @override
  String get roofEntryEmpty => 'Imagen o croquis, planos, obstáculos y sombras';

  @override
  String roofEntrySummary(int count, String area) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count planos',
      one: '1 plano',
    );
    return '$_temp0 · $area';
  }

  @override
  String get roofBaseTitle => 'Base del techo';

  @override
  String get roofBaseNone =>
      'Importa una imagen vista desde arriba o dibuja un croquis con medidas de cinta.';

  @override
  String get roofBaseSketch => 'Croquis con medidas de cinta (sin imagen)';

  @override
  String get roofBaseImageUncalibrated =>
      'Imagen sin calibrar: traza una línea de medida conocida';

  @override
  String roofBaseImage(String scale) {
    return 'Imagen calibrada · 1 píxel = $scale';
  }

  @override
  String get roofImportImage => 'Importar imagen';

  @override
  String get roofChangeImage => 'Cambiar imagen';

  @override
  String get roofSketchMode => 'Croquis con cinta';

  @override
  String get roofImageRightsNotice =>
      'Usa solo imágenes que tengas derecho a usar.';

  @override
  String get roofImageTopViewHint =>
      'Vista desde arriba: captura, foto aérea, de dron o plano. Las vistas inclinadas dan medidas falsas.';

  @override
  String get roofSourceGallery => 'Galería';

  @override
  String get roofSourceCamera => 'Cámara';

  @override
  String get roofImageSaved => 'Imagen guardada. Ahora calibra la escala.';

  @override
  String get roofImageInvalid => 'El archivo no es una imagen válida.';

  @override
  String get roofPlanesTitle => 'Planos del techo';

  @override
  String get roofPlanesEmpty => 'Aún no hay planos trazados.';

  @override
  String roofPlaneListItem(String area, String tilt, String azimuth) {
    return '$area · inclinación $tilt · azimut $azimuth';
  }

  @override
  String get roofObstaclesTitle => 'Obstáculos';

  @override
  String roofObstaclesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count obstáculos',
      one: '1 obstáculo',
      zero: 'Ninguno',
    );
    return '$_temp0';
  }

  @override
  String get roofOpenEditor => 'Trazar y editar';

  @override
  String get roofShadeTitle => 'Sombras';

  @override
  String get roofShadeSubtitle =>
      'Sombra por fecha y hora y mapa de calor del año';

  @override
  String get roofHorizonTitle => 'Horizonte';

  @override
  String roofHorizonSubtitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count obstáculos lejanos',
      one: '1 obstáculo lejano',
      zero: 'ningún obstáculo lejano',
    );
    return 'Montañas (PVGIS) y $_temp0';
  }

  @override
  String get roofEditorTitle => 'Editor del techo';

  @override
  String get roofToolCalibrate => 'Calibrar';

  @override
  String get roofToolVerify => 'Verificar';

  @override
  String get roofToolNorth => 'Norte';

  @override
  String get roofToolDraw => 'Trazar';

  @override
  String get roofToolObstacle => 'Obstáculos';

  @override
  String get roofToolWalkway => 'Pasillos';

  @override
  String get roofToolSelect => 'Elegir';

  @override
  String get roofCalibrateFirst =>
      'Primero calibra la escala con una medida conocida.';

  @override
  String get roofCalibrateHelp =>
      'Toca los dos extremos de algo cuya medida conozcas (un lado del techo, el frente del lote, una barra de escala). Usa zoom para tocar con precisión.';

  @override
  String get roofCalibrateDialogTitle => '¿Cuánto mide la línea?';

  @override
  String get roofVerifyDialogTitle => '¿Cuánto mide en la realidad?';

  @override
  String get roofCalibrateDialogHelp =>
      'Escribe la medida real en metros (con cinta o del plano).';

  @override
  String get roofLengthMetersLabel => 'Metros';

  @override
  String get roofLineTooShort =>
      'La línea es muy corta. Haz zoom y traza una más larga.';

  @override
  String get roofScaleNone => 'Sin escala todavía.';

  @override
  String roofScaleValue(String perPixel, String pixelsPerMeter) {
    return 'Escala: 1 píxel = $perPixel ($pixelsPerMeter píxeles por metro)';
  }

  @override
  String get roofVerifyHelp =>
      'Opcional: traza otra línea de medida conocida para comprobar la escala.';

  @override
  String roofVerifyResult(String measured, String real, String difference) {
    return 'Mide $measured contra $real reales: $difference';
  }

  @override
  String get roofVerifyWarning =>
      'Diferencia mayor a 5 %: la imagen puede estar inclinada o alguna medida está mal. Recalibra.';

  @override
  String get roofNorthHelp =>
      'Gira la flecha hasta que apunte al norte, o toca dos puntos de una orilla del techo y confírmala con la brújula en sitio.';

  @override
  String roofNorthValue(String angle, String source) {
    return 'Norte: $angle · $source';
  }

  @override
  String get roofNorthSourceDefault => 'arriba (sin confirmar)';

  @override
  String get roofNorthSourceManual => 'girado a mano';

  @override
  String get roofNorthSourceCompass => 'confirmado con brújula';

  @override
  String get roofNorthCompass => 'Confirmar con brújula';

  @override
  String get roofNorthCompassNeedsLine => 'Toca 2 puntos de una orilla';

  @override
  String get roofNorthArrowTooltip => 'Norte';

  @override
  String get roofNorthLetter => 'N';

  @override
  String get roofDrawHelp =>
      'Toca cada esquina del plano. El imán ayuda a hacer esquinas de 90° y a unir vértices. Toca la primera esquina para cerrar.';

  @override
  String roofDrawLive(String sides, String area) {
    return 'Lados: $sides · Área: $area';
  }

  @override
  String get roofSnap => 'Imán';

  @override
  String get roofUndo => 'Deshacer';

  @override
  String get roofClosePolygon => 'Cerrar plano';

  @override
  String roofPlaneDefaultName(int number) {
    return 'Plano $number';
  }

  @override
  String get roofObstacleHelp =>
      'Elige el tipo y toca dónde está. Pretil: toca sus dos extremos.';

  @override
  String get roofWalkwayHelp =>
      'Toca los dos extremos del pasillo de mantenimiento dentro de un plano.';

  @override
  String get roofWalkwayOutside => 'El pasillo debe quedar dentro de un plano.';

  @override
  String get roofWalkwayWidthTitle => 'Ancho del pasillo';

  @override
  String roofWalkwayItem(String length, String width) {
    return 'Pasillo de $length × $width';
  }

  @override
  String get roofSelectHelp =>
      'Toca un plano para ver sus medidas o un obstáculo para editarlo.';

  @override
  String get roofMoveVertexHelp =>
      'Para mover una esquina: tócala y luego toca su nuevo lugar.';

  @override
  String roofPlaneSummary(
    String horizontal,
    String sloped,
    String usable,
    String tilt,
    String azimuth,
  ) {
    return 'Vista desde arriba $horizontal · real inclinada $sloped · útil $usable\nInclinación $tilt · azimut $azimuth';
  }

  @override
  String get roofInvalidNumber => 'Escribe un número válido.';

  @override
  String get roofPlaneName => 'Nombre';

  @override
  String get roofPlaneTilt => 'Inclinación (grados)';

  @override
  String get roofPlaneInclinometer => 'Inclinómetro';

  @override
  String get roofPlaneEave => 'Orilla baja (alero)';

  @override
  String roofPlaneEdgeItem(int number, String length, String azimuth) {
    return 'Lado $number: $length → mira a $azimuth';
  }

  @override
  String roofPlaneAzimuth(String azimuth) {
    return 'Azimut (hacia dónde baja): $azimuth (180° = sur)';
  }

  @override
  String get roofPlaneSetback => 'Retiro de borde (m)';

  @override
  String get roofSplitHelp =>
      'Dividir en dos planos por una diagonal entre dos esquinas:';

  @override
  String get roofSplitVertex => 'Esquina';

  @override
  String get roofSplit => 'Dividir';

  @override
  String get roofSplitInvalid => 'Esa diagonal no queda dentro del plano.';

  @override
  String get roofPlaneDeleteTitle => '¿Borrar el plano?';

  @override
  String get roofPlaneDeleteMessage => 'Se quitará del techo.';

  @override
  String get roofObstacleDiameter => 'Diámetro (m)';

  @override
  String get roofObstacleWidth => 'Ancho (m)';

  @override
  String get roofObstacleThickness => 'Espesor (m)';

  @override
  String get roofObstacleDepth => 'Fondo (m)';

  @override
  String get roofObstacleRotation => 'Giro (grados)';

  @override
  String get roofObstacleHeight => 'Altura sobre tu techo (m)';

  @override
  String get roofObstacleHeightHelp =>
      'Típica del catálogo, medida con cinta o con el teléfono (distancia × tan(ángulo) + altura de ojos).';

  @override
  String get roofHeightTypical => 'Típica';

  @override
  String get roofHeightTape => 'Cinta';

  @override
  String get roofHeightPhone => 'Teléfono';

  @override
  String get roofHeightPhoneTitle => 'Altura con el teléfono';

  @override
  String get roofHeightPhoneHelp =>
      'Párate a una distancia conocida, apunta la cámara al punto más alto y lee el ángulo.';

  @override
  String get roofHeightDistance => 'Distancia al objeto (m)';

  @override
  String get roofHeightAngle => 'Ángulo al tope (grados)';

  @override
  String get roofHeightEye => 'Altura de tus ojos (m)';

  @override
  String roofHeightResult(String height) {
    return 'Altura: $height';
  }

  @override
  String get roofSensorTiltTitle => 'Inclinómetro';

  @override
  String get roofSensorTiltHelp =>
      'Apoya el teléfono sobre el techo, con la pantalla hacia arriba y el lado largo en la dirección de la pendiente.';

  @override
  String get roofSensorCompassTitle => 'Brújula';

  @override
  String get roofSensorCompassHelp =>
      'Acuesta el teléfono sobre la orilla elegida, con la parte de arriba apuntando del primer punto al segundo. Aléjalo de metales.';

  @override
  String get roofSensorAimTitle => 'Apuntar con la cámara';

  @override
  String get roofSensorAimHelp =>
      'Apunta la cámara trasera al punto más alto del objeto.';

  @override
  String roofSensorTiltValue(String value) {
    return 'Inclinación: $value';
  }

  @override
  String roofSensorAzimuthValue(String value) {
    return 'Rumbo: $value';
  }

  @override
  String roofSensorElevationValue(String value) {
    return 'Ángulo: $value';
  }

  @override
  String roofSensorDeclination(String value) {
    return 'Corregido al norte verdadero con declinación magnética $value (modelo WMM).';
  }

  @override
  String get roofSensorWaiting => 'Esperando al sensor…';

  @override
  String get roofSensorUnavailable =>
      'Este teléfono no tiene el sensor o está apagado. Escribe el valor a mano.';

  @override
  String get roofSensorUse => 'Usar';

  @override
  String get roofTapeTitle => 'Croquis con cinta';

  @override
  String get roofTapeHelp =>
      'Escribe cada lado en orden. Giro: 90 = esquina normal, −90 = esquina hacia adentro.';

  @override
  String roofTapeSide(int number) {
    return 'Lado $number (m)';
  }

  @override
  String get roofTapeTurn => 'Giro (°)';

  @override
  String get roofTapeAddSide => 'Agregar lado';

  @override
  String roofTapeResult(String area, String error) {
    return 'Área: $area · cierre: $error';
  }

  @override
  String get roofTapeNotClosed =>
      'Las medidas no cierran: revisa algún lado o giro.';

  @override
  String get roofShadeNeedsLocation =>
      'Primero guarda la ubicación del proyecto (se necesita para saber dónde está el sol).';

  @override
  String roofSunPosition(String elevation, String azimuth) {
    return 'Sol: $elevation de altura, azimut $azimuth';
  }

  @override
  String get roofSunHidden =>
      'El sol está abajo o tapado por el horizonte: no hay sombra directa.';

  @override
  String roofShadeTime(String time) {
    return '$time h';
  }

  @override
  String get roofShadeCompute => 'Mapa de calor anual';

  @override
  String get roofShadeHeatmap => 'Ver mapa';

  @override
  String roofShadePlaneLoss(
    String plane,
    String year,
    String december,
    String june,
  ) {
    return '$plane: pierde $year del sol directo al año (diciembre $december, junio $june)';
  }

  @override
  String get roofShadeLegend =>
      'Verde = sin sombra · amarillo · rojo = 30 % o más de pérdida. Incluye el horizonte.';

  @override
  String get roofHorizonHelp =>
      'El horizonte tapa el sol bajo. Se junta el del terreno (montañas, de PVGIS) con los obstáculos lejanos que midas con el teléfono.';

  @override
  String get roofTerrainTitle => 'Terreno (PVGIS)';

  @override
  String get roofTerrainNone => 'Sin descargar';

  @override
  String roofTerrainValue(String max) {
    return 'Descargado · altura máxima $max';
  }

  @override
  String get roofTerrainDownload => 'Descargar';

  @override
  String get roofHorizonDownloadError =>
      'No se pudo descargar el horizonte. Revisa la conexión.';

  @override
  String get roofFarTitle => 'Obstáculos lejanos';

  @override
  String get roofFarEmpty =>
      'Ninguno. Agrega árboles o edificios cercanos que tapen el sol.';

  @override
  String roofFarItem(int count, String max) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count puntos',
      one: '1 punto',
    );
    return '$_temp0 · hasta $max';
  }

  @override
  String get roofFarAdd => 'Obstáculo lejano';

  @override
  String get roofFarName => 'Nombre (p. ej. árbol del vecino)';

  @override
  String get roofFarDefaultName => 'Obstáculo lejano';

  @override
  String get roofFarHelp =>
      'Desde el techo, apunta la cámara al borde de arriba del obstáculo, de izquierda a derecha, y agrega varios puntos.';

  @override
  String get roofFarMeasure => 'Medir punto con el teléfono';

  @override
  String get roofFarAzimuth => 'Azimut (°)';

  @override
  String get roofFarElevation => 'Altura (°)';

  @override
  String get roofCardinalN => 'N';

  @override
  String get roofCardinalE => 'E';

  @override
  String get roofCardinalS => 'S';

  @override
  String get roofCardinalW => 'O';
}
