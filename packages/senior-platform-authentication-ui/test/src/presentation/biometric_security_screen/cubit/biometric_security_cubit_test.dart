import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/biometric_security_screen/cubit/biometric_security_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/biometric_security_screen/cubit/biometric_security_state.dart';

import '../../../../mocks/encryption_key_mock.dart';

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  group('BiometricSecurityState', () {
    late AuthenticationBloc mockAuthenticationBloc;
    late BiometricSecurityCubit biometricSecurityCubit;

    setUpAll(
      () => SeniorAuthentication.initialize(
        enableBiometry: true,
        enableBiometryOnly: true,
        encryptionKey: encryptionKeyMock,
      ),
    );

    setUp(() {
      mockAuthenticationBloc = MockAuthenticationBloc();
      biometricSecurityCubit = BiometricSecurityCubit(
        authenticationBloc: mockAuthenticationBloc,
      );
    });
    group('BiometricSecurityCubitTest', () {
      blocTest(
        '',
        build: () => biometricSecurityCubit,
        act: (cubit) => cubit.checkAuthentication(),
        expect: () => <BiometricSecurityCubit>[],
      );

      blocTest(
        '',
        build: () => biometricSecurityCubit,
        act: (cubit) => cubit.unauthenticated(
          biometryStatus: BiometryStatus.unknown,
        ),
        expect: () => <BiometricSecurityCubit>[],
      );

      group('BiometricSecurityState', () {
        test('unction returns an empty list', () {
          const state = BiometricSecurityState();
          expect(state.props, isEmpty);
        });
      });
    });
  });
}
