import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/deauthenticate_user_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/remove_application_key_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/cubit/application_key_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/cubit/application_key_state.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../mocks/clocking_event_mock.dart';
import '../../../../../../mocks/token_mock.dart';

class MockGetTokenUsecase extends Mock implements GetTokenUsecase {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

class MockCheckUserPermissionUsecase extends Mock
    implements CheckUserPermissionUsecase {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockIUtils extends Mock implements IUtils {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockHasConnectivityUsecase extends Mock
    implements IHasConnectivityUsecase {}

class MockRemoveApplicationKeyUsecase extends Mock
    implements RemoveApplicationKeyUsecase {}

class MockDeauthenticateUserUsecase extends Mock
    implements DeauthenticateUserUsecase {}

void main() {
  late ApplicationKeyCubit applicationKeyCubit;
  late GetTokenUsecase mockGetTokenUsecase;
  late GetAccessTokenUsecase mockGetAccessTokenUsecase;
  late CheckUserPermissionUsecase mockCheckUserPermissionUsecase;
  late ISharedPreferencesService sharedPreferencesService;
  late IUtils utils;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late IClockingEventRepository clockingEventRepository;
  late IHasConnectivityUsecase hasConnectivityUsecase;
  late RemoveApplicationKeyUsecase removeApplicationKeyUsecase;
  late DeauthenticateUserUsecase deauthenticateUserUsecase;

  setUp(
    () {
      mockGetTokenUsecase = MockGetTokenUsecase();
      mockGetAccessTokenUsecase = MockGetAccessTokenUsecase();
      mockCheckUserPermissionUsecase = MockCheckUserPermissionUsecase();
      sharedPreferencesService = MockSharedPreferencesService();
      utils = MockIUtils();
      getExecutionModeUsecase = MockGetExecutionModeUsecase();
      clockingEventRepository = MockClockingEventRepository();
      hasConnectivityUsecase = MockHasConnectivityUsecase();
      removeApplicationKeyUsecase = MockRemoveApplicationKeyUsecase();
      deauthenticateUserUsecase = MockDeauthenticateUserUsecase();

      when(
        () => mockGetTokenUsecase.call(tokenType: TokenType.user),
      ).thenAnswer((_) async => tokenMock);

      when(
        () => mockCheckUserPermissionUsecase.call(
          userPermissionCheckEntity: any(named: 'userPermissionCheckEntity'),
          tokenType: any(named: 'tokenType'),
        ),
      ).thenAnswer(
        (_) async => const UserPermissionsEntity(
          authorized: true,
          permissions: [
            UserPermissionEntity(
              action: 'action',
              resource: 'resource',
              authorized: true,
              owner: true,
            ),
          ],
        ),
      );

      when(
        () => sharedPreferencesService.setTenant(value: 'tenant.com.br'),
      ).thenAnswer((_) async => {});

      when(
        () => sharedPreferencesService.setExecuteSyncAllInfoOnStartup(
          value: true,
        ),
      ).thenAnswer((_) async => {});

      when(
        () => utils.getTenantFromUsername(
          username: 'username@tenant.com.br',
        ),
      ).thenReturn('tenant.com.br');

      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.multiple);

      applicationKeyCubit = ApplicationKeyCubit(
        getTokenUsecase: mockGetTokenUsecase,
        getAccessTokenUsecase: mockGetAccessTokenUsecase,
        checkUserPermissionUsecase: mockCheckUserPermissionUsecase,
        sharedPreferencesService: sharedPreferencesService,
        utils: utils,
        getExecutionModeUsecase: getExecutionModeUsecase,
        deauthenticateUserUsecase: deauthenticateUserUsecase,
        clockingEventRepository: clockingEventRepository,
        hasConnectivityUsecase: hasConnectivityUsecase,
        removeApplicationKeyUsecase: removeApplicationKeyUsecase,
      );
    },
  );

  group('ApplicationKeyCubit', () {
    blocTest(
      'call KeyRegisteredSuccessfully state',
      build: () {
        when(
          () => hasConnectivityUsecase.call(),
        ).thenAnswer(
          (_) async => true,
        );

        applicationKeyCubit.keyAlreadyRegistered = false;
        when(() => mockGetAccessTokenUsecase.call(tokenType: TokenType.key))
            .thenAnswer((_) async => tokenMock.accessToken);
        return applicationKeyCubit;
      },
      act: (bloc) => bloc.loadContent(),
      expect: () => [
        isA<LoadingUserIsAuthenticatedState>(),
        isA<KeyRegisteredSuccessfullyState>(),
      ],
      verify: (bloc) {
        verify(
          () => mockGetAccessTokenUsecase.call(tokenType: TokenType.key),
        ).called(1);
        verify(
          () => sharedPreferencesService.setTenant(value: 'tenant.com.br'),
        );
        verify(
          () => sharedPreferencesService.setExecuteSyncAllInfoOnStartup(
            value: true,
          ),
        );

        verify(
          () => utils.getTenantFromUsername(
            username: 'username@tenant.com.br',
          ),
        );
        verifyNoMoreInteractions(mockGetAccessTokenUsecase);
        verifyNoMoreInteractions(sharedPreferencesService);
        verifyNoMoreInteractions(utils);
      },
    );
    blocTest(
      'call KeyAlreadyRegistered state',
      build: () {
        when(
          () => hasConnectivityUsecase.call(),
        ).thenAnswer(
          (_) async => true,
        );

        when(() => mockGetAccessTokenUsecase.call(tokenType: TokenType.key))
            .thenAnswer((_) async => tokenMock.accessToken);
        return applicationKeyCubit;
      },
      act: (bloc) => bloc.loadContent(),
      expect: () => [
        isA<LoadingUserIsAuthenticatedState>(),
        isA<KeyAlreadyRegisteredState>(),
      ],
      verify: (bloc) {
        verify(
          () => mockGetAccessTokenUsecase.call(tokenType: TokenType.key),
        ).called(1);
        verifyNoMoreInteractions(mockGetAccessTokenUsecase);
      },
    );

    blocTest(
      'call ReadContentSetKeyState state',
      build: () {
        when(
          () => hasConnectivityUsecase.call(),
        ).thenAnswer(
          (_) async => true,
        );

        when(() => mockGetAccessTokenUsecase.call(tokenType: TokenType.key))
            .thenAnswer((_) async => null);

        when(() => mockGetTokenUsecase.call(tokenType: TokenType.user))
            .thenAnswer((_) async => tokenMock);

        return applicationKeyCubit;
      },
      act: (bloc) => bloc.loadContent(),
      expect: () => [
        isA<LoadingUserIsAuthenticatedState>(),
        isA<ReadContentSetKeyState>(),
      ],
      verify: (bloc) {
        verify(
          () => mockGetAccessTokenUsecase.call(tokenType: TokenType.key),
        ).called(1);
        verify(
          () => mockGetTokenUsecase.call(tokenType: TokenType.user),
        ).called(1);
        verifyNoMoreInteractions(mockGetAccessTokenUsecase);
      },
    );

    blocTest(
      'call HasNoConnectivityState state',
      build: () {
        applicationKeyCubit.keyAlreadyRegistered = true;

        when(
          () => hasConnectivityUsecase.call(),
        ).thenAnswer(
          (_) async => false,
        );

        return applicationKeyCubit;
      },
      act: (bloc) => bloc.loadContent(),
      expect: () => [
        isA<HasNoConnectivityState>(),
      ],
      verify: (bloc) {
        verify(
          () => hasConnectivityUsecase.call(),
        ).called(1);

        verifyNoMoreInteractions(hasConnectivityUsecase);
      },
    );

    blocTest(
      'call LoadingUserIsAuthenticatedState state',
      build: () {
        when(
          () => hasConnectivityUsecase.call(),
        ).thenAnswer(
          (_) async => true,
        );

        when(() => mockGetAccessTokenUsecase.call(tokenType: TokenType.key))
            .thenAnswer((_) async => null);

        when(() => mockGetTokenUsecase.call(tokenType: TokenType.user))
            .thenAnswer((_) async => null);

        return applicationKeyCubit;
      },
      act: (bloc) => bloc.loadContent(),
      expect: () => [
        isA<LoadingUserIsAuthenticatedState>(),
        isA<UserNotAuthenticatedState>(),
      ],
      verify: (bloc) {
        verifyNever(
          () => mockGetAccessTokenUsecase.call(tokenType: TokenType.key),
        );
        verify(
          () => mockGetTokenUsecase.call(tokenType: TokenType.user),
        ).called(1);

        verifyNoMoreInteractions(mockGetAccessTokenUsecase);
      },
    );

    blocTest<ApplicationKeyCubit, ApplicationKeyBaseState>(
      'add removeKeys | emit [ConfirmRemoveKeysState]',
      build: () => applicationKeyCubit,
      seed: () => KeyAlreadyRegisteredState(),
      act: (bloc) => bloc.removeKeys(),
      expect: () => [
        isA<ConfirmRemoveKeysState>(),
      ],
    );

    blocTest<ApplicationKeyCubit, ApplicationKeyBaseState>(
      'add removeKeys | emit [VerifyingUnsycedClockingEventsState, RemovingKeysState, KeysRemovedState]',
      build: () {
        when(
          () => clockingEventRepository.findAllUnsynced(limit: null),
        ).thenAnswer(
          (_) async => [],
        );

        when(
          () => removeApplicationKeyUsecase.call(),
        ).thenAnswer(
          (_) async {},
        );

        return applicationKeyCubit;
      },
      seed: () => ConfirmRemoveKeysState(),
      act: (bloc) => bloc.removeKeys(),
      expect: () => [
        isA<VerifyingUnsycedClockingEventsState>(),
        isA<RemovingKeysState>(),
        isA<KeysRemovedState>(),
      ],
    );

    blocTest<ApplicationKeyCubit, ApplicationKeyBaseState>(
      'add removeKeys | emit [VerifyingUnsycedClockingEventsState, RemovingKeysState, RemoveKeyErrorState, KeyAlreadyRegisteredState]',
      build: () {
        when(
          () => clockingEventRepository.findAllUnsynced(limit: null),
        ).thenAnswer(
          (_) async => [],
        );

        when(
          () => removeApplicationKeyUsecase.call(),
        ).thenThrow(
          Exception(),
        );

        return applicationKeyCubit;
      },
      seed: () => ConfirmRemoveKeysState(),
      act: (bloc) => bloc.removeKeys(),
      expect: () => [
        isA<VerifyingUnsycedClockingEventsState>(),
        isA<RemovingKeysState>(),
        isA<RemoveKeyErrorState>(),
        isA<KeyAlreadyRegisteredState>(),
      ],
    );

    blocTest<ApplicationKeyCubit, ApplicationKeyBaseState>(
      'add removeKeys | emit [VerifyingUnsycedClockingEventsState, VerifyingConnectivityState, HasUnsyncedClockingEventsState]',
      build: () {
        when(
          () => clockingEventRepository.findAllUnsynced(limit: null),
        ).thenAnswer(
          (_) async => [
            clockingEventMock,
          ],
        );

        return applicationKeyCubit;
      },
      seed: () => ConfirmRemoveKeysState(),
      act: (bloc) => bloc.removeKeys(),
      expect: () => [
        isA<VerifyingUnsycedClockingEventsState>(),
        isA<HasUnsyncedClockingEventsState>(),
      ],
    );

    blocTest<ApplicationKeyCubit, ApplicationKeyBaseState>(
      'add cancelRemoveKeys | emit [KeyAlreadyRegisteredState]',
      build: () => applicationKeyCubit,
      act: (bloc) => bloc.cancelRemoveKeys(),
      expect: () => [
        isA<KeyAlreadyRegisteredState>(),
      ],
    );

    test('logoffUser test', () async {
      when(
        () => deauthenticateUserUsecase.call(),
      ).thenAnswer((_) async => {});

      applicationKeyCubit.initialExecutionMode = ExecutionModeEnum.multiple;

      await applicationKeyCubit.logoffUser();

      when(() => deauthenticateUserUsecase.call());
    });
  });
}
