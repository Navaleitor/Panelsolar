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
