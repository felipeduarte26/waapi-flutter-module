import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/check_feature_toggle_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_feature_toggle_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/feature_toggle_enum.dart';

class MockCheckFeatureToggleRepository extends Mock
    implements CheckFeatureToggleRepository {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockHasConnectivityUsecase extends Mock
    implements IHasConnectivityUsecase {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

void main() {
  const String tTenantName = 'tTenantName';
  const String tEmployeeId = 'tEmployeeId';
  const String token = 'token';
  late CheckFeatureToggleUsecase checkFeatureToggleUsecase;
  late CheckFeatureToggleRepository checkFeatureToggleRepository;
  late GetAccessTokenUsecase getAccessTokenUsecase;
  late ISharedPreferencesService sharedPreferencesService;
  late IHasConnectivityUsecase hasConnectivityUsecase;
  late GetExecutionModeUsecase getExecutionModeUsecase;

  setUp(() {
    checkFeatureToggleRepository = MockCheckFeatureToggleRepository();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();
    sharedPreferencesService = MockSharedPreferencesService();
    hasConnectivityUsecase = MockHasConnectivityUsecase();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();

    checkFeatureToggleUsecase = CheckFeatureToggleUsecaseImpl(
      checkFeatureToggleRepository: checkFeatureToggleRepository,
      getExecutionModeUsecase: getExecutionModeUsecase,
      getAccessTokenUsecase: getAccessTokenUsecase,
      hasConnectivityUsecase: hasConnectivityUsecase,
      sharedPreferencesService: sharedPreferencesService,
    );
  });
  group('CheckFeatureToggleUsecase', () {
    test('Should return false when token is null test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer(
        (_) async => ExecutionModeEnum.multiple,
      );

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer(
        (_) async => null,
      );

      bool featureAccess = await checkFeatureToggleUsecase.call(
        featureToggle: FeatureToggleEnum.faceRecognition,
      );

      expect(featureAccess, false);

      verify(() => getExecutionModeUsecase.call()).called(1);
      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.key))
          .called(1);

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
    });

    test('Must return success when with key token test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer(
        (_) async => ExecutionModeEnum.multiple,
      );

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer(
        (_) async => token,
      );

      when(
        () => hasConnectivityUsecase.call(),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => sharedPreferencesService.getTenant(),
      ).thenAnswer(
        (_) async => tTenantName,
      );

      when(
        () => checkFeatureToggleRepository.call(
          featureToggle: FeatureToggleEnum.faceRecognition,
          tokenType: TokenType.key,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => sharedPreferencesService.setFeatureToggle(
          employeeIdOrTenant: tTenantName,
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
          value: true,
        ),
      ).thenAnswer((_) async => {});

      bool featureAccess = await checkFeatureToggleUsecase.call(
        featureToggle: FeatureToggleEnum.faceRecognition,
      );

      expect(featureAccess, true);

      verify(() => getExecutionModeUsecase.call());
      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.key));
      verify(() => hasConnectivityUsecase.call());
      verify(() => sharedPreferencesService.getTenant());
      verify(
        () => checkFeatureToggleRepository.call(
          featureToggle: FeatureToggleEnum.faceRecognition,
          tokenType: TokenType.key,
        ),
      );
      verify(
        () => sharedPreferencesService.setFeatureToggle(
          employeeIdOrTenant: tTenantName,
          executionModeEnum: ExecutionModeEnum.multiple,
          featureToggle: FeatureToggleEnum.faceRecognition,
          value: true,
        ),
      ).called(1);

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
      verifyNoMoreInteractions(hasConnectivityUsecase);
      verifyNoMoreInteractions(sharedPreferencesService);
      verifyNoMoreInteractions(checkFeatureToggleRepository);
    });

    test('Must return success when with user token and no connection test',
        () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.individual);

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.user),
      ).thenAnswer((_) async => token);

      when(
        () => hasConnectivityUsecase.call(),
      ).thenAnswer((_) async => true);

      when(
        () => sharedPreferencesService.getSessionEmployeeId(),
      ).thenAnswer((_) async => tEmployeeId);

      when(
        () => checkFeatureToggleRepository.call(
          featureToggle: FeatureToggleEnum.faceRecognition,
          tokenType: TokenType.user,
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => sharedPreferencesService.setFeatureToggle(
          employeeIdOrTenant: tEmployeeId,
          executionModeEnum: ExecutionModeEnum.individual,
          featureToggle: FeatureToggleEnum.faceRecognition,
          value: true,
        ),
      ).thenAnswer((_) async => {});

      bool featureAccess = await checkFeatureToggleUsecase.call(
        featureToggle: FeatureToggleEnum.faceRecognition,
      );

      expect(featureAccess, true);

      verify(() => getExecutionModeUsecase.call());
      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.user));
      verify(() => hasConnectivityUsecase.call());
      verify(() => sharedPreferencesService.getSessionEmployeeId());
      verify(
        () => checkFeatureToggleRepository.call(
          featureToggle: FeatureToggleEnum.faceRecognition,
          tokenType: TokenType.user,
        ),
      ).called(1);
      verify(
        () => sharedPreferencesService.setFeatureToggle(
          employeeIdOrTenant: tEmployeeId,
          executionModeEnum: ExecutionModeEnum.individual,
          featureToggle: FeatureToggleEnum.faceRecognition,
          value: true,
        ),
      ).called(1);

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
      verifyNoMoreInteractions(hasConnectivityUsecase);
      verifyNoMoreInteractions(sharedPreferencesService);
      verifyNoMoreInteractions(checkFeatureToggleRepository);
    });

    test('Should return false when online only test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.individual);

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.user),
      ).thenAnswer((_) async => token);

      when(
        () => hasConnectivityUsecase.call(),
      ).thenAnswer((_) async => false);

      when(
        () => sharedPreferencesService.getSessionEmployeeId(),
      ).thenAnswer((_) async => tEmployeeId);

      bool featureAccess = await checkFeatureToggleUsecase.call(
        featureToggle: FeatureToggleEnum.faceRecognition,
        onlyOnline: true,
      );

      expect(featureAccess, false);

      verify(() => getExecutionModeUsecase.call());
      verify(() => getAccessTokenUsecase.call(tokenType: TokenType.user));
      verify(() => hasConnectivityUsecase.call());
      verify(() => sharedPreferencesService.getSessionEmployeeId());

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(getAccessTokenUsecase);
      verifyNoMoreInteractions(hasConnectivityUsecase);
      verifyNoMoreInteractions(sharedPreferencesService);
    });
  });
}
