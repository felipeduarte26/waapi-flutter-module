// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/domain/entities/key_authentication_data.dart';

import '../../../../../mocks/authentication_data_mock.dart';
import '../../../../../mocks/encryption_key_mock.dart';
import '../../../../../mocks/get_user_input_mock.dart';
import '../../../../../mocks/token_mock.dart';
import '../../../../../mocks/user_mock.dart';

class MockGetUserUsecase extends Mock implements GetUserUsecase {}

class MockStoreAuthenticationDataUsecase extends Mock
    implements StoreAuthenticationDataUsecase {}

class MockCheckStoredTokenUsecase extends Mock
    implements CheckStoredTokenUsecase {}

class MockLogoutOnlineUsecase extends Mock implements LogoutUsecase {}

class MockClearStoredDataUsecase extends Mock
    implements ClearStoredDataUsecase {}

class MockGetStoredTokenUsecase extends Mock implements GetStoredTokenUsecase {}

class MockRefreshStoredTokenUsecase extends Mock
    implements RefreshStoredTokenUsecase {}

class MockCheckStatusConnectionUsecase extends Mock
    implements CheckStatusConnectionUsecase {}

class MockCheckKeyStoredTokenUsecase extends Mock
    implements CheckKeyStoredTokenUsecase {}

class MockClearKeyStoredDataUsecase extends Mock
    implements ClearKeyStoredDataUsecase {}

class MockGetStoredKeyTokenUsecase extends Mock
    implements GetStoredKeyTokenUsecase {}

class MockGetStoredKeyUsecase extends Mock implements GetStoredKeyUsecase {}

class MockRefreshKeyStoredTokenUsecase extends Mock
    implements RefreshKeyStoredTokenUsecase {}

class MockStoreKeyAuthenticationDataUsecase extends Mock
    implements StoreKeyAuthenticationDataUsecase {}

class MockBiometricAuthenticationUsecase extends Mock
    implements BiometricCanCheckUseCase {}

class MockBiometricAuthAuthenticateUseCase extends Mock
    implements BiometricAuthenticateUsecase {}

class MockBiometricAuthCanAuthenticateUseCase extends Mock
    implements BiometricCanCheckUseCase {}

class MockGetStoredUserUsecase extends Mock implements GetStoredUserUsecase {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockSecureStorageRepository extends Mock
    implements SecureStorageRepository {}

void main() {
  late GetUserUsecase getUserUsecase;
  late StoreAuthenticationDataUsecase storeAuthenticationDataUsecase;
  late CheckStoredTokenUsecase checkStoredTokenUsecase;
  late LogoutUsecase logoutOnlineUsecase;
  late ClearStoredDataUsecase clearStoredDataUsecase;
  late GetStoredTokenUsecase getStoredTokenUsecase;
  late AuthenticationBloc authenticationBloc;
  late RefreshStoredTokenUsecase refreshStoredTokenUsecase;
  late CheckStatusConnectionUsecase checkStatusConnectionUsecase;
  late CheckKeyStoredTokenUsecase checkKeyStoredTokenUsecase;
  late ClearKeyStoredDataUsecase clearKeyStoredDataUsecase;
  late GetStoredKeyTokenUsecase getStoredKeyTokenUsecase;
  late GetStoredKeyUsecase getStoredKeyUsecase;
  late RefreshKeyStoredTokenUsecase refreshKeyStoredTokenUsecase;
  late StoreKeyAuthenticationDataUsecase storeAppKeyAuthenticationDataUsecase;
  late BiometricCanCheckUseCase biometricAuthCanAuthenticateUseCase;
  late BiometricAuthenticateUsecase biometricAuthAuthenticateUseCase;
  late GetStoredUserUsecase getStoredUserUsecase;
  late SecureStorageRepository secureStorageRepository;
  const String tUsername = 'username';
  const String tAccessKey = 'accessKey';

  setUpAll(() {
    SeniorAuthentication.initialize(
      enableBiometry: true,
      enableBiometryOnly: true,
      encryptionKey: encryptionKeyMock,
    );
  });

  setUp(() {
    getUserUsecase = MockGetUserUsecase();
    storeAuthenticationDataUsecase = MockStoreAuthenticationDataUsecase();
    checkStoredTokenUsecase = MockCheckStoredTokenUsecase();
    logoutOnlineUsecase = MockLogoutOnlineUsecase();
    getStoredTokenUsecase = MockGetStoredTokenUsecase();
    clearStoredDataUsecase = MockClearStoredDataUsecase();
    refreshStoredTokenUsecase = MockRefreshStoredTokenUsecase();
    checkStatusConnectionUsecase = MockCheckStatusConnectionUsecase();
    checkKeyStoredTokenUsecase = MockCheckKeyStoredTokenUsecase();
    clearKeyStoredDataUsecase = MockClearKeyStoredDataUsecase();
    getStoredKeyTokenUsecase = MockGetStoredKeyTokenUsecase();
    getStoredKeyUsecase = MockGetStoredKeyUsecase();
    refreshKeyStoredTokenUsecase = MockRefreshKeyStoredTokenUsecase();
    storeAppKeyAuthenticationDataUsecase =
        MockStoreKeyAuthenticationDataUsecase();
    biometricAuthCanAuthenticateUseCase =
        MockBiometricAuthCanAuthenticateUseCase();
    biometricAuthAuthenticateUseCase = MockBiometricAuthAuthenticateUseCase();
    getStoredUserUsecase = MockGetStoredUserUsecase();
    secureStorageRepository = MockSecureStorageRepository();
    authenticationBloc = AuthenticationBloc.mocked(
      getUserUsecase: getUserUsecase,
      storeAuthenticationDataUsecase: storeAuthenticationDataUsecase,
      checkStoredTokenUsecase: checkStoredTokenUsecase,
      logoutOnlineUsecase: logoutOnlineUsecase,
      clearStoredDataUsecase: clearStoredDataUsecase,
      getStoredTokenUsecase: getStoredTokenUsecase,
      refreshStoredTokenUsecase: refreshStoredTokenUsecase,
      checkStatusConnectionUsecase: checkStatusConnectionUsecase,
      checkKeyStoredTokenUsecase: checkKeyStoredTokenUsecase,
      clearKeyStoredDataUsecase: clearKeyStoredDataUsecase,
      getStoredKeyTokenUsecase: getStoredKeyTokenUsecase,
      getStoredKeyUsecase: getStoredKeyUsecase,
      refreshKeyStoredTokenUsecase: refreshKeyStoredTokenUsecase,
      storeAppKeyAuthenticationDataUsecase:
          storeAppKeyAuthenticationDataUsecase,
      biometricAuthCanAuthenticateUseCase: biometricAuthCanAuthenticateUseCase,
      biometricAuthAuthenticateUseCase: biometricAuthAuthenticateUseCase,
      getStoredUserUsecase: getStoredUserUsecase,
      secureStorageRepository: secureStorageRepository,
    );
    registerFallbackValue(authenticationDataMock);
    registerFallbackValue(NoParams());
    registerFallbackValue(UserName());
    registerFallbackValue(getUserInputMock);
    registerFallbackValue(encryptionKeyMock);
  });

  group('factory', () {
    test('AuthenticationBloc factory', () {
      final leafAuthenticationBloc = AuthenticationBloc();
      expect(leafAuthenticationBloc, isA<AuthenticationBloc>());
    });
  });

  group('onAuthenticationStatusChanged', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unknown] when AuthenticationStatusChanged '
      'event is fired with AuthenticationStatus.unknown',
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(
          AuthenticationStatus.unknown,
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unknown(),
      ],
      verify: (_) async {
        verifyNever(() => getUserUsecase.call(any()));
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when AuthenticationStatusChanged '
      'event is fired with AuthenticationStatus.unauthenticated',
      build: () => authenticationBloc,
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
      ),
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(
          AuthenticationStatus.unauthenticated,
          biometryStatus: BiometryStatus.success,
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          biometryStatus: BiometryStatus.success,
          keyToken: keyTokenMock,
        ),
      ],
      verify: (_) async {
        verifyNever(() => getUserUsecase.call(any()));
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when AuthenticationStatusChanged '
      'event is fired with AuthenticationStatus.authenticated '
      'and verify usecases call',
      setUp: () {
        when(() => getUserUsecase.call(any()))
            .thenAnswer((_) async => userMock);
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(const AuthenticationStatusChanged(
        AuthenticationStatus.authenticated,
        authenticationResponse: authenticationResponseMock,
      )),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          username: tUsername,
        ),
      ],
      verify: (_) async {
        verify(() => getUserUsecase.call(any())).called(1);
        verify(() => storeAuthenticationDataUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when AuthenticationStatusChanged '
      'event is fired with AuthenticationStatus.authenticated and biometrics'
      'and verify usecases call',
      setUp: () {
        when(() => getUserUsecase.call(any()))
            .thenAnswer((_) async => userMock);
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => getStoredUserUsecase.call(any()))
            .thenAnswer((_) async => userMock);
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => biometricAuthCanAuthenticateUseCase.call(any()))
            .thenAnswer((_) async => true);
        when(() => biometricAuthAuthenticateUseCase.call(any())).thenAnswer(
          (_) async => BiometryStatus.success,
        );
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        const AuthenticationStatusChanged(AuthenticationStatus.authenticated,
            authenticationResponse: authenticationResponseMock,
            biometryStatus: BiometryStatus.success),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          username: tUsername,
        ),
      ],
      verify: (_) async {
        verify(() => getUserUsecase.call(any())).called(1);
        verify(() => storeAuthenticationDataUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when AuthenticationStatusChanged '
      'event is fired with AuthenticationStatus.offline',
      setUp: () {
        when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
          (_) async => false,
        );
        when(() => getUserUsecase.call(any()))
            .thenAnswer((_) async => userMock);
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(const AuthenticationStatusChanged(
        AuthenticationStatus.offline,
        authenticationResponse: authenticationResponseMock,
      )),
      expect: () => <AuthenticationState>[
        AuthenticationState.offline(tUsername),
      ],
      verify: (_) async {
        verifyNever(() => getUserUsecase.call(any()));
      },
    );
  });

  group('onLogoutOnlineRequested', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when LogoutOnlineRequested '
      'event if fired and verify usecases call',
      seed: () => const AuthenticationState.authenticated(
        token: tokenMock,
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.authenticating,
      ),
      setUp: () {
        when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
          (_) async => true,
        );
        when(() => getStoredTokenUsecase.call(any())).thenAnswer(
          (_) async => (
            token: tokenMock,
            exception: null,
          ),
        );
        when(() => getStoredKeyUsecase.call(any()))
            .thenAnswer((_) async => ApplicationKey(
                  accessKey: tAccessKey,
                  tenantName: 'tenantName',
                ));
        when(() => getStoredKeyTokenUsecase.call(any())).thenAnswer(
          (_) async => keyTokenMock,
        );
        when(() => logoutOnlineUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => clearStoredDataUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => clearKeyStoredDataUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        LogoutOnlineRequested(
          eraseUserToken: true,
          eraseKeyToken: true,
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          biometryStatus: BiometryStatus.authenticating,
          token: null,
          keyToken: null,
        ),
      ],
      verify: (_) async {
        verify(() => getStoredTokenUsecase.call(any())).called(1);
        verify(() => getStoredKeyUsecase.call(any())).called(1);
        verify(() => getStoredKeyTokenUsecase.call(any())).called(1);
        verify(() => logoutOnlineUsecase.call(any())).called(2);
        verify(() => clearStoredDataUsecase.call(any())).called(1);
        verify(() => clearKeyStoredDataUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when LogoutOnlineRequested '
      'event if fired fail and verify usecases call',
      setUp: () {
        when(() => checkStatusConnectionUsecase.call(NoParams())).thenAnswer(
          (_) async => true,
        );
        when(() => getStoredTokenUsecase.call(any()))
            .thenThrow((_) async => Exception());
        when(() => getStoredKeyUsecase.call(any()))
            .thenThrow((_) async => Exception());
        when(() => getStoredKeyTokenUsecase.call(any()))
            .thenThrow((_) async => Exception());
        when(() => logoutOnlineUsecase.call(any()))
            .thenAnswer((_) async => false);
        when(() => clearStoredDataUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(LogoutOnlineRequested()),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          biometryStatus: BiometryStatus.authenticating,
          token: null,
          keyToken: null,
        ),
      ],
      verify: (_) async {
        verify(() => getStoredTokenUsecase.call(any())).called(1);
        verifyNever(() => clearStoredDataUsecase.call(any()));
      },
    );
  });

  group('onCheckAuthenticationRequested', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when CheckAuthenticationRequested '
      'event if fired with valid token on storage and verify usecases call and checkKeyToken false',
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.canceled,
      ),
      setUp: () {
        when(() => checkStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => getStoredUserUsecase.call(any()))
            .thenAnswer((_) async => userMockNotBiometric);
        when(() => getStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => (token: tokenMock, exception: null));
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          checkKeyToken: false,
          timestamp: 1,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          username: tUsername,
          biometryStatus: BiometryStatus.canceled,
          keyToken: keyTokenMock,
          token: tokenMock,
          timestamp: 1,
        ),
      ],
      verify: (_) async {
        verify(() => checkStoredTokenUsecase.call(any())).called(1);
        verify(() => getStoredTokenUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when CheckAuthenticationRequested '
      'event if triggered with activated biometrics validating token and verify usecases call and checkKeyToken false',
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.success,
      ),
      setUp: () {
        when(() => checkStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => getStoredUserUsecase.call(any()))
            .thenAnswer((_) async => userMock);
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => biometricAuthCanAuthenticateUseCase.call(any()))
            .thenAnswer((_) async => true);
        when(() => biometricAuthAuthenticateUseCase.call(any())).thenAnswer(
          (_) async => BiometryStatus.success,
        );
        when(() => getStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => (token: tokenMock, exception: null));
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          checkKeyToken: false,
          timestamp: 1,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          username: tUsername,
          keyToken: keyTokenMock,
          biometryStatus: BiometryStatus.success,
          timestamp: 1,
        ),
      ],
      verify: (_) async {
        verify(() => checkStoredTokenUsecase.call(any())).called(1);
        verify(() => getStoredTokenUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when CheckAuthenticationRequested '
      'event if triggered with not activated biometrics validating token and verify usecases call and checkKeyToken false',
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.success,
      ),
      setUp: () {
        when(() => checkStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => false);
        when(() => refreshStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => null);
        when(() => getStoredUserUsecase.call(any()))
            .thenAnswer((_) async => userMockNotBiometric);
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => biometricAuthCanAuthenticateUseCase.call(any()))
            .thenAnswer((_) async => true);
        when(() => biometricAuthAuthenticateUseCase.call(any()))
            .thenAnswer((_) async => BiometryStatus.canceled);
        when(() => getStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => (token: tokenMock, exception: null));
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          checkKeyToken: false,
          timestamp: 1,
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          biometryStatus: BiometryStatus.canceled,
          keyToken: keyTokenMock,
          timestamp: 1,
        ),
      ],
      verify: (_) async {
        verify(() => checkStoredTokenUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when CheckAuthenticationRequested '
      'event if fired with invalid token on storage and verify usecases call',
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.success,
      ),
      setUp: () {
        when(() => checkStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => false);
        when(() => refreshStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => null);
        when(() => getStoredUserUsecase.call(any()))
            .thenAnswer((_) async => userMockNotBiometric);
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => getStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => (token: tokenMock, exception: null));
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          checkKeyToken: false,
          timestamp: 1,
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          biometryStatus: BiometryStatus.success,
          keyToken: keyTokenMock,
          timestamp: 1,
        ),
      ],
      verify: (_) async {
        verify(() => checkStoredTokenUsecase.call(any())).called(1);
        verify(() => refreshStoredTokenUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when CheckAuthenticationRequested '
      'event if fired with invalid token on storage and refreshToken usecases call and checkKeyToken false',
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.success,
      ),
      setUp: () {
        when(() => checkStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => false);
        when(() => refreshStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => tokenMock);
        when(() => getStoredUserUsecase.call(any()))
            .thenAnswer((_) async => userMockNotBiometric);
        when(() => getStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => (token: tokenMock, exception: null));
        when(() => storeAuthenticationDataUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          timestamp: 1,
          checkKeyToken: false,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          username: tUsername,
          keyToken: keyTokenMock,
          biometryStatus: BiometryStatus.success,
          timestamp: 1,
          token: tokenMock,
        ),
      ],
      verify: (_) async {
        verify(() => checkStoredTokenUsecase.call(any())).called(1);
        verify(() => refreshStoredTokenUsecase.call(any())).called(1);
        verify(() => getStoredTokenUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when CheckAuthenticationRequested '
      'event if fired with checkKeyToken true and valid keyToken on storage and verify usecases call with token in state',
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.success,
        token: tokenMock,
      ),
      setUp: () {
        when(() => checkKeyStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          checkKeyToken: true,
          timestamp: 1,
          accesskey: tAccessKey,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          username: tUsername,
          keyToken: keyTokenMock,
          biometryStatus: BiometryStatus.success,
          timestamp: 1,
          token: tokenMock,
        ),
      ],
      verify: (_) async {
        verify(() => checkKeyStoredTokenUsecase.call(any())).called(1);
        verifyZeroInteractions(refreshKeyStoredTokenUsecase);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when CheckAuthenticationRequested '
      'event if fired with checkKeyToken true and valid keyToken on storage and verify usecases call without keyToken in state',
      seed: () => const AuthenticationState.authenticated(
        biometryStatus: BiometryStatus.success,
        token: tokenMock,
      ),
      setUp: () {
        when(() => checkKeyStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => true);
        when(() => getStoredKeyTokenUsecase.call(any()))
            .thenAnswer((_) async => keyTokenMock);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          checkKeyToken: true,
          timestamp: 1,
          accesskey: tAccessKey,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          username: tUsername,
          keyToken: keyTokenMock,
          biometryStatus: BiometryStatus.success,
          timestamp: 1,
          token: tokenMock,
        ),
      ],
      verify: (_) async {
        verify(() => checkKeyStoredTokenUsecase.call(any())).called(1);
        verify(() => getStoredKeyTokenUsecase.call(any())).called(1);
        verifyZeroInteractions(refreshKeyStoredTokenUsecase);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when CheckAuthenticationRequested '
      'event if fired with checkKeyToken true and invalid keyToken on storage and refreshKeyToken usecase success',
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.success,
        token: tokenMock,
      ),
      setUp: () {
        when(() => checkKeyStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => false);
        when(() => refreshKeyStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => keyTokenMock);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          checkKeyToken: true,
          timestamp: 1,
          accesskey: tAccessKey,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          username: tUsername,
          keyToken: keyTokenMock,
          biometryStatus: BiometryStatus.success,
          timestamp: 1,
          token: tokenMock,
        ),
      ],
      verify: (_) async {
        verify(() => checkKeyStoredTokenUsecase.call(any())).called(1);
        verify(() => refreshKeyStoredTokenUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when CheckAuthenticationRequested '
      'event if fired with checkKeyToken true and invalid keyToken on storage and refreshKeyToken returns null',
      seed: () => const AuthenticationState.authenticated(
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.success,
        token: tokenMock,
      ),
      setUp: () {
        when(() => checkKeyStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => false);
        when(() => refreshKeyStoredTokenUsecase.call(any()))
            .thenAnswer((_) async => null);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        CheckAuthenticationRequested(
          username: tUsername,
          checkKeyToken: true,
          accesskey: tAccessKey,
          timestamp: 1,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.unauthenticated(
          biometryStatus: BiometryStatus.success,
          token: tokenMock,
          timestamp: 1,
        ),
      ],
      verify: (_) async {
        verify(() => checkKeyStoredTokenUsecase.call(any())).called(1);
        verify(() => refreshKeyStoredTokenUsecase.call(any())).called(1);
      },
    );
  });

  group('onLogoutOfflineRequested', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when LogoutOfflineRequested '
      'event if fired and verify usecases call with eraseKeyToken true and eraseUserToken true',
      seed: () => const AuthenticationState.authenticated(
        token: tokenMock,
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.canceled,
      ),
      setUp: () {
        when(() => clearStoredDataUsecase.call(any(), onlyLastUser: true))
            .thenAnswer((_) async => true);
        when(() => clearKeyStoredDataUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        LogoutOfflineRequested(
          username: tUsername,
          eraseKeyToken: true,
          eraseUserToken: true,
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          keyToken: null,
          biometryStatus: BiometryStatus.canceled,
          token: null,
        ),
      ],
      verify: (_) async {
        verify(() => clearStoredDataUsecase.call(any(), onlyLastUser: true))
            .called(1);
        verify(() => clearKeyStoredDataUsecase.call(any())).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when LogoutOfflineRequested '
      'event if fired and verify usecases call with eraseKeyToken false and eraseUserToken false',
      seed: () => const AuthenticationState.authenticated(
        token: tokenMock,
        keyToken: keyTokenMock,
        biometryStatus: BiometryStatus.canceled,
      ),
      setUp: () {
        when(() => clearStoredDataUsecase.call(any(),
                onlyLastUser: any(named: 'onlyLastUser')))
            .thenAnswer((_) async => true);
        when(() => clearKeyStoredDataUsecase.call(any()))
            .thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        LogoutOfflineRequested(
          username: tUsername,
          eraseKeyToken: true,
          eraseUserToken: false,
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          keyToken: keyTokenMock,
          biometryStatus: BiometryStatus.canceled,
          token: tokenMock,
        ),
      ],
      verify: (_) async {
        verify(() => clearStoredDataUsecase.call(any(),
            onlyLastUser: any(named: 'onlyLastUser')));
        verify(() => clearKeyStoredDataUsecase.call(any()));
        // verifyZeroInteractions(clearStoredDataUsecase);
        // verifyZeroInteractions(clearKeyStoredDataUsecase);
      },
    );
  });

  group('onAuthenticateKey', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when AuthenticateKey '
      'event authenticationResponse.token is null',
      seed: () => const AuthenticationState.authenticated(
        token: tokenMock,
      ),
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        AuthenticateKey(
          authenticationResponse: AuthenticationResponse(
            token: null,
          ),
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          token: tokenMock,
        ),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when AuthenticateKey '
      'event storeAppKeyAuthenticationDataUsecase returns false',
      seed: () => const AuthenticationState.authenticated(
        token: tokenMock,
        biometryStatus: BiometryStatus.success,
      ),
      setUp: () {
        when(
          () => storeAppKeyAuthenticationDataUsecase.call(
            KeyAuthenticationData(
              loginWithKey: authenticationResponseMock.loginWithKey,
              token: authenticationResponseMock.token,
            ),
          ),
        ).thenAnswer((_) async => false);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        AuthenticateKey(
          authenticationResponse: authenticationResponseMock,
        ),
      ),
      expect: () => <AuthenticationState>[
        const AuthenticationState.unauthenticated(
          biometryStatus: BiometryStatus.success,
          token: tokenMock,
        ),
      ],
      verify: (_) async {
        verify(
          () => storeAppKeyAuthenticationDataUsecase.call(
            KeyAuthenticationData(
              loginWithKey: authenticationResponseMock.loginWithKey,
              token: authenticationResponseMock.token,
            ),
          ),
        ).called(1);
      },
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.unauthenticated] when AuthenticateKey '
      'event storeAppKeyAuthenticationDataUsecase returns true',
      seed: () => const AuthenticationState.unauthenticated(
        token: tokenMock,
        biometryStatus: BiometryStatus.success,
      ),
      setUp: () {
        when(
          () => storeAppKeyAuthenticationDataUsecase.call(
            KeyAuthenticationData(
              loginWithKey: authenticationResponseMock.loginWithKey,
              token: authenticationResponseMock.token,
            ),
          ),
        ).thenAnswer((_) async => true);
      },
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        AuthenticateKey(
          authenticationResponse: authenticationResponseMock,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          biometryStatus: BiometryStatus.success,
          token: tokenMock,
          keyToken: authenticationResponseMock.token,
        ),
      ],
      verify: (_) async {
        verify(
          () => storeAppKeyAuthenticationDataUsecase.call(
            KeyAuthenticationData(
              loginWithKey: authenticationResponseMock.loginWithKey,
              token: authenticationResponseMock.token,
            ),
          ),
        ).called(1);
      },
    );
  });

  group('onChangeAccessTokenAuthenticationRequested', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits [AuthenticationState.authenticated] when ChangeAccessTokenAuthenticationRequested '
      'event if fired with valid token',
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(
        ChangeAccessTokenAuthenticationRequested(
          token: tokenMock,
        ),
      ),
      expect: () => <AuthenticationState>[
        AuthenticationState.authenticated(
          token: tokenMock,
        ),
      ],
    );
  });

  group(
    '_onCheckBiometricAuthentication',
    () {
      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.unauthenticated] when biometric authentication returns error',
        setUp: () {
          when(() => getStoredUserUsecase.call(any()))
              .thenAnswer((_) async => userMock);
          when(() => biometricAuthCanAuthenticateUseCase.call(any()))
              .thenAnswer((_) async => true);
          when(() => biometricAuthAuthenticateUseCase.call(any()))
              .thenAnswer((_) async => BiometryStatus.error);
        },
        build: () => authenticationBloc,
        act: (bloc) => bloc.add(
          CheckBiometricAuthenticationRequested(username: tUsername),
        ),
        expect: () => <AuthenticationState>[
          AuthenticationState.unauthenticated(
            biometryStatus: BiometryStatus.error,
            keyToken: keyTokenMock,
            token: tokenMock,
          ),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationState.authenticated] when biometric authentication succeeds',
        setUp: () {
          when(() => getStoredUserUsecase.call(any()))
              .thenAnswer((_) async => userMock);
          when(() => biometricAuthCanAuthenticateUseCase.call(any()))
              .thenAnswer((_) async => true);
          when(() => biometricAuthAuthenticateUseCase.call(any()))
              .thenAnswer((_) async => BiometryStatus.success);
        },
        build: () => authenticationBloc,
        act: (bloc) => bloc.add(
          CheckBiometricAuthenticationRequested(username: tUsername),
        ),
        expect: () => <AuthenticationState>[
          AuthenticationState.authenticated(
            username: tUsername,
            biometryStatus: BiometryStatus.success,
            token: tokenMock,
          ),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'does not emit any state when stored user is null',
        setUp: () {
          when(() => getStoredUserUsecase.call(any()))
              .thenAnswer((_) async => null);
        },
        build: () => authenticationBloc,
        act: (bloc) => bloc.add(
          CheckBiometricAuthenticationRequested(username: tUsername),
        ),
        expect: () => <AuthenticationState>[
          AuthenticationState.unauthenticated(
            keyToken: keyTokenMock,
            token: tokenMock,
          ),
        ],
      );

      blocTest<AuthenticationBloc, AuthenticationState>(
        'does not emit any state when stored  activeBiometry  is false',
        setUp: () {
          when(() => getStoredUserUsecase.call(any()))
              .thenAnswer((_) async => userMockNotBiometric);
        },
        build: () => authenticationBloc,
        act: (bloc) => bloc.add(
          CheckBiometricAuthenticationRequested(username: tUsername),
        ),
        expect: () => <AuthenticationState>[
          AuthenticationState.authenticated(
            username: tUsername,
            token: tokenMock,
            keyToken: keyTokenMock,
          ),
        ],
      );
    },
  );
}
