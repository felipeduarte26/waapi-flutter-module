import 'collector_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CollectorLocalizationsEn extends CollectorLocalizations {
  CollectorLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Marcação de Ponto Senior';

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get dateFormatClock => 'MMM d, yyyy';

  @override
  String get share => 'Share';

  @override
  String get close => 'Close';

  @override
  String get appointmentReceipt => 'Clocking event receipt';

  @override
  String get cardReceiptData => 'Date';

  @override
  String get cardReceiptTime => 'Time';

  @override
  String get cardReceiptZone => 'Time Zone';

  @override
  String get cardReceiptEmployeeName => 'Employee';

  @override
  String get cardReceiptEmployeeCPF => 'CPF';

  @override
  String get cardReceiptCompanyName => 'Company';

  @override
  String get cardReceiptCompanyCNPJ => 'CNPJ';

  @override
  String get cardReceiptIdentification => 'Clocking event identifier';

  @override
  String get hoursWorked => 'Hours worked today';

  @override
  String get breaks => 'Breaks';

  @override
  String get lastClockingevent => 'Last clocking event';

  @override
  String get lastClockingevents => 'Last clocking events';

  @override
  String get breakTime => '%t break';

  @override
  String get whenRegistered => 'When registered, they will appear here';

  @override
  String get todaysClockinEvents => 'Today\'s clocking events';

  @override
  String get noClockingEvents => 'No clocking events registered today.';

  @override
  String get loading => 'Loading...';

  @override
  String get deviceSituation => 'Device situation';

  @override
  String get goToLogin => 'Exit';

  @override
  String get deviceAuthorizationIsPending => 'The Time Control function is not activated for this device due to pending HR authorization.';

  @override
  String get deviceAuthorizationWasRejected => 'The Time Control function is not activated for this device due to authorization rejected by HR.';

  @override
  String get deviceActivationIsPending => 'The Time Control function is not activated for this device due to pending HR authorization.';

  @override
  String get deviceActivationWasRejected => 'The Time Control function is not activated for this device due to authorization rejected by HR.';

  @override
  String get clockingEventSingleNotAvailable => 'Clocking event is not available in individual mode for your user';

  @override
  String get contactRh => 'Please contact HR or go to a collective device to clock in.';

  @override
  String get clockingEvents => 'Clocking events';

  @override
  String rangeDate(String fromDate, String toDate) {
    return '$fromDate to $toDate';
  }

  @override
  String get menuItemHome => 'Home';

  @override
  String get menuItemAppointment => 'Clocking events';

  @override
  String get menuItemTime => 'Hours';

  @override
  String get menuItemProfile => 'Profile';

  @override
  String get clockingEventTitle => 'Clocking Event';

  @override
  String get clockingEventGoodMorning => 'Good morning';

  @override
  String get clockingEventGoodAfternoon => 'Good afternoon';

  @override
  String get clockingEventGoodEvening => 'Good evening';

  @override
  String get clockingEventCaptureTime => 'Register clocking event';

  @override
  String get clockingEventCapturingTime => 'Clocking event in progress';

  @override
  String get clockingEventKeepButtonPressedToRegister => 'Keep the button pressed to register';

  @override
  String get clockingEventAppointmentMade => 'Clocking event successful';

  @override
  String get clockingEventSeeReceipt => 'View statement';

  @override
  String get withoutClockingEvents => 'No clocking events';

  @override
  String get dateFormatter => 'MM/dd/yyyy';

  @override
  String get period => 'Period';

  @override
  String get oddClockingEvent => 'Odd clocking events';

  @override
  String get periodClockingEvent => 'Clocking events of the period';

  @override
  String lastUpdate(String date, String hour) {
    return 'Last updated on $date at $hour';
  }

  @override
  String get clockInfoTitle1 => 'Unsynchronized clocking event';

  @override
  String get clockInfoDescription1 => 'These are clocking events that were registered and will be synchronized as soon as an internet connection is available.';

  @override
  String get clockInfoTitle2 => 'Platform and cell phone origin';

  @override
  String get clockInfoDescription2 => 'These are clocking events registered via application and the platform. They are categorized as cross events.';

  @override
  String get clockInfoTitle3 => 'Cell phone origin';

  @override
  String get clockInfoDescription3 => 'These are clocking events registered via application, be it the Clocking Event app or Waapi.';

  @override
  String get clockInfoTitle4 => 'Platform origin';

  @override
  String get clockInfoDescription4 => 'These are clocking events registered via the platform.';

  @override
  String get clockInfoTitle5 => 'Manual clocking event';

  @override
  String get clockInfoDescription5 => 'A clocking event registered manually by the manager or employee through the app or platform.';

  @override
  String get clockInfoTitle6 => 'Odd clocking events';

  @override
  String get clockInfoDescription6 => 'It means there is one clocking event missing to complete your workday, but it may have been taken at another clocking event controller.';

  @override
  String get clockInfoTitle7 => 'Leave clocking events';

  @override
  String get clockInfoDescription7 => 'These are clocking events that have a leave registered in the workday.';

  @override
  String get infoUnderstoodButton => 'Understood';

  @override
  String get registerCameraButton => 'Register';

  @override
  String get clockingsOfTheDay => 'Clocking events of the day';

  @override
  String get addClocking => 'Add clocking event';

  @override
  String get timeControlManagement => 'Time Control Management';

  @override
  String get centralizingJourney => 'Centralizing the employee\'s journey';

  @override
  String get haveControl => 'Have control of your time control journey';

  @override
  String get shortcutsTimeControl => 'Shortcuts for Time Control Management';

  @override
  String get recentClockingEventMessage => 'You clocked in/out less than 2 minutes ago. Do you want to clock in/out again?';

  @override
  String get outsideTheFenceMessage => 'The current location is outside the perimeter defined by your employer. Do you wish to continue?';

  @override
  String get alert => 'Warning';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get confirmAppointment => 'Confirm clocking event';

  @override
  String get cancelAppointment => 'Do not clock in/out';

  @override
  String get hoursWorkedTodayInfo => 'The amount of hours is calculated when there are paired clocking events (clock-in and clock-out), so the total is updated only when recording the end of a period.';

  @override
  String get syncClockingEventSyncSuccess => 'Synchronization completed.';

  @override
  String get syncClockingEventSyncInternetUnavailable => 'Synchronization not completed. Check your internet connection.';

  @override
  String get syncClockingEventSyncFailure => 'Sorry, the synchronization has failed. Please try again.';

  @override
  String get syncClockingEventSyncPartialSuccess => 'Sincronização concluída parcialmente. Alguns registros não foram sincronizados. Verifique sua conexão com a internet e tente novamente.';

  @override
  String get configurations => 'Settings';

  @override
  String get completedAppointments => 'Clocking events made';

  @override
  String get setKey => 'Configure application key';

  @override
  String get permissions => 'Permissions';

  @override
  String get syncAppointInfo => 'Synchronize time information';

  @override
  String get resources => 'Features';

  @override
  String get facialRecognitionRegistration => 'Facial recognition registration';

  @override
  String get facialRecognitionRegistrationDescription => 'Register facial recognition for a new employee';

  @override
  String get readWebQRCode => 'Read WEB QRcode';

  @override
  String get readWebQRCodeDescription => 'Use device to register facial recognition of a new employee';

  @override
  String get othersResources => 'Other';

  @override
  String get help => 'Help';

  @override
  String get helpCenter => 'Help center';

  @override
  String get viewTourAgain => 'View tour again';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get about => 'About';

  @override
  String get signOut => 'Log out';

  @override
  String get clockingEventNotAvailable => 'The clocking event is not available to your user.';

  @override
  String get descriptionClockingEventNotAvailable => 'Please wait or contact HR for more information.';

  @override
  String get toView => 'View';

  @override
  String successClockingEvent(String hour, String date, String name) {
    return 'Clocking event made at $hour on $date for $name';
  }

  @override
  String get configurationReminders => 'Configure clocking event reminders';

  @override
  String get configurationNotifications => 'Configure settings';

  @override
  String get configurationRegisteredClock => 'Registered clocking events';

  @override
  String get configurationReports => 'Reports';

  @override
  String get configurationAppReview => 'App rating';

  @override
  String get configurationSearch => 'Search ';

  @override
  String get configurationViewTourAgain => 'View tour again';

  @override
  String get configurationSynchronizationSuccessfully => 'Synchronization successful.';

  @override
  String get configurationSynchronizationError => 'Could not synchronize the clocking events information at the moment. Please try again later.';

  @override
  String get hoursTitle => 'Totalizador de horas';

  @override
  String get hoursTabTitle1 => 'Jornada do dia';

  @override
  String get hoursTabTitle2 => 'Saldo';

  @override
  String get hoursTabTitle3 => 'Espelho';

  @override
  String get facialTryAgain => 'Try again';

  @override
  String get facialRegistrationCompletedSuccessfully => 'Registration successful!';

  @override
  String get facialBackStart => 'Back home';

  @override
  String get facialPerformingPhotoAnalysis => 'Analyzing photo...';

  @override
  String get facialLooksLikeAreOffline => 'No internet connection';

  @override
  String get facialRegistrationOnlineCheckConnection => 'The initial registration must be done connected to the internet. Check your connection and try again.';

  @override
  String get facialCheckingInformation => 'Verifying information...';

  @override
  String get facialTipsFacialRecognition => 'Facial recognition tips';

  @override
  String get facialFollowInstructionsCapture => 'Follow the instructions for a good capture';

  @override
  String get facialPositionCellPhoneEyeCamera => 'Position your cell phone at eye level and look directly to the camera;';

  @override
  String get facialBeBrightEnvironmentPeopleBackground => 'Stay in a well-lit environment, without people and objects in the background;';

  @override
  String get facialAvoidWearingAccessoriesGlasses => 'Avoid using accessories that hide your face, such as glasses, caps, masks and hats;';

  @override
  String get facialAvoidShakingYourCellPhone => 'Avoid shaking your cell phone during the capture;';

  @override
  String get facialAvoidMakingFacesOrExpressions => 'Avoid making expressions that may interfere in the quality of the capture;';

  @override
  String get facialIfNecessaryAskHelpCamera => 'If necessary, ask another person for help and activate the back camera of your cell phone.';

  @override
  String get facialStartReconnaissance => 'Start recognition';

  @override
  String get facialPhotoCapture => 'Photo capture';

  @override
  String get facialPositionFaceToCapture => 'Position your face to capture';

  @override
  String get facialFacialRecognition => 'Facial recognition';

  @override
  String get facialFacialRecognitionMultiMode => 'Register by face';

  @override
  String get recognitionMultiModeInProgress => 'Wait...';

  @override
  String get recognitionMultiModeDoSync => 'No registered faces were found. Perform face registration or synchronization to proceed with the clocking event.';

  @override
  String get facialModalAlertTitle => 'Are you sure you want to register without facial recognition?';

  @override
  String get facialModalAlertTryOtherWay => 'Try a different way';

  @override
  String get facialModalAlertTryOtherWayDescription => 'If you can\'t register using facial recognition, try a different way of registering your clocking event.';

  @override
  String get facialModalAlertContent => 'The clocking event will be done without the register of the facial recognition.';

  @override
  String get facialModalAlertBackButton => 'Go back';

  @override
  String get facialModalAlertProceedButton => 'Register without the face';

  @override
  String get facialInitTechnologyTitle => 'Initializing technology';

  @override
  String get facialInitTechnologyContent => 'While facial recognition technology is being initialized, clocking events will be done without face identification.';

  @override
  String get facialRecognitionRegistrationQuestion => 'Registering for facial recognition?';

  @override
  String get facialRecognitionRegistrationInformation => 'You haven\'t yet registered your face for clocking events with facial recognition. Register now and ensure your data is more secure and faster.';

  @override
  String get facialRegisterNow => 'Register now';

  @override
  String get facialCouldNotanalyzePhoto => 'Unable to analyze the photo';

  @override
  String get facialTryAgainLater => 'Try again or wait a few moments to repeat the action.';

  @override
  String get facialNotIdentifiedFace => 'Face not identified';

  @override
  String get facialLowQualityPhoto => 'The photo is low quality or blurry.';

  @override
  String get facialFaceIsntVisible => 'Make sure your face is visible and within the frame and try again.';

  @override
  String get facialRecognitionRegistrationSoonAvailable => 'In a few minutes, facial recognition clocking events will be available to you.';

  @override
  String get facialFaceAlreadyRegistered => 'Face already registered!';

  @override
  String get facialRecognitionRegistrationAvailable => 'Facial recognition clocking event is now available.';

  @override
  String get facialRecognitionRegistrationEmployee => 'Register facial recognition';

  @override
  String get facialSelectEmployeeTitle => 'Select the employee you want to register the facial recognition';

  @override
  String get enterRrSearchForTheCollaborator => 'Type in or search for the employee';

  @override
  String get employeeList => 'Employee list';

  @override
  String get continueText => 'Continue';

  @override
  String get collaborator => 'Employee';

  @override
  String get userWithoutPermission => 'User without permission';

  @override
  String get userWithoutPermissionDescription => 'Please contact HR to check your user\'s permission.';

  @override
  String get unresponsiveService => 'Unresponsive service';

  @override
  String get unresponsiveServiceDescription => 'Unable to establish a connection with the clocking events service.';

  @override
  String get facialUserNoPermissionTitle => 'User without permission';

  @override
  String get facialUserNoPermissionMessage => 'Please contact HR to check your user\'s permission.';

  @override
  String get registerWithoutConfirm => 'Register clocking event without confirmation?';

  @override
  String get willRegisterWithoutPhoto => 'Clocking event will be completed without photo confirmation.';

  @override
  String get registerWithoutPhoto => 'Register without photo';

  @override
  String get reRegister => 'Re-register';

  @override
  String get permissionCameraNotAllowedMessage => 'To use facial recognition and photo capture after clocking in, you must allow access to the device\'s camera. This information is not mandatory, but complements your entry.';

  @override
  String get permissionLocationNotAllowedMessage => 'We recommend adding the location to your clocking event and, to do so, you need to allow access to your device\'s location. This information is not mandatory, but it complements your entry.';

  @override
  String get goToConfiguration => 'Permissions';

  @override
  String get continueAction => 'Continue';

  @override
  String get deviceSettings => 'Device settings';

  @override
  String get setPushNotification => 'Configure push notifications';

  @override
  String get appReview => 'App evaluation';

  @override
  String get searchApp => 'Search';

  @override
  String get applicationKeyHelpTitle => 'Learn about the mobile device key configuration';

  @override
  String get applicationKeyHelpContent1 => 'Register the application key on the Senior X Platform';

  @override
  String get applicationKeyHelpContent2 => 'Add the key and secret information for the registered application, which will be responsible for the communication between the Senior X Platform and Clocking Event 2.0;';

  @override
  String get applicationKeyHelpContent3 => 'If you are sure that the information is correct and still having trouble signing in to the app, please verify this with the HR department of your company.';

  @override
  String get keyAlreadyRegistered => 'Key already registered!';

  @override
  String get registerNewkey => 'Register new key';

  @override
  String get keyAlreadyRegisteredDescription => 'You can remove the key with the action below.';

  @override
  String get keyAlreadyRegisteredRemove => 'Remove key';

  @override
  String get helpTextDocumentationPortal => 'Documentation Portal';

  @override
  String get keyRegisteredSuccessfully => 'Key successfully registered!';

  @override
  String get keyRegisteredSuccessfullyDescription => 'The resources will be available for use on the homepage.';

  @override
  String get keyRegisteredSuccessfullyBackHome => 'Back to homepage';

  @override
  String get searchEmployee => 'Search for an employee';

  @override
  String get selectPeriodToFilter => 'Select a period to filter';

  @override
  String get change => 'Change';

  @override
  String get init => 'Start';

  @override
  String get end => 'End';

  @override
  String get filter => 'Filter';

  @override
  String get cancel => 'Cancel';

  @override
  String get invalidDate => 'Invalid date';

  @override
  String get invalidDateFormat => 'Invalid date format';

  @override
  String get moreThanEndDate => 'Greater than end date';

  @override
  String get lessThanStartDate => 'Less than start date';

  @override
  String get driversJourney => 'Driver\'s shift';

  @override
  String get workStatus => 'Work status';

  @override
  String get notStarted => 'Not started';

  @override
  String get working => 'Working';

  @override
  String get driving => 'Driving';

  @override
  String get mandatoryBreak => 'Mandatory break';

  @override
  String get foodTime => 'Break';

  @override
  String get waiting => 'Waiting';

  @override
  String get actions => 'Actions';

  @override
  String get startDrivingWithLineBreak => 'Start\ndriving';

  @override
  String get startMandatoryBreakWithLineBreak => 'Start mandatory\nbreak';

  @override
  String get startWaitingWithLineBreak => 'Start\nwaiting';

  @override
  String get startFoodTimeWithLineBreak => 'Start\nBreak';

  @override
  String get startJourney => 'Start shift';

  @override
  String get newJourney => 'New shift';

  @override
  String get stopDriving => 'Stop driving';

  @override
  String get stopMandatoryBreak => 'Stop break';

  @override
  String get stopFoodTime => 'Stop Break';

  @override
  String get stopWaiting => 'Stop waiting';

  @override
  String get journeyStart => 'Shift start';

  @override
  String get numberOfPauses => 'Number of breaks';

  @override
  String get totalWorked => 'Total worked';

  @override
  String get totalWorkedInfo => 'Updated total time worked from the start of the day until now. Does not include mandatory breaks and meals. If the total value is zeroed and red, it means that the workday contains odd appointments.';

  @override
  String get timeInWorking => 'Time working';

  @override
  String get timeInDriving => 'Time driving';

  @override
  String get timeInMandatoryBreak => 'Time in mandatory break';

  @override
  String get timeInFoodTime => 'Break time';

  @override
  String get timeInWaiting => 'Time waiting';

  @override
  String get hours => 'hours';

  @override
  String get minutes => 'min';

  @override
  String get seconds => 'sec';

  @override
  String get workingStatusDescription => 'Work shift elapsed since the beginning, regardless of specific statuses that have been recorded.';

  @override
  String get deviceLocation => 'Device Location';

  @override
  String get deviceLocationDescription => 'Allows determining the geographic location of the device at the time of the clocking events.';

  @override
  String get drive => 'Driving';

  @override
  String get drivingStatusDescription => 'Vehicle driving time during the day\'s shift.';

  @override
  String get mandatoryBreakStatusDescription => 'Mandatory break is important to prevent fatigue and ensure safer travels, counted as part of your shift.';

  @override
  String get foodTimeOrBreaks => 'Meal or breaks';

  @override
  String get foodTimeStatusDescription => 'Like breaks, main meal breaks are important to avoid tiredness and fatigue. These breaks do not count as working time.';

  @override
  String get waitingTime => 'Waiting Time';

  @override
  String get waitingStatusDescription => 'Waiting periods indicate a vehicle stoppage period that requires driver supervision, such as at weigh stations, truck loading and unloading, among others.';

  @override
  String get overnight => 'Overnight';

  @override
  String get overnightDescription => 'Registers overnight stays during longer journeys for rest between shifts.';

  @override
  String get paidBreak => 'Paid Break';

  @override
  String get paidBreakStatusDescription => 'This break is considered working time and therefore does not result in a deduction from the employee\'s salary.';

  @override
  String get mainTimeClocking => 'Time Clocking';

  @override
  String get mainTimeClockingDescription => 'Clocking events (entry or exit) recorded.';

  @override
  String get hoursWorkedInfo => 'Updated total when clocking in and out. Includes working time, driving, and waiting.';

  @override
  String get timeInBreaks => 'Time in breaks';

  @override
  String get breaksInfo => 'Updated total when starting and ending breaks. Includes mandatory breaks and meals.';

  @override
  String get moreDetails => 'More details';

  @override
  String betweenTimes(String startTime, String endTime, String totalTime) {
    return 'From $startTime to $endTime, total $totalTime';
  }

  @override
  String get totalsOfTheDay => 'Daily totals';

  @override
  String get foodTimeStatusDescriptionModal => 'The interval within a shift is typically designated for meals, but it is also crucial for preventing fatigue. Some shifts may include more than one break.';

  @override
  String get wasThisInformationHelpful => 'Was this information helpful?';

  @override
  String get enableLogs => 'Enable logs';

  @override
  String get disableLogs => 'Disable logs';

  @override
  String get logsDisabled => 'Logs disabled';

  @override
  String get logsEnabled => 'Logs enabled';

  @override
  String get sendLogs => 'Send logs';

  @override
  String get successfulSyncLogs => 'Successful synchronizing logs';

  @override
  String get partialSuccessSyncLogs => 'Partial success when synchronizing logs';

  @override
  String get faliedSyncLogs => 'Failed to synchronize logs';

  @override
  String get unexpectedErrorSyncLogs => 'Unexpected error when synchronizing logs';

  @override
  String get notLogsToSync => 'There are no logs to synchronize';

  @override
  String get aboutScreenAppTitle => 'Application';

  @override
  String get aboutScreenVersion => 'Version';

  @override
  String get aboutScreenDeviceTitle => 'Device';

  @override
  String get aboutScreenIdentifier => 'Identifier';

  @override
  String get aboutScreenModel => 'Model';

  @override
  String get aboutScreenName => 'Name';

  @override
  String get aboutScreenDevelopedBy => 'Developed by';

  @override
  String get removeFilter => 'Clear';

  @override
  String get checkConnectivityForKeys => 'The application key must be managed online. Check your connection and try again.';

  @override
  String get selectTheStartingDate => 'Select the starting date';

  @override
  String get selectTheEndDate => 'Select the end date';

  @override
  String reminderClockingEventMessageIntraJourney(Object reminderTime) {
    return 'You clocked in less than $reminderTime hour(s) ago. During the break for rest and meals, it\'s important to complete the minimum period before returning to work.';
  }

  @override
  String reminderClockingEventMessageInterJourney(Object reminderTime) {
    return 'You clocked in less than $reminderTime hours ago. During the break between shifts, it\'s important to complete the minimum period before returning to work.';
  }

  @override
  String get warning => 'Warning';

  @override
  String get registerKeyOnSyncLogs => 'Only sends logs with configured application key';

  @override
  String get hasNoConnectivityToSync => 'No connection to perform data sync.';

  @override
  String get unableToSyncClockingEvents => 'Unable to sync clocking events';

  @override
  String get syncUnsuccessful => 'Sync unsuccessful';

  @override
  String reason(String reason) {
    return 'Reason:\n$reason';
  }

  @override
  String get unsyncedClockingEvents => 'Unsynced clocking events';

  @override
  String get syncClockingEventsBeforeRemoveKeys => 'There are unsynchronized clocking events. Please synchronize before removing the key.';

  @override
  String get confirmRemoveKeys => 'Remove it?\nYour company account will be unlinked and all employee information, as well as clocking events, will be removed from the device.';

  @override
  String get loadingUnsyncedClockingEvents => 'Loading unsynced clocking events...';

  @override
  String get verifiyngConnectivity => 'Verifying internet connection...';

  @override
  String get syncingClockingEvents => 'Syncing clocking events...';

  @override
  String get removingKeys => 'Removing keys...';

  @override
  String get keysNotRemoved => 'Keys not removed';

  @override
  String get keysRemovedUnsuccessfully => 'Unable to completely remove keys. Try again.';

  @override
  String get keysRemoved => 'Keys removed';

  @override
  String get keysRemovedSuccessfully => 'The keys were successfully removed.';

  @override
  String get initJourney => 'Start workday?';

  @override
  String get initJourneyBeforeStartAction => 'No workday in progress, would you like to start a workday before proceeding?';

  @override
  String get initMyJourney => 'Start my workday';

  @override
  String get manualRegistration => 'Manual registration';

  @override
  String get ok => 'Ok';

  @override
  String get continueRegistration => 'Continue with registration?';

  @override
  String get wantToStartJourney => 'Start worktime?';

  @override
  String startJourneyBeforeStartAction(String action) {
    return 'A worktime start event has not been set yet. Start now before registering $action?';
  }

  @override
  String journeyStartedBeforeAction(String actionLabel) {
    return 'Worktime and $actionLabel started successfully.';
  }

  @override
  String actionStartedWithoutJourney(String actionLabel) {
    return '$actionLabel started, but worktime has not. A manual adjustment will have to be made later.';
  }

  @override
  String finishCurrentActionBeforeStartNextAction(String currentActionLabel, String nextActionLabel) {
    return 'Finish $currentActionLabel before starting $nextActionLabel in sequence?';
  }

  @override
  String newActionStartedAndPreviousDoesNot(String newActionLabel, String previousActionLabel) {
    return '$newActionLabel started and $previousActionLabel not finished by the application. Adjust manually if necessary later.';
  }

  @override
  String previousActionFinishedAndNewStarted(String previousActionLabel, String newActionLabel) {
    return '$previousActionLabel finished and $newActionLabel started successfully.';
  }

  @override
  String closeActionBeforeEndJourney(String actionLabel) {
    return 'End $actionLabel before ending the worktime?';
  }

  @override
  String previousActionClosedAndJourneyEnded(String actionLabel) {
    return '$actionLabel and worktime successfully completed.';
  }

  @override
  String journeyFinishedAndPreviousActionDoesNot(String actionLabel) {
    return 'Worktime finished, but $actionLabel not. A manual adjustment will have to be made later.';
  }

  @override
  String get finish => 'Finish';

  @override
  String get start => 'Start';

  @override
  String get sureStartNewJourney => 'Start a new workday?';

  @override
  String get previousJourneyStillRunning => 'The previous workday is still in progress. If you proceed, the end time clocking event will need to be entered manually later.';

  @override
  String get finishJourney => 'End journey';

  @override
  String get wantRegisterOvernight => 'Do you want to register an overnight rest?';

  @override
  String get reportOvernightAfterJourney => 'Report the occurrence of overnight rest after this workday, if necessary.';

  @override
  String get registerOvernight => 'Register overnight rest';

  @override
  String get startOf => 'Start of ';

  @override
  String get endOf => 'End of ';

  @override
  String get work => 'Work';

  @override
  String get abbreviatedHour => 'h';

  @override
  String get addOvernightButton => 'Add overnight';

  @override
  String get overnightAddedSuccessfully => 'Overnight added successfully';

  @override
  String get overnightAddedError => 'Error adding overnight';

  @override
  String get journey => 'Journey';

  @override
  String get cameraPermission => 'Camera';

  @override
  String get cameraPermissionDescription => 'Permission to access the camera. We use this feature to capture a photo of the employee, read a QR code or perform facial recognition.';

  @override
  String get gpsPermission => 'GPS';

  @override
  String get gpsPermissionDescription => 'Permission to access GPS. We use this feature to identify the location where clocking events are recorded.';

  @override
  String get nfcPermission => 'NFC';

  @override
  String get nfcPermissionDescription => 'NFC feature, we use this feature when the approach mode is activated by the employer to be able to register appointments.';

  @override
  String get deviceConfigurationPermission => 'Device permissions';

  @override
  String get privacyCenter => 'Privacy central';

  @override
  String get privacyPolicies => 'Privacy policies';

  @override
  String get info => 'Information';

  @override
  String get viewDate => 'Visualization date';

  @override
  String get facialRegistrationCompleted => 'Clocking event made';

  @override
  String get facialCaceledRegistration => 'Clocking event canceled';

  @override
  String get facialRegistering => 'Wait...';

  @override
  String get facialCollaboratorNotFound => 'Employee not found or inactive';

  @override
  String get noFaceRegistered => 'No face registered';

  @override
  String get offlineFeatureUnavailable => 'This functionality is not available while you are offline. Check your connection';

  @override
  String get titleNotifications => 'Notifications';

  @override
  String get notificationErrorNextPage => 'An error occurred while loading upcoming notifications. Tap Repeat and try again.';

  @override
  String get repeat => 'Repeat';

  @override
  String get notificationErrorState => 'Could not obtain your notifications';

  @override
  String get notificationErrorStateDescription => 'Unable to recover your notifications because an internal system error has occurred. Wait a few moments and to retry this action, tap Try Again.';

  @override
  String get notificationNotReceivedTitle => 'You did not receive any notifications yet.';

  @override
  String get notificationNotReceivedDescription => 'When you receive a notification, it will be available here for consultation.';

  @override
  String get latestNotifications => 'Latest notifications';

  @override
  String get optionCancel => 'Cancel';

  @override
  String get errorMarkNotificationAsRead => 'An error occurred while marking your notification as read. Tap Repeat to try again.';

  @override
  String get featureIsNotAvailableOffline => 'This feature is not available while offline. Please check your internet connection.';

  @override
  String get selectItem => 'Select';

  @override
  String get facialMsgStatusVeryBlurryImage => 'The photo is out of focus or the face is in motion. Try again.';

  @override
  String get facialMsgStatusMoreThanOneFaceFoundInTheImage => 'Only one face should appear in the registration photo.';

  @override
  String get facialMsgStatusFacesNotFoundInTheImage => 'No face was sufficiently found in the image. Please try again.';

  @override
  String get facialMsgStatusNonFrontalFace => 'Position the face at the front and look directly at the camera.';

  @override
  String get facialMsgStatusPoorQualityImage => 'The image has low resolution, noise or poor lighting.';

  @override
  String get facialMsgStatusVerySmallFaceInTheImage => 'Bring your face closer to the camera.';

  @override
  String get facialMsgStatusFaceTooCloseToTheEdgeOfTheImage => 'Center your face on the screen and try again.';

  @override
  String get facialMsgStatusEvidenceOfFraud => 'The image did not meet the authenticity requirements. Try again.';

  @override
  String get facialMsgStatusIdsWithCloseImagesWereFound => 'The face looks similar to another person in the database. Avoid duplicate registrations.';

  @override
  String get facialMsgStatusGlassesDetectedOrTooMuchEyeShadow => 'Remove glasses or adjust lighting to avoid eye shadows.';

  @override
  String get facialMsgStatusLowConfidenceFaceDetection => 'The system was unable to detect a face with sufficient confidence. Try again.';

  @override
  String get facialTitleStatusVeryBlurryImage => 'Image too blurry';

  @override
  String get facialTitleStatusMoreThanOneFaceFoundInTheImage => 'More than one face detected';

  @override
  String get facialTitleStatusFacesNotFoundInTheImage => 'Face not detected';

  @override
  String get facialTitleStatusNonFrontalFace => 'Face out of position';

  @override
  String get facialTitleStatusPoorQualityImage => 'Poor image quality';

  @override
  String get facialTitleStatusVerySmallFaceInTheImage => 'Small face in the image';

  @override
  String get facialTitleStatusFaceTooCloseToTheEdgeOfTheImage => 'Face close to the edge';

  @override
  String get facialTitleStatusEvidenceOfFraud => 'Possible fraud detected';

  @override
  String get facialTitleStatusIdsWithCloseImagesWereFound => 'Similarity to other faces';

  @override
  String get facialTitleStatusGlassesDetectedOrTooMuchEyeShadow => 'Glasses or eye shadows';

  @override
  String get facialTitleStatusLowConfidenceFaceDetection => 'Low confidence in the face';

  @override
  String get privacy_police_change => 'We have updated our privacy policy';

  @override
  String get privacy_police_change_subtitle => 'Click to view or consult at any time at Settings > Privacy policy.';

  @override
  String get reRegisterApplicationKey => 'Query application key';

  @override
  String get errorAuthenticatingApplicationKey => 'Error authenticating application key.';

  @override
  String get authenticating => 'Authenticating...';

  @override
  String get authenticationFailure => 'Authentication failure';

  @override
  String get errorWhileAuthenticatingApplicationKey => 'An error occurred while authenticating the application key registered on this device.';

  @override
  String get recognitionBlocked => 'Recognition blocked, please wait';

  @override
  String get secondsFullName => 'seconds';

  @override
  String get totalTimeSinceLastJourney => 'Time since last workday';

  @override
  String get userNameScreenTitle => 'Log in with credentials';
}
