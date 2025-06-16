import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/feature_toggle_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/token_mock.dart';

class MockSessionService extends Mock implements ISessionService {}

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

void main() {
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late ISessionService sessionService;
  late GetTokenUsecase getTokenUsecase;
  late ISharedPreferencesService sharedPreferencesService;

  setUp(() {
    sessionService = MockSessionService();
    getTokenUsecase = MockGetTokenUsecase();
    sharedPreferencesService = MockSharedPreferencesService();

    getExecutionModeUsecase = GetExecutionModeUsecaseImpl(
      getTokenUsecase: getTokenUsecase,
      sessionService: sessionService,
      iSharedPreferencesService: sharedPreferencesService,
    );

    when(
      () => getTokenUsecase.call(tokenType: TokenType.key),
    ).thenAnswer((_) async => null);

    when(() => sessionService.getEmployeeId()).thenReturn('');
    when(
      () => sharedPreferencesService.getFeatureToggle(
        executionModeEnum: ExecutionModeEnum.driver,
        employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
        featureToggle: FeatureToggleEnum.pilotdriver,
      ),
    ).thenAnswer((_) async => true);
  });

  group('GetExecutionModeUsecase', () {
    test('should individual mode successfully test', () async {
      when(
        () => sessionService.hasEmployee(),
      ).thenReturn(true);

      when(
        () => sessionService.getExecutionMode(),
      ).thenReturn(ExecutionModeEnum.individual);

      expect(
        (await getExecutionModeUsecase.call()),
        ExecutionModeEnum.individual,
      );

      verify(
        () => getTokenUsecase.call(tokenType: TokenType.key),
      );

      verify(
        () => sessionService.hasEmployee(),
      );

      verify(
        () => sessionService.getExecutionMode(),
      );

      verify(
        () => sessionService.getEmployeeId(),
      );

      verifyNoMoreInteractions(sessionService);
      verifyNoMoreInteractions(getTokenUsecase);
    });

    test('must return multiple with user in multiple mode test', () async {
      when(
        () => sessionService.hasEmployee(),
      ).thenReturn(true);

      when(
        () => sessionService.getExecutionMode(),
      ).thenReturn(ExecutionModeEnum.multiple);

      expect(
        (await getExecutionModeUsecase.call()),
        ExecutionModeEnum.multiple,
      );

      verify(
        () => getTokenUsecase.call(tokenType: TokenType.key),
      );

      verify(
        () => sessionService.hasEmployee(),
      );

      verify(
        () => sessionService.getExecutionMode(),
      );

      verify(
        () => sessionService.getEmployeeId(),
      );

      verifyNoMoreInteractions(sessionService);
      verifyNoMoreInteractions(getTokenUsecase);
    });

    test(
        'must return multiple with registered application'
        ' key test', () async {
      when(
        () => getTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => tokenMock);

      expect(
        (await getExecutionModeUsecase.call()),
        ExecutionModeEnum.multiple,
      );

      verify(
        () => getTokenUsecase.call(tokenType: TokenType.key),
      );

      verifyNoMoreInteractions(sessionService);
      verifyNoMoreInteractions(getTokenUsecase);
    });

    test(
        'must return multiple when there is no application key'
        ' or logged in user test', () async {
      when(
        () => sessionService.hasEmployee(),
      ).thenReturn(false);

      expect(
        (await getExecutionModeUsecase.call()),
        ExecutionModeEnum.multiple,
      );

      verify(
        () => getTokenUsecase.call(tokenType: TokenType.key),
      );

      verify(
        () => sessionService.hasEmployee(),
      );

      verifyNoMoreInteractions(sessionService);
      verifyNoMoreInteractions(getTokenUsecase);
    });

    test('must return individual when feature toggle is false', () async {
      when(
        () => sessionService.hasEmployee(),
      ).thenReturn(true);

      when(
            () => sessionService.getExecutionMode(),
      ).thenReturn(ExecutionModeEnum.driver);

      when(
        () => sharedPreferencesService.getFeatureToggle(
          executionModeEnum: ExecutionModeEnum.driver,
          employeeIdOrTenant: any(named: 'employeeIdOrTenant'),
          featureToggle: FeatureToggleEnum.pilotdriver,
        ),
      ).thenAnswer((_) async => false);

      expect(
        (await getExecutionModeUsecase.call()),
        ExecutionModeEnum.individual,
      );

      verify(
            () => getTokenUsecase.call(tokenType: TokenType.key),
      );

      verify(
            () => sessionService.hasEmployee(),
      );

      verify(
            () => sessionService.getExecutionMode(),
      );

      verify(
            () => sessionService.getEmployeeId(),
      );

      verifyNoMoreInteractions(sessionService);
      verifyNoMoreInteractions(getTokenUsecase);
    });
  });
}
