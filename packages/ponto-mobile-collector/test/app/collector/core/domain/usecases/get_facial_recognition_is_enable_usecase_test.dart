import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_facial_recognition_is_enable_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_session_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/configuration_entity_mock.dart';
import '../../../../../mocks/employee_dto_mock.dart';

class MockGetSessionEmployeeUsecase extends Mock
    implements GetSessionEmployeeUsecase {}

class MockIConfigurationRepository extends Mock
    implements IConfigurationRepository {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

void main() {
  late GetFacialRecognitionIsEnableUsecase getFacialRecognitionIsEnableUsecase;
  late GetSessionEmployeeUsecase getSessionEmployeeUsecase;
  late IConfigurationRepository configurationRepository;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  const String tToken = 'token';

  setUp(() {
    getSessionEmployeeUsecase = MockGetSessionEmployeeUsecase();
    configurationRepository = MockIConfigurationRepository();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();

    getFacialRecognitionIsEnableUsecase =
        GetFacialRecognitionIsEnableUsecaseImpl(
      getSessionEmployeeUsecase: getSessionEmployeeUsecase,
      configurationRepository: configurationRepository,
      getExecutionModeUsecase: getExecutionModeUsecase,
      getAccessTokenUsecase: getAccessTokenUsecase,
    );
  });

  group('GetFacialRecognitionIsEnableUsecase', () {
    test('return true config on individual mode test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.individual);

      when(
        () => getSessionEmployeeUsecase.call(),
      ).thenReturn(employeeMockDto);

      when(
        () => configurationRepository.findByEmployeeId(
          employeeId: employeeDtoMock.id,
        ),
      ).thenAnswer((_) async => configurationEntityMock);

      expect(await getFacialRecognitionIsEnableUsecase.call(), true);

      verify(() => getExecutionModeUsecase.call());

      verify(() => getSessionEmployeeUsecase.call());

      verify(
        () => configurationRepository.findByEmployeeId(
          employeeId: employeeDtoMock.id,
        ),
      );
    });

    test('return false config on individual mode test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.individual);

      when(
        () => getSessionEmployeeUsecase.call(),
      ).thenReturn(null);

      expect(await getFacialRecognitionIsEnableUsecase.call(), false);

      verify(() => getExecutionModeUsecase.call());

      verify(() => getSessionEmployeeUsecase.call());
    });

    test('return true config on multiple mode test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.multiple);

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => tToken);

      expect(await getFacialRecognitionIsEnableUsecase.call(), true);

      verify(() => getExecutionModeUsecase.call());

      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.key));
    });
  });
}
