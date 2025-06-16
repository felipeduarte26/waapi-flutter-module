import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/cubit/enable_biometric_auth_cubit.dart';

import '../../../../../mocks/encryption_key_mock.dart';
import '../../../../../mocks/token_mock.dart';

// Mocks
class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockBiometricAvailableUseCase extends Mock
    implements BiometricAvailableUsecase {}

class MockBiometricCanCheckUseCase extends Mock
    implements BiometricCanCheckUseCase {}

class MockBiometricAuthenticateUseCase extends Mock
    implements BiometricAuthenticateUsecase {}

void main() {
  group('EnableBiometricAuthCubit', () {
    late AuthenticationBloc mockAuthenticationBloc;
    late BiometricAvailableUsecase mockBiometricAvailableUseCase;
    late BiometricCanCheckUseCase mockBiometricCanCheckUseCase;
    late BiometricAuthenticateUsecase mockBiometricAuthenticateUseCase;
    late EnableBiometricAuthCubit enableBiometricAuthCubit;

    setUpAll(
      () => SeniorAuthentication.initialize(
        enableBiometry: true,
        enableBiometryOnly: true,
        encryptionKey: encryptionKeyMock,
      ),
    );

    setUp(() {
      mockAuthenticationBloc = MockAuthenticationBloc();
      mockBiometricAvailableUseCase = MockBiometricAvailableUseCase();
      mockBiometricCanCheckUseCase = MockBiometricCanCheckUseCase();
      mockBiometricAuthenticateUseCase = MockBiometricAuthenticateUseCase();
      enableBiometricAuthCubit = EnableBiometricAuthCubit(
        authenticationBloc: mockAuthenticationBloc,
        biometricAuthAvailableUseCase: mockBiometricAvailableUseCase,
        biometricAuthCanCheckUseCase: mockBiometricCanCheckUseCase,
        biometricAuthenticateUseCase: mockBiometricAuthenticateUseCase,
      );
    });

    group('initialize', () {
      blocTest<EnableBiometricAuthCubit, EnableBiometricAuthState>(
        'emit  enableBiometricAuthStatus = BiometricAuthInfo.getAvailableBiometrics and biometricsAreRegistered = true',
        setUp: () {
          when(() => mockBiometricCanCheckUseCase(NoParams()))
              .thenAnswer((_) async => true);
          when(() => mockBiometricAvailableUseCase(NoParams()))
              .thenAnswer((_) async => true);
        },
        build: () => enableBiometricAuthCubit,
        act: (cubit) => cubit.initialize(),
        expect: () => <EnableBiometricAuthState>[
          const EnableBiometricAuthState(
            enableBiometricAuthStatus: BiometricAuthInfo.unknown,
            biometryStatus: BiometryStatus.unknown,
          ),
          const EnableBiometricAuthState(
            enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
            biometricsAreRegistered: true,
            biometryStatus: BiometryStatus.unknown,
          ),
        ],
      );

      blocTest<EnableBiometricAuthCubit, EnableBiometricAuthState>(
        'emit  enableBiometricAuthStatus = BiometricAuthInfo.getAvailableBiometrics and biometricsAreRegistered = false',
        setUp: () {
          when(() => mockBiometricCanCheckUseCase(NoParams()))
              .thenAnswer((_) async => true);
          when(() => mockBiometricAvailableUseCase(NoParams()))
              .thenAnswer((_) async => false);
        },
        build: () => enableBiometricAuthCubit,
        act: (cubit) => cubit.initialize(),
        expect: () => <EnableBiometricAuthState>[
          const EnableBiometricAuthState(
            enableBiometricAuthStatus: BiometricAuthInfo.unknown,
          ),
          const EnableBiometricAuthState(
            enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
            biometricsAreRegistered: false,
          ),
        ],
      );
    });

    group('biometricAuth', () {
      blocTest(
        '',
        setUp: () {
          when(() => mockAuthenticationBloc
                  .onAuthenticationBiometricAuthRequested())
              .thenAnswer((_) async => BiometryStatus.success);
        },
        build: () => enableBiometricAuthCubit,
        act: (cubit) => cubit.biometricAuth(
          authenticationResponse: authenticationResponseMock,
        ),
        expect: () => <EnableBiometricAuthState>[
          const EnableBiometricAuthState(
            enableBiometricAuthStatus: BiometricAuthInfo.unknown,
            biometryStatus: BiometryStatus.authenticating,
          ),
          const EnableBiometricAuthState(
            enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
            biometryStatus: BiometryStatus.success,
          ),
        ],
      );
    });

    group('biometricsAreRegistered', () {
      blocTest(
        '',
        build: () => enableBiometricAuthCubit,
        act: (cubit) => cubit.biometricsAreRegistered(),
        expect: () => <EnableBiometricAuthState>[
          const EnableBiometricAuthState(
            enableBiometricAuthStatus:
                BiometricAuthInfo.biometricsNotRegistered,
            biometricsAreRegistered: false,
          ),
        ],
      );
    });

    group('authentication', () {
      blocTest(
        '',
        build: () => enableBiometricAuthCubit,
        act: (cubit) => cubit.authentication(
          authenticationResponse: authenticationResponseMock,
          biometryStatus: BiometryStatus.success,
        ),
        expect: () => <EnableBiometricAuthState>[],
      );
    });
  });
}
