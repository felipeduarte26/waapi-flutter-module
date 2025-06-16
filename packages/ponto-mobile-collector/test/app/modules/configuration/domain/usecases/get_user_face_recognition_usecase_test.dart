import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_session_employee_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/configuration_entity_mock.dart';
import '../../../../../mocks/employee_dto_mock.dart';

class MockGetSessionEmployeeUsecase extends Mock
    implements GetSessionEmployeeUsecase {}

class MockConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class MockPlatformService extends Mock implements IPlatformService {}

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

void main() {
  late IGetUserFaceRecognitionUsecase getUserFaceRecognitionUsecase;
  late GetSessionEmployeeUsecase getSessionEmployeeUsecase;
  late IConfigurationRepository configurationRepository;
  late IPlatformService platformService;

  setUp(() {
    getSessionEmployeeUsecase = MockGetSessionEmployeeUsecase();
    configurationRepository = MockConfigurationRepository();
    platformService = MockPlatformService();

    when(
      () => getSessionEmployeeUsecase.call(),
    ).thenReturn(employeeMockDto);

    when(
      () => configurationRepository.findByEmployeeId(
        employeeId: employeeDtoMock.id,
      ),
    ).thenAnswer((_) async => configurationEntityMock);

    getUserFaceRecognitionUsecase = GetUserFaceRecognitionUsecase(
      configurationRepository: configurationRepository,
      getSessionEmployeeUsecase: getSessionEmployeeUsecase,
    );
  });

  group('IGetUserFaceRecognitionUsecase', () {
    test('should init successfully test', () async {
      expect(await getUserFaceRecognitionUsecase.call(), true);

      verify(
        () => getSessionEmployeeUsecase.call(),
      ).called(1);

      verify(
        () => configurationRepository.findByEmployeeId(
          employeeId: employeeDtoMock.id,
        ),
      ).called(1);

      verifyNoMoreInteractions(getSessionEmployeeUsecase);
      verifyNoMoreInteractions(configurationRepository);
      verifyNoMoreInteractions(platformService);
    });
  });
}
