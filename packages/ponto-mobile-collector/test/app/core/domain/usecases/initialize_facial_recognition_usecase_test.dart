import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iconfiguration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/platform/iplatform_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_session_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/initialize_facial_recognition_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';

import '../../../../mocks/configuration_entity_mock.dart';
import '../../../../mocks/employee_dto_mock.dart';

class MockGetSessionEmployeeUsecase extends Mock
    implements GetSessionEmployeeUsecase {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class MockPlatformService extends Mock implements IPlatformService {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

class MockAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

void main() {
  late InitializeFacialRecognitionUsecase initializeFacialRecognitionUsecase;
  late GetSessionEmployeeUsecase getSessionEmployeeUsecase;
  late IConfigurationRepository configurationRepository;
  late IPlatformService platformService;
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  const String token = 'token';

  setUp(() {
    getSessionEmployeeUsecase = MockGetSessionEmployeeUsecase();
    configurationRepository = MockConfigurationRepository();
    platformService = MockPlatformService();
    faceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    getAccessTokenUsecase = MockAccessTokenUsecase();

    when(
      () => getSessionEmployeeUsecase.call(),
    ).thenReturn(employeeMockDto);

    when(
      () => configurationRepository.findByEmployeeId(
        employeeId: employeeDtoMock.id,
      ),
    ).thenAnswer((_) async => configurationEntityMock);

    when(
      () => getExecutionModeUsecase.call(),
    ).thenAnswer(
      (_) async => ExecutionModeEnum.individual,
    );

    when(() => faceRecognitionSdkAuthenticationService.initialize())
        .thenAnswer((_) async => {});

    initializeFacialRecognitionUsecase = InitializeFacialRecognitionUsecaseImpl(
      configurationRepository: configurationRepository,
      faceRecognitionSdkAuthenticationService:
          faceRecognitionSdkAuthenticationService,
      getSessionEmployeeUsecase: getSessionEmployeeUsecase,
      getExecutionModeUsecase: getExecutionModeUsecase,
      getAccessTokenUsecase: getAccessTokenUsecase,
    );
  });

  group('InitializeFacialRecognitionUsecase', () {
    test('should init successfully in idividual mode test', () async {
      await initializeFacialRecognitionUsecase.call();

      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      verify(
        () => getSessionEmployeeUsecase.call(),
      ).called(1);

      verify(
        () => configurationRepository.findByEmployeeId(
          employeeId: employeeDtoMock.id,
        ),
      ).called(1);

      verify(() => faceRecognitionSdkAuthenticationService.initialize())
          .called(1);
      verify(() => getExecutionModeUsecase.call());

      verifyNoMoreInteractions(getSessionEmployeeUsecase);
      verifyNoMoreInteractions(configurationRepository);
      verifyNoMoreInteractions(platformService);
      verifyNoMoreInteractions(faceRecognitionSdkAuthenticationService);
    });

    test('should init successfully in multiple mode test', () async {
      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => token);

      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer(
        (_) async => ExecutionModeEnum.multiple,
      );

      await initializeFacialRecognitionUsecase.call();

      debugDefaultTargetPlatformOverride = TargetPlatform.android;

      verify(() => faceRecognitionSdkAuthenticationService.initialize())
          .called(1);

      verify(() => getExecutionModeUsecase.call());
      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.key));
      verifyZeroInteractions(getSessionEmployeeUsecase);
      verifyZeroInteractions(configurationRepository);
      verifyZeroInteractions(platformService);
      verifyNoMoreInteractions(faceRecognitionSdkAuthenticationService);
    });
  });
}
