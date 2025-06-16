// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/encryption_key_mock.dart';
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

  setUpAll(() => SeniorAuthentication.initialize(
        enableLoginOffline: true,
        enableBiometry: true,
        encryptionKey: encryptionKeyMock,
      ));

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
          status: NetworkStatus.loading,
          username: tUsername,
          password: tPassword,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          authenticationFlow: AuthenticationFlow.biometryFlow,
          authenticationResponse: authenticationResponseMock,
          biometryFlow: true,
        ),
      ],
    );
  });
}
