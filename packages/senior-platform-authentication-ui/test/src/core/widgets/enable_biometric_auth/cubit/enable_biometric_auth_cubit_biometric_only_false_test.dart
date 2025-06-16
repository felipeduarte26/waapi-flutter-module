import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/cubit/enable_biometric_auth_cubit.dart';

import '../../../../../mocks/encryption_key_mock.dart';

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
        enableBiometryOnly: false,
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
        'emit  enableBiometricAuthStatus = BiometricAuthInfo.getAvailableBiometrics and biometricsAreRegistered = true enableBiometryOnly = false',
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
            biometricsAreRegistered: true,
          ),
        ],
      );
    });
  });
}
