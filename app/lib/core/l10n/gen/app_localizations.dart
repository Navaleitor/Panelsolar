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

  /// No description provided for @weatherTitle.
  ///
  /// In es, this message translates to:
  /// **'Clima y producción'**
  String get weatherTitle;

  /// No description provided for @weatherEntryTitle.
  ///
  /// In es, this message translates to:
  /// **'Clima y producción (prueba F2)'**
  String get weatherEntryTitle;

  /// No description provided for @weatherEntrySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Descarga el clima de una coordenada y estima la producción.'**
  String get weatherEntrySubtitle;

  /// No description provided for @weatherIntro.
  ///
  /// In es, this message translates to:
  /// **'Producción estimada de un sistema de 1 kWp con la orientación óptima. Datos: NASA POWER (5 años) y PVGIS.'**
  String get weatherIntro;

  /// No description provided for @weatherLatitude.
  ///
  /// In es, this message translates to:
  /// **'Latitud (°)'**
  String get weatherLatitude;

  /// No description provided for @weatherLongitude.
  ///
  /// In es, this message translates to:
  /// **'Longitud (°)'**
  String get weatherLongitude;

  /// No description provided for @weatherInvalidCoordinate.
  ///
  /// In es, this message translates to:
  /// **'Escribe un número válido'**
  String get weatherInvalidCoordinate;

  /// No description provided for @weatherAnalyze.
  ///
  /// In es, this message translates to:
  /// **'Descargar clima y calcular'**
  String get weatherAnalyze;

  /// No description provided for @weatherRefresh.
  ///
  /// In es, this message translates to:
  /// **'Volver a descargar'**
  String get weatherRefresh;

  /// No description provided for @weatherLoading.
  ///
  /// In es, this message translates to:
  /// **'Descargando clima y simulando…'**
  String get weatherLoading;

  /// No description provided for @weatherError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo obtener el clima: {message}'**
  String weatherError(String message);

  /// No description provided for @weatherSource.
  ///
  /// In es, this message translates to:
  /// **'Serie: {source}'**
  String weatherSource(String source);

  /// No description provided for @weatherAnnualTitle.
  ///
  /// In es, this message translates to:
  /// **'Producción anual'**
  String get weatherAnnualTitle;

  /// No description provided for @weatherAnnualValue.
  ///
  /// In es, this message translates to:
  /// **'{value} kWh por kWp al año'**
  String weatherAnnualValue(String value);

  /// No description provided for @weatherPerformanceRatio.
  ///
  /// In es, this message translates to:
  /// **'Performance ratio: {value}'**
  String weatherPerformanceRatio(String value);

  /// No description provided for @weatherMonthlyTitle.
  ///
  /// In es, this message translates to:
  /// **'Producción mensual (kWh por kWp)'**
  String get weatherMonthlyTitle;

  /// No description provided for @weatherOptimalTitle.
  ///
  /// In es, this message translates to:
  /// **'Orientación óptima'**
  String get weatherOptimalTitle;

  /// No description provided for @weatherOptimalValue.
  ///
  /// In es, this message translates to:
  /// **'Inclinación {tilt}° · azimut {azimuth}°'**
  String weatherOptimalValue(String tilt, String azimuth);

  /// No description provided for @weatherLatitudeRule.
  ///
  /// In es, this message translates to:
  /// **'Con inclinación = latitud: {value} kWh/kWp ({diff} %)'**
  String weatherLatitudeRule(String value, String diff);

  /// No description provided for @weatherTemperaturesTitle.
  ///
  /// In es, this message translates to:
  /// **'Temperaturas del sitio'**
  String get weatherTemperaturesTitle;

  /// No description provided for @weatherSunPathTitle.
  ///
  /// In es, this message translates to:
  /// **'Trayectoria solar'**
  String get weatherSunPathTitle;

  /// No description provided for @weatherSunPathAxis.
  ///
  /// In es, this message translates to:
  /// **'Azimut (°) vs. altura solar (°)'**
  String get weatherSunPathAxis;

  /// No description provided for @weatherJuneSolstice.
  ///
  /// In es, this message translates to:
  /// **'Solsticio de junio'**
  String get weatherJuneSolstice;

  /// No description provided for @weatherEquinox.
  ///
  /// In es, this message translates to:
  /// **'Equinoccios'**
  String get weatherEquinox;

  /// No description provided for @weatherDecemberSolstice.
  ///
  /// In es, this message translates to:
  /// **'Solsticio de diciembre'**
  String get weatherDecemberSolstice;

  /// No description provided for @weatherWarningsTitle.
  ///
  /// In es, this message translates to:
  /// **'Advertencias'**
  String get weatherWarningsTitle;

  /// No description provided for @weatherAttributionsTitle.
  ///
  /// In es, this message translates to:
  /// **'Fuentes de datos'**
  String get weatherAttributionsTitle;

  /// No description provided for @weatherProjectLocation.
  ///
  /// In es, this message translates to:
  /// **'Ubicación guardada del proyecto:'**
  String get weatherProjectLocation;

  /// No description provided for @weatherNoProjectLocation.
  ///
  /// In es, this message translates to:
  /// **'Este proyecto todavía no tiene ubicación. Escribe las coordenadas aquí, o agrégala en la ficha del proyecto.'**
  String get weatherNoProjectLocation;

  /// No description provided for @weatherProjectEntryTitle.
  ///
  /// In es, this message translates to:
  /// **'Clima y producción'**
  String get weatherProjectEntryTitle;

  /// No description provided for @weatherProjectEntrySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Cuánta energía daría 1 kWp aquí y la mejor inclinación'**
  String get weatherProjectEntrySubtitle;

  /// No description provided for @weatherTimeZone.
  ///
  /// In es, this message translates to:
  /// **'Zona horaria: {zone} ({offset})'**
  String weatherTimeZone(String zone, String offset);

  /// No description provided for @weatherDesignMin.
  ///
  /// In es, this message translates to:
  /// **'Mínima para diseño: {value} °C ({source})'**
  String weatherDesignMin(String value, String source);

  /// No description provided for @weatherDesignMax.
  ///
  /// In es, this message translates to:
  /// **'Máxima para diseño: {value} °C ({source})'**
  String weatherDesignMax(String value, String source);

  /// No description provided for @weatherDesignHint.
  ///
  /// In es, this message translates to:
  /// **'Para diseñar los strings se usa la más extrema de las dos fuentes.'**
  String get weatherDesignHint;

  /// No description provided for @weatherTemperaturesBySource.
  ///
  /// In es, this message translates to:
  /// **'{source}: mínima {min} °C · máxima {max} °C'**
  String weatherTemperaturesBySource(String source, String min, String max);

  /// No description provided for @obstacleWaterTank.
  ///
  /// In es, this message translates to:
  /// **'Tinaco'**
  String get obstacleWaterTank;

  /// No description provided for @obstacleAntenna.
  ///
  /// In es, this message translates to:
  /// **'Antena'**
  String get obstacleAntenna;

  /// No description provided for @obstacleParapet.
  ///
  /// In es, this message translates to:
  /// **'Pretil'**
  String get obstacleParapet;

  /// No description provided for @obstacleGasTank.
  ///
  /// In es, this message translates to:
  /// **'Tanque de gas'**
  String get obstacleGasTank;

  /// No description provided for @obstacleMinisplit.
  ///
  /// In es, this message translates to:
  /// **'Minisplit'**
  String get obstacleMinisplit;

  /// No description provided for @obstacleDome.
  ///
  /// In es, this message translates to:
  /// **'Domo'**
  String get obstacleDome;

  /// No description provided for @obstacleStairwell.
  ///
  /// In es, this message translates to:
  /// **'Cubo de escalera'**
  String get obstacleStairwell;

  /// No description provided for @obstacleTree.
  ///
  /// In es, this message translates to:
  /// **'Árbol'**
  String get obstacleTree;

  /// No description provided for @obstacleNeighborBuilding.
  ///
  /// In es, this message translates to:
  /// **'Edificio vecino'**
  String get obstacleNeighborBuilding;

  /// No description provided for @roofTitle.
  ///
  /// In es, this message translates to:
  /// **'Techo'**
  String get roofTitle;

  /// No description provided for @roofEntryEmpty.
  ///
  /// In es, this message translates to:
  /// **'Imagen o croquis, planos, obstáculos y sombras'**
  String get roofEntryEmpty;

  /// No description provided for @roofEntrySummary.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 plano} other{{count} planos}} · {area}'**
  String roofEntrySummary(int count, String area);

  /// No description provided for @roofBaseTitle.
  ///
  /// In es, this message translates to:
  /// **'Base del techo'**
  String get roofBaseTitle;

  /// No description provided for @roofBaseNone.
  ///
  /// In es, this message translates to:
  /// **'Importa una imagen vista desde arriba o dibuja un croquis con medidas de cinta.'**
  String get roofBaseNone;

  /// No description provided for @roofBaseSketch.
  ///
  /// In es, this message translates to:
  /// **'Croquis con medidas de cinta (sin imagen)'**
  String get roofBaseSketch;

  /// No description provided for @roofBaseImageUncalibrated.
  ///
  /// In es, this message translates to:
  /// **'Imagen sin calibrar: traza una línea de medida conocida'**
  String get roofBaseImageUncalibrated;

  /// No description provided for @roofBaseImage.
  ///
  /// In es, this message translates to:
  /// **'Imagen calibrada · 1 píxel = {scale}'**
  String roofBaseImage(String scale);

  /// No description provided for @roofImportImage.
  ///
  /// In es, this message translates to:
  /// **'Importar imagen'**
  String get roofImportImage;

  /// No description provided for @roofChangeImage.
  ///
  /// In es, this message translates to:
  /// **'Cambiar imagen'**
  String get roofChangeImage;

  /// No description provided for @roofSketchMode.
  ///
  /// In es, this message translates to:
  /// **'Croquis con cinta'**
  String get roofSketchMode;

  /// No description provided for @roofImageRightsNotice.
  ///
  /// In es, this message translates to:
  /// **'Usa solo imágenes que tengas derecho a usar.'**
  String get roofImageRightsNotice;

  /// No description provided for @roofImageTopViewHint.
  ///
  /// In es, this message translates to:
  /// **'Vista desde arriba: captura, foto aérea, de dron o plano. Las vistas inclinadas dan medidas falsas.'**
  String get roofImageTopViewHint;

  /// No description provided for @roofSourceGallery.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get roofSourceGallery;

  /// No description provided for @roofSourceCamera.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get roofSourceCamera;

  /// No description provided for @roofImageSaved.
  ///
  /// In es, this message translates to:
  /// **'Imagen guardada. Ahora calibra la escala.'**
  String get roofImageSaved;

  /// No description provided for @roofImageInvalid.
  ///
  /// In es, this message translates to:
  /// **'El archivo no es una imagen válida.'**
  String get roofImageInvalid;

  /// No description provided for @roofPlanesTitle.
  ///
  /// In es, this message translates to:
  /// **'Planos del techo'**
  String get roofPlanesTitle;

  /// No description provided for @roofPlanesEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay planos trazados.'**
  String get roofPlanesEmpty;

  /// No description provided for @roofPlaneListItem.
  ///
  /// In es, this message translates to:
  /// **'{area} · inclinación {tilt} · azimut {azimuth}'**
  String roofPlaneListItem(String area, String tilt, String azimuth);

  /// No description provided for @roofObstaclesTitle.
  ///
  /// In es, this message translates to:
  /// **'Obstáculos'**
  String get roofObstaclesTitle;

  /// No description provided for @roofObstaclesCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Ninguno} =1{1 obstáculo} other{{count} obstáculos}}'**
  String roofObstaclesCount(int count);

  /// No description provided for @roofOpenEditor.
  ///
  /// In es, this message translates to:
  /// **'Trazar y editar'**
  String get roofOpenEditor;

  /// No description provided for @roofShadeTitle.
  ///
  /// In es, this message translates to:
  /// **'Sombras'**
  String get roofShadeTitle;

  /// No description provided for @roofShadeSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Sombra por fecha y hora y mapa de calor del año'**
  String get roofShadeSubtitle;

  /// No description provided for @roofHorizonTitle.
  ///
  /// In es, this message translates to:
  /// **'Horizonte'**
  String get roofHorizonTitle;

  /// No description provided for @roofHorizonSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Montañas (PVGIS) y {count, plural, =0{ningún obstáculo lejano} =1{1 obstáculo lejano} other{{count} obstáculos lejanos}}'**
  String roofHorizonSubtitle(int count);

  /// No description provided for @roofEditorTitle.
  ///
  /// In es, this message translates to:
  /// **'Editor del techo'**
  String get roofEditorTitle;

  /// No description provided for @roofToolCalibrate.
  ///
  /// In es, this message translates to:
  /// **'Calibrar'**
  String get roofToolCalibrate;

  /// No description provided for @roofToolVerify.
  ///
  /// In es, this message translates to:
  /// **'Verificar'**
  String get roofToolVerify;

  /// No description provided for @roofToolNorth.
  ///
  /// In es, this message translates to:
  /// **'Norte'**
  String get roofToolNorth;

  /// No description provided for @roofToolDraw.
  ///
  /// In es, this message translates to:
  /// **'Trazar'**
  String get roofToolDraw;

  /// No description provided for @roofToolObstacle.
  ///
  /// In es, this message translates to:
  /// **'Obstáculos'**
  String get roofToolObstacle;

  /// No description provided for @roofToolWalkway.
  ///
  /// In es, this message translates to:
  /// **'Pasillos'**
  String get roofToolWalkway;

  /// No description provided for @roofToolSelect.
  ///
  /// In es, this message translates to:
  /// **'Elegir'**
  String get roofToolSelect;

  /// No description provided for @roofCalibrateFirst.
  ///
  /// In es, this message translates to:
  /// **'Primero calibra la escala con una medida conocida.'**
  String get roofCalibrateFirst;

  /// No description provided for @roofCalibrateHelp.
  ///
  /// In es, this message translates to:
  /// **'Toca los dos extremos de algo cuya medida conozcas (un lado del techo, el frente del lote, una barra de escala). Usa zoom para tocar con precisión.'**
  String get roofCalibrateHelp;

  /// No description provided for @roofCalibrateDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cuánto mide la línea?'**
  String get roofCalibrateDialogTitle;

  /// No description provided for @roofVerifyDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cuánto mide en la realidad?'**
  String get roofVerifyDialogTitle;

  /// No description provided for @roofCalibrateDialogHelp.
  ///
  /// In es, this message translates to:
  /// **'Escribe la medida real en metros (con cinta o del plano).'**
  String get roofCalibrateDialogHelp;

  /// No description provided for @roofLengthMetersLabel.
  ///
  /// In es, this message translates to:
  /// **'Metros'**
  String get roofLengthMetersLabel;

  /// No description provided for @roofLineTooShort.
  ///
  /// In es, this message translates to:
  /// **'La línea es muy corta. Haz zoom y traza una más larga.'**
  String get roofLineTooShort;

  /// No description provided for @roofScaleNone.
  ///
  /// In es, this message translates to:
  /// **'Sin escala todavía.'**
  String get roofScaleNone;

  /// No description provided for @roofScaleValue.
  ///
  /// In es, this message translates to:
  /// **'Escala: 1 píxel = {perPixel} ({pixelsPerMeter} píxeles por metro)'**
  String roofScaleValue(String perPixel, String pixelsPerMeter);

  /// No description provided for @roofVerifyHelp.
  ///
  /// In es, this message translates to:
  /// **'Opcional: traza otra línea de medida conocida para comprobar la escala.'**
  String get roofVerifyHelp;

  /// No description provided for @roofVerifyResult.
  ///
  /// In es, this message translates to:
  /// **'Mide {measured} contra {real} reales: {difference}'**
  String roofVerifyResult(String measured, String real, String difference);

  /// No description provided for @roofVerifyWarning.
  ///
  /// In es, this message translates to:
  /// **'Diferencia mayor a 5 %: la imagen puede estar inclinada o alguna medida está mal. Recalibra.'**
  String get roofVerifyWarning;

  /// No description provided for @roofNorthHelp.
  ///
  /// In es, this message translates to:
  /// **'Gira la flecha hasta que apunte al norte, o toca dos puntos de una orilla del techo y confírmala con la brújula en sitio.'**
  String get roofNorthHelp;

  /// No description provided for @roofNorthValue.
  ///
  /// In es, this message translates to:
  /// **'Norte: {angle} · {source}'**
  String roofNorthValue(String angle, String source);

  /// No description provided for @roofNorthSourceDefault.
  ///
  /// In es, this message translates to:
  /// **'arriba (sin confirmar)'**
  String get roofNorthSourceDefault;

  /// No description provided for @roofNorthSourceManual.
  ///
  /// In es, this message translates to:
  /// **'girado a mano'**
  String get roofNorthSourceManual;

  /// No description provided for @roofNorthSourceCompass.
  ///
  /// In es, this message translates to:
  /// **'confirmado con brújula'**
  String get roofNorthSourceCompass;

  /// No description provided for @roofNorthCompass.
  ///
  /// In es, this message translates to:
  /// **'Confirmar con brújula'**
  String get roofNorthCompass;

  /// No description provided for @roofNorthCompassNeedsLine.
  ///
  /// In es, this message translates to:
  /// **'Toca 2 puntos de una orilla'**
  String get roofNorthCompassNeedsLine;

  /// No description provided for @roofNorthArrowTooltip.
  ///
  /// In es, this message translates to:
  /// **'Norte'**
  String get roofNorthArrowTooltip;

  /// No description provided for @roofNorthLetter.
  ///
  /// In es, this message translates to:
  /// **'N'**
  String get roofNorthLetter;

  /// No description provided for @roofDrawHelp.
  ///
  /// In es, this message translates to:
  /// **'Toca cada esquina del plano. El imán ayuda a hacer esquinas de 90° y a unir vértices. Toca la primera esquina para cerrar.'**
  String get roofDrawHelp;

  /// No description provided for @roofDrawLive.
  ///
  /// In es, this message translates to:
  /// **'Lados: {sides} · Área: {area}'**
  String roofDrawLive(String sides, String area);

  /// No description provided for @roofSnap.
  ///
  /// In es, this message translates to:
  /// **'Imán'**
  String get roofSnap;

  /// No description provided for @roofUndo.
  ///
  /// In es, this message translates to:
  /// **'Deshacer'**
  String get roofUndo;

  /// No description provided for @roofClosePolygon.
  ///
  /// In es, this message translates to:
  /// **'Cerrar plano'**
  String get roofClosePolygon;

  /// No description provided for @roofPlaneDefaultName.
  ///
  /// In es, this message translates to:
  /// **'Plano {number}'**
  String roofPlaneDefaultName(int number);

  /// No description provided for @roofObstacleHelp.
  ///
  /// In es, this message translates to:
  /// **'Elige el tipo y toca dónde está. Pretil: toca sus dos extremos.'**
  String get roofObstacleHelp;

  /// No description provided for @roofWalkwayHelp.
  ///
  /// In es, this message translates to:
  /// **'Toca los dos extremos del pasillo de mantenimiento dentro de un plano.'**
  String get roofWalkwayHelp;

  /// No description provided for @roofWalkwayOutside.
  ///
  /// In es, this message translates to:
  /// **'El pasillo debe quedar dentro de un plano.'**
  String get roofWalkwayOutside;

  /// No description provided for @roofWalkwayWidthTitle.
  ///
  /// In es, this message translates to:
  /// **'Ancho del pasillo'**
  String get roofWalkwayWidthTitle;

  /// No description provided for @roofWalkwayItem.
  ///
  /// In es, this message translates to:
  /// **'Pasillo de {length} × {width}'**
  String roofWalkwayItem(String length, String width);

  /// No description provided for @roofSelectHelp.
  ///
  /// In es, this message translates to:
  /// **'Toca un plano para ver sus medidas o un obstáculo para editarlo.'**
  String get roofSelectHelp;

  /// No description provided for @roofMoveVertexHelp.
  ///
  /// In es, this message translates to:
  /// **'Para mover una esquina: tócala y luego toca su nuevo lugar.'**
  String get roofMoveVertexHelp;

  /// No description provided for @roofPlaneSummary.
  ///
  /// In es, this message translates to:
  /// **'Vista desde arriba {horizontal} · real inclinada {sloped} · útil {usable}\nInclinación {tilt} · azimut {azimuth}'**
  String roofPlaneSummary(
    String horizontal,
    String sloped,
    String usable,
    String tilt,
    String azimuth,
  );

  /// No description provided for @roofInvalidNumber.
  ///
  /// In es, this message translates to:
  /// **'Escribe un número válido.'**
  String get roofInvalidNumber;

  /// No description provided for @roofPlaneName.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get roofPlaneName;

  /// No description provided for @roofPlaneTilt.
  ///
  /// In es, this message translates to:
  /// **'Inclinación (grados)'**
  String get roofPlaneTilt;

  /// No description provided for @roofPlaneInclinometer.
  ///
  /// In es, this message translates to:
  /// **'Inclinómetro'**
  String get roofPlaneInclinometer;

  /// No description provided for @roofPlaneEave.
  ///
  /// In es, this message translates to:
  /// **'Orilla baja (alero)'**
  String get roofPlaneEave;

  /// No description provided for @roofPlaneEdgeItem.
  ///
  /// In es, this message translates to:
  /// **'Lado {number}: {length} → mira a {azimuth}'**
  String roofPlaneEdgeItem(int number, String length, String azimuth);

  /// No description provided for @roofPlaneAzimuth.
  ///
  /// In es, this message translates to:
  /// **'Azimut (hacia dónde baja): {azimuth} (180° = sur)'**
  String roofPlaneAzimuth(String azimuth);

  /// No description provided for @roofPlaneSetback.
  ///
  /// In es, this message translates to:
  /// **'Retiro de borde (m)'**
  String get roofPlaneSetback;

  /// No description provided for @roofSplitHelp.
  ///
  /// In es, this message translates to:
  /// **'Dividir en dos planos por una diagonal entre dos esquinas:'**
  String get roofSplitHelp;

  /// No description provided for @roofSplitVertex.
  ///
  /// In es, this message translates to:
  /// **'Esquina'**
  String get roofSplitVertex;

  /// No description provided for @roofSplit.
  ///
  /// In es, this message translates to:
  /// **'Dividir'**
  String get roofSplit;

  /// No description provided for @roofSplitInvalid.
  ///
  /// In es, this message translates to:
  /// **'Esa diagonal no queda dentro del plano.'**
  String get roofSplitInvalid;

  /// No description provided for @roofPlaneDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar el plano?'**
  String get roofPlaneDeleteTitle;

  /// No description provided for @roofPlaneDeleteMessage.
  ///
  /// In es, this message translates to:
  /// **'Se quitará del techo.'**
  String get roofPlaneDeleteMessage;

  /// No description provided for @roofObstacleDiameter.
  ///
  /// In es, this message translates to:
  /// **'Diámetro (m)'**
  String get roofObstacleDiameter;

  /// No description provided for @roofObstacleWidth.
  ///
  /// In es, this message translates to:
  /// **'Ancho (m)'**
  String get roofObstacleWidth;

  /// No description provided for @roofObstacleThickness.
  ///
  /// In es, this message translates to:
  /// **'Espesor (m)'**
  String get roofObstacleThickness;

  /// No description provided for @roofObstacleDepth.
  ///
  /// In es, this message translates to:
  /// **'Fondo (m)'**
  String get roofObstacleDepth;

  /// No description provided for @roofObstacleRotation.
  ///
  /// In es, this message translates to:
  /// **'Giro (grados)'**
  String get roofObstacleRotation;

  /// No description provided for @roofObstacleHeight.
  ///
  /// In es, this message translates to:
  /// **'Altura sobre tu techo (m)'**
  String get roofObstacleHeight;

  /// No description provided for @roofObstacleHeightHelp.
  ///
  /// In es, this message translates to:
  /// **'Típica del catálogo, medida con cinta o con el teléfono (distancia × tan(ángulo) + altura de ojos).'**
  String get roofObstacleHeightHelp;

  /// No description provided for @roofHeightTypical.
  ///
  /// In es, this message translates to:
  /// **'Típica'**
  String get roofHeightTypical;

  /// No description provided for @roofHeightTape.
  ///
  /// In es, this message translates to:
  /// **'Cinta'**
  String get roofHeightTape;

  /// No description provided for @roofHeightPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get roofHeightPhone;

  /// No description provided for @roofHeightPhoneTitle.
  ///
  /// In es, this message translates to:
  /// **'Altura con el teléfono'**
  String get roofHeightPhoneTitle;

  /// No description provided for @roofHeightPhoneHelp.
  ///
  /// In es, this message translates to:
  /// **'Párate a una distancia conocida, apunta la cámara al punto más alto y lee el ángulo.'**
  String get roofHeightPhoneHelp;

  /// No description provided for @roofHeightDistance.
  ///
  /// In es, this message translates to:
  /// **'Distancia al objeto (m)'**
  String get roofHeightDistance;

  /// No description provided for @roofHeightAngle.
  ///
  /// In es, this message translates to:
  /// **'Ángulo al tope (grados)'**
  String get roofHeightAngle;

  /// No description provided for @roofHeightEye.
  ///
  /// In es, this message translates to:
  /// **'Altura de tus ojos (m)'**
  String get roofHeightEye;

  /// No description provided for @roofHeightResult.
  ///
  /// In es, this message translates to:
  /// **'Altura: {height}'**
  String roofHeightResult(String height);

  /// No description provided for @roofSensorTiltTitle.
  ///
  /// In es, this message translates to:
  /// **'Inclinómetro'**
  String get roofSensorTiltTitle;

  /// No description provided for @roofSensorTiltHelp.
  ///
  /// In es, this message translates to:
  /// **'Apoya el teléfono sobre el techo, con la pantalla hacia arriba y el lado largo en la dirección de la pendiente.'**
  String get roofSensorTiltHelp;

  /// No description provided for @roofSensorCompassTitle.
  ///
  /// In es, this message translates to:
  /// **'Brújula'**
  String get roofSensorCompassTitle;

  /// No description provided for @roofSensorCompassHelp.
  ///
  /// In es, this message translates to:
  /// **'Acuesta el teléfono sobre la orilla elegida, con la parte de arriba apuntando del primer punto al segundo. Aléjalo de metales.'**
  String get roofSensorCompassHelp;

  /// No description provided for @roofSensorAimTitle.
  ///
  /// In es, this message translates to:
  /// **'Apuntar con la cámara'**
  String get roofSensorAimTitle;

  /// No description provided for @roofSensorAimHelp.
  ///
  /// In es, this message translates to:
  /// **'Apunta la cámara trasera al punto más alto del objeto.'**
  String get roofSensorAimHelp;

  /// No description provided for @roofSensorTiltValue.
  ///
  /// In es, this message translates to:
  /// **'Inclinación: {value}'**
  String roofSensorTiltValue(String value);

  /// No description provided for @roofSensorAzimuthValue.
  ///
  /// In es, this message translates to:
  /// **'Rumbo: {value}'**
  String roofSensorAzimuthValue(String value);

  /// No description provided for @roofSensorElevationValue.
  ///
  /// In es, this message translates to:
  /// **'Ángulo: {value}'**
  String roofSensorElevationValue(String value);

  /// No description provided for @roofSensorDeclination.
  ///
  /// In es, this message translates to:
  /// **'Corregido al norte verdadero con declinación magnética {value} (modelo WMM).'**
  String roofSensorDeclination(String value);

  /// No description provided for @roofSensorWaiting.
  ///
  /// In es, this message translates to:
  /// **'Esperando al sensor…'**
  String get roofSensorWaiting;

  /// No description provided for @roofSensorUnavailable.
  ///
  /// In es, this message translates to:
  /// **'Este teléfono no tiene el sensor o está apagado. Escribe el valor a mano.'**
  String get roofSensorUnavailable;

  /// No description provided for @roofSensorUse.
  ///
  /// In es, this message translates to:
  /// **'Usar'**
  String get roofSensorUse;

  /// No description provided for @roofTapeTitle.
  ///
  /// In es, this message translates to:
  /// **'Croquis con cinta'**
  String get roofTapeTitle;

  /// No description provided for @roofTapeHelp.
  ///
  /// In es, this message translates to:
  /// **'Escribe cada lado en orden. Giro: 90 = esquina normal, −90 = esquina hacia adentro.'**
  String get roofTapeHelp;

  /// No description provided for @roofTapeSide.
  ///
  /// In es, this message translates to:
  /// **'Lado {number} (m)'**
  String roofTapeSide(int number);

  /// No description provided for @roofTapeTurn.
  ///
  /// In es, this message translates to:
  /// **'Giro (°)'**
  String get roofTapeTurn;

  /// No description provided for @roofTapeAddSide.
  ///
  /// In es, this message translates to:
  /// **'Agregar lado'**
  String get roofTapeAddSide;

  /// No description provided for @roofTapeResult.
  ///
  /// In es, this message translates to:
  /// **'Área: {area} · cierre: {error}'**
  String roofTapeResult(String area, String error);

  /// No description provided for @roofTapeNotClosed.
  ///
  /// In es, this message translates to:
  /// **'Las medidas no cierran: revisa algún lado o giro.'**
  String get roofTapeNotClosed;

  /// No description provided for @roofShadeNeedsLocation.
  ///
  /// In es, this message translates to:
  /// **'Primero guarda la ubicación del proyecto (se necesita para saber dónde está el sol).'**
  String get roofShadeNeedsLocation;

  /// No description provided for @roofSunPosition.
  ///
  /// In es, this message translates to:
  /// **'Sol: {elevation} de altura, azimut {azimuth}'**
  String roofSunPosition(String elevation, String azimuth);

  /// No description provided for @roofSunHidden.
  ///
  /// In es, this message translates to:
  /// **'El sol está abajo o tapado por el horizonte: no hay sombra directa.'**
  String get roofSunHidden;

  /// No description provided for @roofShadeTime.
  ///
  /// In es, this message translates to:
  /// **'{time} h'**
  String roofShadeTime(String time);

  /// No description provided for @roofShadeCompute.
  ///
  /// In es, this message translates to:
  /// **'Mapa de calor anual'**
  String get roofShadeCompute;

  /// No description provided for @roofShadeHeatmap.
  ///
  /// In es, this message translates to:
  /// **'Ver mapa'**
  String get roofShadeHeatmap;

  /// No description provided for @roofShadePlaneLoss.
  ///
  /// In es, this message translates to:
  /// **'{plane}: pierde {year} del sol directo al año (diciembre {december}, junio {june})'**
  String roofShadePlaneLoss(
    String plane,
    String year,
    String december,
    String june,
  );

  /// No description provided for @roofShadeLegend.
  ///
  /// In es, this message translates to:
  /// **'Verde = sin sombra · amarillo · rojo = 30 % o más de pérdida. Incluye el horizonte.'**
  String get roofShadeLegend;

  /// No description provided for @roofHorizonHelp.
  ///
  /// In es, this message translates to:
  /// **'El horizonte tapa el sol bajo. Se junta el del terreno (montañas, de PVGIS) con los obstáculos lejanos que midas con el teléfono.'**
  String get roofHorizonHelp;

  /// No description provided for @roofTerrainTitle.
  ///
  /// In es, this message translates to:
  /// **'Terreno (PVGIS)'**
  String get roofTerrainTitle;

  /// No description provided for @roofTerrainNone.
  ///
  /// In es, this message translates to:
  /// **'Sin descargar'**
  String get roofTerrainNone;

  /// No description provided for @roofTerrainValue.
  ///
  /// In es, this message translates to:
  /// **'Descargado · altura máxima {max}'**
  String roofTerrainValue(String max);

  /// No description provided for @roofTerrainDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargar'**
  String get roofTerrainDownload;

  /// No description provided for @roofHorizonDownloadError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo descargar el horizonte. Revisa la conexión.'**
  String get roofHorizonDownloadError;

  /// No description provided for @roofFarTitle.
  ///
  /// In es, this message translates to:
  /// **'Obstáculos lejanos'**
  String get roofFarTitle;

  /// No description provided for @roofFarEmpty.
  ///
  /// In es, this message translates to:
  /// **'Ninguno. Agrega árboles o edificios cercanos que tapen el sol.'**
  String get roofFarEmpty;

  /// No description provided for @roofFarItem.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 punto} other{{count} puntos}} · hasta {max}'**
  String roofFarItem(int count, String max);

  /// No description provided for @roofFarAdd.
  ///
  /// In es, this message translates to:
  /// **'Obstáculo lejano'**
  String get roofFarAdd;

  /// No description provided for @roofFarName.
  ///
  /// In es, this message translates to:
  /// **'Nombre (p. ej. árbol del vecino)'**
  String get roofFarName;

  /// No description provided for @roofFarDefaultName.
  ///
  /// In es, this message translates to:
  /// **'Obstáculo lejano'**
  String get roofFarDefaultName;

  /// No description provided for @roofFarHelp.
  ///
  /// In es, this message translates to:
  /// **'Desde el techo, apunta la cámara al borde de arriba del obstáculo, de izquierda a derecha, y agrega varios puntos.'**
  String get roofFarHelp;

  /// No description provided for @roofFarMeasure.
  ///
  /// In es, this message translates to:
  /// **'Medir punto con el teléfono'**
  String get roofFarMeasure;

  /// No description provided for @roofFarAzimuth.
  ///
  /// In es, this message translates to:
  /// **'Azimut (°)'**
  String get roofFarAzimuth;

  /// No description provided for @roofFarElevation.
  ///
  /// In es, this message translates to:
  /// **'Altura (°)'**
  String get roofFarElevation;

  /// No description provided for @roofCardinalN.
  ///
  /// In es, this message translates to:
  /// **'N'**
  String get roofCardinalN;

  /// No description provided for @roofCardinalE.
  ///
  /// In es, this message translates to:
  /// **'E'**
  String get roofCardinalE;

  /// No description provided for @roofCardinalS.
  ///
  /// In es, this message translates to:
  /// **'S'**
  String get roofCardinalS;

  /// No description provided for @roofCardinalW.
  ///
  /// In es, this message translates to:
  /// **'O'**
  String get roofCardinalW;

  /// No description provided for @catalogPanels.
  ///
  /// In es, this message translates to:
  /// **'Paneles'**
  String get catalogPanels;

  /// No description provided for @catalogInverters.
  ///
  /// In es, this message translates to:
  /// **'Inversores'**
  String get catalogInverters;

  /// No description provided for @catalogOptimizers.
  ///
  /// In es, this message translates to:
  /// **'Optimizadores'**
  String get catalogOptimizers;

  /// No description provided for @catalogBatteries.
  ///
  /// In es, this message translates to:
  /// **'Baterías'**
  String get catalogBatteries;

  /// No description provided for @catalogNewPanel.
  ///
  /// In es, this message translates to:
  /// **'Panel nuevo'**
  String get catalogNewPanel;

  /// No description provided for @catalogNewInverter.
  ///
  /// In es, this message translates to:
  /// **'Inversor nuevo'**
  String get catalogNewInverter;

  /// No description provided for @catalogNewOptimizer.
  ///
  /// In es, this message translates to:
  /// **'Optimizador nuevo'**
  String get catalogNewOptimizer;

  /// No description provided for @catalogNewBattery.
  ///
  /// In es, this message translates to:
  /// **'Batería nueva'**
  String get catalogNewBattery;

  /// No description provided for @catalogEditTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar equipo'**
  String get catalogEditTitle;

  /// No description provided for @catalogEmpty.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay equipos. Captúralos con su hoja de datos o impórtalos del catálogo CEC.'**
  String get catalogEmpty;

  /// No description provided for @catalogInvalidData.
  ///
  /// In es, this message translates to:
  /// **'Revisa los datos: Vmp debe ser menor que Voc y el MPPT mínimo menor que el máximo.'**
  String get catalogInvalidData;

  /// No description provided for @catalogDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Borrar el equipo?'**
  String get catalogDeleteTitle;

  /// No description provided for @catalogDeleteMessage.
  ///
  /// In es, this message translates to:
  /// **'Los diseños que ya lo usan lo conservan.'**
  String get catalogDeleteMessage;

  /// No description provided for @catalogPanelSummary.
  ///
  /// In es, this message translates to:
  /// **'{watts} W · Voc {voc} V · Isc {isc} A'**
  String catalogPanelSummary(int watts, String voc, String isc);

  /// No description provided for @catalogInverterSummary.
  ///
  /// In es, this message translates to:
  /// **'{kw} kW · {mppt} MPPT · {kind}'**
  String catalogInverterSummary(String kw, int mppt, String kind);

  /// No description provided for @specManufacturer.
  ///
  /// In es, this message translates to:
  /// **'Fabricante'**
  String get specManufacturer;

  /// No description provided for @specModel.
  ///
  /// In es, this message translates to:
  /// **'Modelo'**
  String get specModel;

  /// No description provided for @specPmax.
  ///
  /// In es, this message translates to:
  /// **'Potencia máxima (Pmax)'**
  String get specPmax;

  /// No description provided for @specVoc.
  ///
  /// In es, this message translates to:
  /// **'Voltaje de circuito abierto (Voc)'**
  String get specVoc;

  /// No description provided for @specVocHelp.
  ///
  /// In es, this message translates to:
  /// **'El voltaje sin carga. Con frío sube: se usa para no pasar el máximo del inversor.'**
  String get specVocHelp;

  /// No description provided for @specIsc.
  ///
  /// In es, this message translates to:
  /// **'Corriente de cortocircuito (Isc)'**
  String get specIsc;

  /// No description provided for @specIscHelp.
  ///
  /// In es, this message translates to:
  /// **'La corriente máxima del panel. Con ella se eligen cables y fusibles.'**
  String get specIscHelp;

  /// No description provided for @specVmp.
  ///
  /// In es, this message translates to:
  /// **'Voltaje en máxima potencia (Vmp)'**
  String get specVmp;

  /// No description provided for @specImp.
  ///
  /// In es, this message translates to:
  /// **'Corriente en máxima potencia (Imp)'**
  String get specImp;

  /// No description provided for @specGammaPmax.
  ///
  /// In es, this message translates to:
  /// **'Coeficiente de temperatura de Pmax'**
  String get specGammaPmax;

  /// No description provided for @specCoeffHelp.
  ///
  /// In es, this message translates to:
  /// **'Viene en la hoja de datos como %/°C y es negativo (p. ej. −0.35).'**
  String get specCoeffHelp;

  /// No description provided for @specBetaVoc.
  ///
  /// In es, this message translates to:
  /// **'Coeficiente de temperatura de Voc'**
  String get specBetaVoc;

  /// No description provided for @specBetaVmp.
  ///
  /// In es, this message translates to:
  /// **'Coeficiente de temperatura de Vmp'**
  String get specBetaVmp;

  /// No description provided for @specLength.
  ///
  /// In es, this message translates to:
  /// **'Largo'**
  String get specLength;

  /// No description provided for @specWidth.
  ///
  /// In es, this message translates to:
  /// **'Ancho'**
  String get specWidth;

  /// No description provided for @specWeight.
  ///
  /// In es, this message translates to:
  /// **'Peso'**
  String get specWeight;

  /// No description provided for @specCellType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de celda'**
  String get specCellType;

  /// No description provided for @specCellCount.
  ///
  /// In es, this message translates to:
  /// **'Número de celdas'**
  String get specCellCount;

  /// No description provided for @specBifacial.
  ///
  /// In es, this message translates to:
  /// **'Bifacial'**
  String get specBifacial;

  /// No description provided for @specMaxFuse.
  ///
  /// In es, this message translates to:
  /// **'Fusible máximo en serie'**
  String get specMaxFuse;

  /// No description provided for @cellMono.
  ///
  /// In es, this message translates to:
  /// **'Monocristalino'**
  String get cellMono;

  /// No description provided for @cellPoly.
  ///
  /// In es, this message translates to:
  /// **'Policristalino'**
  String get cellPoly;

  /// No description provided for @cellThinFilm.
  ///
  /// In es, this message translates to:
  /// **'Película delgada'**
  String get cellThinFilm;

  /// No description provided for @cellOther.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get cellOther;

  /// No description provided for @specInverterKind.
  ///
  /// In es, this message translates to:
  /// **'Tipo'**
  String get specInverterKind;

  /// No description provided for @inverterString.
  ///
  /// In es, this message translates to:
  /// **'De string'**
  String get inverterString;

  /// No description provided for @inverterMicro.
  ///
  /// In es, this message translates to:
  /// **'Microinversor'**
  String get inverterMicro;

  /// No description provided for @inverterHybrid.
  ///
  /// In es, this message translates to:
  /// **'Híbrido (con baterías)'**
  String get inverterHybrid;

  /// No description provided for @specPac.
  ///
  /// In es, this message translates to:
  /// **'Potencia de salida (Pac)'**
  String get specPac;

  /// No description provided for @specVdcMax.
  ///
  /// In es, this message translates to:
  /// **'Voltaje de entrada máximo'**
  String get specVdcMax;

  /// No description provided for @specMpptMin.
  ///
  /// In es, this message translates to:
  /// **'MPPT mínimo'**
  String get specMpptMin;

  /// No description provided for @specMpptMax.
  ///
  /// In es, this message translates to:
  /// **'MPPT máximo'**
  String get specMpptMax;

  /// No description provided for @specMpptCount.
  ///
  /// In es, this message translates to:
  /// **'Número de MPPT'**
  String get specMpptCount;

  /// No description provided for @specMpptCountHelp.
  ///
  /// In es, this message translates to:
  /// **'Entradas independientes. En un microinversor, cuántos paneles admite.'**
  String get specMpptCountHelp;

  /// No description provided for @specImaxMppt.
  ///
  /// In es, this message translates to:
  /// **'Corriente máxima por MPPT'**
  String get specImaxMppt;

  /// No description provided for @specEfficiency.
  ///
  /// In es, this message translates to:
  /// **'Eficiencia'**
  String get specEfficiency;

  /// No description provided for @specPhases.
  ///
  /// In es, this message translates to:
  /// **'Fases'**
  String get specPhases;

  /// No description provided for @phaseSingle.
  ///
  /// In es, this message translates to:
  /// **'Monofásico'**
  String get phaseSingle;

  /// No description provided for @phaseThree.
  ///
  /// In es, this message translates to:
  /// **'Trifásico'**
  String get phaseThree;

  /// No description provided for @specAcVoltage.
  ///
  /// In es, this message translates to:
  /// **'Voltaje de salida'**
  String get specAcVoltage;

  /// No description provided for @specIacMax.
  ///
  /// In es, this message translates to:
  /// **'Corriente máxima de salida'**
  String get specIacMax;

  /// No description provided for @specPmaxIn.
  ///
  /// In es, this message translates to:
  /// **'Potencia de entrada máxima'**
  String get specPmaxIn;

  /// No description provided for @specVinMax.
  ///
  /// In es, this message translates to:
  /// **'Voltaje de entrada máximo'**
  String get specVinMax;

  /// No description provided for @specImaxIn.
  ///
  /// In es, this message translates to:
  /// **'Corriente de entrada máxima'**
  String get specImaxIn;

  /// No description provided for @specVoutMax.
  ///
  /// In es, this message translates to:
  /// **'Voltaje de salida máximo'**
  String get specVoutMax;

  /// No description provided for @specIoutMax.
  ///
  /// In es, this message translates to:
  /// **'Corriente de salida máxima'**
  String get specIoutMax;

  /// No description provided for @specChemistry.
  ///
  /// In es, this message translates to:
  /// **'Química'**
  String get specChemistry;

  /// No description provided for @chemLeadAcid.
  ///
  /// In es, this message translates to:
  /// **'Plomo ácido'**
  String get chemLeadAcid;

  /// No description provided for @specCapacity.
  ///
  /// In es, this message translates to:
  /// **'Capacidad'**
  String get specCapacity;

  /// No description provided for @specUsable.
  ///
  /// In es, this message translates to:
  /// **'Capacidad útil'**
  String get specUsable;

  /// No description provided for @specNominalVoltage.
  ///
  /// In es, this message translates to:
  /// **'Voltaje nominal'**
  String get specNominalVoltage;

  /// No description provided for @specMaxCharge.
  ///
  /// In es, this message translates to:
  /// **'Carga máxima'**
  String get specMaxCharge;

  /// No description provided for @specMaxDischarge.
  ///
  /// In es, this message translates to:
  /// **'Descarga máxima'**
  String get specMaxDischarge;

  /// No description provided for @specCycles.
  ///
  /// In es, this message translates to:
  /// **'Ciclos de vida'**
  String get specCycles;

  /// No description provided for @specRequired.
  ///
  /// In es, this message translates to:
  /// **'Obligatorio'**
  String get specRequired;

  /// No description provided for @specInvalidNumber.
  ///
  /// In es, this message translates to:
  /// **'Escribe un número'**
  String get specInvalidNumber;

  /// No description provided for @specPositive.
  ///
  /// In es, this message translates to:
  /// **'Debe ser mayor que 0'**
  String get specPositive;

  /// No description provided for @cecTitle.
  ///
  /// In es, this message translates to:
  /// **'Importar del catálogo CEC'**
  String get cecTitle;

  /// No description provided for @cecHelp.
  ///
  /// In es, this message translates to:
  /// **'Catálogo público de equipos certificados. Busca por marca o modelo e importa solo los que uses; revisa después la hoja de datos.'**
  String get cecHelp;

  /// No description provided for @cecSearchHint.
  ///
  /// In es, this message translates to:
  /// **'Marca o modelo'**
  String get cecSearchHint;

  /// No description provided for @cecLoading.
  ///
  /// In es, this message translates to:
  /// **'Descargando el catálogo (≈ 6 MB, solo la primera vez)…'**
  String get cecLoading;

  /// No description provided for @cecError.
  ///
  /// In es, this message translates to:
  /// **'No se pudo descargar el catálogo. Revisa la conexión e inténtalo de nuevo.'**
  String get cecError;

  /// No description provided for @cecTypeMore.
  ///
  /// In es, this message translates to:
  /// **'Escribe al menos 2 letras.'**
  String get cecTypeMore;

  /// No description provided for @cecNoResults.
  ///
  /// In es, this message translates to:
  /// **'Sin resultados.'**
  String get cecNoResults;

  /// No description provided for @cecImport.
  ///
  /// In es, this message translates to:
  /// **'Importar'**
  String get cecImport;

  /// No description provided for @cecImported.
  ///
  /// In es, this message translates to:
  /// **'Importado al catálogo'**
  String get cecImported;
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
