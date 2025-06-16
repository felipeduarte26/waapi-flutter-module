import '../../../infra/utils/enum/execution_mode_enum.dart';
import '../../../infra/utils/enum/feature_toggle_enum.dart';

abstract class ISharedPreferencesService {
  /// Set the id of the logged in employee.
  Future<void> setSessionEmployeeId({required String? employeeId});

  /// Get the id of the logged in employee.
  Future<String?> getSessionEmployeeId();

  /// Set the Username of the logged in employee from mobileLogin.
  Future<void> setSessionPlatformUsername({required String? platformUserName});

  /// Get the Username of the logged in employee from mobileLogin.
  Future<String?> getSessionPlatformUsername();

  /// Set the id of the logged in company.
  Future<void> setSessionCompanyId({required String? companyId});

  /// Get the id of the logged in company.
  Future<String?> getSessionCompanyId();

  /// Set the value if the sync was executed in multi mode.
  Future<void> setMultiModeSync({required bool doSyncMultiMode});

  /// Get the value of the sync in multi mode.
  Future<bool> getMultiModeSync();

  /// Indicates whether permissions for this device were already requested on first launch.
  Future<bool> getRequestPermissionOnStatrtup();

  /// Defines if current device permissions are already requested on first launch.
  Future<void> setRequestPermissionOnStatrtup({required bool value});

  /// Indicates if the user is a manager.
  Future<bool> getUserLoggedIsManager();

  /// Defines as true if the user is a manager.
  Future<void> setUserLoggedIsManager({required bool value});

  /// Set a default capture camera.
  Future<int> getCameraDefault();

  /// Get a default capture camera.
  Future<void> setCameraDefault({required int value});

  /// Set a default capture camera.
  Future<int> getCodeScannerCamera();

  /// Get a default capture camera.
  Future<void> setCodeScannerCamera({required int value});

  /// Get the tenant value.
  Future<String?> getTenant();

  /// Set the tenant value.
  Future<void> setTenant({String value});

  /// Remove tenant
  Future<bool> removeTenant();

  /// Set as true if the compatibility routine was already executed.
  Future<bool> getCompatibilityRoutineExecuted();

  /// Get the value of compatibility routine, executed: true, not executed: false.
  Future<void> setCompatibilityRoutineExecuted({
    required bool value,
  }); // alterar pra booleano

  Future<bool> getImportDeviceInfoRoutineExecuted();

  Future<void> setImportDeviceInfoRoutineExecuted({
    required bool value,
  });

  Future<bool> getImportApplicationKeyRoutineExecuted();

  Future<void> setImportApplicationKeyRoutineExecuted({
    required bool value,
  });

  Future<bool> getImportAppointmentsRoutineExecuted();

  Future<void> setImportAppointmentsRoutineExecuted({
    required bool value,
  });

  /// Get the facial recognition authentication value.
  Future<bool> getFacialRecognitionAuthentication({required String companyId});

  /// Set the facial recognition authentication value.
  Future<void> setFacialRecognitionAuthentication({
    required String companyId,
    required bool value,
  });

  /// Get the download AI files value.
  Future<bool> getDownloadAIFiles();

  /// Set the download AI files value.
  Future<void> setDownloadAIFiles({required bool value});

  /// Get the register company value.
  Future<bool> getRegisterCompany({required String companyId});

  /// Set the register company value.
  Future<void> setRegisterCompany({
    required String companyId,
    required bool value,
  });

  /// Obtains the last value of a feature toggle
  Future<bool> getFeatureToggle({
    required ExecutionModeEnum executionModeEnum,
    required String employeeIdOrTenant,
    required FeatureToggleEnum featureToggle,
  });

  /// Defines indicato the last value of a feature toggle
  Future<void> setFeatureToggle({
    required ExecutionModeEnum executionModeEnum,
    required String employeeIdOrTenant,
    required FeatureToggleEnum featureToggle,
    required bool value,
  });

  /// Obtains a user permission.
  Future<bool> getUserPermission({
    required String userName,
    required String action,
    required String resource,
  });

  /// Defines a user permission.
  Future<void> setUserPermission({
    required String userName,
    required String action,
    required String resource,
    required bool authorized,
  });

  /// Defines whether to send error log
  Future<void> setSendCrashLog({required bool value});

  /// Obtains to send error log
  Future<bool> getSendCrashLog();

  /// Set the facial recognition auth token.
  Future<void> setFacialRecognitionAuthToken({required String token});

  /// Get the facial recognition auth token.
  Future<String> getFacialRecognitionAuthToken();

  /// Defines whether to synchronize information at application startup
  Future<void> setExecuteSyncAllInfoOnStartup({required bool value});

  /// Obtains whether to synchronize information at application startup
  Future<bool> getExecuteSyncAllInfoOnStartup();

  /// Remove all data from shared preferences.
  Future<bool> clearAll();

  /// Set the token FCM.
  Future<void> setTokemFcm({
    required String token,
  });

  /// Get the token FCM.
  Future<String?> getTokemFcm();

  /// Defines whether it is the first time the application is being opened.
  Future<void> setFirstShowPrivacyPolicy({
    required bool first,
  });

  /// Obtains whether it is the first time the application is being opened.
  Future<bool> getFirstShowPrivacyPolicy();

  /// Clear orphans data by employee ids.
  Future<void> clearKeysByEmployeeIds({
    required List<String> employeeIds,
  });
}
