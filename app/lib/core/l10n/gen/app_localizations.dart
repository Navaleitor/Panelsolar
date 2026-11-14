import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Nombre de la app.
  ///
  /// In es, this message translates to:
  /// **'Panelsolar'**
  String get appTitle;

  /// No description provided for @navClients.
  ///
  /// In es, this message translates to:
  /// **'Clientes'**
  String get navClients;

  /// No description provided for @navProjects.
  ///
  /// In es, this message translates to:
  /// **'Proyectos'**
  String get navProjects;

  /// No description provided for @navCatalog.
  ///
  /// In es, this message translates to:
  /// **'Catálogo'**
  String get navCatalog;

  /// No description provided for @navMaintenance.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento'**
  String get navMaintenance;

  /// No description provided for @navSettings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get navSettings;

  /// No description provided for @clientsDescription.
  ///
  /// In es, this message translates to:
  /// **'Datos de contacto, recibos de luz y consumo de cada cliente.'**
  String get clientsDescription;

  /// No description provided for @projectsDescription.
  ///
  /// In es, this message translates to:
  /// **'Sitio, techo, clima, diseño y reportes de cada instalación.'**
  String get projectsDescription;

  /// No description provided for @catalogDescription.
  ///
  /// In es, this message translates to:
  /// **'Paneles, inversores, baterías y estructuras.'**
  String get catalogDescription;

  /// No description provided for @maintenanceDescription.
  ///
  /// In es, this message translates to:
  /// **'Plan de servicios, recordatorios y bitácora de visitas.'**
  String get maintenanceDescription;

  /// No description provided for @settingsDescription.
  ///
  /// In es, this message translates to:
  /// **'Perfil de empresa, idioma, unidades y respaldo.'**
  String get settingsDescription;

  /// Aviso en pantallas vacías.
  ///
  /// In es, this message translates to:
  /// **'Disponible en la fase {phase}.'**
  String comingInPhase(String phase);

  /// No description provided for @settingsDatabaseTitle.
  ///
  /// In es, this message translates to:
  /// **'Base de datos'**
  String get settingsDatabaseTitle;

  /// No description provided for @settingsDatabaseOk.
  ///
  /// In es, this message translates to:
  /// **'Funcionando · esquema v{version}'**
  String settingsDatabaseOk(int version);

  /// No description provided for @settingsDatabaseError.
  ///
  /// In es, this message translates to:
  /// **'Error al abrir la base de datos'**
  String get settingsDatabaseError;

  /// No description provided for @actionAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar'**
  String get actionAdd;

  /// No description provided for @actionCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get actionCancel;

  /// No description provided for @actionChange.
  ///
  /// In es, this message translates to:
  /// **'Cambiar'**
  String get actionChange;

  /// No description provided for @actionContinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get actionContinue;

  /// No description provided for @actionCopy.
  ///
  /// In es, this message translates to:
  /// **'Copiar'**
  String get actionCopy;

  /// No description provided for @actionDelete.
  ///
  /// In es, this message translates to:
  /// **'Borrar'**
  String get actionDelete;

  /// No description provided for @actionEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get actionEdit;

  /// No description provided for @actionOpen.
  ///
  /// In es, this message translates to:
  /// **'Abrir'**
  String get actionOpen;

  /// No description provided for @actionPaste.
  ///
  /// In es, this message translates to:
  /// **'Pegar'**
  String get actionPaste;

  /// No description provided for @actionRename.
  ///
  /// In es, this message translates to:
  /// **'Renombrar'**
  String get actionRename;

  /// No description provided for @actionSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get actionSave;

  /// No description provided for @actionSearch.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get actionSearch;

  /// No description provided for @errorGeneric.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal. Intenta de nuevo.'**
  String get errorGeneric;

  /// No description provided for @copied.
  ///
  /// In es, this message translates to:
  /// **'Copiado'**
  String get copied;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get filterAll;

  /// No description provided for @validationRequired.
  ///
  /// In es, this message translates to:
  /// **'Obligatorio'**
  String get validationRequired;

  /// No description provided for @validationEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo no válido'**
  String get validationEmail;

  /// No description provided for @validationPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono no válido (mínimo 7 dígitos)'**
  String get validationPhone;

  /// No description provided for @validationNumber.
  ///
  /// In es, this message translates to:
  /// **'Número no válido'**
  String get validationNumber;

  /// No description provided for @validationPeriod.
  ///
  /// In es, this message translates to:
  /// **'El fin del periodo no puede ser antes del inicio'**
  String get validationPeriod;

  /// No description provided for @validationTimeZone.
  ///
  /// In es, this message translates to:
  /// **'Zona horaria desconocida (ej. America/Monterrey)'**
  String get validationTimeZone;

  /// No description provided for @fieldName.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get fieldName;

  /// No description provided for @fieldPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get fieldPhone;

  /// No description provided for @fieldEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get fieldEmail;

  /// No description provided for @fieldAddress.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get fieldAddress;

  /// No description provided for @fieldNotes.
  ///
  /// In es, this message translates to:
  /// **'Notas'**
  String get fieldNotes;

  /// No description provided for @fieldClient.
  ///
  /// In es, this message translates to:
  /// **'Cliente'**
  String get fieldClient;

  /// No description provided for @fieldProjectName.
  ///
  /// In es, this message translates to:
  /// **'Nombre del proyecto'**
  String get fieldProjectName;

  /// No description provided for @fieldStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get fieldStatus;

  /// No description provided for @fieldDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get fieldDate;

  /// No description provided for @fieldAltitude.
  ///
  /// In es, this message translates to:
  /// **'Altitud (opcional)'**
  String get fieldAltitude;

  /// No description provided for @fieldTimeZone.
  ///
  /// In es, this message translates to:
  /// **'Zona horaria'**
  String get fieldTimeZone;

  /// No description provided for @fieldTariff.
  ///
  /// In es, this message translates to:
  /// **'Tarifa'**
  String get fieldTariff;

  /// No description provided for @fieldPeriodStart.
  ///
  /// In es, this message translates to:
  /// **'Inicio del periodo'**
  String get fieldPeriodStart;

  /// No description provided for @fieldPeriodEnd.
  ///
  /// In es, this message translates to:
  /// **'Fin del periodo'**
  String get fieldPeriodEnd;

  /// No description provided for @fieldEnergyKwh.
  ///
  /// In es, this message translates to:
  /// **'Consumo'**
  String get fieldEnergyKwh;

  /// No description provided for @fieldAmount.
  ///
  /// In es, this message translates to:
  /// **'Importe (opcional)'**
  String get fieldAmount;

  /// No description provided for @clientsSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar por nombre, teléfono, correo o dirección'**
  String get clientsSearchHint;

  /// No description provided for @clientsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay clientes. Toca «Nuevo cliente».'**
  String get clientsEmpty;

  /// No description provided for @clientsNoMatches.
  ///
  /// In es, this message translates to:
  /// **'Ningún cliente coincide con la búsqueda.'**
  String get clientsNoMatches;

  /// No description provided for @clientNew.
  ///
  /// In es, this message translates to:
  /// **'Nuevo cliente'**
  String get clientNew;

  /// No description provided for @clientEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar cliente'**
  String get clientEdit;

  /// No description provided for @clientNotFound.
  ///
  /// In es, this message translates to:
  /// **'Este cliente ya no existe.'**
  String get clientNotFound;

  /// No description provided for @clientNoContact.
  ///
  /// In es, this message translates to:
  /// **'Sin datos de contacto'**
  String get clientNoContact;

  /// No description provided for @clientProjectsTitle.
  ///
  /// In es, this message translates to:
  /// **'Proyectos'**
  String get clientProjectsTitle;

  /// No description provided for @clientNoProjects.
  ///
  /// In es, this message translates to:
  /// **'Sin proyectos'**
  String get clientNoProjects;

  /// No description provided for @clientDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar cliente?'**
  String get clientDeleteTitle;

  /// No description provided for @clientDeleteMessage.
  ///
  /// In es, this message translates to:
  /// **'También se ocultarán sus proyectos y recibos. Se puede recuperar desde un respaldo.'**
  String get clientDeleteMessage;

  /// No description provided for @projectsSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Buscar por proyecto o cliente'**
  String get projectsSearchHint;

  /// No description provided for @projectsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay proyectos.'**
  String get projectsEmpty;

  /// No description provided for @projectNew.
  ///
  /// In es, this message translates to:
  /// **'Nuevo proyecto'**
  String get projectNew;

  /// No description provided for @projectEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar proyecto'**
  String get projectEdit;

  /// No description provided for @projectNotFound.
  ///
  /// In es, this message translates to:
  /// **'Este proyecto ya no existe.'**
  String get projectNotFound;

  /// No description provided for @projectNeedsClient.
  ///
  /// In es, this message translates to:
  /// **'Primero da de alta un cliente.'**
  String get projectNeedsClient;

  /// No description provided for @projectDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar proyecto?'**
  String get projectDeleteTitle;

  /// No description provided for @projectDeleteMessage.
  ///
  /// In es, this message translates to:
  /// **'Se ocultará junto con sus fotos y documentos. Se puede recuperar desde un respaldo.'**
  String get projectDeleteMessage;

  /// No description provided for @statusProspect.
  ///
  /// In es, this message translates to:
  /// **'Prospecto'**
  String get statusProspect;

  /// No description provided for @statusDesign.
  ///
  /// In es, this message translates to:
  /// **'Diseño'**
  String get statusDesign;

  /// No description provided for @statusQuoted.
  ///
  /// In es, this message translates to:
  /// **'Cotizado'**
  String get statusQuoted;

  /// No description provided for @statusInstalled.
  ///
  /// In es, this message translates to:
  /// **'Instalado'**
  String get statusInstalled;

  /// No description provided for @statusMaintenance.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento'**
  String get statusMaintenance;

  /// No description provided for @locationTitle.
  ///
  /// In es, this message translates to:
  /// **'Ubicación'**
  String get locationTitle;

  /// No description provided for @locationNone.
  ///
  /// In es, this message translates to:
  /// **'Sin ubicación'**
  String get locationNone;

  /// No description provided for @locationIntro.
  ///
  /// In es, this message translates to:
  /// **'Elige cómo obtener las coordenadas del sitio. Solo se guardan latitud y longitud; la app no muestra mapas.'**
  String get locationIntro;

  /// No description provided for @locationOptionGps.
  ///
  /// In es, this message translates to:
  /// **'Usar el GPS del teléfono'**
  String get locationOptionGps;

  /// No description provided for @locationOptionGpsHint.
  ///
  /// In es, this message translates to:
  /// **'Estando en el sitio'**
  String get locationOptionGpsHint;

  /// No description provided for @locationOptionAddress.
  ///
  /// In es, this message translates to:
  /// **'Buscar una dirección'**
  String get locationOptionAddress;

  /// No description provided for @locationOptionAddressHint.
  ///
  /// In es, this message translates to:
  /// **'Calle, número, colonia y ciudad'**
  String get locationOptionAddressHint;

  /// No description provided for @locationOptionLink.
  ///
  /// In es, this message translates to:
  /// **'Pegar un enlace de mapa'**
  String get locationOptionLink;

  /// No description provided for @locationOptionLinkHint.
  ///
  /// In es, this message translates to:
  /// **'Compartido desde Google Maps o Apple Maps'**
  String get locationOptionLinkHint;

  /// No description provided for @locationOptionManual.
  ///
  /// In es, this message translates to:
  /// **'Escribir coordenadas'**
  String get locationOptionManual;

  /// No description provided for @locationOptionManualHint.
  ///
  /// In es, this message translates to:
  /// **'Decimales o grados, minutos y segundos'**
  String get locationOptionManualHint;

  /// No description provided for @locationSourceGps.
  ///
  /// In es, this message translates to:
  /// **'GPS'**
  String get locationSourceGps;

  /// No description provided for @locationSourceAddress.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get locationSourceAddress;

  /// No description provided for @locationSourceLink.
  ///
  /// In es, this message translates to:
  /// **'Enlace de mapa'**
  String get locationSourceLink;

  /// No description provided for @locationSourceManual.
  ///
  /// In es, this message translates to:
  /// **'Escritas a mano'**
  String get locationSourceManual;

  /// No description provided for @locationConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Es correcta esta ubicación?'**
  String get locationConfirmTitle;

  /// No description provided for @locationConfirmHint.
  ///
  /// In es, this message translates to:
  /// **'Revisa las coordenadas. Puedes copiarlas y comprobarlas en tu app de mapas antes de guardar.'**
  String get locationConfirmHint;

  /// No description provided for @locationConfirmAction.
  ///
  /// In es, this message translates to:
  /// **'Sí, guardar ubicación'**
  String get locationConfirmAction;

  /// No description provided for @locationChooseAnother.
  ///
  /// In es, this message translates to:
  /// **'No, elegir otra'**
  String get locationChooseAnother;

  /// No description provided for @locationSaved.
  ///
  /// In es, this message translates to:
  /// **'Ubicación guardada'**
  String get locationSaved;

  /// No description provided for @timeZoneHelp.
  ///
  /// In es, this message translates to:
  /// **'Por defecto, la del teléfono. Formato IANA, p. ej. America/Monterrey o America/Hermosillo.'**
  String get timeZoneHelp;

  /// No description provided for @coordinatesHelp.
  ///
  /// In es, this message translates to:
  /// **'Ej.: 25.6866, -100.3161  o  25°41\'11.8\"N 100°18\'58.0\"W'**
  String get coordinatesHelp;

  /// No description provided for @coordinatesInvalid.
  ///
  /// In es, this message translates to:
  /// **'No se reconocen las coordenadas.'**
  String get coordinatesInvalid;

  /// No description provided for @addressHint.
  ///
  /// In es, this message translates to:
  /// **'Ej.: Av. Constitución 100, Monterrey'**
  String get addressHint;

  /// No description provided for @addressNoResults.
  ///
  /// In es, this message translates to:
  /// **'Sin resultados. Prueba con menos detalle o agrega la ciudad.'**
  String get addressNoResults;

  /// No description provided for @geocodeErrorNetwork.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión. Revisa internet e intenta de nuevo.'**
  String get geocodeErrorNetwork;

  /// No description provided for @geocodeErrorBusy.
  ///
  /// In es, this message translates to:
  /// **'El servicio de búsqueda está ocupado. Espera un momento.'**
  String get geocodeErrorBusy;

  /// No description provided for @geocodeErrorService.
  ///
  /// In es, this message translates to:
  /// **'El servicio de búsqueda respondió con un error.'**
  String get geocodeErrorService;

  /// No description provided for @mapLinkInstructions.
  ///
  /// In es, this message translates to:
  /// **'En Google Maps o Apple Maps toca «Compartir» → «Copiar», y pégalo aquí.'**
  String get mapLinkInstructions;

  /// No description provided for @mapLinkErrorShort.
  ///
  /// In es, this message translates to:
  /// **'No se pudo abrir el enlace corto. Revisa la conexión o usa el enlace completo.'**
  String get mapLinkErrorShort;

  /// No description provided for @mapLinkErrorUnrecognized.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron coordenadas en ese texto.'**
  String get mapLinkErrorUnrecognized;

  /// No description provided for @gpsErrorDisabled.
  ///
  /// In es, this message translates to:
  /// **'La ubicación del teléfono está apagada. Actívala e intenta de nuevo.'**
  String get gpsErrorDisabled;

  /// No description provided for @gpsErrorDenied.
  ///
  /// In es, this message translates to:
  /// **'Se necesita permiso de ubicación.'**
  String get gpsErrorDenied;

  /// No description provided for @gpsErrorDeniedForever.
  ///
  /// In es, this message translates to:
  /// **'El permiso de ubicación está bloqueado. Actívalo en Ajustes del teléfono → Apps → Panelsolar.'**
  String get gpsErrorDeniedForever;

  /// No description provided for @gpsErrorTimeout.
  ///
  /// In es, this message translates to:
  /// **'El GPS no respondió a tiempo. Sal a cielo abierto e intenta de nuevo.'**
  String get gpsErrorTimeout;

  /// No description provided for @photosTitle.
  ///
  /// In es, this message translates to:
  /// **'Fotos'**
  String get photosTitle;

  /// No description provided for @photosEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin fotos en esta etapa'**
  String get photosEmpty;

  /// No description provided for @photoAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar foto'**
  String get photoAdd;

  /// No description provided for @photoFromCamera.
  ///
  /// In es, this message translates to:
  /// **'Tomar con la cámara'**
  String get photoFromCamera;

  /// No description provided for @photoFromGallery.
  ///
  /// In es, this message translates to:
  /// **'Elegir de la galería'**
  String get photoFromGallery;

  /// No description provided for @photoCaption.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get photoCaption;

  /// No description provided for @photoNoGps.
  ///
  /// In es, this message translates to:
  /// **'Sin ubicación GPS'**
  String get photoNoGps;

  /// No description provided for @photoDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar foto?'**
  String get photoDeleteTitle;

  /// No description provided for @photoDeleteMessage.
  ///
  /// In es, this message translates to:
  /// **'Se ocultará del proyecto.'**
  String get photoDeleteMessage;

  /// No description provided for @stageSurvey.
  ///
  /// In es, this message translates to:
  /// **'Levantamiento'**
  String get stageSurvey;

  /// No description provided for @stageInstallation.
  ///
  /// In es, this message translates to:
  /// **'Instalación'**
  String get stageInstallation;

  /// No description provided for @stageMaintenance.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento'**
  String get stageMaintenance;

  /// No description provided for @documentsTitle.
  ///
  /// In es, this message translates to:
  /// **'Documentos'**
  String get documentsTitle;

  /// No description provided for @documentsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin documentos (PDF o imagen)'**
  String get documentsEmpty;

  /// No description provided for @documentAdded.
  ///
  /// In es, this message translates to:
  /// **'Documento agregado'**
  String get documentAdded;

  /// No description provided for @documentUnsupported.
  ///
  /// In es, this message translates to:
  /// **'Solo se aceptan PDF o imágenes (JPG, PNG, WEBP).'**
  String get documentUnsupported;

  /// No description provided for @documentCannotOpen.
  ///
  /// In es, this message translates to:
  /// **'No hay una app para abrir este archivo.'**
  String get documentCannotOpen;

  /// No description provided for @documentDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar documento?'**
  String get documentDeleteTitle;

  /// No description provided for @billsTitle.
  ///
  /// In es, this message translates to:
  /// **'Recibos de luz'**
  String get billsTitle;

  /// No description provided for @billsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin recibos. Agrega al menos los del último año.'**
  String get billsEmpty;

  /// No description provided for @billNew.
  ///
  /// In es, this message translates to:
  /// **'Nuevo recibo'**
  String get billNew;

  /// No description provided for @billEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar recibo'**
  String get billEdit;

  /// No description provided for @billDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar recibo?'**
  String get billDeleteTitle;

  /// No description provided for @billDeleteMessage.
  ///
  /// In es, this message translates to:
  /// **'Dejará de contar en el consumo.'**
  String get billDeleteMessage;

  /// No description provided for @tariffNone.
  ///
  /// In es, this message translates to:
  /// **'Sin especificar'**
  String get tariffNone;

  /// No description provided for @periodMonthly.
  ///
  /// In es, this message translates to:
  /// **'Mensual'**
  String get periodMonthly;

  /// No description provided for @periodBimonthly.
  ///
  /// In es, this message translates to:
  /// **'Bimestral'**
  String get periodBimonthly;

  /// No description provided for @consumptionAnnual.
  ///
  /// In es, this message translates to:
  /// **'Consumo anual estimado'**
  String get consumptionAnnual;

  /// No description provided for @consumptionMonthly.
  ///
  /// In es, this message translates to:
  /// **'Promedio mensual'**
  String get consumptionMonthly;

  /// No description provided for @consumptionDaily.
  ///
  /// In es, this message translates to:
  /// **'diario'**
  String get consumptionDaily;

  /// No description provided for @consumptionAnnualCost.
  ///
  /// In es, this message translates to:
  /// **'Gasto anual estimado'**
  String get consumptionAnnualCost;

  /// No description provided for @altitudeValue.
  ///
  /// In es, this message translates to:
  /// **'{meters} m s. n. m.'**
  String altitudeValue(String meters);

  /// No description provided for @gpsAccuracy.
  ///
  /// In es, this message translates to:
  /// **'Precisión: ±{meters} m'**
  String gpsAccuracy(String meters);

  /// No description provided for @projectAdvanceTo.
  ///
  /// In es, this message translates to:
  /// **'Pasar a «{status}»'**
  String projectAdvanceTo(String status);

  /// No description provided for @photosImported.
  ///
  /// In es, this message translates to:
  /// **'{saved, plural, =0{Ninguna foto nueva} =1{1 foto guardada} other{{saved} fotos guardadas}}{duplicates, plural, =0{} =1{ · 1 repetida} other{ · {duplicates} repetidas}}{invalid, plural, =0{} =1{ · 1 no válida} other{ · {invalid} no válidas}}'**
  String photosImported(int saved, int duplicates, int invalid);

  /// No description provided for @consumptionPartialYear.
  ///
  /// In es, this message translates to:
  /// **'Con {days} días de recibos: el anual es una estimación. Agrega el año completo.'**
  String consumptionPartialYear(int days);

  /// No description provided for @consumptionDacWarning.
  ///
  /// In es, this message translates to:
  /// **'El promedio mensual rebasa el límite de la tarifa {tariff} ({limit} kWh/mes): riesgo de pasar a DAC.'**
  String consumptionDacWarning(String tariff, String limit);

  /// No description provided for @actionClear.
  ///
  /// In es, this message translates to:
  /// **'Borrar'**
  String get actionClear;

  /// No description provided for @dateNotSet.
  ///
  /// In es, this message translates to:
  /// **'Sin fecha'**
  String get dateNotSet;

  /// No description provided for @savedMessage.
  ///
  /// In es, this message translates to:
  /// **'Guardado'**
  String get savedMessage;

  /// No description provided for @fieldTechnician.
  ///
  /// In es, this message translates to:
  /// **'Técnico'**
  String get fieldTechnician;

  /// No description provided for @installationTitle.
  ///
  /// In es, this message translates to:
  /// **'Instalación'**
  String get installationTitle;

  /// No description provided for @equipmentTitle.
  ///
  /// In es, this message translates to:
  /// **'Equipos instalados'**
  String get equipmentTitle;

  /// No description provided for @equipmentEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay equipos. Agrega paneles, inversor y protecciones con su número de serie.'**
  String get equipmentEmpty;

  /// No description provided for @equipmentCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin equipos} =1{1 equipo} other{{count} equipos}}'**
  String equipmentCount(int count);

  /// No description provided for @equipmentNewTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuevo equipo'**
  String get equipmentNewTitle;

  /// No description provided for @equipmentEditTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar equipo'**
  String get equipmentEditTitle;

  /// No description provided for @equipmentDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar este equipo?'**
  String get equipmentDeleteTitle;

  /// No description provided for @equipmentKind.
  ///
  /// In es, this message translates to:
  /// **'Tipo'**
  String get equipmentKind;

  /// No description provided for @equipmentBrand.
  ///
  /// In es, this message translates to:
  /// **'Marca'**
  String get equipmentBrand;

  /// No description provided for @equipmentModel.
  ///
  /// In es, this message translates to:
  /// **'Modelo'**
  String get equipmentModel;

  /// No description provided for @equipmentSerial.
  ///
  /// In es, this message translates to:
  /// **'Número de serie'**
  String get equipmentSerial;

  /// No description provided for @equipmentSerialShort.
  ///
  /// In es, this message translates to:
  /// **'S/N {serial}'**
  String equipmentSerialShort(String serial);

  /// No description provided for @equipmentInstalledAt.
  ///
  /// In es, this message translates to:
  /// **'Fecha de instalación'**
  String get equipmentInstalledAt;

  /// No description provided for @equipmentWarrantyUntil.
  ///
  /// In es, this message translates to:
  /// **'Garantía hasta'**
  String get equipmentWarrantyUntil;

  /// No description provided for @warrantyUntil.
  ///
  /// In es, this message translates to:
  /// **'Garantía hasta {date}'**
  String warrantyUntil(String date);

  /// No description provided for @warrantyExpired.
  ///
  /// In es, this message translates to:
  /// **'Garantía vencida el {date}'**
  String warrantyExpired(String date);

  /// No description provided for @equipmentPanel.
  ///
  /// In es, this message translates to:
  /// **'Panel'**
  String get equipmentPanel;

  /// No description provided for @equipmentInverter.
  ///
  /// In es, this message translates to:
  /// **'Inversor'**
  String get equipmentInverter;

  /// No description provided for @equipmentMicroinverter.
  ///
  /// In es, this message translates to:
  /// **'Microinversor'**
  String get equipmentMicroinverter;

  /// No description provided for @equipmentOptimizer.
  ///
  /// In es, this message translates to:
  /// **'Optimizador'**
  String get equipmentOptimizer;

  /// No description provided for @equipmentBattery.
  ///
  /// In es, this message translates to:
  /// **'Batería'**
  String get equipmentBattery;

  /// No description provided for @equipmentMeter.
  ///
  /// In es, this message translates to:
  /// **'Medidor'**
  String get equipmentMeter;

  /// No description provided for @equipmentProtection.
  ///
  /// In es, this message translates to:
  /// **'Protección'**
  String get equipmentProtection;

  /// No description provided for @equipmentStructure.
  ///
  /// In es, this message translates to:
  /// **'Estructura'**
  String get equipmentStructure;

  /// No description provided for @equipmentOther.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get equipmentOther;

  /// No description provided for @commissioningTitle.
  ///
  /// In es, this message translates to:
  /// **'Puesta en marcha'**
  String get commissioningTitle;

  /// No description provided for @commissioningHint.
  ///
  /// In es, this message translates to:
  /// **'Checklist IEC 62446-1: strings, polaridad, aislamiento, tierra y etiquetado.'**
  String get commissioningHint;

  /// No description provided for @commissioningPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get commissioningPending;

  /// No description provided for @commissioningApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobado'**
  String get commissioningApproved;

  /// No description provided for @commissioningObservations.
  ///
  /// In es, this message translates to:
  /// **'Con observaciones'**
  String get commissioningObservations;

  /// No description provided for @commissioningChecks.
  ///
  /// In es, this message translates to:
  /// **'Revisiones'**
  String get commissioningChecks;

  /// No description provided for @commissioningDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de la prueba'**
  String get commissioningDate;

  /// No description provided for @commissioningNotes.
  ///
  /// In es, this message translates to:
  /// **'Observaciones'**
  String get commissioningNotes;

  /// No description provided for @commissioningResult.
  ///
  /// In es, this message translates to:
  /// **'Resultado'**
  String get commissioningResult;

  /// No description provided for @commissioningSuggested.
  ///
  /// In es, this message translates to:
  /// **'Según lo guardado, la app sugiere: {status}'**
  String commissioningSuggested(String status);

  /// No description provided for @commissioningSaveForPhotos.
  ///
  /// In es, this message translates to:
  /// **'Guarda el checklist para poder agregar fotos de evidencia.'**
  String get commissioningSaveForPhotos;

  /// No description provided for @evidencePhotos.
  ///
  /// In es, this message translates to:
  /// **'Fotos de evidencia'**
  String get evidencePhotos;

  /// No description provided for @checkOk.
  ///
  /// In es, this message translates to:
  /// **'Bien'**
  String get checkOk;

  /// No description provided for @checkFail.
  ///
  /// In es, this message translates to:
  /// **'Falla'**
  String get checkFail;

  /// No description provided for @checkNotChecked.
  ///
  /// In es, this message translates to:
  /// **'Sin revisar'**
  String get checkNotChecked;

  /// No description provided for @checkPolarity.
  ///
  /// In es, this message translates to:
  /// **'Polaridad correcta'**
  String get checkPolarity;

  /// No description provided for @checkPolarityAll.
  ///
  /// In es, this message translates to:
  /// **'Polaridad de todos los strings'**
  String get checkPolarityAll;

  /// No description provided for @checkGrounding.
  ///
  /// In es, this message translates to:
  /// **'Continuidad de puesta a tierra'**
  String get checkGrounding;

  /// No description provided for @checkLabeling.
  ///
  /// In es, this message translates to:
  /// **'Etiquetado y señalización'**
  String get checkLabeling;

  /// No description provided for @insulationMohm.
  ///
  /// In es, this message translates to:
  /// **'Resistencia de aislamiento (MΩ)'**
  String get insulationMohm;

  /// No description provided for @insulationTestVoltage.
  ///
  /// In es, this message translates to:
  /// **'Tensión de prueba (V)'**
  String get insulationTestVoltage;

  /// No description provided for @insulationHint.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 1 MΩ (IEC 62446-1). Prueba a 500 V si el sistema es de 120–500 V; a 1000 V si es mayor.'**
  String get insulationHint;

  /// No description provided for @groundingOhm.
  ///
  /// In es, this message translates to:
  /// **'Resistencia de tierra (Ω), si se midió'**
  String get groundingOhm;

  /// No description provided for @stringsTitle.
  ///
  /// In es, this message translates to:
  /// **'Strings (Voc e Isc)'**
  String get stringsTitle;

  /// No description provided for @stringsHint.
  ///
  /// In es, this message translates to:
  /// **'Captura lo esperado (de la hoja de datos o el diseño) y lo medido. Tolerancia: Voc ±5 %, Isc ±10 %.'**
  String get stringsHint;

  /// No description provided for @stringsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Sin strings medidos'**
  String get stringsEmpty;

  /// No description provided for @stringTestTitle.
  ///
  /// In es, this message translates to:
  /// **'String'**
  String get stringTestTitle;

  /// No description provided for @stringLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre (p. ej. S1)'**
  String get stringLabel;

  /// No description provided for @stringDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar este string?'**
  String get stringDeleteTitle;

  /// No description provided for @expectedVoc.
  ///
  /// In es, this message translates to:
  /// **'Voc esperado (V)'**
  String get expectedVoc;

  /// No description provided for @measuredVoc.
  ///
  /// In es, this message translates to:
  /// **'Voc medido (V)'**
  String get measuredVoc;

  /// No description provided for @expectedIsc.
  ///
  /// In es, this message translates to:
  /// **'Isc esperado (A)'**
  String get expectedIsc;

  /// No description provided for @measuredIsc.
  ///
  /// In es, this message translates to:
  /// **'Isc medido (A)'**
  String get measuredIsc;

  /// No description provided for @calendarEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay visitas programadas. Abre un proyecto → Mantenimiento → \"Crear plan\".'**
  String get calendarEmpty;

  /// No description provided for @calendarOverdue.
  ///
  /// In es, this message translates to:
  /// **'Vencidas'**
  String get calendarOverdue;

  /// No description provided for @calendarSoon.
  ///
  /// In es, this message translates to:
  /// **'Próximos 30 días'**
  String get calendarSoon;

  /// No description provided for @calendarLater.
  ///
  /// In es, this message translates to:
  /// **'Más adelante'**
  String get calendarLater;

  /// No description provided for @templateTitle.
  ///
  /// In es, this message translates to:
  /// **'Plantilla de servicios'**
  String get templateTitle;

  /// No description provided for @templateHint.
  ///
  /// In es, this message translates to:
  /// **'Estos servicios se copian al crear el plan de un proyecto. Toca uno para cambiar su frecuencia; mantén presionado para borrarlo. El interruptor indica si se incluye.'**
  String get templateHint;

  /// No description provided for @serviceTitle.
  ///
  /// In es, this message translates to:
  /// **'Servicio'**
  String get serviceTitle;

  /// No description provided for @serviceKind.
  ///
  /// In es, this message translates to:
  /// **'Tipo de servicio'**
  String get serviceKind;

  /// No description provided for @serviceCustomName.
  ///
  /// In es, this message translates to:
  /// **'Nombre personalizado (opcional)'**
  String get serviceCustomName;

  /// No description provided for @serviceIntervalMonths.
  ///
  /// In es, this message translates to:
  /// **'Cada cuántos meses'**
  String get serviceIntervalMonths;

  /// No description provided for @serviceIntervalInvalid.
  ///
  /// In es, this message translates to:
  /// **'Escribe de 1 a 120 meses'**
  String get serviceIntervalInvalid;

  /// No description provided for @serviceNextDue.
  ///
  /// In es, this message translates to:
  /// **'Próxima visita'**
  String get serviceNextDue;

  /// No description provided for @serviceDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar este servicio?'**
  String get serviceDeleteTitle;

  /// No description provided for @serviceCleaning.
  ///
  /// In es, this message translates to:
  /// **'Limpieza de paneles'**
  String get serviceCleaning;

  /// No description provided for @serviceVisualInspection.
  ///
  /// In es, this message translates to:
  /// **'Inspección visual'**
  String get serviceVisualInspection;

  /// No description provided for @serviceTightening.
  ///
  /// In es, this message translates to:
  /// **'Apriete de conexiones'**
  String get serviceTightening;

  /// No description provided for @serviceInverter.
  ///
  /// In es, this message translates to:
  /// **'Revisión del inversor'**
  String get serviceInverter;

  /// No description provided for @serviceProtections.
  ///
  /// In es, this message translates to:
  /// **'Revisión de protecciones'**
  String get serviceProtections;

  /// No description provided for @serviceThermography.
  ///
  /// In es, this message translates to:
  /// **'Termografía'**
  String get serviceThermography;

  /// No description provided for @serviceOther.
  ///
  /// In es, this message translates to:
  /// **'Otro servicio'**
  String get serviceOther;

  /// No description provided for @everyMonths.
  ///
  /// In es, this message translates to:
  /// **'{months, plural, =1{Cada mes} other{Cada {months} meses}}'**
  String everyMonths(int months);

  /// No description provided for @nextOn.
  ///
  /// In es, this message translates to:
  /// **'Próxima: {date}'**
  String nextOn(String date);

  /// No description provided for @planTitle.
  ///
  /// In es, this message translates to:
  /// **'Plan de servicios'**
  String get planTitle;

  /// No description provided for @planEmpty.
  ///
  /// In es, this message translates to:
  /// **'Este proyecto aún no tiene plan de mantenimiento.'**
  String get planEmpty;

  /// No description provided for @planEmptyShort.
  ///
  /// In es, this message translates to:
  /// **'Sin plan de mantenimiento'**
  String get planEmptyShort;

  /// No description provided for @planFromTemplate.
  ///
  /// In es, this message translates to:
  /// **'Crear plan desde la plantilla'**
  String get planFromTemplate;

  /// No description provided for @visitsTitle.
  ///
  /// In es, this message translates to:
  /// **'Bitácora de visitas'**
  String get visitsTitle;

  /// No description provided for @visitsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay visitas registradas.'**
  String get visitsEmpty;

  /// No description provided for @visitLog.
  ///
  /// In es, this message translates to:
  /// **'Registrar visita'**
  String get visitLog;

  /// No description provided for @visitTitle.
  ///
  /// In es, this message translates to:
  /// **'Visita'**
  String get visitTitle;

  /// No description provided for @visitDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de la visita'**
  String get visitDate;

  /// No description provided for @visitServicesDone.
  ///
  /// In es, this message translates to:
  /// **'Servicios hechos'**
  String get visitServicesDone;

  /// No description provided for @visitNoNotes.
  ///
  /// In es, this message translates to:
  /// **'Sin notas (toca para escribir)'**
  String get visitNoNotes;

  /// No description provided for @visitPhotos.
  ///
  /// In es, this message translates to:
  /// **'Fotos de la visita'**
  String get visitPhotos;

  /// No description provided for @visitDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar esta visita?'**
  String get visitDeleteTitle;

  /// No description provided for @visitDeleteMessage.
  ///
  /// In es, this message translates to:
  /// **'Se borra de la bitácora. Las próximas fechas del plan no cambian.'**
  String get visitDeleteMessage;

  /// No description provided for @servicesDone.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin servicios} =1{1 servicio} other{{count} servicios}}'**
  String servicesDone(int count);

  /// No description provided for @remindersTitle.
  ///
  /// In es, this message translates to:
  /// **'Recordatorios de mantenimiento'**
  String get remindersTitle;

  /// No description provided for @remindersHint.
  ///
  /// In es, this message translates to:
  /// **'Aviso 7 días antes y el mismo día, a las 9:00.'**
  String get remindersHint;

  /// No description provided for @reminderTitle.
  ///
  /// In es, this message translates to:
  /// **'Mantenimiento: {service}'**
  String reminderTitle(String service);

  /// No description provided for @reminderBodyToday.
  ///
  /// In es, this message translates to:
  /// **'Hoy toca en {project} ({client}).'**
  String reminderBodyToday(String project, String client);

  /// No description provided for @reminderBodyBefore.
  ///
  /// In es, this message translates to:
  /// **'En {days} días en {project} ({client}).'**
  String reminderBodyBefore(int days, String project, String client);

  /// No description provided for @productionTitle.
  ///
  /// In es, this message translates to:
  /// **'Producción'**
  String get productionTitle;

  /// No description provided for @productionEmpty.
  ///
  /// In es, this message translates to:
  /// **'Captura cada mes los kWh que marca el inversor para compararlos con lo esperado.'**
  String get productionEmpty;

  /// No description provided for @productionEmptyShort.
  ///
  /// In es, this message translates to:
  /// **'Sin lecturas'**
  String get productionEmptyShort;

  /// No description provided for @productionActual.
  ///
  /// In es, this message translates to:
  /// **'Real'**
  String get productionActual;

  /// No description provided for @productionExpected.
  ///
  /// In es, this message translates to:
  /// **'Esperado'**
  String get productionExpected;

  /// No description provided for @productionBelow.
  ///
  /// In es, this message translates to:
  /// **'Bajo el umbral'**
  String get productionBelow;

  /// No description provided for @productionLast12.
  ///
  /// In es, this message translates to:
  /// **'Últimos 12 meses con lectura'**
  String get productionLast12;

  /// No description provided for @productionSettings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes de seguimiento'**
  String get productionSettings;

  /// No description provided for @productionKwp.
  ///
  /// In es, this message translates to:
  /// **'Potencia instalada (kWp), para el PR'**
  String get productionKwp;

  /// No description provided for @productionThreshold.
  ///
  /// In es, this message translates to:
  /// **'Umbral de alerta (% por debajo)'**
  String get productionThreshold;

  /// No description provided for @productionThresholdHint.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo: 15 = avisar si lo real queda 15 % o más por debajo de lo esperado.'**
  String get productionThresholdHint;

  /// No description provided for @productionAlertTitle.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 mes por debajo de lo esperado} other{{count} meses por debajo de lo esperado}}'**
  String productionAlertTitle(int count);

  /// No description provided for @productionAlertBody.
  ///
  /// In es, this message translates to:
  /// **'Más de {threshold} % abajo. Revisa limpieza, sombras, strings e inversor.'**
  String productionAlertBody(String threshold);

  /// No description provided for @readingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Lecturas mensuales'**
  String get readingsTitle;

  /// No description provided for @readingAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar lectura'**
  String get readingAdd;

  /// No description provided for @readingTitle.
  ///
  /// In es, this message translates to:
  /// **'Lectura del mes'**
  String get readingTitle;

  /// No description provided for @readingMonth.
  ///
  /// In es, this message translates to:
  /// **'Mes'**
  String get readingMonth;

  /// No description provided for @readingYear.
  ///
  /// In es, this message translates to:
  /// **'Año'**
  String get readingYear;

  /// No description provided for @readingActual.
  ///
  /// In es, this message translates to:
  /// **'kWh reales (del inversor)'**
  String get readingActual;

  /// No description provided for @readingExpected.
  ///
  /// In es, this message translates to:
  /// **'kWh esperados (opcional)'**
  String get readingExpected;

  /// No description provided for @readingPoa.
  ///
  /// In es, this message translates to:
  /// **'Irradiación en el plano, kWh/m² (opcional, para PR)'**
  String get readingPoa;

  /// No description provided for @readingDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar esta lectura?'**
  String get readingDeleteTitle;

  /// No description provided for @readingVsExpected.
  ///
  /// In es, this message translates to:
  /// **'Esperado {expected} kWh ({deviation} %)'**
  String readingVsExpected(String expected, String deviation);

  /// No description provided for @backupTitle.
  ///
  /// In es, this message translates to:
  /// **'Respaldo'**
  String get backupTitle;

  /// No description provided for @backupExportTitle.
  ///
  /// In es, this message translates to:
  /// **'Exportar a archivo .zip'**
  String get backupExportTitle;

  /// No description provided for @backupExportSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Base de datos, fotos y documentos. Guárdalo donde quieras.'**
  String get backupExportSubtitle;

  /// No description provided for @backupExportPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Si pones contraseña, el archivo va cifrado (AES-256). Sin ella no se puede restaurar: guárdala bien. Déjala vacía para no cifrar.'**
  String get backupExportPasswordHint;

  /// No description provided for @backupExported.
  ///
  /// In es, this message translates to:
  /// **'Respaldo guardado'**
  String get backupExported;

  /// No description provided for @backupNotSaved.
  ///
  /// In es, this message translates to:
  /// **'No se guardó el respaldo'**
  String get backupNotSaved;

  /// No description provided for @backupError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo completar. Intenta de nuevo.'**
  String get backupError;

  /// No description provided for @backupImportTitle.
  ///
  /// In es, this message translates to:
  /// **'Restaurar desde archivo .zip'**
  String get backupImportTitle;

  /// No description provided for @backupImportSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Verás una vista previa antes de reemplazar los datos.'**
  String get backupImportSubtitle;

  /// No description provided for @backupHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Últimos respaldos'**
  String get backupHistoryTitle;

  /// No description provided for @backupHistoryEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay respaldos.'**
  String get backupHistoryEmpty;

  /// No description provided for @backupFailed.
  ///
  /// In es, this message translates to:
  /// **'Falló'**
  String get backupFailed;

  /// No description provided for @backupTriggerManual.
  ///
  /// In es, this message translates to:
  /// **'Manual'**
  String get backupTriggerManual;

  /// No description provided for @backupTriggerAuto.
  ///
  /// In es, this message translates to:
  /// **'Automático'**
  String get backupTriggerAuto;

  /// No description provided for @backupTriggerProject.
  ///
  /// In es, this message translates to:
  /// **'Proyecto finalizado'**
  String get backupTriggerProject;

  /// No description provided for @backupTriggerRestore.
  ///
  /// In es, this message translates to:
  /// **'Restauración'**
  String get backupTriggerRestore;

  /// No description provided for @frequencyDaily.
  ///
  /// In es, this message translates to:
  /// **'Diario'**
  String get frequencyDaily;

  /// No description provided for @frequencyWeekly.
  ///
  /// In es, this message translates to:
  /// **'Semanal'**
  String get frequencyWeekly;

  /// No description provided for @frequencyManual.
  ///
  /// In es, this message translates to:
  /// **'Solo manual'**
  String get frequencyManual;

  /// No description provided for @driveNotConfigured.
  ///
  /// In es, this message translates to:
  /// **'Falta configurar la cuenta de Google de la app (ver docs/guias/respaldo-google.md). El respaldo .zip funciona sin esto.'**
  String get driveNotConfigured;

  /// No description provided for @driveConnect.
  ///
  /// In es, this message translates to:
  /// **'Respaldar en Google Drive'**
  String get driveConnect;

  /// No description provided for @driveConnectHint.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión con Google. Se guarda en una carpeta privada de la app en tu Drive.'**
  String get driveConnectHint;

  /// No description provided for @driveBackupNow.
  ///
  /// In es, this message translates to:
  /// **'Respaldar ahora'**
  String get driveBackupNow;

  /// No description provided for @driveBackupDone.
  ///
  /// In es, this message translates to:
  /// **'Respaldo en Drive listo ({count} archivos nuevos)'**
  String driveBackupDone(int count);

  /// No description provided for @driveFrequency.
  ///
  /// In es, this message translates to:
  /// **'Respaldo automático (con Wi-Fi)'**
  String get driveFrequency;

  /// No description provided for @drivePasswordTitle.
  ///
  /// In es, this message translates to:
  /// **'Contraseña del respaldo en Drive'**
  String get drivePasswordTitle;

  /// No description provided for @drivePasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Cifra los respaldos de Drive (AES-256). Necesitarás la contraseña para restaurar en otro teléfono. Déjala vacía para quitar el cifrado.'**
  String get drivePasswordHint;

  /// No description provided for @driveEncryptedOn.
  ///
  /// In es, this message translates to:
  /// **'Cifrado activado'**
  String get driveEncryptedOn;

  /// No description provided for @driveEncryptedOff.
  ///
  /// In es, this message translates to:
  /// **'Sin cifrado'**
  String get driveEncryptedOff;

  /// No description provided for @driveRestore.
  ///
  /// In es, this message translates to:
  /// **'Restaurar desde Google Drive'**
  String get driveRestore;

  /// No description provided for @driveChooseBackup.
  ///
  /// In es, this message translates to:
  /// **'Elige un respaldo'**
  String get driveChooseBackup;

  /// No description provided for @driveNoBackups.
  ///
  /// In es, this message translates to:
  /// **'No hay respaldos en esta cuenta.'**
  String get driveNoBackups;

  /// No description provided for @driveDisconnect.
  ///
  /// In es, this message translates to:
  /// **'Desconectar Google Drive'**
  String get driveDisconnect;

  /// No description provided for @driveDisconnectMessage.
  ///
  /// In es, this message translates to:
  /// **'Se detiene el respaldo automático. Los respaldos ya subidos se quedan en tu Drive.'**
  String get driveDisconnectMessage;

  /// No description provided for @passwordOptional.
  ///
  /// In es, this message translates to:
  /// **'Contraseña (opcional)'**
  String get passwordOptional;

  /// No description provided for @passwordConfirm.
  ///
  /// In es, this message translates to:
  /// **'Repite la contraseña'**
  String get passwordConfirm;

  /// No description provided for @passwordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get passwordLabel;

  /// No description provided for @passwordMismatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get passwordMismatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In es, this message translates to:
  /// **'Usa al menos 6 caracteres'**
  String get passwordTooShort;

  /// No description provided for @passwordWrong.
  ///
  /// In es, this message translates to:
  /// **'Contraseña incorrecta'**
  String get passwordWrong;

  /// No description provided for @restoreTitle.
  ///
  /// In es, this message translates to:
  /// **'Restaurar respaldo'**
  String get restoreTitle;

  /// No description provided for @restoreInvalid.
  ///
  /// In es, this message translates to:
  /// **'Este archivo no es un respaldo de Panelsolar o está dañado.'**
  String get restoreInvalid;

  /// No description provided for @restoreCreatedWith.
  ///
  /// In es, this message translates to:
  /// **'Hecho con la versión {version}'**
  String restoreCreatedWith(String version);

  /// No description provided for @restoreEncrypted.
  ///
  /// In es, this message translates to:
  /// **'Cifrado: pide contraseña'**
  String get restoreEncrypted;

  /// No description provided for @restoreNotEncrypted.
  ///
  /// In es, this message translates to:
  /// **'Sin cifrar'**
  String get restoreNotEncrypted;

  /// No description provided for @restoreWarning.
  ///
  /// In es, this message translates to:
  /// **'Restaurar reemplaza TODOS los datos de este teléfono por los del respaldo.'**
  String get restoreWarning;

  /// No description provided for @restoreAction.
  ///
  /// In es, this message translates to:
  /// **'Restaurar'**
  String get restoreAction;

  /// No description provided for @restoreConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Reemplazar todos los datos?'**
  String get restoreConfirmTitle;

  /// No description provided for @restoreConfirmMessage.
  ///
  /// In es, this message translates to:
  /// **'Los clientes, proyectos y fotos actuales se cambian por los del respaldo. No se puede deshacer.'**
  String get restoreConfirmMessage;

  /// No description provided for @restoreDone.
  ///
  /// In es, this message translates to:
  /// **'Restaurado. Archivos: {restored} recuperados, {missing} faltantes.'**
  String restoreDone(int restored, int missing);

  /// No description provided for @restoreNewerApp.
  ///
  /// In es, this message translates to:
  /// **'El respaldo es de una versión más nueva de la app. Actualiza la app primero.'**
  String get restoreNewerApp;

  /// No description provided for @restoreUndoTitle.
  ///
  /// In es, this message translates to:
  /// **'Deshacer la última restauración'**
  String get restoreUndoTitle;

  /// No description provided for @restoreUndoSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Vuelve a los datos que había antes de restaurar (copia automática en este teléfono).'**
  String get restoreUndoSubtitle;

  /// No description provided for @restoreSafetyKept.
  ///
  /// In es, this message translates to:
  /// **'Tus datos anteriores quedaron guardados: Ajustes → \"Deshacer la última restauración\".'**
  String get restoreSafetyKept;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
