// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/hash_info_mock.dart';
import '../../../../mocks/mfa_info_mock.dart';
import '../../../../mocks/tenant_login_settings_mock.dart';
import '../../../../mocks/token_mock.dart';

class MockGetTenantLoginSettingsUsecase extends Mock
    implements GetTenantLoginSettingsUsecase {}

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockCheckStatusConnectionUsecase extends Mock
    implements CheckStatusConnectionUsecase {}

class MockGetStoredTokenUsecase extends Mock implements GetStoredTokenUsecase {}

class MockLoginOfflineUsecase extends Mock implements LoginOfflineUsecase {}

class MockCheckStoredTokenUsecase extends Mock
    implements CheckStoredTokenUsecase {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late GetTenantLoginSettingsUsecase getTenantLoginSettingsUsecase;
  late LoginUsecase loginUsecase;
  late LoginOfflineUsecase loginOfflineUsecase;
  late AuthenticationBloc authenticationBloc;
  late UserNameAuthenticationCubit userNameAuthenticationCubit;
  late CheckStatusConnectionUsecase checkStatusConnectionUsecase;
  late GetStoredTokenUsecase getStoredTokenUsecase;
  late CheckStoredTokenUsecase checkStoredTokenUsecase;
  late SecureStorageRepository secureStorageRepository;
  const tUsername = 'teste@senior.com.br';
  const tPassword = 'Teste1!';

  setUpAll(
    () => SeniorAuthentication.initialize(
      enableLoginOffline: true,
      encryptionKey: encryptionKeyMock,
    ),
  );

  setUp(() {
    getTenantLoginSettingsUsecase = MockGetTenantLoginSettingsUsecase();
    loginUsecase = MockLoginUsecase();
    loginOfflineUsecase = MockLoginOfflineUsecase();
    authenticationBloc = MockAuthenticationBloc();
    getStoredTokenUsecase = MockGetStoredTokenUsecase();
    checkStatusConnectionUsecase = MockCheckStatusConnectionUsecase();
    secureStorageRepository = MockSecureStorageRepository();
    checkStoredTokenUsecase = MockCheckStoredTokenUsecase();

    userNameAuthenticationCubit = UserNameAuthenticationCubit(
      checkStoredTokenUsecase: checkStoredTokenUsecase,
      secureStorageRepository: secureStorageRepository,
      authenticationBloc: authenticationBloc,
      loginUsecase: loginUsecase,
      getTenantLoginSettingsUsecase: getTenantLoginSettingsUsecase,
      checkStatusConnectionUsecase: checkStatusConnectionUsecase,
      getStoredTokenUsecase: getStoredTokenUsecase,
      loginOfflineUsecase: loginOfflineUsecase,
    );

    registerFallbackValue(NoParams());
    registerFallbackValue(UserName());
  });

  group('onUserNameChanged', () {
    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits current state with new userName when onUserNameChanged '
      'event is fired with userName text',
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState.initial(),
      act: (cubit) => cubit.onUserNameChanged(tUsername),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState.initial().copyWith(username: tUsername),
      ],
    );
  });

  group('onPasswordChanged', () {
    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits current state with new userName when onUserNameChanged '
      'event is fired with userName text',
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState.initial(),
      act: (cubit) => cubit.onPasswordChanged(tPassword),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState.initial().copyWith(password: tPassword),
      ],
    );
  });

  group('login', () {
    const tUserLogin = UserLogin(
      username: tUsername,
      password: tPassword,
    );
    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when login executes successfully online',
      setUp: () {
        when(() => loginUsecase.call(tUserLogin))
            .thenAnswer((_) async => authenticationResponseMock);

        when(() => checkStatusConnectionUsecase.call(NoParams()))
            .thenAnswer((_) async => true);
      },
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: tPassword,
        tenantLoginSettings: tenantLoginSettingsMock,
        errorType: null,
        authenticationFlow: AuthenticationFlow.password,
      ),
      act: (cubit) => cubit.login(),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when login executes successfully online but there is no token',
      setUp: () {
        when(() => loginUsecase.call(tUserLogin))
            .thenAnswer((_) async => invalidAuthenticationResponseMock);

        when(() => checkStatusConnectionUsecase.call(NoParams()))
            .thenAnswer((_) async => true);
      },
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: tPassword,
        tenantLoginSettings: tenantLoginSettingsMock,
        errorType: null,
        authenticationFlow: AuthenticationFlow.password,
      ),
      act: (cubit) => cubit.login(),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: ErrorType.unknown,
          authenticationFlow: AuthenticationFlow.password,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
          mfaInfo: null,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when login executes successfully offline',
      setUp: () {
        when(() => loginUsecase.call(tUserLogin))
            .thenAnswer((_) async => authenticationResponseMock);

        when(() => checkStatusConnectionUsecase.call(NoParams()))
            .thenAnswer((_) async => false);

        when(() => checkStoredTokenUsecase
                .call(UserName(currentUsername: tUsername)))
            .thenAnswer((_) async => true);

        when(() => getStoredTokenUsecase
                .call(UserName(currentUsername: tUsername)))
            .thenAnswer((_) async => (token: tokenMock, exception: null));

        when(() => loginOfflineUsecase.call(hashInfoMock))
            .thenAnswer((_) async => true);

        when(() => secureStorageRepository.writeLastUser(tUsername, ''))
            .thenAnswer((_) async {
          return;
        });
      },
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: tPassword,
        tenantLoginSettings: null,
        errorType: null,
        authenticationFlow: AuthenticationFlow.password,
      ),
      act: (cubit) => cubit.login(),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: null,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: null,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
          authenticationResponse: authenticationResponseMock,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when login executes successfully with MFAInfo CONFIGURED',
      setUp: () {
        when(() => loginUsecase.call(tUserLogin))
            .thenAnswer((_) async => authenticationResponseMfaConfiguredMock);

        when(() => checkStatusConnectionUsecase.call(NoParams()))
            .thenAnswer((_) async => true);
      },
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: tPassword,
        tenantLoginSettings: tenantLoginSettingsMock,
        errorType: null,
        authenticationFlow: AuthenticationFlow.password,
      ),
      act: (cubit) => cubit.login(),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.mfa,
          mfaInfo: mfaInfoConfiguredMock,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
          mfaInfo: mfaInfoConfiguredMock,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
          mfaInfo: mfaInfoConfiguredMock,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when login executes successfully with MFAInfo not CONFIGURED',
      setUp: () {
        when(() => loginUsecase.call(tUserLogin)).thenAnswer(
            (_) async => authenticationResponseMfaNotConfiguredMock);

        when(() => checkStatusConnectionUsecase.call(NoParams()))
            .thenAnswer((_) async => true);
      },
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: tPassword,
        tenantLoginSettings: tenantLoginSettingsMock,
        errorType: null,
        authenticationFlow: AuthenticationFlow.password,
      ),
      act: (cubit) => cubit.login(),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.mfa,
          mfaInfo: mfaInfoNotConfiguredMock,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
          mfaInfo: mfaInfoNotConfiguredMock,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
          mfaInfo: mfaInfoNotConfiguredMock,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when login fails with UnauthorizedException',
      setUp: () {
        when(() => loginUsecase.call(tUserLogin))
            .thenThrow(UnauthorizedException());

        when(() => checkStatusConnectionUsecase.call(NoParams()))
            .thenAnswer((_) async => true);
      },
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: tPassword,
        tenantLoginSettings: tenantLoginSettingsMock,
        errorType: null,
        authenticationFlow: AuthenticationFlow.unknown,
      ),
      act: (cubit) => cubit.login(),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: ErrorType.unauthorized,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when login fails with Unknown error',
      setUp: () {
        when(() => loginUsecase.call(tUserLogin)).thenThrow(Exception('Opps'));

        when(() => checkStatusConnectionUsecase.call(NoParams()))
            .thenAnswer((_) async => true);
      },
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: tPassword,
        tenantLoginSettings: tenantLoginSettingsMock,
        errorType: null,
        authenticationFlow: AuthenticationFlow.unknown,
      ),
      act: (cubit) => cubit.login(),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: ErrorType.unknown,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
      ],
    );
  });

  group('getTenantLoginSettings', () {
    TenantLogin tTenantLogin =
        TenantLogin(tenantDomain: tUsername.split('@')[1], userName: tUsername);
    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when getTenantLoginSettings executes successfully',
      setUp: () {
        when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
          (_) async => true,
        );

        when(() => getTenantLoginSettingsUsecase.call(tTenantLogin)).thenAnswer(
          (_) async => tenantLoginSettingsMock,
        );
      },
      build: () => userNameAuthenticationCubit,
      seed: () => const UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: '',
        tenantLoginSettings: null,
        errorType: null,
        authenticationFlow: AuthenticationFlow.password,
      ),
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <UserNameAuthenticationState>[
        const UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: '',
          tenantLoginSettings: null,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: '',
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.password,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when getTenantLoginSettings fails with TenantNotFoundException',
      setUp: () {
        when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
          (_) async => true,
        );

        when(() => getTenantLoginSettingsUsecase.call(tTenantLogin))
            .thenThrow(TenantNotFoundException());
      },
      build: () => userNameAuthenticationCubit,
      seed: () => const UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: '',
        tenantLoginSettings: null,
        errorType: null,
        authenticationFlow: AuthenticationFlow.unknown,
      ),
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <UserNameAuthenticationState>[
        const UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: '',
          tenantLoginSettings: null,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        const UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: '',
          tenantLoginSettings: null,
          errorType: ErrorType.tenantNotFound,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        const UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: '',
          tenantLoginSettings: null,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when getTenantLoginSettings fails with Unknown error',
      setUp: () {
        when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
          (_) async => true,
        );

        when(() => getTenantLoginSettingsUsecase.call(tTenantLogin))
            .thenThrow(Exception('Opps'));
      },
      build: () => userNameAuthenticationCubit,
      seed: () => const UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: '',
        tenantLoginSettings: null,
        errorType: null,
        authenticationFlow: AuthenticationFlow.unknown,
      ),
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <UserNameAuthenticationState>[
        const UserNameAuthenticationState(
          status: NetworkStatus.loading,
          username: tUsername,
          password: '',
          tenantLoginSettings: null,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        const UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: '',
          tenantLoginSettings: null,
          errorType: ErrorType.unknown,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
        const UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: '',
          tenantLoginSettings: null,
          errorType: null,
          authenticationFlow: AuthenticationFlow.unknown,
        ),
      ],
    );

    blocTest<UserNameAuthenticationCubit, UserNameAuthenticationState>(
      'emits correct states when getTenantLoginSettings not executes because is offline',
      setUp: () {
        when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
          (_) async => false,
        );

        when(() => getStoredTokenUsecase
            .call(UserName(currentUsername: tUsername))).thenAnswer(
          (_) async => (token: tokenMock, exception: null),
        );

        when(() => checkStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => userNameAuthenticationCubit,
      seed: () => UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: tUsername,
        password: '',
        errorType: null,
        authenticationFlow: AuthenticationFlow.unknown,
      ),
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <UserNameAuthenticationState>[
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: tUsername,
          password: '',
          authenticationFlow: AuthenticationFlow.offline,
          errorType: null,
        ),
      ],
    );
  });
}
