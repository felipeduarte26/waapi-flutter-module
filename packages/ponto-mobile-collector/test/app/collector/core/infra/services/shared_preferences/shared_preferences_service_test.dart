import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/feature_toggle_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  String tEmployeeId = 'tEmployeeId';
  String tCompanyId = 'tCompanyId';

  setUp(
    () {
      final Map<String, Object> values = <String, Object>{'counter': 1};
      SharedPreferences.setMockInitialValues(values);
    },
  );

  group('SharedPreferencesServiceTest', () {
    test(
      'test SessionEmployeeId get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setSessionEmployeeId(employeeId: tEmployeeId);
        String? valor = await service.getSessionEmployeeId();
        expect(valor, tEmployeeId);
      },
    );

    test(
      'test RequestPermissionOnStatrtup get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        service.setRequestPermissionOnStatrtup(value: true);
        bool valor = await service.getRequestPermissionOnStatrtup();
        expect(valor, true);

        service.setCameraDefault(value: 0);
        expect(await service.getCameraDefault(), 0);
      },
    );

    test(
      'test doSyncMultiMode get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        service.setMultiModeSync(doSyncMultiMode: false);
        bool valor = await service.getMultiModeSync();
        expect(valor, true);
      },
    );

    test(
      'test Tenant get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setTenant(value: '1234');
        String? valor = await service.getTenant();
        expect(valor, '1234');
      },
    );

    test(
      'test Tenant remove',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setTenant(value: '1234');
        await service.removeTenant();
        String? valor = await service.getTenant();
        expect(valor, null);
      },
    );

    test(
      'test ImportDeviceInfoRoutineExecuted get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setImportDeviceInfoRoutineExecuted(value: true);
        bool valor = await service.getImportDeviceInfoRoutineExecuted();
        expect(valor, true);
      },
    );

    test(
      'test ImportApplicationKeyRoutineExecuted get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setImportApplicationKeyRoutineExecuted(value: true);
        bool valor = await service.getImportApplicationKeyRoutineExecuted();
        expect(valor, true);
      },
    );

    test(
      'test ImportAppointmewntsRoutineExecuted get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setImportAppointmentsRoutineExecuted(value: true);
        bool valor = await service.getImportAppointmentsRoutineExecuted();
        expect(valor, true);
      },
    );

    test(
      'test CompatibilityRoutineExecuted get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setCompatibilityRoutineExecuted(value: true);
        bool valor = await service.getCompatibilityRoutineExecuted();
        expect(valor, true);
      },
    );

    test(
      'test FacialRecognitionAuthentication get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setFacialRecognitionAuthentication(
          companyId: tCompanyId,
          value: true,
        );
        bool valor = await service.getFacialRecognitionAuthentication(
          companyId: tCompanyId,
        );
        expect(valor, true);
      },
    );

    test(
      'test DownloadAIFiles get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setDownloadAIFiles(value: true);
        bool valor = await service.getDownloadAIFiles();
        expect(valor, true);
      },
    );

    test(
      'test RegisterCompany get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setRegisterCompany(
          companyId: tCompanyId,
          value: true,
        );
        bool valor = await service.getRegisterCompany(
          companyId: tCompanyId,
        );
        expect(valor, true);
      },
    );

    test(
      'test FeatureToggle get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setFeatureToggle(
          employeeIdOrTenant: 'employeeIdOrTenant',
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
          value: true,
        );
        bool valor = await service.getFeatureToggle(
          employeeIdOrTenant: 'employeeIdOrTenant',
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
        );
        expect(valor, true);
      },
    );

    test(
      'test UserPermission get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setUserPermission(
          userName: 'employeeId',
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.clockEventList.resource,
          authorized: true,
        );
        bool valor = await service.getUserPermission(
          userName: 'employeeId',
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.clockEventList.resource,
        );
        expect(valor, true);
      },
    );

    test(
      'test qrCodeReaderDefaultCamera get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setCodeScannerCamera(value: 1);
        int valor = await service.getCodeScannerCamera();
        expect(valor, 1);
      },
    );
    test(
      'test sessionCompanyId get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setSessionCompanyId(companyId: '123');
        String? valor = await service.getSessionCompanyId();
        expect(valor, '123');
      },
    );

    test(
      'test SessionPlatformUsername get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setSessionPlatformUsername(platformUserName: 'username');
        var valor = await service.getSessionPlatformUsername();
        expect(valor, 'username');
      },
    );

    test(
      'test userLoggedIsManager get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setUserLoggedIsManager(value: true);
        bool? valor = await service.getUserLoggedIsManager();
        expect(valor, true);
      },
    );

    test(
      'test SendCrashLog get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setSendCrashLog(value: true);
        bool? valor = await service.getSendCrashLog();
        expect(valor, true);
      },
    );

    test(
      'test FacialRecognitionAuthToken get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setFacialRecognitionAuthToken(token: 'token');
        String valor = await service.getFacialRecognitionAuthToken();
        expect(valor, 'token');
      },
    );

    test(
      'test ImportDeviceInfoRoutineExecuted get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setImportDeviceInfoRoutineExecuted(value: true);
        bool valor = await service.getImportDeviceInfoRoutineExecuted();
        expect(valor, true);
      },
    );

    test(
      'test ImportApplicationKeyRoutineExecuted get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setImportApplicationKeyRoutineExecuted(value: true);
        bool valor = await service.getImportApplicationKeyRoutineExecuted();
        expect(valor, true);
      },
    );

    test(
      'test ImportAppointmewntsRoutineExecuted get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setImportAppointmentsRoutineExecuted(value: true);
        bool valor = await service.getImportAppointmentsRoutineExecuted();
        expect(valor, true);
      },
    );

    test(
      'test CompatibilityRoutineExecuted get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setCompatibilityRoutineExecuted(value: true);
        bool valor = await service.getCompatibilityRoutineExecuted();
        expect(valor, true);
      },
    );

    test(
      'test FacialRecognitionAuthentication get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setFacialRecognitionAuthentication(
          companyId: tCompanyId,
          value: true,
        );
        bool valor = await service.getFacialRecognitionAuthentication(
          companyId: tCompanyId,
        );
        expect(valor, true);
      },
    );

    test(
      'test DownloadAIFiles get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setDownloadAIFiles(value: true);
        bool valor = await service.getDownloadAIFiles();
        expect(valor, true);
      },
    );

    test(
      'test RegisterCompany get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setRegisterCompany(
          companyId: tCompanyId,
          value: true,
        );
        bool valor = await service.getRegisterCompany(
          companyId: tCompanyId,
        );
        expect(valor, true);
      },
    );

    test(
      'test FeatureToggle get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setFeatureToggle(
          employeeIdOrTenant: 'employeeIdOrTenant',
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
          value: true,
        );
        bool valor = await service.getFeatureToggle(
          employeeIdOrTenant: 'employeeIdOrTenant',
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
        );
        expect(valor, true);
      },
    );

    test(
      'test UserPermission get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setUserPermission(
          userName: 'employeeId',
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.clockEventList.resource,
          authorized: true,
        );
        bool valor = await service.getUserPermission(
          userName: 'employeeId',
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.clockEventList.resource,
        );
        expect(valor, true);
      },
    );

    test(
      'test qrCodeReaderDefaultCamera get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setCodeScannerCamera(value: 1);
        int valor = await service.getCodeScannerCamera();
        expect(valor, 1);
      },
    );
    test(
      'test sessionCompanyId get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setSessionCompanyId(companyId: '123');
        String? valor = await service.getSessionCompanyId();
        expect(valor, '123');
      },
    );

    test(
      'test SessionPlatformUsername get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setSessionPlatformUsername(platformUserName: 'username');
        var valor = await service.getSessionPlatformUsername();
        expect(valor, 'username');
      },
    );

    test(
      'test userLoggedIsManager get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setUserLoggedIsManager(value: true);
        bool? valor = await service.getUserLoggedIsManager();
        expect(valor, true);
      },
    );

    test(
      'test SendCrashLog get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setSendCrashLog(value: true);
        bool? valor = await service.getSendCrashLog();
        expect(valor, true);
      },
    );

    test(
      'test FacialRecognitionAuthToken get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setFacialRecognitionAuthToken(token: 'token');
        String valor = await service.getFacialRecognitionAuthToken();
        expect(valor, 'token');
      },
    );

    test(
      'test FacialRecognitionAuthToken get and set',
      () async {
        SharedPreferencesService service = SharedPreferencesService();
        await service.setExecuteSyncAllInfoOnStartup(value: true);
        bool valor = await service.getExecuteSyncAllInfoOnStartup();
        expect(valor, true);
      },
    );

    test(
      'clearAll should remove all SharedPreferences',
      () async {
        // Arrange
        final prefs = await SharedPreferences.getInstance();
        SharedPreferencesService service = SharedPreferencesService();
        await prefs.setString('key1', 'value1');
        await prefs.setString('key2', 'value2');

        // Act
        await service.clearAll();

        // Assert
        final result1 = prefs.getString('key1');
        final result2 = prefs.getString('key2');
        expect(result1, isNull);
        expect(result2, isNull);
      },
    );

    test('setTokemFcm should save token in SharedPreferences', () async {
      const token = 'fcm_token';
      SharedPreferencesService service = SharedPreferencesService();

      await service.setTokemFcm(token: token);

      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString(SharedPreferencesEnum.tokenFcm.name);
      expect(savedToken, token);
    });

    test('getTokemFcm should return token from SharedPreferences', () async {
      const token = 'fcm_token';
      SharedPreferencesService service = SharedPreferencesService();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(SharedPreferencesEnum.tokenFcm.name, token);

      final result = await service.getTokemFcm();

      expect(result, token);
    });

    test(
        'getTokemFcm should return null if token is not set in SharedPreferences',
        () async {
      SharedPreferencesService service = SharedPreferencesService();

      final result = await service.getTokemFcm();

      expect(result, isNull);
    });

    test('getFirstShowPrivacyPolicy returns the correct value', () async {
      SharedPreferencesService service = SharedPreferencesService();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(
        SharedPreferencesEnum.firstShowPrivacyPolicy.name,
        true,
      );
      final result = await service.getFirstShowPrivacyPolicy();

      expect(result, true);
    });

    test('setFirstShowPrivacyPolicy sets the value correctly', () async {
      SharedPreferencesService service = SharedPreferencesService();

      await service.setFirstShowPrivacyPolicy(first: true);

      final prefs = await SharedPreferences.getInstance();
      final firstPrivacy =
          prefs.getBool(SharedPreferencesEnum.firstShowPrivacyPolicy.name);
      expect(firstPrivacy, true);
    });

    test('getFirstShowPrivacyPolicy returns true if no value is set', () async {
      SharedPreferencesService service = SharedPreferencesService();
      final result = await service.getFirstShowPrivacyPolicy();

      expect(result, true);
    });

    test(
      'clearKeysByEmployeeIds should remove all keys by employee ids',
      () async {
        SharedPreferencesService service = SharedPreferencesService();

        await service.setFeatureToggle(
          employeeIdOrTenant: '1',
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
          value: true,
        );

        var value = await service.getFeatureToggle(
          employeeIdOrTenant: '1',
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
        );

        expect(value, isTrue);

        await service.clearKeysByEmployeeIds(employeeIds: ['1']);

        value = await service.getFeatureToggle(
          employeeIdOrTenant: '1',
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
        );

        expect(value, isFalse);
      },
    );
  });
}
