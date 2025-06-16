import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/configuration_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_acess_token_username_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_clocking_event_use_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/feature_toggle_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/show_face_registration_message_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/configuration_dto_mock.dart';

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockSessionService extends Mock implements ISessionService {}

class MockGetAccessTokenUsernameUsecase extends Mock
    implements GetAccessTokenUsernameUsecase {}

class FakeEmployeeDto extends Fake implements EmployeeDto {
  FakeEmployeeDto({required this.id, this.faceRegistered});

  @override
  String id;

  @override
  String? faceRegistered;
}

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

class MockGetClockingEventUsecase extends Mock
    implements GetClockingEventUseUsecase {}

void main() {
  late ShowFaceRegistrationMessageUsecase showFaceRegistrationMessageUsecase;
  late ISharedPreferencesService sharedPreferencesService;
  late ISessionService sessionService;
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  late GetAccessTokenUsernameUsecase getAccessTokenUsernameUsecase;
  late GetClockingEventUseUsecase getClockingEventUsecaseMock;

  setUp(() {
    sharedPreferencesService = MockSharedPreferencesService();
    sessionService = MockSessionService();
    faceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();
    getAccessTokenUsernameUsecase = MockGetAccessTokenUsernameUsecase();

    when(() => getAccessTokenUsernameUsecase.call())
        .thenAnswer((_) async => 'username@tenant.com.br');
    getClockingEventUsecaseMock = MockGetClockingEventUsecase();
    when(() => sessionService.hasEmployee()).thenReturn(true);
    var fakeEmployeeDto = FakeEmployeeDto(
      id: '4dac8f77-fca8-434d-b40a-c2d9726d381f',
    );
    when(() => sessionService.getEmployee()).thenReturn(fakeEmployeeDto);
    when(() => sessionService.getConfiguration())
        .thenReturn(configurationDTOMock);
    when(
      () =>
          faceRecognitionSdkAuthenticationService.getInitializationIsRunning(),
    ).thenAnswer((_) => false);

    when(
      () => sharedPreferencesService.getFeatureToggle(
        executionModeEnum: ExecutionModeEnum.individual,
        employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
        featureToggle: FeatureToggleEnum.faceRecognition,
      ),
    ).thenAnswer((_) async => true);

    when(
      () => sharedPreferencesService.getUserPermission(
        userName: 'username@tenant.com.br',
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.facialAuth.resource,
      ),
    ).thenAnswer((_) async => true);
    when(
      () => getClockingEventUsecaseMock.call(
        '2',
        '4dac8f77-fca8-434d-b40a-c2d9726d381f',
      ),
    ).thenAnswer((_) async => ClockingEventUseType.clockingEvent);

    showFaceRegistrationMessageUsecase = ShowFaceRegistrationMessageUsecaseImpl(
      sessionService: sessionService,
      sharedPreferencesService: sharedPreferencesService,
      faceRecognitionSdkAuthenticationService:
          faceRecognitionSdkAuthenticationService,
      getAccessTokenUsernameUsecase: getAccessTokenUsernameUsecase,
      getClockingEventUseUsecase: getClockingEventUsecaseMock,
    );
  });

  group('ShowFaceRegistrationMessageUsecase', () {
    test('returns false when there is no employee in the session test',
        () async {
      when(() => sessionService.hasEmployee()).thenReturn(false);
      expect(await showFaceRegistrationMessageUsecase.call('2'), false);
    });

    test('returns false when you already have a registered face test',
        () async {
      when(() => sessionService.getEmployee()).thenReturn(
        FakeEmployeeDto(
          id: 'a279db80-364f-4a8a-a1f8-851a1f3977f1',
          faceRegistered: 'a279db80364f4a8aa1f8851a1f3977f1',
        ),
      );
      expect(await showFaceRegistrationMessageUsecase.call('2'), false);
    });

    test('returns false when recognition configuration is denied test',
        () async {
        ConfigurationDto config = ConfigurationDto(
        onlyOnline: true,
        operationMode: OperationModeType.single,
        timezone: '03:00',
        takePhoto: true,
      );

      when(() => sessionService.getConfiguration()).thenReturn(config);

      expect(await showFaceRegistrationMessageUsecase.call('2'), false);
    });

    test('returns true test', () async {
      expect(await showFaceRegistrationMessageUsecase.call('2'), true);
    });
  });
}
