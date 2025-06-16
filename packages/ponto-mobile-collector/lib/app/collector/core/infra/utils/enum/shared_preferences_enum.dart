enum SharedPreferencesEnum {
  /// Indicates the ID of the employee logged in to the current session.
  sessionEmployeeId,

  /// Indicates the ID_PLATFORM_USER of the employee logged in to the current session.
  sessionPlatformUsername,

  /// Indicates the ID of the company logged in to the current session.
  sessionCompanyId,

  /// Indicates the value of the sync in multi mode.
  doSyncMultiMode,

  /// Indicates whether or not to request OS permissions at startup.
  requestPermissionOnStatrtup,
  userLoggedIsManager,
  deviceUuid,
  userId,
  lastPhotoPath,

  /// Indicates the application's current default camera.
  cameraDefault,

  /// QR code reader default camera.
  qrCodeReaderDefaultCamera,

  /// Indicates the company's tenant linked to multiple mode.
  tenant,

  /// Indicates whether the general compatibility routine has already been executed successfully.
  compatibilityRoutineExecuted,

  /// Indicates whether the device information import routine in ionic was executed successfully.
  importDeviceInfoRoutineExecuted,

  /// Indicates whether the ionic app key import routine was executed successfully.
  importApplicationKeyRoutineExecuted,

  /// Indicates whether the ionic app key import routine was executed successfully.
  importAppointmentsRoutineExecuted,

  /// Indicates whether the ionic tag import routine was executed successfully.
  facialRecognitionAuthentication,

  /// Indicates whether the AI ​​has already been downloaded.
  downloadAIFiles,

  /// Indicates whether the company is already registered with Gryfo.
  registerCompany,

  /// Indicates whether the employee's biometric face has already been registered.
  registeredBiometricFace,

  /// Indicates the state of a toggle feature based on the company's employee or tenant id.
  featureToggle,

  /// Stores the permissions of the logged in user in individual mode.
  userPermission,

  /// Indicates the ID of the current journey.
  currentJourneyId,

  /// Indicates the seen sends the error log to the api
  sendCrashLog,

  /// Stores the token used for facial recognition authentication.
  facialRecognitionAuthToken,

  /// Indicates whether to synchronize information at application startup
  executeSyncAllInfoOnStartup,

  /// Indicates the token used for FCM.
  tokenFcm,

  /// Indicates if it is the first time the application is being opened
  firstShowPrivacyPolicy;

  static SharedPreferencesEnum build(String name) {
    if (name == SharedPreferencesEnum.sessionEmployeeId.name) {
      return SharedPreferencesEnum.sessionEmployeeId;
    }

    if (name == SharedPreferencesEnum.sessionPlatformUsername.name) {
      return SharedPreferencesEnum.sessionPlatformUsername;
    }

    if (name == SharedPreferencesEnum.sessionCompanyId.name) {
      return SharedPreferencesEnum.sessionCompanyId;
    }

    if (name == SharedPreferencesEnum.lastPhotoPath.name) {
      return SharedPreferencesEnum.lastPhotoPath;
    }

    if (name == SharedPreferencesEnum.requestPermissionOnStatrtup.name) {
      return SharedPreferencesEnum.requestPermissionOnStatrtup;
    }

    if (name == SharedPreferencesEnum.userLoggedIsManager.name) {
      return SharedPreferencesEnum.userLoggedIsManager;
    }

    if (name == SharedPreferencesEnum.doSyncMultiMode.name) {
      return SharedPreferencesEnum.doSyncMultiMode;
    }

    if (name == SharedPreferencesEnum.deviceUuid.name) {
      return SharedPreferencesEnum.deviceUuid;
    }

    if (name == SharedPreferencesEnum.userId.name) {
      return SharedPreferencesEnum.userId;
    }

    if (name == SharedPreferencesEnum.cameraDefault.name) {
      return SharedPreferencesEnum.cameraDefault;
    }

    if (name == SharedPreferencesEnum.tenant.name) {
      return SharedPreferencesEnum.tenant;
    }

    if (name == SharedPreferencesEnum.compatibilityRoutineExecuted.name) {
      return SharedPreferencesEnum.compatibilityRoutineExecuted;
    }

    if (name == SharedPreferencesEnum.importDeviceInfoRoutineExecuted.name) {
      return SharedPreferencesEnum.importDeviceInfoRoutineExecuted;
    }

    if (name ==
        SharedPreferencesEnum.importApplicationKeyRoutineExecuted.name) {
      return SharedPreferencesEnum.importApplicationKeyRoutineExecuted;
    }

    if (name == SharedPreferencesEnum.importAppointmentsRoutineExecuted.name) {
      return SharedPreferencesEnum.importAppointmentsRoutineExecuted;
    }

    if (name == SharedPreferencesEnum.facialRecognitionAuthentication.name) {
      return SharedPreferencesEnum.facialRecognitionAuthentication;
    }

    if (name == SharedPreferencesEnum.downloadAIFiles.name) {
      return SharedPreferencesEnum.downloadAIFiles;
    }

    if (name == SharedPreferencesEnum.registerCompany.name) {
      return SharedPreferencesEnum.registerCompany;
    }

    if (name == SharedPreferencesEnum.registeredBiometricFace.name) {
      return SharedPreferencesEnum.registeredBiometricFace;
    }

    if (name == SharedPreferencesEnum.featureToggle.name) {
      return SharedPreferencesEnum.featureToggle;
    }

    if (name == SharedPreferencesEnum.userPermission.name) {
      return SharedPreferencesEnum.userPermission;
    }

    if (name == SharedPreferencesEnum.currentJourneyId.name) {
      return SharedPreferencesEnum.currentJourneyId;
    }

    if (name == SharedPreferencesEnum.sendCrashLog.name) {
      return SharedPreferencesEnum.sendCrashLog;
    }

    if (name == SharedPreferencesEnum.facialRecognitionAuthToken.name) {
      return SharedPreferencesEnum.facialRecognitionAuthToken;
    }

    if (name == SharedPreferencesEnum.currentJourneyId.name) {
      return SharedPreferencesEnum.currentJourneyId;
    }

    if (name == SharedPreferencesEnum.executeSyncAllInfoOnStartup.name) {
      return SharedPreferencesEnum.executeSyncAllInfoOnStartup;
    }

    if (name == SharedPreferencesEnum.tokenFcm.name) {
      return SharedPreferencesEnum.tokenFcm;
    }

    if (name == SharedPreferencesEnum.firstShowPrivacyPolicy.name) {
      return SharedPreferencesEnum.firstShowPrivacyPolicy;
    }

    throw Exception('SharedPreferencesEnum not found.');
  }
}
