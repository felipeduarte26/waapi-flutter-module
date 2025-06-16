import 'collector_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class CollectorLocalizationsEs extends CollectorLocalizations {
  CollectorLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Marcação de Ponto Senior';

  @override
  String get helloWorld => '¡Hola Mundo!';

  @override
  String get dateFormatClock => 'd \'de\' MMMM \'de\' y';

  @override
  String get share => 'Compartir';

  @override
  String get close => 'Cerrar';

  @override
  String get appointmentReceipt => 'Comprobante de Marcación';

  @override
  String get cardReceiptData => 'Fecha';

  @override
  String get cardReceiptTime => 'Hora';

  @override
  String get cardReceiptZone => 'Zona';

  @override
  String get cardReceiptEmployeeName => 'Empleado';

  @override
  String get cardReceiptEmployeeCPF => 'CPF';

  @override
  String get cardReceiptCompanyName => 'Empresa';

  @override
  String get cardReceiptCompanyCNPJ => 'CNPJ';

  @override
  String get cardReceiptIdentification => 'Identificador de marcación';

  @override
  String get hoursWorked => 'Horas trabajadas hoy';

  @override
  String get breaks => 'Intervalos';

  @override
  String get lastClockingevent => 'Última marcación';

  @override
  String get lastClockingevents => 'Últimas marcaciones';

  @override
  String get breakTime => 'Intervalo de %t';

  @override
  String get whenRegistered => 'Cuando se registren, aparecerán aquí';

  @override
  String get todaysClockinEvents => 'Marcaciones de hoy';

  @override
  String get noClockingEvents => 'No hay marcaciones registradas hoy.';

  @override
  String get loading => 'Cargando...';

  @override
  String get deviceSituation => 'Novedad del dispositivo';

  @override
  String get goToLogin => 'Salir';

  @override
  String get deviceAuthorizationIsPending => 'La función Punto no está activada para este dispositivo debido a una autorización pendiente de RH.';

  @override
  String get deviceAuthorizationWasRejected => 'La función Punto no está activada para este dispositivo debido a autorización rechazada por RH.';

  @override
  String get deviceActivationIsPending => 'La función Punto no está activada para este dispositivo debido a una activación pendiente por parte de RH.';

  @override
  String get deviceActivationWasRejected => 'La función Punto no está activada para este dispositivo debido a una activación rechazada por RH.';

  @override
  String get clockingEventSingleNotAvailable => 'La marcación del punto no está disponible para el modo individual para su usuario';

  @override
  String get contactRh => 'Por favor, contacte con el RRHH y/o diríjase a un dispositivo colectivo para registrar el punto.';

  @override
  String get clockingEvents => 'Marcaciones';

  @override
  String rangeDate(String fromDate, String toDate) {
    return '$fromDate hasta $toDate';
  }

  @override
  String get menuItemHome => 'Inicio';

  @override
  String get menuItemAppointment => 'Marcaciones';

  @override
  String get menuItemTime => 'Horas';

  @override
  String get menuItemProfile => 'Perfil';

  @override
  String get clockingEventTitle => 'Punto';

  @override
  String get clockingEventGoodMorning => 'Buenos días';

  @override
  String get clockingEventGoodAfternoon => 'Buenas tardes';

  @override
  String get clockingEventGoodEvening => 'Buenas noches';

  @override
  String get clockingEventCaptureTime => 'Registrar punto';

  @override
  String get clockingEventCapturingTime => 'Realizando marcación';

  @override
  String get clockingEventKeepButtonPressedToRegister => 'Mantenga pulsado el botón para registrar';

  @override
  String get clockingEventAppointmentMade => 'Marcación hecha';

  @override
  String get clockingEventSeeReceipt => 'Ver comprobante';

  @override
  String get withoutClockingEvents => 'Sin marcaciones';

  @override
  String get dateFormatter => 'dd/MM/yyyy';

  @override
  String get period => 'Período';

  @override
  String get oddClockingEvent => 'Marcaciones impares';

  @override
  String get periodClockingEvent => 'Marcaciones del período';

  @override
  String lastUpdate(String date, String hour) {
    return 'Última actualización $date a la(s) $hour';
  }

  @override
  String get clockInfoTitle1 => 'Marcación no sincronizada';

  @override
  String get clockInfoDescription1 => 'Son marcaciones que fueron registradas y se sincronizarán tan pronto como haya una conexión a Internet.';

  @override
  String get clockInfoTitle2 => 'Origen vía móvil y plataforma';

  @override
  String get clockInfoDescription2 => 'Son marcaciones que fueron registradas vía aplicación y plataforma. Se clasifican como marcación cross.';

  @override
  String get clockInfoTitle3 => 'Origen vía móvil';

  @override
  String get clockInfoDescription3 => 'Son marcaciones que fueron registradas vía aplicación, tanto Punto como Waapi.';

  @override
  String get clockInfoTitle4 => 'Origen vía plataforma';

  @override
  String get clockInfoDescription4 => 'Son marcaciones que fueron registradas vía plataforma';

  @override
  String get clockInfoTitle5 => 'Marcación Manual';

  @override
  String get clockInfoDescription5 => 'Marcación registrada manualmente por el gestor o empleado a través del app o plataforma.';

  @override
  String get clockInfoTitle6 => 'Marcaciones impares';

  @override
  String get clockInfoDescription6 => 'Significa que falta una marcación para que su jornada laboral esté completa, pero puede haberse realizado en otro registrador de punto.';

  @override
  String get clockInfoTitle7 => 'Marcación con ausentismo';

  @override
  String get clockInfoDescription7 => 'Son marcaciones que tienen algún ausentismo registrado en la jornada laboral.';

  @override
  String get infoUnderstoodButton => 'Entendí';

  @override
  String get registerCameraButton => 'Registrar';

  @override
  String get clockingsOfTheDay => 'Marcaciones del día';

  @override
  String get addClocking => 'Agregar marcación';

  @override
  String get timeControlManagement => 'Gestión del Punto';

  @override
  String get centralizingJourney => 'Centralizando la jornada del empleado';

  @override
  String get haveControl => 'Tenga el control de su jornada del punto.';

  @override
  String get shortcutsTimeControl => 'Acceso directo al Gestión del Punto';

  @override
  String get recentClockingEventMessage => 'Usted ha marcado el punto hace menos de 2 minutos. ¿Desea realizar otra marcación?';

  @override
  String get outsideTheFenceMessage => 'La ubicación actual está fuera del perímetro definido por su empleador. ¿Desea continuar?';

  @override
  String get alert => 'Atención';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get confirmAppointment => 'Confirmar marcación';

  @override
  String get cancelAppointment => 'No realizar marcación';

  @override
  String get hoursWorkedTodayInfo => 'Se calcula la cantidad de horas cuando hay marcaciones en pares (entrada y salida), así que solo se actualiza el total al registrar el fin de un período.';

  @override
  String get syncClockingEventSyncSuccess => 'Sincronización concluda.';

  @override
  String get syncClockingEventSyncInternetUnavailable => 'Sincronización no ha concluido. Verifique su conexión con la internet.';

  @override
  String get syncClockingEventSyncFailure => 'Perdón, la sincronización ha fallado. Intentélo oyta vez.';

  @override
  String get syncClockingEventSyncPartialSuccess => 'Sincronização concluída parcialmente. Alguns registros não foram sincronizados. Verifique sua conexão com a internet e tente novamente.';

  @override
  String get configurations => 'Configuración';

  @override
  String get completedAppointments => 'Marcaciones realizadas';

  @override
  String get setKey => 'Configurar clave de aplicación';

  @override
  String get permissions => 'Permisos';

  @override
  String get syncAppointInfo => 'Sincronizar información del punto';

  @override
  String get resources => 'Recursos';

  @override
  String get facialRecognitionRegistration => 'Registro de reconocimiento facial';

  @override
  String get facialRecognitionRegistrationDescription => 'Registrar reconocimiento facial de un nuevo empleado';

  @override
  String get readWebQRCode => 'Leer QR Code Web';

  @override
  String get readWebQRCodeDescription => 'Usar dispositivo para registrar reconocimiento facial de un nuevo empleado';

  @override
  String get othersResources => 'Otros';

  @override
  String get help => 'Ayuda';

  @override
  String get helpCenter => 'Central de ayuda';

  @override
  String get viewTourAgain => 'Ver tour novamente';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get about => 'Sobre';

  @override
  String get signOut => 'Salir';

  @override
  String get clockingEventNotAvailable => 'La marcación de punto no está disponible para su usuario.';

  @override
  String get descriptionClockingEventNotAvailable => 'Por favor, espere o contacte con RRHH para saber más.';

  @override
  String get toView => 'Ver';

  @override
  String successClockingEvent(String hour, String date, String name) {
    return 'Marcación realizada a la(s) $hour en del $date para $name';
  }

  @override
  String get configurationReminders => 'Configurar recordatorio del punto';

  @override
  String get configurationNotifications => 'Configurar notificaciones';

  @override
  String get configurationRegisteredClock => 'Marcaciones registradas';

  @override
  String get configurationReports => 'Informes';

  @override
  String get configurationAppReview => 'Evaluación de la aplicación';

  @override
  String get configurationSearch => 'Búsqueda';

  @override
  String get configurationViewTourAgain => 'Ver gira nuevamente';

  @override
  String get configurationSynchronizationSuccessfully => 'Sincronización realizada con éxito.';

  @override
  String get configurationSynchronizationError => 'No ha sido posible sincronizar la información del punto en el momento. Inténtelo de nuevo más tarde.';

  @override
  String get hoursTitle => 'Totalizador de horas';

  @override
  String get hoursTabTitle1 => 'Jornada do dia';

  @override
  String get hoursTabTitle2 => 'Saldo';

  @override
  String get hoursTabTitle3 => 'Espelho';

  @override
  String get facialTryAgain => 'Inténtalo de nuevo';

  @override
  String get facialRegistrationCompletedSuccessfully => '¡Registro realizado con éxito!';

  @override
  String get facialBackStart => 'Volver al inicio de la página';

  @override
  String get facialPerformingPhotoAnalysis => 'Analizando la foto...';

  @override
  String get facialLooksLikeAreOffline => 'Sin conexión con la internet';

  @override
  String get facialRegistrationOnlineCheckConnection => 'El registro inicial debe hacerse en línea. Verifique su conexión y inténtelo de nuevo.';

  @override
  String get facialCheckingInformation => 'Verificación de la información...';

  @override
  String get facialTipsFacialRecognition => 'Consejos para el reconocimiento facial';

  @override
  String get facialFollowInstructionsCapture => 'Siga las instrucciones para una buena captura';

  @override
  String get facialPositionCellPhoneEyeCamera => 'Coloque el teléfono celular a la altura de los ojos y mire directamente a la cámara;';

  @override
  String get facialBeBrightEnvironmentPeopleBackground => 'Sitúese en un entorno bien iluminado, sin personas ni objetos de fondo;';

  @override
  String get facialAvoidWearingAccessoriesGlasses => 'Evite llevar accesorios que oculten su rostro, como gafas, gorras, máscaras y sombreros;';

  @override
  String get facialAvoidShakingYourCellPhone => 'Evite agitar el teléfono celular durante la captura;';

  @override
  String get facialAvoidMakingFacesOrExpressions => 'Evite hacer muecas o expresiones que puedan interferir en la calidad de la captura;';

  @override
  String get facialIfNecessaryAskHelpCamera => 'Si es necesario, pida ayuda a otra persona y active la cámara trasera de su celular.';

  @override
  String get facialStartReconnaissance => 'Empezar reconocimiento';

  @override
  String get facialPhotoCapture => 'Captura de la foto';

  @override
  String get facialPositionFaceToCapture => 'Posicione su rostro a capturar';

  @override
  String get facialFacialRecognition => 'reconocimiento facial';

  @override
  String get facialFacialRecognitionMultiMode => 'Registro por rostro';

  @override
  String get recognitionMultiModeInProgress => 'Espere...';

  @override
  String get recognitionMultiModeDoSync => 'No encontramos rostros registrados. Regístrelos o sincronízalos para proceder con la marcación.';

  @override
  String get facialModalAlertTitle => '¿Está seguro de que desea registrarse sin reconocimiento facial?';

  @override
  String get facialModalAlertTryOtherWay => 'Inténtalo de otra manera';

  @override
  String get facialModalAlertTryOtherWayDescription => 'Si no logra realizar el registro por reconocimiento facial, intente otra forma de registrar su marcación.';

  @override
  String get facialModalAlertContent => 'La marcación de punto se realizará sin el registro del reconocimiento facial.';

  @override
  String get facialModalAlertBackButton => 'Volver';

  @override
  String get facialModalAlertProceedButton => 'Registrar sin rostro';

  @override
  String get facialInitTechnologyTitle => 'Inicializando la tecnología';

  @override
  String get facialInitTechnologyContent => 'Mientras se inicializa la tecnología de reconocimiento facial, la marcación de punto se hará sin identificación facial.';

  @override
  String get facialRecognitionRegistrationQuestion => '¿Registrar reconocimiento facial?';

  @override
  String get facialRecognitionRegistrationInformation => 'Aún no ha registrado su rostro para el registro de punto con reconocimiento facial. Regístrese ahora y asegúrese de que sus datos están más seguros y son más rápidos.';

  @override
  String get facialRegisterNow => 'Regístrese ahora';

  @override
  String get facialCouldNotanalyzePhoto => 'No ha sido posible analizar la foto';

  @override
  String get facialTryAgainLater => 'Vuelva a intentarlo o espere unos instantes para repetir la acción.';

  @override
  String get facialNotIdentifiedFace => 'Rostro no identificado';

  @override
  String get facialLowQualityPhoto => 'La foto es de baja calidad o está borrosa.';

  @override
  String get facialFaceIsntVisible => 'Asegúrese de que su rostro está visible y dentro del encuadre e inténtelo de nuevo.';

  @override
  String get facialRecognitionRegistrationSoonAvailable => 'La marcación por reconocimiento facial estará disponible en unos minutos.';

  @override
  String get facialFaceAlreadyRegistered => '¡Rostro ya registrado!';

  @override
  String get facialRecognitionRegistrationAvailable => 'La marcación por reconocimiento facial ya está disponible.';

  @override
  String get facialRecognitionRegistrationEmployee => 'Registro reconocimiento facial';

  @override
  String get facialSelectEmployeeTitle => 'Seleccione el empleado que desea registrar el reconocimiento facial';

  @override
  String get enterRrSearchForTheCollaborator => 'Digite o busque el empleado';

  @override
  String get employeeList => 'Lista de empleados';

  @override
  String get continueText => 'Continuar';

  @override
  String get collaborator => 'Empleado';

  @override
  String get userWithoutPermission => 'Usuario sin permiso';

  @override
  String get userWithoutPermissionDescription => 'Póngase en contacto con RRHH para verificar el permiso de su usuario.';

  @override
  String get unresponsiveService => 'Servicio sin respuesta';

  @override
  String get unresponsiveServiceDescription => 'No ha sido posible establecer la conexión con el servicio de marcación de punto.';

  @override
  String get facialUserNoPermissionTitle => 'Usuario sin permiso';

  @override
  String get facialUserNoPermissionMessage => 'Por favor, póngase en contacto con RRHH para verificar el permiso de su usuario.';

  @override
  String get registerWithoutConfirm => '¿Está seguro que desea registrar sin la confirmación?';

  @override
  String get willRegisterWithoutPhoto => 'El registro del punto será realizado sin la confirmación de la foto.';

  @override
  String get registerWithoutPhoto => 'Registrar sin foto';

  @override
  String get reRegister => 'Volver a registrar';

  @override
  String get permissionCameraNotAllowedMessage => 'Para utilizar el reconocimiento facial y la captura de fotos después de marcar, es necesario permitir el acceso a la cámara del dispositivo. Esta información no es obligatoria, pero complementa su registro.';

  @override
  String get permissionLocationNotAllowedMessage => 'Recomendamos añadir la dirección a su marcación de punto. Para eso, es necesario permitir acceso a la localización del dispositivo. Esta información no es obligatoria, pero complementa su registro.';

  @override
  String get goToConfiguration => 'Permisos';

  @override
  String get continueAction => 'Continuar';

  @override
  String get deviceSettings => 'Configuración del dispositivo';

  @override
  String get setPushNotification => 'Configurar las notificaciones push';

  @override
  String get appReview => 'Evaluación de la app';

  @override
  String get searchApp => 'Encuesta';

  @override
  String get applicationKeyHelpTitle => 'Entienda la configuración de clave para el dispositivo móvil';

  @override
  String get applicationKeyHelpContent1 => 'Registre la clave de aplicación en la Plataforma Senior X';

  @override
  String get applicationKeyHelpContent2 => 'Introduzca la información de clave y secreto para la aplicación registrada, que será responsable por la comunicación de la Plataforma Senior X con el Control de Asistencia 2.0;';

  @override
  String get applicationKeyHelpContent3 => 'Si está seguro de que la información es correcta y sigue teniendo problemas para acceder a la aplicación, consulte con el departamento de RRHH de su empresa.';

  @override
  String get keyAlreadyRegistered => '¡Clave ya registrada!';

  @override
  String get registerNewkey => 'Registrar nueva clave';

  @override
  String get keyAlreadyRegisteredDescription => 'Usted puede eliminar la clave con la acción abajo.';

  @override
  String get keyAlreadyRegisteredRemove => 'Eliminar clave';

  @override
  String get helpTextDocumentationPortal => 'Portal de documentación';

  @override
  String get keyRegisteredSuccessfully => '¡Clave regitrada con éxito!';

  @override
  String get keyRegisteredSuccessfullyDescription => 'Los recursos estarán disponibles para uso en el inicio.';

  @override
  String get keyRegisteredSuccessfullyBackHome => 'Volver al inicio';

  @override
  String get searchEmployee => 'Buscar empleado';

  @override
  String get selectPeriodToFilter => 'Seleccione un período para filtrar';

  @override
  String get change => 'Cambiar';

  @override
  String get init => 'Inicial';

  @override
  String get end => 'Final';

  @override
  String get filter => 'Filtrar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get invalidDate => 'Fecha inválida';

  @override
  String get invalidDateFormat => 'Formato de fecha inválido';

  @override
  String get moreThanEndDate => 'Superior a la fecha final';

  @override
  String get lessThanStartDate => 'Inferior a la fecha inicial';

  @override
  String get driversJourney => 'Jornada del conductor';

  @override
  String get workStatus => 'Status de trabajo';

  @override
  String get notStarted => 'No iniciado';

  @override
  String get working => 'Trabajando';

  @override
  String get driving => 'Conduciendo';

  @override
  String get mandatoryBreak => 'Pausa obligatoria';

  @override
  String get foodTime => 'Intervalo';

  @override
  String get waiting => 'Espera';

  @override
  String get actions => 'Acciones';

  @override
  String get startDrivingWithLineBreak => 'Iniciar\ndirección';

  @override
  String get startMandatoryBreakWithLineBreak => 'Iniciar pausa\nobligatoria';

  @override
  String get startWaitingWithLineBreak => 'Iniciar\nespera';

  @override
  String get startFoodTimeWithLineBreak => 'Iniciar\nintervalo';

  @override
  String get startJourney => 'Iniciar jornada';

  @override
  String get newJourney => 'Nueva jornada';

  @override
  String get stopDriving => 'Cerrar dirección';

  @override
  String get stopMandatoryBreak => 'Cerrar pausa';

  @override
  String get stopFoodTime => 'Cerrar intervalo';

  @override
  String get stopWaiting => 'Cerrar espera';

  @override
  String get journeyStart => 'Inicio de la jornada';

  @override
  String get numberOfPauses => 'Número de pausas';

  @override
  String get totalWorked => 'Total trabajado';

  @override
  String get totalWorkedInfo => 'Tiempo total trabajado actualizado desde el inicio del viaje hasta el día de hoy. No incluye pausas obligatorias ni comidas. Si el valor total está a cero y en rojo, significa que el viaje contiene reservas impares.';

  @override
  String get timeInWorking => 'Tiempo trabajando';

  @override
  String get timeInDriving => 'Tiempo conduciendo';

  @override
  String get timeInMandatoryBreak => 'Tiempo en pausa obligatoria';

  @override
  String get timeInFoodTime => 'Tiempo en intervalo';

  @override
  String get timeInWaiting => 'Tiempo en espera';

  @override
  String get hours => 'horas';

  @override
  String get minutes => 'min';

  @override
  String get seconds => 'seg';

  @override
  String get workingStatusDescription => 'Jornada laboral transcurrida desde el inicio de la jornada, independientemente de los status específicos que se hayan registrado.';

  @override
  String get deviceLocation => 'Localización de dispositivos';

  @override
  String get deviceLocationDescription => 'Permite determinar la localización geográfica del dispositivo en el momento de las marcaciones.';

  @override
  String get drive => 'Dirección';

  @override
  String get drivingStatusDescription => 'Tiempo de conducción del vehículo durante el día.';

  @override
  String get mandatoryBreakStatusDescription => 'El descanso obligatorio es importante para prevenir la fatiga y asegurar viajes más seguros, se cuenta como parte de su viaje.';

  @override
  String get foodTimeOrBreaks => 'Alimentación o intervalos';

  @override
  String get foodTimeStatusDescription => 'Como el descanso, los intervalos principales para alimentación son importantes para evitar el cansancio y la fatiga. Estos intervalos no cuentan como tiempo trabajado.';

  @override
  String get waitingTime => 'Tiempo de espera';

  @override
  String get waitingStatusDescription => 'Los períodos de espera indican un período sin movimiento del vehículo, pero que requieren el acompañamiento del conductor, como fila de báscula, carga y descarga del camión, entre otros.';

  @override
  String get overnight => 'Pernoctación';

  @override
  String get overnightDescription => 'Registra la estada/pernoctación durante un viaje más larga para descanso entre una jornada y otra.';

  @override
  String get paidBreak => 'Descanso pago';

  @override
  String get paidBreakStatusDescription => 'Este intervalo se considera como tiempo de trabajo y, por lo tanto, no resulta en una reducción del salario del empleado.';

  @override
  String get mainTimeClocking => 'Marcación de punto';

  @override
  String get mainTimeClockingDescription => 'Marcaciones de punto (de entrada o salida) registradas.';

  @override
  String get hoursWorkedInfo => 'Total actualizado al registrar la entrada y la salida. Incluye el tiempo de trabajo, de conducción y de espera.';

  @override
  String get timeInBreaks => 'Tiempo en intervalos';

  @override
  String get breaksInfo => 'Total actualizado al registrar inicio y fin. Incluye descanso obligatorio y alimentación.';

  @override
  String get moreDetails => 'Más detalles';

  @override
  String betweenTimes(String startTime, String endTime, String totalTime) {
    return 'De $startTime hasta $endTime, total de $totalTime';
  }

  @override
  String get totalsOfTheDay => 'Totalizadores del día';

  @override
  String get foodTimeStatusDescriptionModal => 'El intervalo dentro de una jornada es normalmente destinado para alimentación, pero también es muy importante para evitar la fatiga. En algunas jornadas puede haber más de un intervalo.';

  @override
  String get wasThisInformationHelpful => '¿Esta información ha sido útil?';

  @override
  String get enableLogs => 'Habilitar registros';

  @override
  String get disableLogs => 'Desactivar registros';

  @override
  String get logsDisabled => 'Registros deshabilitados';

  @override
  String get logsEnabled => 'Registros habilitados';

  @override
  String get sendLogs => 'Enviar registros';

  @override
  String get successfulSyncLogs => 'Sincronización exitosa de registros';

  @override
  String get partialSuccessSyncLogs => 'Sincronización parcial de registros';

  @override
  String get faliedSyncLogs => 'No se pudieron sincronizar los registros';

  @override
  String get unexpectedErrorSyncLogs => 'Error inesperado al sincronizar registros';

  @override
  String get notLogsToSync => 'No hay registros para sincronizar';

  @override
  String get aboutScreenAppTitle => 'Aplicación';

  @override
  String get aboutScreenVersion => 'Versión';

  @override
  String get aboutScreenDeviceTitle => 'Dispositivo';

  @override
  String get aboutScreenIdentifier => 'Identificador';

  @override
  String get aboutScreenModel => 'Modelo';

  @override
  String get aboutScreenName => 'Nombre';

  @override
  String get aboutScreenDevelopedBy => 'Desarrollado por';

  @override
  String get removeFilter => 'Borrar';

  @override
  String get checkConnectivityForKeys => 'La clave de la aplicación se debe gestionar en línea. Verifique su conexión e inténtelo de nuevo.';

  @override
  String get selectTheStartingDate => 'Seleccione la fecha de inicio';

  @override
  String get selectTheEndDate => 'Seleccione la fecha final';

  @override
  String reminderClockingEventMessageIntraJourney(Object reminderTime) {
    return 'Usted registró el punto hace menos de $reminderTime. Durante las pausas de descanso y alimentación, es importante completar el período mínimo antes de regresar al trabajo.';
  }

  @override
  String reminderClockingEventMessageInterJourney(Object reminderTime) {
    return 'Usted registró el punto hace menos de $reminderTime. Durante el descanso entre jornadas, es importante completar el período mínimo antes de regresar al trabajo.';
  }

  @override
  String get warning => 'Aviso';

  @override
  String get registerKeyOnSyncLogs => 'Solo envía registros con la clave de aplicación configurada';

  @override
  String get hasNoConnectivityToSync => 'Sin conexión para sincronizar datos.';

  @override
  String get unableToSyncClockingEvents => 'No es posible sincronizar las marcaciones';

  @override
  String get syncUnsuccessful => 'Sincronización fallida';

  @override
  String reason(String reason) {
    return 'Motivo:\n$reason';
  }

  @override
  String get unsyncedClockingEvents => 'Marcaciones no sincronizadas';

  @override
  String get syncClockingEventsBeforeRemoveKeys => 'Hay marcaciones no sincronizadas. Sincronícelas antes de retirar la clave.';

  @override
  String get confirmRemoveKeys => '¿Seguro que desea eliminarla?\nSu cuenta de empresa se desvinculará y toda la información de los empleados, así como las marcaciones, se eliminarán del dispositivo.';

  @override
  String get loadingUnsyncedClockingEvents => 'Buscando marcaciones no sincronizadas...';

  @override
  String get verifiyngConnectivity => 'Verificando conexión a Internet...';

  @override
  String get syncingClockingEvents => 'Sincronizando marcaciones...';

  @override
  String get removingKeys => 'Removendo claves...';

  @override
  String get keysNotRemoved => 'Claves no removidas';

  @override
  String get keysRemovedUnsuccessfully => 'No ha sido posible eliminar completamente las claves. Por favor, inténtelo de nuevo.';

  @override
  String get keysRemoved => 'Claves removidas';

  @override
  String get keysRemovedSuccessfully => 'Las claves fueron removidas con éxito.';

  @override
  String get initJourney => '¿Iniciar jornada?';

  @override
  String get initJourneyBeforeStartAction => 'Ninguna jornada en curso. ¿Desea iniciar una jornada antes de continuar?';

  @override
  String get initMyJourney => 'Iniciar mi jornada';

  @override
  String get manualRegistration => 'Registro manual';

  @override
  String get ok => 'Ok';

  @override
  String get continueRegistration => '¿Desea continuar el registro?';

  @override
  String get wantToStartJourney => '¿Desea iniciar la jornada?';

  @override
  String startJourneyBeforeStartAction(String action) {
    return 'Aún no ha marcado el inicio de la jornada. ¿Desea iniciar ahora antes de marcar $action?';
  }

  @override
  String journeyStartedBeforeAction(String actionLabel) {
    return 'Jornada y $actionLabel iniciado(a) con éxito.';
  }

  @override
  String actionStartedWithoutJourney(String actionLabel) {
    return '$actionLabel iniciado(a), pero la jornada no. Habrá que hacer un ajuste manual posteriormente.';
  }

  @override
  String finishCurrentActionBeforeStartNextAction(String currentActionLabel, String nextActionLabel) {
    return '¿Desea finalizar $currentActionLabel antes de iniciar $nextActionLabel en secuencia?';
  }

  @override
  String newActionStartedAndPreviousDoesNot(String newActionLabel, String previousActionLabel) {
    return '$newActionLabel iniciado(a) y $previousActionLabel no finalizado(a) por la aplicación. Ajústelo manualmente después si es necesario.';
  }

  @override
  String previousActionFinishedAndNewStarted(String previousActionLabel, String newActionLabel) {
    return '$previousActionLabel finalizado(a) y $newActionLabel iniciado(a) con éxito.';
  }

  @override
  String closeActionBeforeEndJourney(String actionLabel) {
    return '¿Desea finalizar $actionLabel antes de finalizar la jornada?';
  }

  @override
  String previousActionClosedAndJourneyEnded(String actionLabel) {
    return '$actionLabel y jornada finalizada con éxito.';
  }

  @override
  String journeyFinishedAndPreviousActionDoesNot(String actionLabel) {
    return 'Jornada finalizada, pero $actionLabel no. Habrá que hacer un ajuste manual posteriormente.';
  }

  @override
  String get finish => 'Finalizar';

  @override
  String get start => 'Iniciar';

  @override
  String get sureStartNewJourney => '¿Realmente desea iniciar una nueva jornada?';

  @override
  String get previousJourneyStillRunning => 'La jornada anterior aún está en curso. Si continúa, la marcación de finalización deberá ser introducida manualmente posteriormente.';

  @override
  String get finishJourney => 'Finalizar jornada';

  @override
  String get wantRegisterOvernight => '¿Desea registrar pernoctación?';

  @override
  String get reportOvernightAfterJourney => 'En caso necesario, introduzca la ocurrencia de pernoctación para descanso después de esa jornada.';

  @override
  String get registerOvernight => 'Registrar pernoctación';

  @override
  String get startOf => 'Comienzo del ';

  @override
  String get endOf => 'Fin del ';

  @override
  String get work => 'Trabajo';

  @override
  String get abbreviatedHour => 'h';

  @override
  String get addOvernightButton => 'Agregar pernoite';

  @override
  String get overnightAddedSuccessfully => 'Pernocte agregado con éxito';

  @override
  String get overnightAddedError => 'Añadir pernoite';

  @override
  String get journey => 'Jornada';

  @override
  String get cameraPermission => 'Cámara';

  @override
  String get cameraPermissionDescription => 'Permiso para acceder a la cámara. Usamos esta función para capturar una foto del empleado, leer un código QR o realizar reconocimiento facial.';

  @override
  String get gpsPermission => 'GPS';

  @override
  String get gpsPermissionDescription => 'Permiso para acceder al GPS. Utilizamos esta función para identificar el lugar donde se registran las marcaciones.';

  @override
  String get nfcPermission => 'NFC';

  @override
  String get nfcPermissionDescription => 'Función NFC, utilizamos esta función cuando el empleador activa el modo de aproximación para poder registrar marcaciones.';

  @override
  String get deviceConfigurationPermission => 'Permisos del dispositivo';

  @override
  String get privacyCenter => 'Centro de privacidad';

  @override
  String get privacyPolicies => 'Políticas de privacidad';

  @override
  String get info => 'Información';

  @override
  String get viewDate => 'Fecha de visualización';

  @override
  String get facialRegistrationCompleted => 'Marcación realizada';

  @override
  String get facialCaceledRegistration => 'Marcación cancelada';

  @override
  String get facialRegistering => 'Espere...';

  @override
  String get facialCollaboratorNotFound => 'Empleado no encontrado o inactivo';

  @override
  String get noFaceRegistered => 'No hay rostro registrado';

  @override
  String get offlineFeatureUnavailable => 'Esta funcionalidad no está disponible mientras estás desconectado. Comprueba tu conexión';

  @override
  String get titleNotifications => 'Notificaciones';

  @override
  String get notificationErrorNextPage => 'Ocurrió un error al cargar las próximas notificaciones. Toque en Repetir para intentar nuevamente.';

  @override
  String get repeat => 'Repetir';

  @override
  String get notificationErrorState => 'No ha sido posible obtener sus notificaciones';

  @override
  String get notificationErrorStateDescription => 'El sistema presentó un error interno y, por eso, no ha sido posible recuperar sus notificaciones. Aguarde un rato y para repetir esta acción, pulse sobre Reintentar.';

  @override
  String get notificationNotReceivedTitle => 'Usted aún no recibió notificaciones.';

  @override
  String get notificationNotReceivedDescription => 'Cuando recibes una notificación, estará disponible aquí para su consulta.';

  @override
  String get latestNotifications => 'Últimas notificaciones';

  @override
  String get optionCancel => 'Cancelar';

  @override
  String get errorMarkNotificationAsRead => 'Ocurrió un error al marcar su notificación como leída. Toque en Repetir para intentar nuevamente.';

  @override
  String get featureIsNotAvailableOffline => 'Esta función no está disponible sin conexión. Comprueba tu conexión.';

  @override
  String get selectItem => 'Seleccionar';

  @override
  String get facialMsgStatusVeryBlurryImage => 'La foto está desenfocada o la cara está en movimiento. Vuelva a intentarlo.';

  @override
  String get facialMsgStatusMoreThanOneFaceFoundInTheImage => 'Solo debe aparecer una cara en la foto de registro.';

  @override
  String get facialMsgStatusFacesNotFoundInTheImage => 'No se ha encontrado ningún rostro con aparición suficiente en la imagen. Vuelva a intentarlo.';

  @override
  String get facialMsgStatusNonFrontalFace => 'Coloca la cara hacia delante y mira directamente a la cámara.';

  @override
  String get facialMsgStatusPoorQualityImage => 'La imagen tiene baja resolución, ruido o iluminación inadecuada.';

  @override
  String get facialMsgStatusVerySmallFaceInTheImage => 'Acerque la cara a la cámara.';

  @override
  String get facialMsgStatusFaceTooCloseToTheEdgeOfTheImage => 'Centre su cara en la pantalla e inténtelo de nuevo.';

  @override
  String get facialMsgStatusEvidenceOfFraud => 'La imagen no cumple los requisitos de autenticidad. Vuelva a intentarlo.';

  @override
  String get facialMsgStatusIdsWithCloseImagesWereFound => ' La cara se parece a otra persona de la base de datos. Evite el doble registro.';

  @override
  String get facialMsgStatusGlassesDetectedOrTooMuchEyeShadow => 'Quítese las gafas o ajuste la iluminación para evitar sombras en los ojos.';

  @override
  String get facialMsgStatusLowConfidenceFaceDetection => 'El sistema no pudo detectar una cara con suficiente confianza. Vuelva a intentarlo.';

  @override
  String get facialTitleStatusVeryBlurryImage => 'Imagen muy borrosa';

  @override
  String get facialTitleStatusMoreThanOneFaceFoundInTheImage => 'Más de una cara detectada';

  @override
  String get facialTitleStatusFacesNotFoundInTheImage => 'Cara no detectada';

  @override
  String get facialTitleStatusNonFrontalFace => 'Cara fuera de posición';

  @override
  String get facialTitleStatusPoorQualityImage => 'Mala calidad de image';

  @override
  String get facialTitleStatusVerySmallFaceInTheImage => 'Cara pequeña en la imagen';

  @override
  String get facialTitleStatusFaceTooCloseToTheEdgeOfTheImage => 'Cara próxima al borde';

  @override
  String get facialTitleStatusEvidenceOfFraud => 'Posible fraude detectado';

  @override
  String get facialTitleStatusIdsWithCloseImagesWereFound => 'Semejanza con otras caras';

  @override
  String get facialTitleStatusGlassesDetectedOrTooMuchEyeShadow => 'Gafas o sombras en los ojos';

  @override
  String get facialTitleStatusLowConfidenceFaceDetection => 'Baja confianza en la cara';

  @override
  String get privacy_police_change => 'Actualizamos nuestra política de privacidad';

  @override
  String get privacy_police_change_subtitle => 'Haga clic para verla o consúltela en cualquier momento en el menú Configuración > Política de privacidad.';

  @override
  String get reRegisterApplicationKey => 'Consultar clave de aplicación';

  @override
  String get errorAuthenticatingApplicationKey => 'Error al autenticar la clave de aplicación.';

  @override
  String get authenticating => 'Autenticando...';

  @override
  String get authenticationFailure => 'Error de Autenticación';

  @override
  String get errorWhileAuthenticatingApplicationKey => 'Ha ocurrido un error al autenticar la clave de aplicación registrada en este dispositivo.';

  @override
  String get recognitionBlocked => 'Reconocimiento bloqueado, por favor espere';

  @override
  String get secondsFullName => 'segundos';

  @override
  String get totalTimeSinceLastJourney => 'Tiempo desde la última jornada';

  @override
  String get userNameScreenTitle => 'Iniciar sesión con credenciales';
}
