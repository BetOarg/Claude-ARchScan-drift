// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get undoScanEdit => 'Deshacer última acción';

  @override
  String get redoScanEdit => 'Rehacer última acción';

  @override
  String get placeOpeningByTouch => 'Ubicar abertura en el plano';

  @override
  String get touchOpeningInstructions =>
      'Tocá una pared y deslizá la abertura hasta su posición. También podés elegir la pared de cierre. Ajustá el ancho y confirmá.';

  @override
  String get deleteOpening => 'Eliminar abertura';

  @override
  String get deleteOpeningConfirmation =>
      'Se eliminará esta abertura. Si conecta dos ambientes, se quitará la conexión sin borrar las habitaciones.';

  @override
  String get appTitle => 'ARchScan';

  @override
  String get newRoom => 'Nuevo ambiente';

  @override
  String get roomName => 'Nombre del ambiente';

  @override
  String get roomDestination => 'Destino o nombre';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get wall => 'Pared';

  @override
  String get door => 'Puerta';

  @override
  String get window => 'Ventana';

  @override
  String get roomTypeLiving => 'Living';

  @override
  String get roomTypeKitchen => 'Cocina';

  @override
  String get roomTypeBathroom => 'Baño';

  @override
  String get roomTypeBedroom => 'Dormitorio';

  @override
  String get roomTypeLaundry => 'Lavadero';

  @override
  String get roomTypeHallway => 'Pasillo';

  @override
  String get roomTypeDiningRoom => 'Comedor';

  @override
  String get roomTypeDailyDiningRoom => 'Comedor diario';

  @override
  String get roomTypePatio => 'Patio';

  @override
  String get roomTypeHall => 'Hall';

  @override
  String get roomTypeBalcony => 'Balcón';

  @override
  String get roomTypeTerrace => 'Terraza';

  @override
  String get roomTypeGarage => 'Cochera';

  @override
  String get roomTypePlayroom => 'Playroom';

  @override
  String get roomTypeOther => 'Otro espacio';

  @override
  String get scanWithRoomPlan => 'Escanear con RoomPlan';

  @override
  String get roomPlanSpaceSaved => 'Espacio de RoomPlan guardado';

  @override
  String roomPlanCaptureFailed(String error) {
    return 'RoomPlan no pudo completar el escaneo: $error';
  }

  @override
  String get roomType => 'Tipo de ambiente';

  @override
  String get viewPlan => 'Ver plano';

  @override
  String get editRoomName => 'Editar nombre del ambiente';

  @override
  String get roomNameExample => 'Ej.: Dormitorio de Ana';

  @override
  String get whatIsSpaceName => '¿Cómo se llama este espacio?';

  @override
  String get roomSuggestionOffice => 'Oficina';

  @override
  String get roomSuggestionStorage => 'Depósito';

  @override
  String get spaceSaved => 'Espacio guardado';

  @override
  String get whatWouldYouLikeToDo =>
      '¿Qué querés hacer ahora? Para continuar desde otro ambiente, seleccioná una puerta o ventana en el plano.';

  @override
  String get addAnotherSpace => 'Agregar otro espacio';

  @override
  String get viewFullPlan => 'Ver plano completo';

  @override
  String get chooseOpeningToContinue =>
      'Elegí una puerta o ventana para continuar';

  @override
  String get noAvailableOpenings => 'No hay aberturas disponibles.';

  @override
  String get openingAlreadyConnected =>
      'Esta abertura ya conecta dos ambientes.';

  @override
  String get unfinishedScan => 'Escaneo sin terminar';

  @override
  String get unfinishedScanFound => 'Encontramos un escaneo que no se terminó.';

  @override
  String get continueScan => 'Continuar escaneo';

  @override
  String get discardScan => 'Descartar';

  @override
  String get markStartRecommendation => 'Marcá el inicio';

  @override
  String get addNextCornerRecommendation => 'Agregá la próxima esquina';

  @override
  String get closeSpaceRecommendation => 'Ya podés cerrar el espacio';

  @override
  String get calculating => 'CALCULANDO...';

  @override
  String get markStart => 'MARCAR INICIO';

  @override
  String get measureNextCorner => 'MEDIR SIGUIENTE ESQUINA';

  @override
  String get placeDoor => 'UBICAR PUERTA';

  @override
  String get placeWindow => 'UBICAR VENTANA';

  @override
  String get addCorner => 'AÑADIR ESQUINA';

  @override
  String get markSecondEnd => 'MARCAR SEGUNDO EXTREMO';

  @override
  String get measureDoor => 'MEDIR PUERTA';

  @override
  String get measureWindow => 'MEDIR VENTANA';

  @override
  String get preparingCamera => 'Preparando cámara...';

  @override
  String get basicScanner => 'Escáner básico';

  @override
  String get cameraStartFailed => 'No se pudo iniciar la cámara';

  @override
  String get unknownError => 'Error desconocido.';

  @override
  String get retryCamera => 'Reintentar cámara';

  @override
  String get cameraPermissionRequired =>
      'El permiso de cámara es necesario para utilizar el Escáner básico.';

  @override
  String get cameraUnavailable =>
      'El dispositivo no tiene una cámara disponible.';

  @override
  String get cameraTimeoutMessage =>
      'La cámara tardó demasiado en responder. Podés intentar iniciarla nuevamente.';

  @override
  String get closeRoom => 'Cerrar ambiente';

  @override
  String get chooseClosingCorner => 'Elegí la esquina donde querés cerrar';

  @override
  String get chooseDifferentCorner =>
      'Elegí una esquina diferente de la inicial';

  @override
  String get diagonalClosureDetectedTitle => 'Cierre diagonal detectado';

  @override
  String get diagonalClosureDetectedMessage =>
      'El cierre directo formaría una diagonal. La aplicación puede agregar la esquina ortogonal faltante y cerrar contra la primera esquina real del ambiente.';

  @override
  String get addCornerAndClose => 'Agregar esquina y cerrar';

  @override
  String smartCloseMessage(String distance) {
    return 'La medición termina a $distance metros del punto inicial. ¿Querés ajustar el cierre exactamente al inicio?';
  }

  @override
  String get continueMeasuring => 'Continuar midiendo';

  @override
  String cameraResumeFailed(String error) {
    return 'No se pudo reanudar la cámara: $error';
  }

  @override
  String get continuationFromOpening => 'Continuación desde una abertura';

  @override
  String get continuationFirstCornerInstruction =>
      'Desde el punto verde, medí la distancia hasta la primera esquina real del ambiente.';

  @override
  String get markRoomStartingPoint =>
      'Marcá el punto inicial de la habitación.';

  @override
  String get measureNextCornerInstruction =>
      'Medí la distancia hasta la próxima esquina y elegí su dirección.';

  @override
  String get traceStarted => 'Inicio del trazado';

  @override
  String cornerRegistered(int count) {
    return 'Esquina $count registrada';
  }

  @override
  String get needThreeCornersToClose =>
      'Necesitás al menos 3 esquinas para cerrar.';

  @override
  String get canContinueOrClose => 'Podés seguir agregando esquinas o cerrar.';

  @override
  String get lastCornerRemoved => 'Última esquina eliminada.';

  @override
  String get measureFirstCorner => 'Medir primera esquina';

  @override
  String get measureFirstCornerBeforeFeatures =>
      'Primero medí la primera esquina real del ambiente.';

  @override
  String get couldNotAddStart => 'No se pudo agregar el inicio.';

  @override
  String get startMarked => 'Inicio marcado. Ahora medí la primera pared.';

  @override
  String get couldNotCalculateCorner => 'No se pudo calcular la nueva esquina.';

  @override
  String get invalidCorner => 'La esquina no es válida.';

  @override
  String get firstCornerRegistered =>
      'Primera esquina registrada. Continuá midiendo las paredes del ambiente.';

  @override
  String measurementRegistrationFailed(String error) {
    return 'No se pudo registrar la medición: $error';
  }

  @override
  String get couldNotCalculateLocation => 'No se pudo calcular la ubicación.';

  @override
  String get enterOpeningWidth => 'Ingresá el ancho de la abertura.';

  @override
  String get couldNotAttachOpening =>
      'No se pudo asociar la abertura a una pared.';

  @override
  String doorAdjustedToWall(String width) {
    return 'Puerta de $width metros ajustada a la pared.';
  }

  @override
  String windowAdjustedToWall(String width) {
    return 'Ventana de $width metros ajustada a la pared.';
  }

  @override
  String locationRegistrationFailed(String error) {
    return 'No se pudo registrar la ubicación: $error';
  }

  @override
  String get openingWallQuestion => '¿En qué pared está la abertura?';

  @override
  String get openingWallExplanation =>
      'Elegí la pared de cierre si la puerta o ventana está sobre el tramo que une la última esquina con la primera.';

  @override
  String get detectWallAutomatically => 'Detectar pared automáticamente';

  @override
  String get useClosingWall => 'Usar pared de cierre';

  @override
  String get placeElement => 'Ubicar elemento';

  @override
  String get measureCorner => 'Medir esquina';

  @override
  String get featureDistanceInstruction =>
      'Indicá cuánto hay desde la última posición hasta la puerta o ventana.';

  @override
  String get cornerDistanceInstruction =>
      'Indicá cuánto hay desde la última esquina hasta la nueva esquina.';

  @override
  String get manualFirstWallInstruction =>
      'Este dispositivo no es compatible con ARCore. Ingresá manualmente la distancia desde la esquina inicial hasta la nueva.';

  @override
  String get manualNextWallInstruction =>
      'Este dispositivo no es compatible con ARCore. Ingresá manualmente la distancia desde la última esquina hasta la nueva.';

  @override
  String get distance => 'Distancia';

  @override
  String get distanceExample => 'Ejemplo: 3,50';

  @override
  String get meters => 'metros';

  @override
  String get enterPositiveDistance => 'Ingresá una distancia mayor a 0';

  @override
  String get direction => 'Dirección';

  @override
  String get directionExample => 'Ejemplo: 90';

  @override
  String get degrees => 'grados';

  @override
  String get enterValidDirection => 'Ingresá una dirección válida';

  @override
  String get doorWidth => 'Ancho de la puerta';

  @override
  String get windowWidth => 'Ancho de la ventana';

  @override
  String get widthExample => 'Ejemplo: 1,20';

  @override
  String get enterMinimumOpeningWidth =>
      'Ingresá un ancho mínimo de 0,20 metros';

  @override
  String get quickDirection => 'Dirección rápida:';

  @override
  String get front => 'Frente';

  @override
  String get right => 'Derecha';

  @override
  String get back => 'Atrás';

  @override
  String get left => 'Izquierda';

  @override
  String get featureDoesNotCreateCorner =>
      'Esto no crea una esquina nueva del ambiente.';

  @override
  String get positionValidatedBeforeAdding =>
      'La nueva posición se valida antes de incorporarla al plano.';

  @override
  String get useMeasurement => 'Usar medición';

  @override
  String get measurementSystem => 'Sistema de medición';

  @override
  String get metricSystem => 'Metros';

  @override
  String get imperialSystem => 'Pies y pulgadas';

  @override
  String get feet => 'Pies';

  @override
  String get inches => 'Pulgadas';

  @override
  String get squareMeters => 'metros cuadrados';

  @override
  String get squareFeet => 'pies cuadrados';

  @override
  String get changeDoorHingeSide => 'Cambiar lado de la bisagra';

  @override
  String get changeDoorOpeningDirection => 'Cambiar sentido de apertura';

  @override
  String get chooseDoorOpeningDirection => 'Elegir apertura de la puerta';

  @override
  String get doorOpensInterior => 'Abrir hacia el interior';

  @override
  String get doorOpensExterior => 'Abrir hacia el exterior';

  @override
  String get editOpeningDimensions => 'Editar medidas y posición';

  @override
  String get openingWidth => 'Ancho de la abertura';

  @override
  String get distanceFromWallStart =>
      'Distancia desde la esquina inicial de la pared';

  @override
  String get wallLength => 'Longitud de la pared';

  @override
  String get invalidOpeningMeasurement =>
      'Ingresá medidas válidas para el ancho y la posición.';

  @override
  String get openingUpdated => 'Abertura actualizada correctamente.';

  @override
  String get openingHeight => 'Altura de la abertura';

  @override
  String get sillHeight => 'Altura desde el piso';

  @override
  String get horizontalOrientation => 'Horizontal';

  @override
  String get verticalOrientation => 'Vertical';

  @override
  String doorPlanDimensions(String width, String height) {
    return '$width de ancho · $height de alto';
  }

  @override
  String windowPlanDimensions(
      String width, String height, String sill, String orientation) {
    return '$width de ancho · $height de alto\n$sill desde el piso · $orientation';
  }

  @override
  String get noRoomsToEdit => 'No hay ambientes para editar.';

  @override
  String get transformRoomsTitle => 'Mover y rotar ambientes';

  @override
  String get touchTransformRooms => 'Mover ambientes con gestos';

  @override
  String get zoomOut => 'Alejar plano';

  @override
  String get zoomIn => 'Acercar plano';

  @override
  String get resetView => 'Restablecer vista';

  @override
  String get touchTransformExplanation =>
      'Arrastrá el ambiente con un dedo. Usá dos dedos para mover o acercar el plano; el botón de ajuste permite girarlo.';

  @override
  String get connectedGroupTransformHint =>
      'Si el ambiente está conectado mediante una abertura, todo el grupo se moverá o rotará como una sola unidad.';

  @override
  String get selectedRoom => 'Ambiente seleccionado';

  @override
  String get movementDistance => 'Distancia de cada movimiento';

  @override
  String get fiveCentimeters => '5 centímetros';

  @override
  String get tenCentimeters => '10 centímetros';

  @override
  String get twentyFiveCentimeters => '25 centímetros';

  @override
  String get fiftyCentimeters => '50 centímetros';

  @override
  String get oneInch => '1 pulgada';

  @override
  String get threeInches => '3 pulgadas';

  @override
  String get sixInches => '6 pulgadas';

  @override
  String get oneFoot => '1 pie';

  @override
  String get movement => 'Movimiento';

  @override
  String get moveUp => 'Mover hacia arriba';

  @override
  String get moveDown => 'Mover hacia abajo';

  @override
  String get moveLeft => 'Mover hacia la izquierda';

  @override
  String get moveRight => 'Mover hacia la derecha';

  @override
  String get rotation => 'Rotación';

  @override
  String get rotateFifteenDegreesLeft => 'Girar 15 grados a la izquierda';

  @override
  String get rotateFifteenDegreesRight => 'Girar 15 grados a la derecha';

  @override
  String get finishEditing => 'Finalizar edición';

  @override
  String get preciseAdjustment => 'Ajuste preciso';

  @override
  String get preciseAdjustmentExplanation =>
      'Ingresá el desplazamiento horizontal, el desplazamiento vertical y el giro exacto del grupo seleccionado.';

  @override
  String get horizontalAdjustment => 'Desplazamiento horizontal';

  @override
  String get verticalAdjustment => 'Desplazamiento vertical';

  @override
  String get rotationDegrees => 'Giro en grados';

  @override
  String get applyAdjustment => 'Aplicar ajuste';

  @override
  String get invalidPreciseAdjustment =>
      'Ingresá al menos un valor válido distinto de cero.';

  @override
  String get preciseAdjustmentApplied =>
      'El ajuste preciso se aplicó correctamente.';

  @override
  String get undoLastTransform => 'Deshacer último ajuste';

  @override
  String get redoLastTransform => 'Rehacer último ajuste';

  @override
  String get alignNearestWall => 'Alinear con la pared más cercana';

  @override
  String get alignmentPreviewTitle => 'Vista previa de alineación';

  @override
  String get alignmentPreviewMessage =>
      'Revisá la posición actual y la posición propuesta antes de aplicar el ajuste.';

  @override
  String get alignmentCurrentPosition => 'Posición actual';

  @override
  String get alignmentProposedPosition => 'Posición propuesta';

  @override
  String get applyAlignment => 'Aplicar alineación';

  @override
  String get alignmentPreviewExpired =>
      'El plano cambió después de generar la vista previa. Generá una nueva alineación.';

  @override
  String get wallAlignedSuccessfully =>
      'Las paredes se alinearon correctamente.';

  @override
  String get joinRooms => 'Unir ambientes';

  @override
  String get roomToJoin => 'Ambiente de destino';

  @override
  String get joinPreviewTitle => 'Vista previa de la unión';

  @override
  String joinPreviewMessage(String source, String target) {
    return 'Se moverá $source para unirlo con $target. La aplicación rechazará la operación si produce solapamientos.';
  }

  @override
  String get applyJoin => 'Aplicar unión';

  @override
  String get joinCompleted => 'Los ambientes se unieron correctamente.';

  @override
  String get joinOverlapPrevented =>
      'La unión fue cancelada porque produciría un solapamiento.';

  @override
  String get noIndependentRoomAvailable =>
      'No hay otro ambiente independiente disponible para unir.';

  @override
  String get noSafeNearbyWall =>
      'No se encontró una pared cercana y paralela que pueda alinearse de forma segura.';

  @override
  String get sharedWall => 'Pared compartida';

  @override
  String get partialSharedWall => 'Tramo de pared compartida';

  @override
  String get roomAdjustedAutomatically =>
      'La habitación se ajustó correctamente.';

  @override
  String get unsafeMovementRejected =>
      'El movimiento fue cancelado porque produciría un solapamiento.';

  @override
  String get unsafeRotationRejected =>
      'La rotación fue cancelada porque produciría un solapamiento.';

  @override
  String get selectedDoor => 'Puerta seleccionada';

  @override
  String get selectedWindow => 'Ventana seleccionada';

  @override
  String get openingConnectedStatus => 'Conectada';

  @override
  String get openingAvailableStatus => 'Disponible';

  @override
  String get openingStartAtMarkedPoint => 'Inicio en el punto marcado';

  @override
  String get continueScanFromHere => 'Continuar escaneo desde aquí';

  @override
  String get selectedDoorUnavailable =>
      'La puerta seleccionada ya no está disponible.';

  @override
  String get selectedOpeningUnavailable =>
      'La abertura seleccionada ya no está disponible.';

  @override
  String get openingWallNotFound =>
      'No se pudo identificar la pared de la abertura.';

  @override
  String get continuationDirectionTitle => '¿Hacia dónde continúa el plano?';

  @override
  String get continuationDirectionExplanation =>
      'El punto verde marca dónde comenzará el nuevo ambiente. Elegí la flecha que apunta hacia el ambiente que vas a escanear.';

  @override
  String continueToward(String direction) {
    return 'Continuar hacia $direction';
  }

  @override
  String get directionRight => 'la derecha';

  @override
  String get directionLeft => 'la izquierda';

  @override
  String get directionDown => 'abajo';

  @override
  String get directionUp => 'arriba';

  @override
  String get notEnoughRoomsToOrganize =>
      'No hay suficientes ambientes para organizar.';

  @override
  String get organizeRooms => 'Organizar ambientes';

  @override
  String get organizeRoomsExplanation =>
      'Se distribuirán solamente los grupos independientes. Los ambientes conectados o que compartan una pared se moverán juntos, conservando su alineación, medidas, puertas y ventanas.\n\nEl primer grupo queda fijo. Si todo el plano ya está unido, no se modificará. Podés deshacer la organización.';

  @override
  String get roomsOrganizedSuccessfully =>
      'Ambientes organizados correctamente.';

  @override
  String get floorPlan2D => 'Plano general 2D';

  @override
  String get editMeasurements => 'Editar medidas';

  @override
  String get moreOptions => 'Más opciones';

  @override
  String get importPlan => 'Importar plano';

  @override
  String get importProject => 'Importar JSON o SVG';

  @override
  String get exportProject => 'Exportar archivo';

  @override
  String get exportJson => 'JSON — copia completa del proyecto';

  @override
  String get exportSvg => 'SVG — plano vectorial editable';

  @override
  String get exportPng => 'PNG — imagen nítida del plano';

  @override
  String get exportJpg => 'JPG — imagen liviana del plano';

  @override
  String get exportDestination => '¿Qué querés hacer con el archivo?';

  @override
  String get saveToFiles => 'Guardar en Archivos…';

  @override
  String get shareFile => 'Compartir…';

  @override
  String get replaceProjectTitle => 'Reemplazar el proyecto abierto';

  @override
  String get replaceProjectMessage =>
      'El archivo es válido. Si continuás, reemplazará el plano abierto. Los archivos guardados fuera de ARchScan no se eliminarán.';

  @override
  String get shareJson => 'Guardar JSON en Archivos';

  @override
  String get exportPdf => 'Guardar PDF en Archivos';

  @override
  String get registeredRooms => 'Ambientes registrados';

  @override
  String get tapRoomToAddOpening =>
      'Tocá dentro de un ambiente para añadir una puerta o ventana.';

  @override
  String roomCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ambientes',
      one: '1 ambiente',
    );
    return '$_temp0';
  }

  @override
  String get planImportedSuccessfully => 'Plano importado correctamente.';

  @override
  String get planImportCancelledOrInvalid =>
      'Importación cancelada o no válida.';

  @override
  String get addElement => 'Agregar elemento';

  @override
  String get selectElementToAdd =>
      'Seleccioná el elemento que querés incorporar.';

  @override
  String get noRoomsYet => 'No hay ambientes aún.';

  @override
  String get renameRoom => 'Renombrar ambiente';

  @override
  String get roomNameShortLabel => 'Nombre';

  @override
  String get roomNameMainBedroomExample => 'Ej. Dormitorio principal';

  @override
  String get noScannedRooms => 'No hay ambientes escaneados';

  @override
  String get completeScanToViewPlan =>
      'Completá un escaneo para visualizar el plano general.';

  @override
  String get closeProject => 'Cerrar proyecto';

  @override
  String get close => 'Cerrar';

  @override
  String roomSummary(String area, String perimeter, int cornerCount) {
    String _temp0 = intl.Intl.pluralLogic(
      cornerCount,
      locale: localeName,
      other: '$cornerCount esquinas',
      one: '1 esquina',
    );
    return '$area · $perimeter de perímetro · $_temp0';
  }

  @override
  String get actions => 'Acciones';

  @override
  String get rename => 'Renombrar';

  @override
  String get completeAllFields => 'Por favor, completá todos los campos.';

  @override
  String get newProject => 'Nuevo proyecto';

  @override
  String get projectNameExample => 'Ej. Remodelación de oficina';

  @override
  String get create => 'Crear';

  @override
  String get myProjects => 'Mis proyectos';

  @override
  String get localProjectsStoredOnDevice =>
      'Proyectos guardados únicamente en este dispositivo';

  @override
  String get newScan => 'Nuevo escaneo';

  @override
  String get noSavedProjects => 'No tenés proyectos guardados';

  @override
  String get pressNewScanToStart => 'Presioná «Nuevo escaneo» para comenzar';

  @override
  String projectUpdated(String date) {
    return 'Actualizado: $date';
  }

  @override
  String get viewFloorPlan => 'Ver plano';

  @override
  String get delete => 'Eliminar';

  @override
  String get permissionsRequired => 'Permisos requeridos';

  @override
  String get cameraLocationPermissionsDenied =>
      'No se otorgó el permiso de cámara. Habilitalo desde los ajustes del sistema para poder escanear.';

  @override
  String get scannerUnavailable => 'Escáner no disponible';

  @override
  String get basicScannerInitializationFailed =>
      'La cámara está disponible, pero no fue posible iniciar el escáner básico.';

  @override
  String get deviceCameraUnavailable =>
      'Este dispositivo no tiene una cámara disponible para realizar el escaneo.';

  @override
  String get understood => 'Entendido';

  @override
  String get arTrackingActive => 'Realidad aumentada activa';

  @override
  String get arCalibrating => 'Calibrando';

  @override
  String get markOpeningEndpointA => 'Marcar extremo A';

  @override
  String get markOpeningEndpointB => 'Marcar extremo B';

  @override
  String get pointOpeningEndpointAInstruction =>
      'Apuntá al extremo A de la abertura y marcá la referencia.';

  @override
  String get pointOpeningEndpointBInstruction =>
      'Ahora apuntá al extremo B de la misma abertura.';

  @override
  String get openingReferenceAlignedInstruction =>
      'Referencia alineada. Ya podés medir el ambiente nuevo.';

  @override
  String get invalidOpeningReferencePoint =>
      'No se detectó un punto válido. Apuntá a la abertura e intentá nuevamente.';

  @override
  String get openingReferenceEndpointsTooClose =>
      'Los extremos están demasiado cerca. Volvé a marcar el extremo B.';

  @override
  String openingReferenceDifference(String difference) {
    return 'Referencia alineada. Atención: la medida de realidad aumentada difiere $difference del plano.';
  }

  @override
  String get openingReferenceAligned => 'Referencia alineada correctamente.';

  @override
  String get invalidCameraPosition =>
      'No se detectó una posición de cámara válida. Apuntá a una superficie reconocida e intentá nuevamente.';

  @override
  String get needTwoCornersBeforeOpening =>
      'Necesitás marcar al menos 2 esquinas antes de medir una abertura.';

  @override
  String featureStartRegistered(String feature) {
    return 'Inicio de $feature registrado. Ubicá la cámara en el otro extremo y volvé a pulsar.';
  }

  @override
  String get openingMeasurementFailed => 'No se pudo medir la abertura.';

  @override
  String featureSaved(String feature, String warning) {
    return '$feature guardada. $warning';
  }

  @override
  String get referenceOpeningMissing =>
      'La abertura de referencia ya no existe.';

  @override
  String get closeRoomFailed =>
      'No se pudo cerrar el ambiente. Revisá los puntos trazados.';

  @override
  String get connectOpeningFailed =>
      'No se pudo conectar el ambiente con la abertura seleccionada.';

  @override
  String get initializingApplication => 'Iniciando ARchScan…';

  @override
  String get applicationInitializationFailed =>
      'No se pudo iniciar la aplicación';

  @override
  String get applicationInitializationFailedDetails =>
      'Revisá la conexión e intentá nuevamente. Tus proyectos guardados permanecen protegidos.';

  @override
  String get retryApplicationStart => 'Reintentar inicio';

  @override
  String get arInitializationFailedTitle =>
      'No se pudo iniciar la realidad aumentada';

  @override
  String get arInitializationFailedMessage =>
      'La sesión de realidad aumentada no respondió a tiempo. Podés reintentar o continuar con el escáner básico usando la cámara.';

  @override
  String get retryArScanner => 'Reintentar realidad aumentada';

  @override
  String get useBasicScanner => 'Continuar con el escáner básico';

  @override
  String get privacyAndAccount => 'Privacidad y datos';

  @override
  String get privacyAndData => 'Privacidad y datos';

  @override
  String get privacyOverview => 'Resumen de privacidad';

  @override
  String get privacyOverviewLocalDescription =>
      'ARchScan funciona sin cuenta y conserva tus proyectos dentro del dispositivo. No sincroniza relevamientos con servidores externos.';

  @override
  String get localDataTitle => 'Datos guardados en el dispositivo';

  @override
  String get localDataDescription =>
      'Los proyectos, escaneos interrumpidos y preferencias se guardan localmente para que la aplicación pueda funcionar sin conexión.';

  @override
  String get localOnlyDataDescription =>
      'Los proyectos, nombres de ambientes, geometría, medidas y preferencias permanecen en el almacenamiento privado de ARchScan en este dispositivo.';

  @override
  String get cameraAndSensorsTitle => 'Cámara y sensores';

  @override
  String get cameraAndSensorsDescription =>
      'La cámara y los sensores se utilizan mientras medís. ARchScan no guarda ni envía fotografías, videos, ubicación geográfica ni lecturas sin procesar de sensores.';

  @override
  String get exportsAndSharingTitle => 'Exportaciones y archivos';

  @override
  String get exportsAndSharingDescription =>
      'Los archivos JSON y PDF se crean o comparten únicamente cuando elegís una acción de exportación o importación.';

  @override
  String get trackingTitle => 'Seguimiento y publicidad';

  @override
  String get trackingDescription =>
      'ARchScan no contiene publicidad, no crea perfiles publicitarios y no realiza seguimiento entre aplicaciones o sitios web.';

  @override
  String get deleteLocalDataTitle => 'Eliminar los proyectos del dispositivo';

  @override
  String get deleteLocalDataDescription =>
      'Elimina permanentemente todos los proyectos guardados por ARchScan en este dispositivo. Los JSON y PDF exportados no se modifican.';

  @override
  String get deleteAllLocalData => 'Eliminar todos los proyectos locales';

  @override
  String get deleteLocalDataConfirmationTitle =>
      '¿Eliminar todos los proyectos locales?';

  @override
  String get deleteLocalDataConfirmationMessage =>
      'Esta acción eliminará permanentemente los proyectos guardados por ARchScan en este dispositivo y no se puede deshacer. Los archivos JSON, PDF o DXF exportados permanecerán donde los hayas guardado.';

  @override
  String get deleteLocalDataPermanently => 'Eliminar definitivamente';

  @override
  String get deletingLocalData => 'Eliminando proyectos…';

  @override
  String get localDataDeleted =>
      'Los proyectos locales se eliminaron correctamente.';

  @override
  String get cameraPermissionDenied =>
      'No se otorgó el permiso de cámara. Habilitalo desde los ajustes del sistema para poder escanear.';

  @override
  String get planImportInvalid =>
      'El archivo no contiene un proyecto compatible y no se realizó ningún cambio.';

  @override
  String get openingHeightPositive => 'Ingresá una altura mayor que cero.';

  @override
  String get windowSillHeight => 'Altura del antepecho';

  @override
  String get openingSillNonNegative =>
      'Ingresá una altura de antepecho igual o mayor que cero.';

  @override
  String get moveOpeningOnWall => 'Mover sobre una pared';

  @override
  String get roomsArrangementUnchanged =>
      'No se modificó la distribución del plano.';

  @override
  String get exportDxf => 'Guardar DXF 2D en Archivos (metros)';

  @override
  String get dxfExportFailed =>
      'No se pudo exportar el archivo DXF. Tu proyecto no se modificó.';

  @override
  String get fileSaveFailed =>
      'No se pudo guardar el archivo fuera de ARchScan. Tu proyecto no se modificó.';

  @override
  String get planTapWall => 'Tocá una pared para ubicar la abertura.';

  @override
  String get planSelectWall =>
      'Tocá una pared o una esquina para editarla sobre el plano.';

  @override
  String get planChooseRoom =>
      'Esta pared pertenece a varios ambientes. Elegí cuál editar.';

  @override
  String get planConnectionBlocked =>
      'El cambio descalzaría una abertura conectada. Mové el grupo de ambientes o quitá la conexión primero.';

  @override
  String get planOverlapBlocked =>
      'El cambio se superpone con otro ambiente. Se conservó el plano anterior.';

  @override
  String get planNoClosure =>
      'No hay un cierre cercano válido con un recorrido de paredes completo. Mové el extremo y volvé a intentar.';

  @override
  String get planStaleEdit =>
      'El plano cambió durante la edición. Seleccioná la pared nuevamente.';

  @override
  String get planInvalidGeometry =>
      'El cambio genera cruces, paredes demasiado cortas o aberturas fuera de su pared. No se aplicó.';

  @override
  String get planClosePreview =>
      'Revisá el recorrido resaltado: conecta con el punto o pared más cercanos que permiten cerrar sin cruces ni solapamientos.';

  @override
  String get planDeletePreview =>
      'Se quitará la pared seleccionada y sus aberturas. El contorno quedará abierto. Si ya estaba abierto, puede dividirse en tramos separados. Las aberturas del vecino se conservarán desconectadas. Podés deshacer esta operación.';

  @override
  String get planMeasurePreview =>
      'Revisá la pared resaltada y sus aberturas antes de confirmar la medida.';

  @override
  String get planConfirm => 'Confirmar cambio';

  @override
  String get planCorner => 'Esquina';

  @override
  String get planDragSelection =>
      'Arrastrá la selección para moverla. Tocá otro punto para cambiar la selección.';

  @override
  String get planDeleteWall => 'Eliminar pared';

  @override
  String get planAddDoor => 'Agregar puerta';

  @override
  String get planAddWindow => 'Agregar ventana';

  @override
  String get planUndo => 'Deshacer';

  @override
  String get planRedo => 'Rehacer';

  @override
  String get planInvalidLength =>
      'Ingresá una medida válida mayor o igual a 0,05 metros. Las pulgadas deben estar entre 0 y menos de 12.';

  @override
  String get planLengthAnchor =>
      'La primera esquina de esta pared queda fija; se ajusta la siguiente. Verás una vista previa antes de guardar.';

  @override
  String get planPreview => 'Ver cambio en el plano';

  @override
  String get planOpenContour => 'Contorno abierto';

  @override
  String get planDeleteRoom => 'Eliminar ambiente';

  @override
  String planDeleteRoomConfirmation(String roomName) {
    return '¿Eliminar “$roomName” y todas sus paredes y aberturas? Se quitarán sus conexiones con otros ambientes, sin borrar esos ambientes. Podés deshacer el cambio durante esta sesión.';
  }

  @override
  String get planRoomDeleted => 'Ambiente eliminado. Podés deshacer el cambio.';

  @override
  String get openingsAddedFromPlan =>
      'Terminá de medir el ambiente y después agregá puertas y ventanas tocando sus paredes en el plano.';

  @override
  String get markPreviousVertex => 'Marcar vértice anterior';

  @override
  String get markStartVertex => 'Marcar vértice de inicio';

  @override
  String get pointPreviousVertexInstruction =>
      'Apuntá al vértice anterior del contorno y confirmalo.';

  @override
  String get pointStartVertexInstruction =>
      'Apuntá al vértice desde el que vas a continuar y confirmalo.';

  @override
  String get vertexReferenceAligned =>
      'Orientación del ambiente alineada. Podés continuar el escaneo.';

  @override
  String get continueFromSelectedVertexTitle =>
      '¿Continuar desde este vértice?';

  @override
  String get continueFromSelectedVertexBody =>
      'El vértice resaltado será el inicio. En AR primero marcarás el vértice anterior y después este punto para conservar la orientación de la pared.';

  @override
  String get areaSummaryTitle => 'Superficies del proyecto';

  @override
  String get totalAreaLabel => 'Superficie total';

  @override
  String get validationTooCloseToPreviousPoint =>
      'El punto está demasiado cerca del punto anterior.';

  @override
  String get validationDuplicatePoint =>
      'El punto está demasiado cerca de una esquina existente.';

  @override
  String get validationSelfIntersection =>
      'El cambio generaría un cruce en el plano.';

  @override
  String get validationInsufficientCorners =>
      'Se necesitan al menos 3 esquinas.';

  @override
  String get validationInsufficientArea =>
      'La superficie del ambiente es demasiado pequeña.';

  @override
  String get validationInvalidGeometry => 'La geometría no es válida.';

  @override
  String get measurementEditorTitle => 'Editar medidas';

  @override
  String get noRoomsToEditMessage => 'No hay ambientes para editar.';

  @override
  String get measurementEditorEmptyHint =>
      'Primero completá y guardá un ambiente desde el Scanner.';

  @override
  String get wallsSection => 'Paredes';

  @override
  String get selectWallToEdit =>
      'Seleccioná una pared para corregir su longitud. La dirección actual de la pared se conserva automáticamente.';

  @override
  String get areaLabel => 'Superficie';

  @override
  String get perimeterLabel => 'Perímetro';

  @override
  String get cornersLabel => 'Esquinas';

  @override
  String wallNumber(Object number) {
    return 'Pared $number';
  }

  @override
  String cornerRange(Object end, Object start) {
    return 'Esquina $start → Esquina $end';
  }

  @override
  String editWallTitle(Object number) {
    return 'Editar pared $number';
  }

  @override
  String currentMeasurement(Object value) {
    return 'Medida actual: $value';
  }

  @override
  String get newLength => 'Nueva longitud';

  @override
  String get lengthExample => 'Ejemplo: 3,25';

  @override
  String get wallLengthChangeNotice =>
      'La nueva medida modifica la geometría real del ambiente. El plano será validado antes de guardar el cambio.';

  @override
  String get invalidNumber => 'Ingresá un número válido.';

  @override
  String get positiveLengthRequired => 'La longitud debe ser mayor que 0.';

  @override
  String get measurementUpdated => 'Medida actualizada correctamente.';

  @override
  String get invalidNewMeasurement => 'La nueva medida no es válida.';

  @override
  String get validAngleRequired => 'Ingresá un ángulo válido';

  @override
  String get directionFront => '↑ Frente · 0°';

  @override
  String get directionRightPreview => '→ Derecha · 90°';

  @override
  String get directionBack => '↓ Atrás · 180°';

  @override
  String get directionLeftPreview => '← Izquierda · 270°';

  @override
  String customDirection(Object angle) {
    return 'Dirección personalizada · $angle°';
  }

  @override
  String get referenceOpeningConnected =>
      'La abertura ya conecta otro ambiente.';

  @override
  String get needThreeCornersToCloseMessage =>
      'Necesitás al menos 3 esquinas para cerrar el ambiente.';

  @override
  String get closeRoomFailedFallback => 'No se pudo cerrar el ambiente.';

  @override
  String get saveRoomFailed =>
      'No se pudo guardar el ambiente. Revisá los solapamientos y volvé a intentar.';

  @override
  String get scanErrorNoActiveRoom => 'No hay un ambiente en curso.';

  @override
  String get scanErrorNeedWallBeforeOpening =>
      'Medí al menos una pared antes de agregar una abertura.';

  @override
  String get scanErrorInvalidOpeningHeights =>
      'La altura debe ser positiva y el antepecho no puede ser negativo.';

  @override
  String scanErrorOpeningTooNarrow(String minWidth) {
    return 'Ingresá un ancho mínimo de $minWidth.';
  }

  @override
  String get scanErrorInvalidWallIndex => 'La pared seleccionada no es válida.';

  @override
  String get scanErrorNoValidWall => 'No se encontró una pared válida.';

  @override
  String scanErrorEndpointsTooClose(String measuredWidth) {
    return 'Los dos puntos de la abertura están demasiado cerca. Medida detectada: $measuredWidth.';
  }

  @override
  String scanErrorOpeningExceedsWall(String openingWidth, String wallLength) {
    return 'La abertura mide $openingWidth, pero la pared mide $wallLength.';
  }

  @override
  String get scanErrorOpeningOverlaps =>
      'La abertura se superpone con otra puerta o ventana. Elegí otra posición sobre la pared.';

  @override
  String get scanErrorCloseSelfIntersection =>
      'El contorno se autointersecta. Revisá las paredes trazadas.';

  @override
  String get defaultProjectName => 'Mi Casa Completa';

  @override
  String scanWarningOpeningMeasured(String measuredWidth) {
    return 'Abertura medida: $measuredWidth.';
  }

  @override
  String get planErrorRoomNotFound => 'No se encontró el ambiente.';

  @override
  String get planErrorInvalidMeasurement => 'La medida no es válida.';

  @override
  String get planErrorEditCausesConflict =>
      'El cambio genera un cruce, solapamiento o modifica una conexión. Revisá el plano.';
}
