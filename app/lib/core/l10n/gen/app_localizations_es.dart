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
  String weatherTemperaturesValue(String min, String max) {
    return 'Mínima registrada $min °C · máxima registrada $max °C';
  }

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
}
