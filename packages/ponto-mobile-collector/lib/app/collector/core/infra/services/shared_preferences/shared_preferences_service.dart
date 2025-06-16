import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../utils/enum/execution_mode_enum.dart';
import '../../utils/enum/feature_toggle_enum.dart';

class SharedPreferencesService implements ISharedPreferencesService {
  @override
  Future<void> setSessionEmployeeId({required String? employeeId}) async {
    final prefs = await SharedPreferences.getInstance();
    if (employeeId == null) {
      await prefs.remove(SharedPreferencesEnum.sessionEmployeeId.name);
    } else {
      await prefs.setString(
        SharedPreferencesEnum.sessionEmployeeId.name,
        employeeId,
      );
    }
  }

  @override
  Future<String?> getSessionEmployeeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesEnum.sessionEmployeeId.name);
  }

  @override
  Future<void> setSessionPlatformUsername({
    required String? platformUserName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (platformUserName == null) {
      await prefs.remove(SharedPreferencesEnum.sessionPlatformUsername.name);
    } else {
      await prefs.setString(
        SharedPreferencesEnum.sessionPlatformUsername.name,
        platformUserName,
      );
    }
  }

  @override
  Future<String?> getSessionPlatformUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesEnum.sessionPlatformUsername.name);
  }

  @override
  Future<bool> getRequestPermissionOnStatrtup() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
            .getBool(SharedPreferencesEnum.requestPermissionOnStatrtup.name) ??
        true;
  }

  @override
  Future<bool> getUserLoggedIsManager() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferencesEnum.userLoggedIsManager.name) ??
        true;
  }

  @override
  Future<void> setMultiModeSync({required bool doSyncMultiMode}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.doSyncMultiMode.name,
      doSyncMultiMode,
    );
  }

  @override
  Future<bool> getMultiModeSync() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferencesEnum.doSyncMultiMode.name) ?? true;
  }

  @override
  Future<void> setRequestPermissionOnStatrtup({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.requestPermissionOnStatrtup.name,
      value,
    );
  }

  @override
  Future<void> setUserLoggedIsManager({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.userLoggedIsManager.name,
      value,
    );
  }

  @override
  Future<int> getCameraDefault() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferencesEnum.cameraDefault.name) ?? 1;
  }

  @override
  Future<void> setCameraDefault({required int value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      SharedPreferencesEnum.cameraDefault.name,
      value,
    );
  }

  @override
  Future<String?> getTenant() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesEnum.tenant.name);
  }

  @override
  Future<void> setTenant({String? value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      SharedPreferencesEnum.tenant.name,
      value!,
    );
  }

  @override
  Future<bool> removeTenant() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(SharedPreferencesEnum.tenant.name);
  }

  @override
  Future<bool> getCompatibilityRoutineExecuted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
            .getBool(SharedPreferencesEnum.compatibilityRoutineExecuted.name) ??
        false;
  }

  @override
  Future<void> setCompatibilityRoutineExecuted({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.compatibilityRoutineExecuted.name,
      value,
    );
  }

  @override
  Future<bool> getImportDeviceInfoRoutineExecuted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          SharedPreferencesEnum.importDeviceInfoRoutineExecuted.name,
        ) ??
        false;
  }

  @override
  Future<void> setImportDeviceInfoRoutineExecuted({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.importDeviceInfoRoutineExecuted.name,
      value,
    );
  }

  @override
  Future<bool> getImportApplicationKeyRoutineExecuted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          SharedPreferencesEnum.importApplicationKeyRoutineExecuted.name,
        ) ??
        false;
  }

  @override
  Future<void> setImportApplicationKeyRoutineExecuted({
    required bool value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.importApplicationKeyRoutineExecuted.name,
      value,
    );
  }

  @override
  Future<bool> getImportAppointmentsRoutineExecuted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          SharedPreferencesEnum.importAppointmentsRoutineExecuted.name,
        ) ??
        false;
  }

  @override
  Future<void> setImportAppointmentsRoutineExecuted({
    required bool value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.importAppointmentsRoutineExecuted.name,
      value,
    );
  }

  @override
  Future<bool> getFacialRecognitionAuthentication({
    required String companyId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          '${SharedPreferencesEnum.facialRecognitionAuthentication.name}-$companyId',
        ) ??
        false;
  }

  @override
  Future<void> setFacialRecognitionAuthentication({
    required String companyId,
    required bool value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      '${SharedPreferencesEnum.facialRecognitionAuthentication.name}-$companyId',
      value,
    );
  }

  @override
  Future<bool> getDownloadAIFiles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          SharedPreferencesEnum.downloadAIFiles.name,
        ) ??
        false;
  }

  @override
  Future<void> setDownloadAIFiles({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.downloadAIFiles.name,
      value,
    );
  }

  @override
  Future<bool> getRegisterCompany({required String companyId}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          '${SharedPreferencesEnum.registerCompany.name}-$companyId',
        ) ??
        false;
  }

  @override
  Future<void> setRegisterCompany({
    required String companyId,
    required bool value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      '${SharedPreferencesEnum.registerCompany.name}-$companyId',
      value,
    );
  }

  @override
  Future<bool> getFeatureToggle({
    required ExecutionModeEnum executionModeEnum,
    required String employeeIdOrTenant,
    required FeatureToggleEnum featureToggle,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          '${SharedPreferencesEnum.featureToggle}-${featureToggle.name}-$executionModeEnum-$employeeIdOrTenant',
        ) ??
        false;
  }

  @override
  Future<void> setFeatureToggle({
    required ExecutionModeEnum executionModeEnum,
    required String employeeIdOrTenant,
    required FeatureToggleEnum featureToggle,
    required bool value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      '${SharedPreferencesEnum.featureToggle}-${featureToggle.name}-$executionModeEnum-$employeeIdOrTenant',
      value,
    );
  }

  @override
  Future<bool> getUserPermission({
    required String userName,
    required String action,
    required String resource,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
          '$userName-$action-$resource',
        ) ??
        false;
  }

  @override
  Future<void> setUserPermission({
    required String userName,
    required String action,
    required String resource,
    required bool authorized,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      '$userName-$action-$resource',
      authorized,
    );
  }

  @override
  Future<String?> getSessionCompanyId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesEnum.sessionCompanyId.name);
  }

  @override
  Future<void> setSessionCompanyId({required String? companyId}) async {
    final prefs = await SharedPreferences.getInstance();
    if (companyId == null) {
      await prefs.remove(SharedPreferencesEnum.sessionCompanyId.name);
    } else {
      await prefs.setString(
        SharedPreferencesEnum.sessionCompanyId.name,
        companyId,
      );
    }
  }

  @override
  Future<int> getCodeScannerCamera() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedPreferencesEnum.qrCodeReaderDefaultCamera.name) ??
        0;
  }

  @override
  Future<void> setCodeScannerCamera({required int value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
      SharedPreferencesEnum.qrCodeReaderDefaultCamera.name,
      value,
    );
  }

  @override
  Future<void> setSendCrashLog({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.sendCrashLog.name,
      value,
    );
  }

  @override
  Future<bool> getSendCrashLog() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferencesEnum.sendCrashLog.name) ?? false;
  }

  @override
  Future<void> setFacialRecognitionAuthToken({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      SharedPreferencesEnum.facialRecognitionAuthToken.name,
      token,
    );
  }

  @override
  Future<String> getFacialRecognitionAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
            .getString(SharedPreferencesEnum.facialRecognitionAuthToken.name) ??
        '';
  }

  @override
  Future<void> setExecuteSyncAllInfoOnStartup({required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.executeSyncAllInfoOnStartup.name,
      value,
    );
  }

  @override
  Future<bool> getExecuteSyncAllInfoOnStartup() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
            .getBool(SharedPreferencesEnum.executeSyncAllInfoOnStartup.name) ??
        false;
  }

  @override
  Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  @override
  Future<void> setTokemFcm({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      SharedPreferencesEnum.tokenFcm.name,
      token,
    );
  }

  @override
  Future<String?> getTokemFcm() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPreferencesEnum.tokenFcm.name);
  }

  @override
  Future<void> setFirstShowPrivacyPolicy({required bool first}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      SharedPreferencesEnum.firstShowPrivacyPolicy.name,
      first,
    );
  }

  @override
  Future<bool> getFirstShowPrivacyPolicy() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferencesEnum.firstShowPrivacyPolicy.name) ??
        true;
  }

  @override
  Future<void> clearKeysByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    keys.retainWhere(
      (key) => employeeIds.any(
        (employeeId) =>
            key.contains(employeeId) ||
            key.contains(employeeId.replaceAll('-', '')),
      ),
    );

    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}
