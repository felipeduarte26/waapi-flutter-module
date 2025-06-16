import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/constants.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/cubit/reset_password_cubit.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/token_mock.dart';
import '../../../../mocks/user_login_reset_password_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockLoginWithResetPasswordUsecase extends Mock
    implements LoginWithResetPasswordUsecase {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late LoginWithResetPasswordUsecase loginWithResetPasswordUsecase;
  late ResetPasswordCubit resetPasswordCubit;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    loginWithResetPasswordUsecase = MockLoginWithResetPasswordUsecase();

    resetPasswordCubit = ResetPasswordCubit(
      authenticationBloc: authenticationBloc,
      loginWithResetPasswordUsecase: loginWithResetPasswordUsecase,
    );
  });

  setUpAll(() {
    registerFallbackValue(userLoginResetPasswordMock);
    SeniorAuthentication.initialize(
      enableBiometry: true,
      enableBiometryOnly: false,
      encryptionKey: encryptionKeyMock,
    );
  });

  group('loginWithResetPassword', () {
    const tUsername = 'username';
    const tTemporaryToken = 'temporaryToken';

    const tPassword = 'newPassword';
    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits correct states when loginWithResetPassword is called successfully',
      setUp: () {
        when(
          () => loginWithResetPasswordUsecase.call(
            any(),
          ),
        ).thenAnswer(
          (_) async => authenticationResponseMock,
        );
      },
      build: () => resetPasswordCubit,
      seed: () => ResetPasswordState.initial().copyWith(
        username: 'username',
        temporaryToken: 'temporaryToken',
      ),
      act: (cubit) => cubit.loginWithResetPassword(tPassword),
      expect: () => <ResetPasswordState>[
        ResetPasswordState.initial().copyWith(
          networkStatus: NetworkStatus.idle,
          authenticationResponse: authenticationResponseMock,
          username: tUsername,
          temporaryToken: tTemporaryToken,
          biometricFlow: true,
        ),
      ],
      verify: (_) {
        verify(
          () => loginWithResetPasswordUsecase.call(userLoginResetPasswordMock),
        ).called(1);
      },
    );
  });
}
