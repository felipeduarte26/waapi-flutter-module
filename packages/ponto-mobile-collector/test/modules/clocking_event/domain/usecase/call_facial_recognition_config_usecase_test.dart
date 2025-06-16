import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/company.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/configuration_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_check_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/feature_toggle_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/call_facial_recognition_config_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/configuration_entity_mock.dart';

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

class MockPlatformService extends Mock implements IPlatformService {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class MockPermissionService extends Mock implements IPermissionService {}

class MockCheckUserPermissionUsecase extends Mock
    implements CheckUserPermissionUsecase {}

class MockEmployeeRepository extends Mock implements EmployeeRepository {}

class MockFaceRecognitionCheckFaceRepository extends Mock
    implements FaceRecognitionCheckFaceRepository {}

class FakeLoginConfigurationDTO extends Fake
    implements ConfigurationDto {
  @override
  final bool faceRecognition;

  FakeLoginConfigurationDTO({required this.faceRecognition});
}

void main() {
  String tEmployeeId = 'bee8e4fc-0285-42b7-95b3-6ac278149966';
  late IPlatformService platformService;
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  late ISharedPreferencesService sharedPreferencesService;
  late ICallFacialRecognitionConfigUsecase callFacialRecognitionConfigUsecase;
  late IConfigurationRepository configurationRepository;
  late IPermissionService permissionService;
  late CheckUserPermissionUsecase checkUserPermissionUsecase;
  late EmployeeRepository employeeRepository;
  late FaceRecognitionCheckFaceRepository faceRecognitionCheckFaceRepository;

  setUp(
    () {
      faceRecognitionSdkAuthenticationService =
          MockFaceRecognitionSdkAuthenticationService();
      platformService = MockPlatformService();
      sharedPreferencesService = MockSharedPreferencesService();
      configurationRepository = MockConfigurationRepository();
      permissionService = MockPermissionService();
      checkUserPermissionUsecase = MockCheckUserPermissionUsecase();
      employeeRepository = MockEmployeeRepository();
      faceRecognitionCheckFaceRepository =
          MockFaceRecognitionCheckFaceRepository();

      when(
        () => permissionService.checkPermissionIsAuthorized(
          permission: DevicePermissionEnum.camera,
        ),
      ).thenAnswer((_) async => true);

      callFacialRecognitionConfigUsecase = CallFacialRecognitionConfigUsecase(
        faceRecognitionSdkAuthenticationService:
            faceRecognitionSdkAuthenticationService,
        platformService: platformService,
        sharedPreferencesService: sharedPreferencesService,
        configurationRepository: configurationRepository,
        permissionService: permissionService,
        checkUserPermissionUsecase: checkUserPermissionUsecase,
        employeeRepository: employeeRepository,
        faceRecognitionCheckFaceRepository: faceRecognitionCheckFaceRepository,
      );
    },
  );

  group(
    'CallFacialRecognitionConfigUsecase',
    () {
      test(
        'call successfully test.',
        () async {
          when(
            () => sharedPreferencesService.getSessionEmployeeId(),
          ).thenAnswer(
            (_) async => tEmployeeId,
          );

          when(
            () => sharedPreferencesService.getSessionPlatformUsername(),
          ).thenAnswer(
            (_) async => 'username@tenant.com.br',
          );

          when(
            () => configurationRepository.findByEmployeeId(
              employeeId: tEmployeeId,
            ),
          ).thenAnswer(
            (_) async => configurationEntityMock,
          );

          when(
            () => employeeRepository.findById(
              id: tEmployeeId,
            ),
          ).thenAnswer(
            (_) async => getEmployee(),
          );

          when(
            () => faceRecognitionCheckFaceRepository.call(
              employeeId: tEmployeeId,
            ),
          ).thenAnswer((_) async => true);

          when(
            () => sharedPreferencesService.getUserPermission(
              userName: 'username@tenant.com.br',
              action: UserActionEnum.allow.action,
              resource: UserResourceEnum.facialAuth.resource,
            ),
          ).thenAnswer((_) => Future.value(true));

          when(
            () => faceRecognitionSdkAuthenticationService
                .getInitializationIsRunning(),
          ).thenReturn(false);

          when(
            () => sharedPreferencesService.getFeatureToggle(
              executionModeEnum: ExecutionModeEnum.individual,
              employeeIdOrTenant: tEmployeeId,
              featureToggle: FeatureToggleEnum.faceRecognition,
            ),
          ).thenAnswer((_) async => true);

          bool result = await callFacialRecognitionConfigUsecase.call();

          expect(result, true);

          verify(
            () => faceRecognitionSdkAuthenticationService
                .getInitializationIsRunning(),
          ).called(1);

          verify(
            () => faceRecognitionCheckFaceRepository.call(
              employeeId: tEmployeeId,
            ),
          ).called(1);

          verify(
            () => sharedPreferencesService.getSessionEmployeeId(),
          ).called(1);

          verifyNoMoreInteractions(faceRecognitionSdkAuthenticationService);
          verifyNoMoreInteractions(platformService);
        },
      );

      test('return false when employeeId is null test', () async {
        when(
          () => sharedPreferencesService.getSessionEmployeeId(),
        ).thenAnswer(
          (_) async => null,
        );

        when(
          () => sharedPreferencesService.getSessionPlatformUsername(),
        ).thenAnswer(
          (_) async => 'username@tenant.com.br',
        );

        bool result = await callFacialRecognitionConfigUsecase.call();

        expect(result, false);

        verify(
          () => sharedPreferencesService.getSessionEmployeeId(),
        ).called(1);
      });

      test('return false when configuration is null test', () async {
        when(
          () => sharedPreferencesService.getSessionEmployeeId(),
        ).thenAnswer(
          (_) async => tEmployeeId,
        );

        when(
          () => sharedPreferencesService.getSessionPlatformUsername(),
        ).thenAnswer(
          (_) async => 'username@tenant.com.br',
        );

        when(
          () => configurationRepository.findByEmployeeId(
            employeeId: tEmployeeId,
          ),
        ).thenAnswer(
          (_) async => null,
        );

        when(
          () => employeeRepository.findById(
            id: tEmployeeId,
          ),
        ).thenAnswer(
          (_) async => getEmployee(),
        );

        bool result = await callFacialRecognitionConfigUsecase.call();

        expect(result, false);

        verify(
          () => sharedPreferencesService.getSessionEmployeeId(),
        ).called(1);

        verify(
          () => configurationRepository.findByEmployeeId(
            employeeId: tEmployeeId,
          ),
        ).called(1);
      });

      test('return false when camera permission id denied test', () async {
        when(
          () => permissionService.checkPermissionIsAuthorized(
            permission: DevicePermissionEnum.camera,
          ),
        ).thenAnswer((_) async => false);

        bool result = await callFacialRecognitionConfigUsecase.call();

        expect(result, false);

        verify(
          () => permissionService.checkPermissionIsAuthorized(
            permission: DevicePermissionEnum.camera,
          ),
        ).called(1);

        verifyNoMoreInteractions(permissionService);
      });
    },
  );
}

Employee getEmployee() {
  Company companyDto =
      const Company(name: 'name', cnpj: '122', timeZone: 'timeZone', id: '1');

  return Employee(
    id: 'bee8e4fc-0285-42b7-95b3-6ac278149966',
    name: 'employee',
    employeeType: 'employeeType',
    company: companyDto,
    cpf: '123',
    faceRegistered: 'bee8e4fc028542b795b36ac278149966',
  );
}
