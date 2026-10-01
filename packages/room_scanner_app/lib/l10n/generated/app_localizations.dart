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
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('es')
  ];

  /// No description provided for @undoScanEdit.
  ///
  /// In es, this message translates to:
  /// **'Deshacer última acción'**
  String get undoScanEdit;

  /// No description provided for @redoScanEdit.
  ///
  /// In es, this message translates to:
  /// **'Rehacer última acción'**
  String get redoScanEdit;

  /// No description provided for @placeOpeningByTouch.
  ///
  /// In es, this message translates to:
  /// **'Ubicar abertura en el plano'**
  String get placeOpeningByTouch;

  /// No description provided for @touchOpeningInstructions.
  ///
  /// In es, this message translates to:
  /// **'Tocá una pared y deslizá la abertura hasta su posición. También podés elegir la pared de cierre. Ajustá el ancho y confirmá.'**
  String get touchOpeningInstructions;

  /// No description provided for @deleteOpening.
  ///
  /// In es, this message translates to:
  /// **'Eliminar abertura'**
  String get deleteOpening;

  /// No description provided for @deleteOpeningConfirmation.
  ///
  /// In es, this message translates to:
  /// **'Se eliminará esta abertura. Si conecta dos ambientes, se quitará la conexión sin borrar las habitaciones.'**
  String get deleteOpeningConfirmation;

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'ARchScan'**
  String get appTitle;

  /// No description provided for @newRoom.
  ///
  /// In es, this message translates to:
  /// **'Nuevo ambiente'**
  String get newRoom;

  /// No description provided for @roomName.
  ///
  /// In es, this message translates to:
  /// **'Nombre del ambiente'**
  String get roomName;

  /// No description provided for @roomDestination.
  ///
  /// In es, this message translates to:
  /// **'Destino o nombre'**
  String get roomDestination;

  /// No description provided for @cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @wall.
  ///
  /// In es, this message translates to:
  /// **'Pared'**
  String get wall;

  /// No description provided for @door.
  ///
  /// In es, this message translates to:
  /// **'Puerta'**
  String get door;

  /// No description provided for @window.
  ///
  /// In es, this message translates to:
  /// **'Ventana'**
  String get window;

  /// No description provided for @roomTypeLiving.
  ///
  /// In es, this message translates to:
  /// **'Living'**
  String get roomTypeLiving;

  /// No description provided for @roomTypeKitchen.
  ///
  /// In es, this message translates to:
  /// **'Cocina'**
  String get roomTypeKitchen;

  /// No description provided for @roomTypeBathroom.
  ///
  /// In es, this message translates to:
  /// **'Baño'**
  String get roomTypeBathroom;

  /// No description provided for @roomTypeBedroom.
  ///
  /// In es, this message translates to:
  /// **'Dormitorio'**
  String get roomTypeBedroom;

  /// No description provided for @roomTypeLaundry.
  ///
  /// In es, this message translates to:
  /// **'Lavadero'**
  String get roomTypeLaundry;

  /// No description provided for @roomTypeHallway.
  ///
  /// In es, this message translates to:
  /// **'Pasillo'**
  String get roomTypeHallway;

  /// No description provided for @roomTypeDiningRoom.
  ///
  /// In es, this message translates to:
  /// **'Comedor'**
  String get roomTypeDiningRoom;

  /// No description provided for @roomTypeDailyDiningRoom.
  ///
  /// In es, this message translates to:
  /// **'Comedor diario'**
  String get roomTypeDailyDiningRoom;

  /// No description provided for @roomTypePatio.
  ///
  /// In es, this message translates to:
  /// **'Patio'**
  String get roomTypePatio;

  /// No description provided for @roomTypeHall.
  ///
  /// In es, this message translates to:
  /// **'Hall'**
  String get roomTypeHall;

  /// No description provided for @roomTypeBalcony.
  ///
  /// In es, this message translates to:
  /// **'Balcón'**
  String get roomTypeBalcony;

  /// No description provided for @roomTypeTerrace.
  ///
  /// In es, this message translates to:
  /// **'Terraza'**
  String get roomTypeTerrace;

  /// No description provided for @roomTypeGarage.
  ///
  /// In es, this message translates to:
  /// **'Cochera'**
  String get roomTypeGarage;

  /// No description provided for @roomTypePlayroom.
  ///
  /// In es, this message translates to:
  /// **'Playroom'**
  String get roomTypePlayroom;

  /// No description provided for @roomTypeOther.
  ///
  /// In es, this message translates to:
  /// **'Otro espacio'**
  String get roomTypeOther;

  /// No description provided for @scanWithRoomPlan.
  ///
  /// In es, this message translates to:
  /// **'Escanear con RoomPlan'**
  String get scanWithRoomPlan;

  /// No description provided for @roomPlanSpaceSaved.
  ///
  /// In es, this message translates to:
  /// **'Espacio de RoomPlan guardado'**
  String get roomPlanSpaceSaved;

  /// No description provided for @roomPlanCaptureFailed.
  ///
  /// In es, this message translates to:
  /// **'RoomPlan no pudo completar el escaneo: {error}'**
  String roomPlanCaptureFailed(String error);

  /// No description provided for @roomType.
  ///
  /// In es, this message translates to:
  /// **'Tipo de ambiente'**
  String get roomType;

  /// No description provided for @viewPlan.
  ///
  /// In es, this message translates to:
  /// **'Ver plano'**
  String get viewPlan;

  /// No description provided for @editRoomName.
  ///
  /// In es, this message translates to:
  /// **'Editar nombre del ambiente'**
  String get editRoomName;

  /// No description provided for @roomNameExample.
  ///
  /// In es, this message translates to:
  /// **'Ej.: Dormitorio de Ana'**
  String get roomNameExample;

  /// No description provided for @whatIsSpaceName.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo se llama este espacio?'**
  String get whatIsSpaceName;

  /// No description provided for @roomSuggestionOffice.
  ///
  /// In es, this message translates to:
  /// **'Oficina'**
  String get roomSuggestionOffice;

  /// No description provided for @roomSuggestionStorage.
  ///
  /// In es, this message translates to:
  /// **'Depósito'**
  String get roomSuggestionStorage;

  /// No description provided for @spaceSaved.
  ///
  /// In es, this message translates to:
  /// **'Espacio guardado'**
  String get spaceSaved;

  /// No description provided for @whatWouldYouLikeToDo.
  ///
  /// In es, this message translates to:
  /// **'¿Qué querés hacer ahora? Para continuar desde otro ambiente, seleccioná una puerta o ventana en el plano.'**
  String get whatWouldYouLikeToDo;

  /// No description provided for @addAnotherSpace.
  ///
  /// In es, this message translates to:
  /// **'Agregar otro espacio'**
  String get addAnotherSpace;

  /// No description provided for @viewFullPlan.
  ///
  /// In es, this message translates to:
  /// **'Ver plano completo'**
  String get viewFullPlan;

  /// No description provided for @chooseOpeningToContinue.
  ///
  /// In es, this message translates to:
  /// **'Elegí una puerta o ventana para continuar'**
  String get chooseOpeningToContinue;

  /// No description provided for @noAvailableOpenings.
  ///
  /// In es, this message translates to:
  /// **'No hay aberturas disponibles.'**
  String get noAvailableOpenings;

  /// No description provided for @openingAlreadyConnected.
  ///
  /// In es, this message translates to:
  /// **'Esta abertura ya conecta dos ambientes.'**
  String get openingAlreadyConnected;

  /// No description provided for @unfinishedScan.
  ///
  /// In es, this message translates to:
  /// **'Escaneo sin terminar'**
  String get unfinishedScan;

  /// No description provided for @unfinishedScanFound.
  ///
  /// In es, this message translates to:
  /// **'Encontramos un escaneo que no se terminó.'**
  String get unfinishedScanFound;

  /// No description provided for @continueScan.
  ///
  /// In es, this message translates to:
  /// **'Continuar escaneo'**
  String get continueScan;

  /// No description provided for @discardScan.
  ///
  /// In es, this message translates to:
  /// **'Descartar'**
  String get discardScan;

  /// No description provided for @markStartRecommendation.
  ///
  /// In es, this message translates to:
  /// **'Marcá el inicio'**
  String get markStartRecommendation;

  /// No description provided for @addNextCornerRecommendation.
  ///
  /// In es, this message translates to:
  /// **'Agregá la próxima esquina'**
  String get addNextCornerRecommendation;

  /// No description provided for @closeSpaceRecommendation.
  ///
  /// In es, this message translates to:
  /// **'Ya podés cerrar el espacio'**
  String get closeSpaceRecommendation;

  /// No description provided for @calculating.
  ///
  /// In es, this message translates to:
  /// **'CALCULANDO...'**
  String get calculating;

  /// No description provided for @markStart.
  ///
  /// In es, this message translates to:
  /// **'MARCAR INICIO'**
  String get markStart;

  /// No description provided for @measureNextCorner.
  ///
  /// In es, this message translates to:
  /// **'MEDIR SIGUIENTE ESQUINA'**
  String get measureNextCorner;

  /// No description provided for @placeDoor.
  ///
  /// In es, this message translates to:
  /// **'UBICAR PUERTA'**
  String get placeDoor;

  /// No description provided for @placeWindow.
  ///
  /// In es, this message translates to:
  /// **'UBICAR VENTANA'**
  String get placeWindow;

  /// No description provided for @addCorner.
  ///
  /// In es, this message translates to:
  /// **'AÑADIR ESQUINA'**
  String get addCorner;

  /// No description provided for @markSecondEnd.
  ///
  /// In es, this message translates to:
  /// **'MARCAR SEGUNDO EXTREMO'**
  String get markSecondEnd;

  /// No description provided for @measureDoor.
  ///
  /// In es, this message translates to:
  /// **'MEDIR PUERTA'**
  String get measureDoor;

  /// No description provided for @measureWindow.
  ///
  /// In es, this message translates to:
  /// **'MEDIR VENTANA'**
  String get measureWindow;

  /// No description provided for @preparingCamera.
  ///
  /// In es, this message translates to:
  /// **'Preparando cámara...'**
  String get preparingCamera;

  /// No description provided for @basicScanner.
  ///
  /// In es, this message translates to:
  /// **'Escáner básico'**
  String get basicScanner;

  /// No description provided for @cameraStartFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar la cámara'**
  String get cameraStartFailed;

  /// No description provided for @unknownError.
  ///
  /// In es, this message translates to:
  /// **'Error desconocido.'**
  String get unknownError;

  /// No description provided for @retryCamera.
  ///
  /// In es, this message translates to:
  /// **'Reintentar cámara'**
  String get retryCamera;

  /// No description provided for @cameraPermissionRequired.
  ///
  /// In es, this message translates to:
  /// **'El permiso de cámara es necesario para utilizar el Escáner básico.'**
  String get cameraPermissionRequired;

  /// No description provided for @cameraUnavailable.
  ///
  /// In es, this message translates to:
  /// **'El dispositivo no tiene una cámara disponible.'**
  String get cameraUnavailable;

  /// No description provided for @cameraTimeoutMessage.
  ///
  /// In es, this message translates to:
  /// **'La cámara tardó demasiado en responder. Podés intentar iniciarla nuevamente.'**
  String get cameraTimeoutMessage;

  /// No description provided for @closeRoom.
  ///
  /// In es, this message translates to:
  /// **'Cerrar ambiente'**
  String get closeRoom;

  /// No description provided for @chooseClosingCorner.
  ///
  /// In es, this message translates to:
  /// **'Elegí la esquina donde querés cerrar'**
  String get chooseClosingCorner;

  /// No description provided for @chooseDifferentCorner.
  ///
  /// In es, this message translates to:
  /// **'Elegí una esquina diferente de la inicial'**
  String get chooseDifferentCorner;

  /// No description provided for @diagonalClosureDetectedTitle.
  ///
  /// In es, this message translates to:
  /// **'Cierre diagonal detectado'**
  String get diagonalClosureDetectedTitle;

  /// No description provided for @diagonalClosureDetectedMessage.
  ///
  /// In es, this message translates to:
  /// **'El cierre directo formaría una diagonal. La aplicación puede agregar la esquina ortogonal faltante y cerrar contra la primera esquina real del ambiente.'**
  String get diagonalClosureDetectedMessage;

  /// No description provided for @addCornerAndClose.
  ///
  /// In es, this message translates to:
  /// **'Agregar esquina y cerrar'**
  String get addCornerAndClose;

  /// No description provided for @smartCloseMessage.
  ///
  /// In es, this message translates to:
  /// **'La medición termina a {distance} metros del punto inicial. ¿Querés ajustar el cierre exactamente al inicio?'**
  String smartCloseMessage(String distance);

  /// No description provided for @continueMeasuring.
  ///
  /// In es, this message translates to:
  /// **'Continuar midiendo'**
  String get continueMeasuring;

  /// No description provided for @cameraResumeFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo reanudar la cámara: {error}'**
  String cameraResumeFailed(String error);

  /// No description provided for @continuationFromOpening.
  ///
  /// In es, this message translates to:
  /// **'Continuación desde una abertura'**
  String get continuationFromOpening;

  /// No description provided for @continuationFirstCornerInstruction.
  ///
  /// In es, this message translates to:
  /// **'Desde el punto verde, medí la distancia hasta la primera esquina real del ambiente.'**
  String get continuationFirstCornerInstruction;

  /// No description provided for @markRoomStartingPoint.
  ///
  /// In es, this message translates to:
  /// **'Marcá el punto inicial de la habitación.'**
  String get markRoomStartingPoint;

  /// No description provided for @measureNextCornerInstruction.
  ///
  /// In es, this message translates to:
  /// **'Medí la distancia hasta la próxima esquina y elegí su dirección.'**
  String get measureNextCornerInstruction;

  /// No description provided for @traceStarted.
  ///
  /// In es, this message translates to:
  /// **'Inicio del trazado'**
  String get traceStarted;

  /// No description provided for @cornerRegistered.
  ///
  /// In es, this message translates to:
  /// **'Esquina {count} registrada'**
  String cornerRegistered(int count);

  /// No description provided for @needThreeCornersToClose.
  ///
  /// In es, this message translates to:
  /// **'Necesitás al menos 3 esquinas para cerrar.'**
  String get needThreeCornersToClose;

  /// No description provided for @canContinueOrClose.
  ///
  /// In es, this message translates to:
  /// **'Podés seguir agregando esquinas o cerrar.'**
  String get canContinueOrClose;

  /// No description provided for @lastCornerRemoved.
  ///
  /// In es, this message translates to:
  /// **'Última esquina eliminada.'**
  String get lastCornerRemoved;

  /// No description provided for @measureFirstCorner.
  ///
  /// In es, this message translates to:
  /// **'Medir primera esquina'**
  String get measureFirstCorner;

  /// No description provided for @measureFirstCornerBeforeFeatures.
  ///
  /// In es, this message translates to:
  /// **'Primero medí la primera esquina real del ambiente.'**
  String get measureFirstCornerBeforeFeatures;

  /// No description provided for @couldNotAddStart.
  ///
  /// In es, this message translates to:
  /// **'No se pudo agregar el inicio.'**
  String get couldNotAddStart;

  /// No description provided for @startMarked.
  ///
  /// In es, this message translates to:
  /// **'Inicio marcado. Ahora medí la primera pared.'**
  String get startMarked;

  /// No description provided for @couldNotCalculateCorner.
  ///
  /// In es, this message translates to:
  /// **'No se pudo calcular la nueva esquina.'**
  String get couldNotCalculateCorner;

  /// No description provided for @invalidCorner.
  ///
  /// In es, this message translates to:
  /// **'La esquina no es válida.'**
  String get invalidCorner;

  /// No description provided for @firstCornerRegistered.
  ///
  /// In es, this message translates to:
  /// **'Primera esquina registrada. Continuá midiendo las paredes del ambiente.'**
  String get firstCornerRegistered;

  /// No description provided for @measurementRegistrationFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo registrar la medición: {error}'**
  String measurementRegistrationFailed(String error);

  /// No description provided for @couldNotCalculateLocation.
  ///
  /// In es, this message translates to:
  /// **'No se pudo calcular la ubicación.'**
  String get couldNotCalculateLocation;

  /// No description provided for @enterOpeningWidth.
  ///
  /// In es, this message translates to:
  /// **'Ingresá el ancho de la abertura.'**
  String get enterOpeningWidth;

  /// No description provided for @couldNotAttachOpening.
  ///
  /// In es, this message translates to:
  /// **'No se pudo asociar la abertura a una pared.'**
  String get couldNotAttachOpening;

  /// No description provided for @doorAdjustedToWall.
  ///
  /// In es, this message translates to:
  /// **'Puerta de {width} metros ajustada a la pared.'**
  String doorAdjustedToWall(String width);

  /// No description provided for @windowAdjustedToWall.
  ///
  /// In es, this message translates to:
  /// **'Ventana de {width} metros ajustada a la pared.'**
  String windowAdjustedToWall(String width);

  /// No description provided for @locationRegistrationFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo registrar la ubicación: {error}'**
  String locationRegistrationFailed(String error);

  /// No description provided for @openingWallQuestion.
  ///
  /// In es, this message translates to:
  /// **'¿En qué pared está la abertura?'**
  String get openingWallQuestion;

  /// No description provided for @openingWallExplanation.
  ///
  /// In es, this message translates to:
  /// **'Elegí la pared de cierre si la puerta o ventana está sobre el tramo que une la última esquina con la primera.'**
  String get openingWallExplanation;

  /// No description provided for @detectWallAutomatically.
  ///
  /// In es, this message translates to:
  /// **'Detectar pared automáticamente'**
  String get detectWallAutomatically;

  /// No description provided for @useClosingWall.
  ///
  /// In es, this message translates to:
  /// **'Usar pared de cierre'**
  String get useClosingWall;

  /// No description provided for @placeElement.
  ///
  /// In es, this message translates to:
  /// **'Ubicar elemento'**
  String get placeElement;

  /// No description provided for @measureCorner.
  ///
  /// In es, this message translates to:
  /// **'Medir esquina'**
  String get measureCorner;

  /// No description provided for @featureDistanceInstruction.
  ///
  /// In es, this message translates to:
  /// **'Indicá cuánto hay desde la última posición hasta la puerta o ventana.'**
  String get featureDistanceInstruction;

  /// No description provided for @cornerDistanceInstruction.
  ///
  /// In es, this message translates to:
  /// **'Indicá cuánto hay desde la última esquina hasta la nueva esquina.'**
  String get cornerDistanceInstruction;

  /// No description provided for @manualFirstWallInstruction.
  ///
  /// In es, this message translates to:
  /// **'Este dispositivo no es compatible con ARCore. Ingresá manualmente la distancia desde la esquina inicial hasta la nueva.'**
  String get manualFirstWallInstruction;

  /// No description provided for @manualNextWallInstruction.
  ///
  /// In es, this message translates to:
  /// **'Este dispositivo no es compatible con ARCore. Ingresá manualmente la distancia desde la última esquina hasta la nueva.'**
  String get manualNextWallInstruction;

  /// No description provided for @distance.
  ///
  /// In es, this message translates to:
  /// **'Distancia'**
  String get distance;

  /// No description provided for @distanceExample.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo: 3,50'**
  String get distanceExample;

  /// No description provided for @meters.
  ///
  /// In es, this message translates to:
  /// **'metros'**
  String get meters;

  /// No description provided for @enterPositiveDistance.
  ///
  /// In es, this message translates to:
  /// **'Ingresá una distancia mayor a 0'**
  String get enterPositiveDistance;

  /// No description provided for @direction.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get direction;

  /// No description provided for @directionExample.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo: 90'**
  String get directionExample;

  /// No description provided for @degrees.
  ///
  /// In es, this message translates to:
  /// **'grados'**
  String get degrees;

  /// No description provided for @enterValidDirection.
  ///
  /// In es, this message translates to:
  /// **'Ingresá una dirección válida'**
  String get enterValidDirection;

  /// No description provided for @doorWidth.
  ///
  /// In es, this message translates to:
  /// **'Ancho de la puerta'**
  String get doorWidth;

  /// No description provided for @windowWidth.
  ///
  /// In es, this message translates to:
  /// **'Ancho de la ventana'**
  String get windowWidth;

  /// No description provided for @widthExample.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo: 1,20'**
  String get widthExample;

  /// No description provided for @enterMinimumOpeningWidth.
  ///
  /// In es, this message translates to:
  /// **'Ingresá un ancho mínimo de 0,20 metros'**
  String get enterMinimumOpeningWidth;

  /// No description provided for @quickDirection.
  ///
  /// In es, this message translates to:
  /// **'Dirección rápida:'**
  String get quickDirection;

  /// No description provided for @front.
  ///
  /// In es, this message translates to:
  /// **'Frente'**
  String get front;

  /// No description provided for @right.
  ///
  /// In es, this message translates to:
  /// **'Derecha'**
  String get right;

  /// No description provided for @back.
  ///
  /// In es, this message translates to:
  /// **'Atrás'**
  String get back;

  /// No description provided for @left.
  ///
  /// In es, this message translates to:
  /// **'Izquierda'**
  String get left;

  /// No description provided for @featureDoesNotCreateCorner.
  ///
  /// In es, this message translates to:
  /// **'Esto no crea una esquina nueva del ambiente.'**
  String get featureDoesNotCreateCorner;

  /// No description provided for @positionValidatedBeforeAdding.
  ///
  /// In es, this message translates to:
  /// **'La nueva posición se valida antes de incorporarla al plano.'**
  String get positionValidatedBeforeAdding;

  /// No description provided for @useMeasurement.
  ///
  /// In es, this message translates to:
  /// **'Usar medición'**
  String get useMeasurement;

  /// No description provided for @measurementSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema de medición'**
  String get measurementSystem;

  /// No description provided for @metricSystem.
  ///
  /// In es, this message translates to:
  /// **'Metros'**
  String get metricSystem;

  /// No description provided for @imperialSystem.
  ///
  /// In es, this message translates to:
  /// **'Pies y pulgadas'**
  String get imperialSystem;

  /// No description provided for @feet.
  ///
  /// In es, this message translates to:
  /// **'Pies'**
  String get feet;

  /// No description provided for @inches.
  ///
  /// In es, this message translates to:
  /// **'Pulgadas'**
  String get inches;

  /// No description provided for @squareMeters.
  ///
  /// In es, this message translates to:
  /// **'metros cuadrados'**
  String get squareMeters;

  /// No description provided for @squareFeet.
  ///
  /// In es, this message translates to:
  /// **'pies cuadrados'**
  String get squareFeet;

  /// No description provided for @changeDoorHingeSide.
  ///
  /// In es, this message translates to:
  /// **'Cambiar lado de la bisagra'**
  String get changeDoorHingeSide;

  /// No description provided for @changeDoorOpeningDirection.
  ///
  /// In es, this message translates to:
  /// **'Cambiar sentido de apertura'**
  String get changeDoorOpeningDirection;

  /// No description provided for @chooseDoorOpeningDirection.
  ///
  /// In es, this message translates to:
  /// **'Elegir apertura de la puerta'**
  String get chooseDoorOpeningDirection;

  /// No description provided for @doorOpensInterior.
  ///
  /// In es, this message translates to:
  /// **'Abrir hacia el interior'**
  String get doorOpensInterior;

  /// No description provided for @doorOpensExterior.
  ///
  /// In es, this message translates to:
  /// **'Abrir hacia el exterior'**
  String get doorOpensExterior;

  /// No description provided for @editOpeningDimensions.
  ///
  /// In es, this message translates to:
  /// **'Editar medidas y posición'**
  String get editOpeningDimensions;

  /// No description provided for @openingWidth.
  ///
  /// In es, this message translates to:
  /// **'Ancho de la abertura'**
  String get openingWidth;

  /// No description provided for @distanceFromWallStart.
  ///
  /// In es, this message translates to:
  /// **'Distancia desde la esquina inicial de la pared'**
  String get distanceFromWallStart;

  /// No description provided for @wallLength.
  ///
  /// In es, this message translates to:
  /// **'Longitud de la pared'**
  String get wallLength;

  /// No description provided for @invalidOpeningMeasurement.
  ///
  /// In es, this message translates to:
  /// **'Ingresá medidas válidas para el ancho y la posición.'**
  String get invalidOpeningMeasurement;

  /// No description provided for @openingUpdated.
  ///
  /// In es, this message translates to:
  /// **'Abertura actualizada correctamente.'**
  String get openingUpdated;

  /// No description provided for @openingHeight.
  ///
  /// In es, this message translates to:
  /// **'Altura de la abertura'**
  String get openingHeight;

  /// No description provided for @sillHeight.
  ///
  /// In es, this message translates to:
  /// **'Altura desde el piso'**
  String get sillHeight;

  /// No description provided for @horizontalOrientation.
  ///
  /// In es, this message translates to:
  /// **'Horizontal'**
  String get horizontalOrientation;

  /// No description provided for @verticalOrientation.
  ///
  /// In es, this message translates to:
  /// **'Vertical'**
  String get verticalOrientation;

  /// No description provided for @doorPlanDimensions.
  ///
  /// In es, this message translates to:
  /// **'{width} de ancho · {height} de alto'**
  String doorPlanDimensions(String width, String height);

  /// No description provided for @windowPlanDimensions.
  ///
  /// In es, this message translates to:
  /// **'{width} de ancho · {height} de alto\n{sill} desde el piso · {orientation}'**
  String windowPlanDimensions(
      String width, String height, String sill, String orientation);

  /// No description provided for @noRoomsToEdit.
  ///
  /// In es, this message translates to:
  /// **'No hay ambientes para editar.'**
  String get noRoomsToEdit;

  /// No description provided for @transformRoomsTitle.
  ///
  /// In es, this message translates to:
  /// **'Mover y rotar ambientes'**
  String get transformRoomsTitle;

  /// No description provided for @touchTransformRooms.
  ///
  /// In es, this message translates to:
  /// **'Mover ambientes con gestos'**
  String get touchTransformRooms;

  /// No description provided for @zoomOut.
  ///
  /// In es, this message translates to:
  /// **'Alejar plano'**
  String get zoomOut;

  /// No description provided for @zoomIn.
  ///
  /// In es, this message translates to:
  /// **'Acercar plano'**
  String get zoomIn;

  /// No description provided for @resetView.
  ///
  /// In es, this message translates to:
  /// **'Restablecer vista'**
  String get resetView;

  /// No description provided for @touchTransformExplanation.
  ///
  /// In es, this message translates to:
  /// **'Arrastrá el ambiente con un dedo. Usá dos dedos para mover o acercar el plano; el botón de ajuste permite girarlo.'**
  String get touchTransformExplanation;

  /// No description provided for @connectedGroupTransformHint.
  ///
  /// In es, this message translates to:
  /// **'Si el ambiente está conectado mediante una abertura, todo el grupo se moverá o rotará como una sola unidad.'**
  String get connectedGroupTransformHint;

  /// No description provided for @selectedRoom.
  ///
  /// In es, this message translates to:
  /// **'Ambiente seleccionado'**
  String get selectedRoom;

  /// No description provided for @movementDistance.
  ///
  /// In es, this message translates to:
  /// **'Distancia de cada movimiento'**
  String get movementDistance;

  /// No description provided for @fiveCentimeters.
  ///
  /// In es, this message translates to:
  /// **'5 centímetros'**
  String get fiveCentimeters;

  /// No description provided for @tenCentimeters.
  ///
  /// In es, this message translates to:
  /// **'10 centímetros'**
  String get tenCentimeters;

  /// No description provided for @twentyFiveCentimeters.
  ///
  /// In es, this message translates to:
  /// **'25 centímetros'**
  String get twentyFiveCentimeters;

  /// No description provided for @fiftyCentimeters.
  ///
  /// In es, this message translates to:
  /// **'50 centímetros'**
  String get fiftyCentimeters;

  /// No description provided for @oneInch.
  ///
  /// In es, this message translates to:
  /// **'1 pulgada'**
  String get oneInch;

  /// No description provided for @threeInches.
  ///
  /// In es, this message translates to:
  /// **'3 pulgadas'**
  String get threeInches;

  /// No description provided for @sixInches.
  ///
  /// In es, this message translates to:
  /// **'6 pulgadas'**
  String get sixInches;

  /// No description provided for @oneFoot.
  ///
  /// In es, this message translates to:
  /// **'1 pie'**
  String get oneFoot;

  /// No description provided for @movement.
  ///
  /// In es, this message translates to:
  /// **'Movimiento'**
  String get movement;

  /// No description provided for @moveUp.
  ///
  /// In es, this message translates to:
  /// **'Mover hacia arriba'**
  String get moveUp;

  /// No description provided for @moveDown.
  ///
  /// In es, this message translates to:
  /// **'Mover hacia abajo'**
  String get moveDown;

  /// No description provided for @moveLeft.
  ///
  /// In es, this message translates to:
  /// **'Mover hacia la izquierda'**
  String get moveLeft;

  /// No description provided for @moveRight.
  ///
  /// In es, this message translates to:
  /// **'Mover hacia la derecha'**
  String get moveRight;

  /// No description provided for @rotation.
  ///
  /// In es, this message translates to:
  /// **'Rotación'**
  String get rotation;

  /// No description provided for @rotateFifteenDegreesLeft.
  ///
  /// In es, this message translates to:
  /// **'Girar 15 grados a la izquierda'**
  String get rotateFifteenDegreesLeft;

  /// No description provided for @rotateFifteenDegreesRight.
  ///
  /// In es, this message translates to:
  /// **'Girar 15 grados a la derecha'**
  String get rotateFifteenDegreesRight;

  /// No description provided for @finishEditing.
  ///
  /// In es, this message translates to:
  /// **'Finalizar edición'**
  String get finishEditing;

  /// No description provided for @preciseAdjustment.
  ///
  /// In es, this message translates to:
  /// **'Ajuste preciso'**
  String get preciseAdjustment;

  /// No description provided for @preciseAdjustmentExplanation.
  ///
  /// In es, this message translates to:
  /// **'Ingresá el desplazamiento horizontal, el desplazamiento vertical y el giro exacto del grupo seleccionado.'**
  String get preciseAdjustmentExplanation;

  /// No description provided for @horizontalAdjustment.
  ///
  /// In es, this message translates to:
  /// **'Desplazamiento horizontal'**
  String get horizontalAdjustment;

  /// No description provided for @verticalAdjustment.
  ///
  /// In es, this message translates to:
  /// **'Desplazamiento vertical'**
  String get verticalAdjustment;

  /// No description provided for @rotationDegrees.
  ///
  /// In es, this message translates to:
  /// **'Giro en grados'**
  String get rotationDegrees;

  /// No description provided for @applyAdjustment.
  ///
  /// In es, this message translates to:
  /// **'Aplicar ajuste'**
  String get applyAdjustment;

  /// No description provided for @invalidPreciseAdjustment.
  ///
  /// In es, this message translates to:
  /// **'Ingresá al menos un valor válido distinto de cero.'**
  String get invalidPreciseAdjustment;

  /// No description provided for @preciseAdjustmentApplied.
  ///
  /// In es, this message translates to:
  /// **'El ajuste preciso se aplicó correctamente.'**
  String get preciseAdjustmentApplied;

  /// No description provided for @undoLastTransform.
  ///
  /// In es, this message translates to:
  /// **'Deshacer último ajuste'**
  String get undoLastTransform;

  /// No description provided for @redoLastTransform.
  ///
  /// In es, this message translates to:
  /// **'Rehacer último ajuste'**
  String get redoLastTransform;

  /// No description provided for @alignNearestWall.
  ///
  /// In es, this message translates to:
  /// **'Alinear con la pared más cercana'**
  String get alignNearestWall;

  /// No description provided for @alignmentPreviewTitle.
  ///
  /// In es, this message translates to:
  /// **'Vista previa de alineación'**
  String get alignmentPreviewTitle;

  /// No description provided for @alignmentPreviewMessage.
  ///
  /// In es, this message translates to:
  /// **'Revisá la posición actual y la posición propuesta antes de aplicar el ajuste.'**
  String get alignmentPreviewMessage;

  /// No description provided for @alignmentCurrentPosition.
  ///
  /// In es, this message translates to:
  /// **'Posición actual'**
  String get alignmentCurrentPosition;

  /// No description provided for @alignmentProposedPosition.
  ///
  /// In es, this message translates to:
  /// **'Posición propuesta'**
  String get alignmentProposedPosition;

  /// No description provided for @applyAlignment.
  ///
  /// In es, this message translates to:
  /// **'Aplicar alineación'**
  String get applyAlignment;

  /// No description provided for @alignmentPreviewExpired.
  ///
  /// In es, this message translates to:
  /// **'El plano cambió después de generar la vista previa. Generá una nueva alineación.'**
  String get alignmentPreviewExpired;

  /// No description provided for @wallAlignedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'Las paredes se alinearon correctamente.'**
  String get wallAlignedSuccessfully;

  /// No description provided for @joinRooms.
  ///
  /// In es, this message translates to:
  /// **'Unir ambientes'**
  String get joinRooms;

  /// No description provided for @roomToJoin.
  ///
  /// In es, this message translates to:
  /// **'Ambiente de destino'**
  String get roomToJoin;

  /// No description provided for @joinPreviewTitle.
  ///
  /// In es, this message translates to:
  /// **'Vista previa de la unión'**
  String get joinPreviewTitle;

  /// No description provided for @joinPreviewMessage.
  ///
  /// In es, this message translates to:
  /// **'Se moverá {source} para unirlo con {target}. La aplicación rechazará la operación si produce solapamientos.'**
  String joinPreviewMessage(String source, String target);

  /// No description provided for @applyJoin.
  ///
  /// In es, this message translates to:
  /// **'Aplicar unión'**
  String get applyJoin;

  /// No description provided for @joinCompleted.
  ///
  /// In es, this message translates to:
  /// **'Los ambientes se unieron correctamente.'**
  String get joinCompleted;

  /// No description provided for @joinOverlapPrevented.
  ///
  /// In es, this message translates to:
  /// **'La unión fue cancelada porque produciría un solapamiento.'**
  String get joinOverlapPrevented;

  /// No description provided for @noIndependentRoomAvailable.
  ///
  /// In es, this message translates to:
  /// **'No hay otro ambiente independiente disponible para unir.'**
  String get noIndependentRoomAvailable;

  /// No description provided for @noSafeNearbyWall.
  ///
  /// In es, this message translates to:
  /// **'No se encontró una pared cercana y paralela que pueda alinearse de forma segura.'**
  String get noSafeNearbyWall;

  /// No description provided for @sharedWall.
  ///
  /// In es, this message translates to:
  /// **'Pared compartida'**
  String get sharedWall;

  /// No description provided for @partialSharedWall.
  ///
  /// In es, this message translates to:
  /// **'Tramo de pared compartida'**
  String get partialSharedWall;

  /// No description provided for @roomAdjustedAutomatically.
  ///
  /// In es, this message translates to:
  /// **'La habitación se ajustó correctamente.'**
  String get roomAdjustedAutomatically;

  /// No description provided for @unsafeMovementRejected.
  ///
  /// In es, this message translates to:
  /// **'El movimiento fue cancelado porque produciría un solapamiento.'**
  String get unsafeMovementRejected;

  /// No description provided for @unsafeRotationRejected.
  ///
  /// In es, this message translates to:
  /// **'La rotación fue cancelada porque produciría un solapamiento.'**
  String get unsafeRotationRejected;

  /// No description provided for @selectedDoor.
  ///
  /// In es, this message translates to:
  /// **'Puerta seleccionada'**
  String get selectedDoor;

  /// No description provided for @selectedWindow.
  ///
  /// In es, this message translates to:
  /// **'Ventana seleccionada'**
  String get selectedWindow;

  /// No description provided for @openingConnectedStatus.
  ///
  /// In es, this message translates to:
  /// **'Conectada'**
  String get openingConnectedStatus;

  /// No description provided for @openingAvailableStatus.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get openingAvailableStatus;

  /// No description provided for @openingStartAtMarkedPoint.
  ///
  /// In es, this message translates to:
  /// **'Inicio en el punto marcado'**
  String get openingStartAtMarkedPoint;

  /// No description provided for @continueScanFromHere.
  ///
  /// In es, this message translates to:
  /// **'Continuar escaneo desde aquí'**
  String get continueScanFromHere;

  /// No description provided for @selectedDoorUnavailable.
  ///
  /// In es, this message translates to:
  /// **'La puerta seleccionada ya no está disponible.'**
  String get selectedDoorUnavailable;

  /// No description provided for @selectedOpeningUnavailable.
  ///
  /// In es, this message translates to:
  /// **'La abertura seleccionada ya no está disponible.'**
  String get selectedOpeningUnavailable;

  /// No description provided for @openingWallNotFound.
  ///
  /// In es, this message translates to:
  /// **'No se pudo identificar la pared de la abertura.'**
  String get openingWallNotFound;

  /// No description provided for @continuationDirectionTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Hacia dónde continúa el plano?'**
  String get continuationDirectionTitle;

  /// No description provided for @continuationDirectionExplanation.
  ///
  /// In es, this message translates to:
  /// **'El punto verde marca dónde comenzará el nuevo ambiente. Elegí la flecha que apunta hacia el ambiente que vas a escanear.'**
  String get continuationDirectionExplanation;

  /// No description provided for @continueToward.
  ///
  /// In es, this message translates to:
  /// **'Continuar hacia {direction}'**
  String continueToward(String direction);

  /// No description provided for @directionRight.
  ///
  /// In es, this message translates to:
  /// **'la derecha'**
  String get directionRight;

  /// No description provided for @directionLeft.
  ///
  /// In es, this message translates to:
  /// **'la izquierda'**
  String get directionLeft;

  /// No description provided for @directionDown.
  ///
  /// In es, this message translates to:
  /// **'abajo'**
  String get directionDown;

  /// No description provided for @directionUp.
  ///
  /// In es, this message translates to:
  /// **'arriba'**
  String get directionUp;

  /// No description provided for @notEnoughRoomsToOrganize.
  ///
  /// In es, this message translates to:
  /// **'No hay suficientes ambientes para organizar.'**
  String get notEnoughRoomsToOrganize;

  /// No description provided for @organizeRooms.
  ///
  /// In es, this message translates to:
  /// **'Organizar ambientes'**
  String get organizeRooms;

  /// No description provided for @organizeRoomsExplanation.
  ///
  /// In es, this message translates to:
  /// **'Se distribuirán solamente los grupos independientes. Los ambientes conectados o que compartan una pared se moverán juntos, conservando su alineación, medidas, puertas y ventanas.\n\nEl primer grupo queda fijo. Si todo el plano ya está unido, no se modificará. Podés deshacer la organización.'**
  String get organizeRoomsExplanation;

  /// No description provided for @roomsOrganizedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'Ambientes organizados correctamente.'**
  String get roomsOrganizedSuccessfully;

  /// No description provided for @floorPlan2D.
  ///
  /// In es, this message translates to:
  /// **'Plano general 2D'**
  String get floorPlan2D;

  /// No description provided for @editMeasurements.
  ///
  /// In es, this message translates to:
  /// **'Editar medidas'**
  String get editMeasurements;

  /// No description provided for @moreOptions.
  ///
  /// In es, this message translates to:
  /// **'Más opciones'**
  String get moreOptions;

  /// No description provided for @importPlan.
  ///
  /// In es, this message translates to:
  /// **'Importar plano'**
  String get importPlan;

  /// No description provided for @importProject.
  ///
  /// In es, this message translates to:
  /// **'Importar JSON o SVG'**
  String get importProject;

  /// No description provided for @exportProject.
  ///
  /// In es, this message translates to:
  /// **'Exportar archivo'**
  String get exportProject;

  /// No description provided for @exportJson.
  ///
  /// In es, this message translates to:
  /// **'JSON — copia completa del proyecto'**
  String get exportJson;

  /// No description provided for @exportSvg.
  ///
  /// In es, this message translates to:
  /// **'SVG — plano vectorial editable'**
  String get exportSvg;

  /// No description provided for @exportPng.
  ///
  /// In es, this message translates to:
  /// **'PNG — imagen nítida del plano'**
  String get exportPng;

  /// No description provided for @exportJpg.
  ///
  /// In es, this message translates to:
  /// **'JPG — imagen liviana del plano'**
  String get exportJpg;

  /// No description provided for @exportDestination.
  ///
  /// In es, this message translates to:
  /// **'¿Qué querés hacer con el archivo?'**
  String get exportDestination;

  /// No description provided for @saveToFiles.
  ///
  /// In es, this message translates to:
  /// **'Guardar en Archivos…'**
  String get saveToFiles;

  /// No description provided for @shareFile.
  ///
  /// In es, this message translates to:
  /// **'Compartir…'**
  String get shareFile;

  /// No description provided for @replaceProjectTitle.
  ///
  /// In es, this message translates to:
  /// **'Reemplazar el proyecto abierto'**
  String get replaceProjectTitle;

  /// No description provided for @replaceProjectMessage.
  ///
  /// In es, this message translates to:
  /// **'El archivo es válido. Si continuás, reemplazará el plano abierto. Los archivos guardados fuera de ARchScan no se eliminarán.'**
  String get replaceProjectMessage;

  /// No description provided for @shareJson.
  ///
  /// In es, this message translates to:
  /// **'Guardar JSON en Archivos'**
  String get shareJson;

  /// No description provided for @exportPdf.
  ///
  /// In es, this message translates to:
  /// **'Guardar PDF en Archivos'**
  String get exportPdf;

  /// No description provided for @registeredRooms.
  ///
  /// In es, this message translates to:
  /// **'Ambientes registrados'**
  String get registeredRooms;

  /// No description provided for @tapRoomToAddOpening.
  ///
  /// In es, this message translates to:
  /// **'Tocá dentro de un ambiente para añadir una puerta o ventana.'**
  String get tapRoomToAddOpening;

  /// No description provided for @roomCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 ambiente} other{{count} ambientes}}'**
  String roomCount(int count);

  /// No description provided for @planImportedSuccessfully.
  ///
  /// In es, this message translates to:
  /// **'Plano importado correctamente.'**
  String get planImportedSuccessfully;

  /// No description provided for @planImportCancelledOrInvalid.
  ///
  /// In es, this message translates to:
  /// **'Importación cancelada o no válida.'**
  String get planImportCancelledOrInvalid;

  /// No description provided for @addElement.
  ///
  /// In es, this message translates to:
  /// **'Agregar elemento'**
  String get addElement;

  /// No description provided for @selectElementToAdd.
  ///
  /// In es, this message translates to:
  /// **'Seleccioná el elemento que querés incorporar.'**
  String get selectElementToAdd;

  /// No description provided for @noRoomsYet.
  ///
  /// In es, this message translates to:
  /// **'No hay ambientes aún.'**
  String get noRoomsYet;

  /// No description provided for @renameRoom.
  ///
  /// In es, this message translates to:
  /// **'Renombrar ambiente'**
  String get renameRoom;

  /// No description provided for @roomNameShortLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get roomNameShortLabel;

  /// No description provided for @roomNameMainBedroomExample.
  ///
  /// In es, this message translates to:
  /// **'Ej. Dormitorio principal'**
  String get roomNameMainBedroomExample;

  /// No description provided for @noScannedRooms.
  ///
  /// In es, this message translates to:
  /// **'No hay ambientes escaneados'**
  String get noScannedRooms;

  /// No description provided for @completeScanToViewPlan.
  ///
  /// In es, this message translates to:
  /// **'Completá un escaneo para visualizar el plano general.'**
  String get completeScanToViewPlan;

  /// No description provided for @closeProject.
  ///
  /// In es, this message translates to:
  /// **'Cerrar proyecto'**
  String get closeProject;

  /// No description provided for @close.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get close;

  /// No description provided for @roomSummary.
  ///
  /// In es, this message translates to:
  /// **'{area} · {perimeter} de perímetro · {cornerCount, plural, =1{1 esquina} other{{cornerCount} esquinas}}'**
  String roomSummary(String area, String perimeter, int cornerCount);

  /// No description provided for @actions.
  ///
  /// In es, this message translates to:
  /// **'Acciones'**
  String get actions;

  /// No description provided for @rename.
  ///
  /// In es, this message translates to:
  /// **'Renombrar'**
  String get rename;

  /// No description provided for @completeAllFields.
  ///
  /// In es, this message translates to:
  /// **'Por favor, completá todos los campos.'**
  String get completeAllFields;

  /// No description provided for @newProject.
  ///
  /// In es, this message translates to:
  /// **'Nuevo proyecto'**
  String get newProject;

  /// No description provided for @projectNameExample.
  ///
  /// In es, this message translates to:
  /// **'Ej. Remodelación de oficina'**
  String get projectNameExample;

  /// No description provided for @create.
  ///
  /// In es, this message translates to:
  /// **'Crear'**
  String get create;

  /// No description provided for @myProjects.
  ///
  /// In es, this message translates to:
  /// **'Mis proyectos'**
  String get myProjects;

  /// No description provided for @localProjectsStoredOnDevice.
  ///
  /// In es, this message translates to:
  /// **'Proyectos guardados únicamente en este dispositivo'**
  String get localProjectsStoredOnDevice;

  /// No description provided for @newScan.
  ///
  /// In es, this message translates to:
  /// **'Nuevo escaneo'**
  String get newScan;

  /// No description provided for @noSavedProjects.
  ///
  /// In es, this message translates to:
  /// **'No tenés proyectos guardados'**
  String get noSavedProjects;

  /// No description provided for @pressNewScanToStart.
  ///
  /// In es, this message translates to:
  /// **'Presioná «Nuevo escaneo» para comenzar'**
  String get pressNewScanToStart;

  /// No description provided for @projectUpdated.
  ///
  /// In es, this message translates to:
  /// **'Actualizado: {date}'**
  String projectUpdated(String date);

  /// No description provided for @viewFloorPlan.
  ///
  /// In es, this message translates to:
  /// **'Ver plano'**
  String get viewFloorPlan;

  /// No description provided for @delete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @permissionsRequired.
  ///
  /// In es, this message translates to:
  /// **'Permisos requeridos'**
  String get permissionsRequired;

  /// No description provided for @cameraLocationPermissionsDenied.
  ///
  /// In es, this message translates to:
  /// **'No se otorgó el permiso de cámara. Habilitalo desde los ajustes del sistema para poder escanear.'**
  String get cameraLocationPermissionsDenied;

  /// No description provided for @scannerUnavailable.
  ///
  /// In es, this message translates to:
  /// **'Escáner no disponible'**
  String get scannerUnavailable;

  /// No description provided for @basicScannerInitializationFailed.
  ///
  /// In es, this message translates to:
  /// **'La cámara está disponible, pero no fue posible iniciar el escáner básico.'**
  String get basicScannerInitializationFailed;

  /// No description provided for @deviceCameraUnavailable.
  ///
  /// In es, this message translates to:
  /// **'Este dispositivo no tiene una cámara disponible para realizar el escaneo.'**
  String get deviceCameraUnavailable;

  /// No description provided for @understood.
  ///
  /// In es, this message translates to:
  /// **'Entendido'**
  String get understood;

  /// No description provided for @arTrackingActive.
  ///
  /// In es, this message translates to:
  /// **'Realidad aumentada activa'**
  String get arTrackingActive;

  /// No description provided for @arCalibrating.
  ///
  /// In es, this message translates to:
  /// **'Calibrando'**
  String get arCalibrating;

  /// No description provided for @markOpeningEndpointA.
  ///
  /// In es, this message translates to:
  /// **'Marcar extremo A'**
  String get markOpeningEndpointA;

  /// No description provided for @markOpeningEndpointB.
  ///
  /// In es, this message translates to:
  /// **'Marcar extremo B'**
  String get markOpeningEndpointB;

  /// No description provided for @pointOpeningEndpointAInstruction.
  ///
  /// In es, this message translates to:
  /// **'Apuntá al extremo A de la abertura y marcá la referencia.'**
  String get pointOpeningEndpointAInstruction;

  /// No description provided for @pointOpeningEndpointBInstruction.
  ///
  /// In es, this message translates to:
  /// **'Ahora apuntá al extremo B de la misma abertura.'**
  String get pointOpeningEndpointBInstruction;

  /// No description provided for @openingReferenceAlignedInstruction.
  ///
  /// In es, this message translates to:
  /// **'Referencia alineada. Ya podés medir el ambiente nuevo.'**
  String get openingReferenceAlignedInstruction;

  /// No description provided for @invalidOpeningReferencePoint.
  ///
  /// In es, this message translates to:
  /// **'No se detectó un punto válido. Apuntá a la abertura e intentá nuevamente.'**
  String get invalidOpeningReferencePoint;

  /// No description provided for @openingReferenceEndpointsTooClose.
  ///
  /// In es, this message translates to:
  /// **'Los extremos están demasiado cerca. Volvé a marcar el extremo B.'**
  String get openingReferenceEndpointsTooClose;

  /// No description provided for @openingReferenceDifference.
  ///
  /// In es, this message translates to:
  /// **'Referencia alineada. Atención: la medida de realidad aumentada difiere {difference} del plano.'**
  String openingReferenceDifference(String difference);

  /// No description provided for @openingReferenceAligned.
  ///
  /// In es, this message translates to:
  /// **'Referencia alineada correctamente.'**
  String get openingReferenceAligned;

  /// No description provided for @invalidCameraPosition.
  ///
  /// In es, this message translates to:
  /// **'No se detectó una posición de cámara válida. Apuntá a una superficie reconocida e intentá nuevamente.'**
  String get invalidCameraPosition;

  /// No description provided for @needTwoCornersBeforeOpening.
  ///
  /// In es, this message translates to:
  /// **'Necesitás marcar al menos 2 esquinas antes de medir una abertura.'**
  String get needTwoCornersBeforeOpening;

  /// No description provided for @featureStartRegistered.
  ///
  /// In es, this message translates to:
  /// **'Inicio de {feature} registrado. Ubicá la cámara en el otro extremo y volvé a pulsar.'**
  String featureStartRegistered(String feature);

  /// No description provided for @openingMeasurementFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo medir la abertura.'**
  String get openingMeasurementFailed;

  /// No description provided for @featureSaved.
  ///
  /// In es, this message translates to:
  /// **'{feature} guardada. {warning}'**
  String featureSaved(String feature, String warning);

  /// No description provided for @referenceOpeningMissing.
  ///
  /// In es, this message translates to:
  /// **'La abertura de referencia ya no existe.'**
  String get referenceOpeningMissing;

  /// No description provided for @closeRoomFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cerrar el ambiente. Revisá los puntos trazados.'**
  String get closeRoomFailed;

  /// No description provided for @connectOpeningFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo conectar el ambiente con la abertura seleccionada.'**
  String get connectOpeningFailed;

  /// No description provided for @initializingApplication.
  ///
  /// In es, this message translates to:
  /// **'Iniciando ARchScan…'**
  String get initializingApplication;

  /// No description provided for @applicationInitializationFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar la aplicación'**
  String get applicationInitializationFailed;

  /// No description provided for @applicationInitializationFailedDetails.
  ///
  /// In es, this message translates to:
  /// **'Revisá la conexión e intentá nuevamente. Tus proyectos guardados permanecen protegidos.'**
  String get applicationInitializationFailedDetails;

  /// No description provided for @retryApplicationStart.
  ///
  /// In es, this message translates to:
  /// **'Reintentar inicio'**
  String get retryApplicationStart;

  /// No description provided for @arInitializationFailedTitle.
  ///
  /// In es, this message translates to:
  /// **'No se pudo iniciar la realidad aumentada'**
  String get arInitializationFailedTitle;

  /// No description provided for @arInitializationFailedMessage.
  ///
  /// In es, this message translates to:
  /// **'La sesión de realidad aumentada no respondió a tiempo. Podés reintentar o continuar con el escáner básico usando la cámara.'**
  String get arInitializationFailedMessage;

  /// No description provided for @retryArScanner.
  ///
  /// In es, this message translates to:
  /// **'Reintentar realidad aumentada'**
  String get retryArScanner;

  /// No description provided for @useBasicScanner.
  ///
  /// In es, this message translates to:
  /// **'Continuar con el escáner básico'**
  String get useBasicScanner;

  /// No description provided for @privacyAndAccount.
  ///
  /// In es, this message translates to:
  /// **'Privacidad y datos'**
  String get privacyAndAccount;

  /// No description provided for @privacyAndData.
  ///
  /// In es, this message translates to:
  /// **'Privacidad y datos'**
  String get privacyAndData;

  /// No description provided for @privacyOverview.
  ///
  /// In es, this message translates to:
  /// **'Resumen de privacidad'**
  String get privacyOverview;

  /// No description provided for @privacyOverviewLocalDescription.
  ///
  /// In es, this message translates to:
  /// **'ARchScan funciona sin cuenta y conserva tus proyectos dentro del dispositivo. No sincroniza relevamientos con servidores externos.'**
  String get privacyOverviewLocalDescription;

  /// No description provided for @localDataTitle.
  ///
  /// In es, this message translates to:
  /// **'Datos guardados en el dispositivo'**
  String get localDataTitle;

  /// No description provided for @localDataDescription.
  ///
  /// In es, this message translates to:
  /// **'Los proyectos, escaneos interrumpidos y preferencias se guardan localmente para que la aplicación pueda funcionar sin conexión.'**
  String get localDataDescription;

  /// No description provided for @localOnlyDataDescription.
  ///
  /// In es, this message translates to:
  /// **'Los proyectos, nombres de ambientes, geometría, medidas y preferencias permanecen en el almacenamiento privado de ARchScan en este dispositivo.'**
  String get localOnlyDataDescription;

  /// No description provided for @cameraAndSensorsTitle.
  ///
  /// In es, this message translates to:
  /// **'Cámara y sensores'**
  String get cameraAndSensorsTitle;

  /// No description provided for @cameraAndSensorsDescription.
  ///
  /// In es, this message translates to:
  /// **'La cámara y los sensores se utilizan mientras medís. ARchScan no guarda ni envía fotografías, videos, ubicación geográfica ni lecturas sin procesar de sensores.'**
  String get cameraAndSensorsDescription;

  /// No description provided for @exportsAndSharingTitle.
  ///
  /// In es, this message translates to:
  /// **'Exportaciones y archivos'**
  String get exportsAndSharingTitle;

  /// No description provided for @exportsAndSharingDescription.
  ///
  /// In es, this message translates to:
  /// **'Los archivos JSON y PDF se crean o comparten únicamente cuando elegís una acción de exportación o importación.'**
  String get exportsAndSharingDescription;

  /// No description provided for @trackingTitle.
  ///
  /// In es, this message translates to:
  /// **'Seguimiento y publicidad'**
  String get trackingTitle;

  /// No description provided for @trackingDescription.
  ///
  /// In es, this message translates to:
  /// **'ARchScan no contiene publicidad, no crea perfiles publicitarios y no realiza seguimiento entre aplicaciones o sitios web.'**
  String get trackingDescription;

  /// No description provided for @deleteLocalDataTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar los proyectos del dispositivo'**
  String get deleteLocalDataTitle;

  /// No description provided for @deleteLocalDataDescription.
  ///
  /// In es, this message translates to:
  /// **'Elimina permanentemente todos los proyectos guardados por ARchScan en este dispositivo. Los JSON y PDF exportados no se modifican.'**
  String get deleteLocalDataDescription;

  /// No description provided for @deleteAllLocalData.
  ///
  /// In es, this message translates to:
  /// **'Eliminar todos los proyectos locales'**
  String get deleteAllLocalData;

  /// No description provided for @deleteLocalDataConfirmationTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar todos los proyectos locales?'**
  String get deleteLocalDataConfirmationTitle;

  /// No description provided for @deleteLocalDataConfirmationMessage.
  ///
  /// In es, this message translates to:
  /// **'Esta acción eliminará permanentemente los proyectos guardados por ARchScan en este dispositivo y no se puede deshacer. Los archivos JSON, PDF o DXF exportados permanecerán donde los hayas guardado.'**
  String get deleteLocalDataConfirmationMessage;

  /// No description provided for @deleteLocalDataPermanently.
  ///
  /// In es, this message translates to:
  /// **'Eliminar definitivamente'**
  String get deleteLocalDataPermanently;

  /// No description provided for @deletingLocalData.
  ///
  /// In es, this message translates to:
  /// **'Eliminando proyectos…'**
  String get deletingLocalData;

  /// No description provided for @localDataDeleted.
  ///
  /// In es, this message translates to:
  /// **'Los proyectos locales se eliminaron correctamente.'**
  String get localDataDeleted;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In es, this message translates to:
  /// **'No se otorgó el permiso de cámara. Habilitalo desde los ajustes del sistema para poder escanear.'**
  String get cameraPermissionDenied;

  /// No description provided for @planImportInvalid.
  ///
  /// In es, this message translates to:
  /// **'El archivo no contiene un proyecto compatible y no se realizó ningún cambio.'**
  String get planImportInvalid;

  /// No description provided for @openingHeightPositive.
  ///
  /// In es, this message translates to:
  /// **'Ingresá una altura mayor que cero.'**
  String get openingHeightPositive;

  /// No description provided for @windowSillHeight.
  ///
  /// In es, this message translates to:
  /// **'Altura del antepecho'**
  String get windowSillHeight;

  /// No description provided for @openingSillNonNegative.
  ///
  /// In es, this message translates to:
  /// **'Ingresá una altura de antepecho igual o mayor que cero.'**
  String get openingSillNonNegative;

  /// No description provided for @moveOpeningOnWall.
  ///
  /// In es, this message translates to:
  /// **'Mover sobre una pared'**
  String get moveOpeningOnWall;

  /// No description provided for @roomsArrangementUnchanged.
  ///
  /// In es, this message translates to:
  /// **'No se modificó la distribución del plano.'**
  String get roomsArrangementUnchanged;

  /// No description provided for @exportDxf.
  ///
  /// In es, this message translates to:
  /// **'Guardar DXF 2D en Archivos (metros)'**
  String get exportDxf;

  /// No description provided for @dxfExportFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo exportar el archivo DXF. Tu proyecto no se modificó.'**
  String get dxfExportFailed;

  /// No description provided for @fileSaveFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo guardar el archivo fuera de ARchScan. Tu proyecto no se modificó.'**
  String get fileSaveFailed;

  /// No description provided for @planTapWall.
  ///
  /// In es, this message translates to:
  /// **'Tocá una pared para ubicar la abertura.'**
  String get planTapWall;

  /// No description provided for @planSelectWall.
  ///
  /// In es, this message translates to:
  /// **'Tocá una pared o una esquina para editarla sobre el plano.'**
  String get planSelectWall;

  /// No description provided for @planChooseRoom.
  ///
  /// In es, this message translates to:
  /// **'Esta pared pertenece a varios ambientes. Elegí cuál editar.'**
  String get planChooseRoom;

  /// No description provided for @planConnectionBlocked.
  ///
  /// In es, this message translates to:
  /// **'El cambio descalzaría una abertura conectada. Mové el grupo de ambientes o quitá la conexión primero.'**
  String get planConnectionBlocked;

  /// No description provided for @planOverlapBlocked.
  ///
  /// In es, this message translates to:
  /// **'El cambio se superpone con otro ambiente. Se conservó el plano anterior.'**
  String get planOverlapBlocked;

  /// No description provided for @planNoClosure.
  ///
  /// In es, this message translates to:
  /// **'No hay un cierre cercano válido con un recorrido de paredes completo. Mové el extremo y volvé a intentar.'**
  String get planNoClosure;

  /// No description provided for @planStaleEdit.
  ///
  /// In es, this message translates to:
  /// **'El plano cambió durante la edición. Seleccioná la pared nuevamente.'**
  String get planStaleEdit;

  /// No description provided for @planInvalidGeometry.
  ///
  /// In es, this message translates to:
  /// **'El cambio genera cruces, paredes demasiado cortas o aberturas fuera de su pared. No se aplicó.'**
  String get planInvalidGeometry;

  /// No description provided for @planClosePreview.
  ///
  /// In es, this message translates to:
  /// **'Revisá el recorrido resaltado: conecta con el punto o pared más cercanos que permiten cerrar sin cruces ni solapamientos.'**
  String get planClosePreview;

  /// No description provided for @planDeletePreview.
  ///
  /// In es, this message translates to:
  /// **'Se quitará la pared seleccionada y sus aberturas. El contorno quedará abierto. Si ya estaba abierto, puede dividirse en tramos separados. Las aberturas del vecino se conservarán desconectadas. Podés deshacer esta operación.'**
  String get planDeletePreview;

  /// No description provided for @planMeasurePreview.
  ///
  /// In es, this message translates to:
  /// **'Revisá la pared resaltada y sus aberturas antes de confirmar la medida.'**
  String get planMeasurePreview;

  /// No description provided for @planConfirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar cambio'**
  String get planConfirm;

  /// No description provided for @planCorner.
  ///
  /// In es, this message translates to:
  /// **'Esquina'**
  String get planCorner;

  /// No description provided for @planDragSelection.
  ///
  /// In es, this message translates to:
  /// **'Arrastrá la selección para moverla. Tocá otro punto para cambiar la selección.'**
  String get planDragSelection;

  /// No description provided for @planDeleteWall.
  ///
  /// In es, this message translates to:
  /// **'Eliminar pared'**
  String get planDeleteWall;

  /// No description provided for @planAddDoor.
  ///
  /// In es, this message translates to:
  /// **'Agregar puerta'**
  String get planAddDoor;

  /// No description provided for @planAddWindow.
  ///
  /// In es, this message translates to:
  /// **'Agregar ventana'**
  String get planAddWindow;

  /// No description provided for @planUndo.
  ///
  /// In es, this message translates to:
  /// **'Deshacer'**
  String get planUndo;

  /// No description provided for @planRedo.
  ///
  /// In es, this message translates to:
  /// **'Rehacer'**
  String get planRedo;

  /// No description provided for @planInvalidLength.
  ///
  /// In es, this message translates to:
  /// **'Ingresá una medida válida mayor o igual a 0,05 metros. Las pulgadas deben estar entre 0 y menos de 12.'**
  String get planInvalidLength;

  /// No description provided for @planLengthAnchor.
  ///
  /// In es, this message translates to:
  /// **'La primera esquina de esta pared queda fija; se ajusta la siguiente. Verás una vista previa antes de guardar.'**
  String get planLengthAnchor;

  /// No description provided for @planPreview.
  ///
  /// In es, this message translates to:
  /// **'Ver cambio en el plano'**
  String get planPreview;

  /// No description provided for @planOpenContour.
  ///
  /// In es, this message translates to:
  /// **'Contorno abierto'**
  String get planOpenContour;

  /// No description provided for @planDeleteRoom.
  ///
  /// In es, this message translates to:
  /// **'Eliminar ambiente'**
  String get planDeleteRoom;

  /// No description provided for @planDeleteRoomConfirmation.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar “{roomName}” y todas sus paredes y aberturas? Se quitarán sus conexiones con otros ambientes, sin borrar esos ambientes. Podés deshacer el cambio durante esta sesión.'**
  String planDeleteRoomConfirmation(String roomName);

  /// No description provided for @planRoomDeleted.
  ///
  /// In es, this message translates to:
  /// **'Ambiente eliminado. Podés deshacer el cambio.'**
  String get planRoomDeleted;

  /// No description provided for @openingsAddedFromPlan.
  ///
  /// In es, this message translates to:
  /// **'Terminá de medir el ambiente y después agregá puertas y ventanas tocando sus paredes en el plano.'**
  String get openingsAddedFromPlan;

  /// No description provided for @markPreviousVertex.
  ///
  /// In es, this message translates to:
  /// **'Marcar vértice anterior'**
  String get markPreviousVertex;

  /// No description provided for @markStartVertex.
  ///
  /// In es, this message translates to:
  /// **'Marcar vértice de inicio'**
  String get markStartVertex;

  /// No description provided for @pointPreviousVertexInstruction.
  ///
  /// In es, this message translates to:
  /// **'Apuntá al vértice anterior del contorno y confirmalo.'**
  String get pointPreviousVertexInstruction;

  /// No description provided for @pointStartVertexInstruction.
  ///
  /// In es, this message translates to:
  /// **'Apuntá al vértice desde el que vas a continuar y confirmalo.'**
  String get pointStartVertexInstruction;

  /// No description provided for @vertexReferenceAligned.
  ///
  /// In es, this message translates to:
  /// **'Orientación del ambiente alineada. Podés continuar el escaneo.'**
  String get vertexReferenceAligned;

  /// No description provided for @continueFromSelectedVertexTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Continuar desde este vértice?'**
  String get continueFromSelectedVertexTitle;

  /// No description provided for @continueFromSelectedVertexBody.
  ///
  /// In es, this message translates to:
  /// **'El vértice resaltado será el inicio. En AR primero marcarás el vértice anterior y después este punto para conservar la orientación de la pared.'**
  String get continueFromSelectedVertexBody;

  /// No description provided for @areaSummaryTitle.
  ///
  /// In es, this message translates to:
  /// **'Superficies del proyecto'**
  String get areaSummaryTitle;

  /// No description provided for @totalAreaLabel.
  ///
  /// In es, this message translates to:
  /// **'Superficie total'**
  String get totalAreaLabel;

  /// No description provided for @validationTooCloseToPreviousPoint.
  ///
  /// In es, this message translates to:
  /// **'El punto está demasiado cerca del punto anterior.'**
  String get validationTooCloseToPreviousPoint;

  /// No description provided for @validationDuplicatePoint.
  ///
  /// In es, this message translates to:
  /// **'El punto está demasiado cerca de una esquina existente.'**
  String get validationDuplicatePoint;

  /// No description provided for @validationSelfIntersection.
  ///
  /// In es, this message translates to:
  /// **'El cambio generaría un cruce en el plano.'**
  String get validationSelfIntersection;

  /// No description provided for @validationInsufficientCorners.
  ///
  /// In es, this message translates to:
  /// **'Se necesitan al menos 3 esquinas.'**
  String get validationInsufficientCorners;

  /// No description provided for @validationInsufficientArea.
  ///
  /// In es, this message translates to:
  /// **'La superficie del ambiente es demasiado pequeña.'**
  String get validationInsufficientArea;

  /// No description provided for @validationInvalidGeometry.
  ///
  /// In es, this message translates to:
  /// **'La geometría no es válida.'**
  String get validationInvalidGeometry;

  /// No description provided for @measurementEditorTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar medidas'**
  String get measurementEditorTitle;

  /// No description provided for @noRoomsToEditMessage.
  ///
  /// In es, this message translates to:
  /// **'No hay ambientes para editar.'**
  String get noRoomsToEditMessage;

  /// No description provided for @measurementEditorEmptyHint.
  ///
  /// In es, this message translates to:
  /// **'Primero completá y guardá un ambiente desde el Scanner.'**
  String get measurementEditorEmptyHint;

  /// No description provided for @wallsSection.
  ///
  /// In es, this message translates to:
  /// **'Paredes'**
  String get wallsSection;

  /// No description provided for @selectWallToEdit.
  ///
  /// In es, this message translates to:
  /// **'Seleccioná una pared para corregir su longitud. La dirección actual de la pared se conserva automáticamente.'**
  String get selectWallToEdit;

  /// No description provided for @areaLabel.
  ///
  /// In es, this message translates to:
  /// **'Superficie'**
  String get areaLabel;

  /// No description provided for @perimeterLabel.
  ///
  /// In es, this message translates to:
  /// **'Perímetro'**
  String get perimeterLabel;

  /// No description provided for @cornersLabel.
  ///
  /// In es, this message translates to:
  /// **'Esquinas'**
  String get cornersLabel;

  /// No description provided for @wallNumber.
  ///
  /// In es, this message translates to:
  /// **'Pared {number}'**
  String wallNumber(Object number);

  /// No description provided for @cornerRange.
  ///
  /// In es, this message translates to:
  /// **'Esquina {start} → Esquina {end}'**
  String cornerRange(Object end, Object start);

  /// No description provided for @editWallTitle.
  ///
  /// In es, this message translates to:
  /// **'Editar pared {number}'**
  String editWallTitle(Object number);

  /// No description provided for @currentMeasurement.
  ///
  /// In es, this message translates to:
  /// **'Medida actual: {value}'**
  String currentMeasurement(Object value);

  /// No description provided for @newLength.
  ///
  /// In es, this message translates to:
  /// **'Nueva longitud'**
  String get newLength;

  /// No description provided for @lengthExample.
  ///
  /// In es, this message translates to:
  /// **'Ejemplo: 3,25'**
  String get lengthExample;

  /// No description provided for @wallLengthChangeNotice.
  ///
  /// In es, this message translates to:
  /// **'La nueva medida modifica la geometría real del ambiente. El plano será validado antes de guardar el cambio.'**
  String get wallLengthChangeNotice;

  /// No description provided for @invalidNumber.
  ///
  /// In es, this message translates to:
  /// **'Ingresá un número válido.'**
  String get invalidNumber;

  /// No description provided for @positiveLengthRequired.
  ///
  /// In es, this message translates to:
  /// **'La longitud debe ser mayor que 0.'**
  String get positiveLengthRequired;

  /// No description provided for @measurementUpdated.
  ///
  /// In es, this message translates to:
  /// **'Medida actualizada correctamente.'**
  String get measurementUpdated;

  /// No description provided for @invalidNewMeasurement.
  ///
  /// In es, this message translates to:
  /// **'La nueva medida no es válida.'**
  String get invalidNewMeasurement;

  /// No description provided for @validAngleRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingresá un ángulo válido'**
  String get validAngleRequired;

  /// No description provided for @directionFront.
  ///
  /// In es, this message translates to:
  /// **'↑ Frente · 0°'**
  String get directionFront;

  /// No description provided for @directionRightPreview.
  ///
  /// In es, this message translates to:
  /// **'→ Derecha · 90°'**
  String get directionRightPreview;

  /// No description provided for @directionBack.
  ///
  /// In es, this message translates to:
  /// **'↓ Atrás · 180°'**
  String get directionBack;

  /// No description provided for @directionLeftPreview.
  ///
  /// In es, this message translates to:
  /// **'← Izquierda · 270°'**
  String get directionLeftPreview;

  /// No description provided for @customDirection.
  ///
  /// In es, this message translates to:
  /// **'Dirección personalizada · {angle}°'**
  String customDirection(Object angle);

  /// No description provided for @referenceOpeningConnected.
  ///
  /// In es, this message translates to:
  /// **'La abertura ya conecta otro ambiente.'**
  String get referenceOpeningConnected;

  /// No description provided for @needThreeCornersToCloseMessage.
  ///
  /// In es, this message translates to:
  /// **'Necesitás al menos 3 esquinas para cerrar el ambiente.'**
  String get needThreeCornersToCloseMessage;

  /// No description provided for @closeRoomFailedFallback.
  ///
  /// In es, this message translates to:
  /// **'No se pudo cerrar el ambiente.'**
  String get closeRoomFailedFallback;

  /// No description provided for @saveRoomFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo guardar el ambiente. Revisá los solapamientos y volvé a intentar.'**
  String get saveRoomFailed;

  /// No description provided for @scanErrorNoActiveRoom.
  ///
  /// In es, this message translates to:
  /// **'No hay un ambiente en curso.'**
  String get scanErrorNoActiveRoom;

  /// No description provided for @scanErrorNeedWallBeforeOpening.
  ///
  /// In es, this message translates to:
  /// **'Medí al menos una pared antes de agregar una abertura.'**
  String get scanErrorNeedWallBeforeOpening;

  /// No description provided for @scanErrorInvalidOpeningHeights.
  ///
  /// In es, this message translates to:
  /// **'La altura debe ser positiva y el antepecho no puede ser negativo.'**
  String get scanErrorInvalidOpeningHeights;

  /// No description provided for @scanErrorOpeningTooNarrow.
  ///
  /// In es, this message translates to:
  /// **'Ingresá un ancho mínimo de {minWidth}.'**
  String scanErrorOpeningTooNarrow(String minWidth);

  /// No description provided for @scanErrorInvalidWallIndex.
  ///
  /// In es, this message translates to:
  /// **'La pared seleccionada no es válida.'**
  String get scanErrorInvalidWallIndex;

  /// No description provided for @scanErrorNoValidWall.
  ///
  /// In es, this message translates to:
  /// **'No se encontró una pared válida.'**
  String get scanErrorNoValidWall;

  /// No description provided for @scanErrorEndpointsTooClose.
  ///
  /// In es, this message translates to:
  /// **'Los dos puntos de la abertura están demasiado cerca. Medida detectada: {measuredWidth}.'**
  String scanErrorEndpointsTooClose(String measuredWidth);

  /// No description provided for @scanErrorOpeningExceedsWall.
  ///
  /// In es, this message translates to:
  /// **'La abertura mide {openingWidth}, pero la pared mide {wallLength}.'**
  String scanErrorOpeningExceedsWall(String openingWidth, String wallLength);

  /// No description provided for @scanErrorOpeningOverlaps.
  ///
  /// In es, this message translates to:
  /// **'La abertura se superpone con otra puerta o ventana. Elegí otra posición sobre la pared.'**
  String get scanErrorOpeningOverlaps;

  /// No description provided for @scanErrorCloseSelfIntersection.
  ///
  /// In es, this message translates to:
  /// **'El contorno se autointersecta. Revisá las paredes trazadas.'**
  String get scanErrorCloseSelfIntersection;

  /// No description provided for @defaultProjectName.
  ///
  /// In es, this message translates to:
  /// **'Mi Casa Completa'**
  String get defaultProjectName;

  /// No description provided for @scanWarningOpeningMeasured.
  ///
  /// In es, this message translates to:
  /// **'Abertura medida: {measuredWidth}.'**
  String scanWarningOpeningMeasured(String measuredWidth);

  /// No description provided for @planErrorRoomNotFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontró el ambiente.'**
  String get planErrorRoomNotFound;

  /// No description provided for @planErrorInvalidMeasurement.
  ///
  /// In es, this message translates to:
  /// **'La medida no es válida.'**
  String get planErrorInvalidMeasurement;

  /// No description provided for @planErrorEditCausesConflict.
  ///
  /// In es, this message translates to:
  /// **'El cambio genera un cruce, solapamiento o modifica una conexión. Revisá el plano.'**
  String get planErrorEditCausesConflict;

  /// No description provided for @openingGeomWidthTooSmall.
  ///
  /// In es, this message translates to:
  /// **'El ancho debe ser de al menos 0,20 metros.'**
  String get openingGeomWidthTooSmall;

  /// No description provided for @openingGeomNegativeDistance.
  ///
  /// In es, this message translates to:
  /// **'La distancia desde la esquina no puede ser negativa.'**
  String get openingGeomNegativeDistance;

  /// No description provided for @openingGeomHeightTooSmall.
  ///
  /// In es, this message translates to:
  /// **'La altura debe ser de al menos 0,20 metros.'**
  String get openingGeomHeightTooSmall;

  /// No description provided for @openingGeomNegativeSillHeight.
  ///
  /// In es, this message translates to:
  /// **'La altura desde el piso no puede ser negativa.'**
  String get openingGeomNegativeSillHeight;

  /// No description provided for @openingGeomRoomNotAvailable.
  ///
  /// In es, this message translates to:
  /// **'El ambiente seleccionado ya no está disponible.'**
  String get openingGeomRoomNotAvailable;

  /// No description provided for @openingGeomOpeningNotAvailable.
  ///
  /// In es, this message translates to:
  /// **'La abertura seleccionada ya no está disponible.'**
  String get openingGeomOpeningNotAvailable;

  /// No description provided for @openingGeomWallNotIdentified.
  ///
  /// In es, this message translates to:
  /// **'No se pudo identificar la pared de la abertura.'**
  String get openingGeomWallNotIdentified;

  /// No description provided for @openingGeomExceedsWall.
  ///
  /// In es, this message translates to:
  /// **'La abertura termina fuera de la pared de {wallLength}.'**
  String openingGeomExceedsWall(String wallLength);

  /// No description provided for @openingGeomOverlaps.
  ///
  /// In es, this message translates to:
  /// **'La abertura se superpone con otra puerta o ventana.'**
  String get openingGeomOverlaps;

  /// No description provided for @openingGeomUpdateFailed.
  ///
  /// In es, this message translates to:
  /// **'No se pudo actualizar la abertura.'**
  String get openingGeomUpdateFailed;

  /// No description provided for @openingGeomInvalidWallOrMeasurements.
  ///
  /// In es, this message translates to:
  /// **'Elegí una pared y medidas válidas para la abertura.'**
  String get openingGeomInvalidWallOrMeasurements;

  /// No description provided for @openingGeomConnectedMustBeOnWall.
  ///
  /// In es, this message translates to:
  /// **'La abertura conectada debe permanecer sobre una pared de ambos ambientes.'**
  String get openingGeomConnectedMustBeOnWall;
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
      'that was used.');
}
