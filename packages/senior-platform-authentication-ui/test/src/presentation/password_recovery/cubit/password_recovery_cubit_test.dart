import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/cubit/password_recovery_cubit.dart';

import '../../../../mocks/change_password_settings_mock.dart';
import '../../../../mocks/reset_password_mock.dart';

class MockGetRecaptchaUrlUsecase extends Mock
    implements GetRecaptchaUrlUsecase {}

class MockGetResetPasswordUsecase extends Mock
    implements ResetPasswordUsecase {}

void main() {
  late GetRecaptchaUrlUsecase getRecaptchaUrlUsecase;
  late ResetPasswordUsecase resetPasswordUsecase;
  late PasswordRecoveryCubit passwordRecoveryCubit;
  const tCaptcha = 'SOMEDUMBCAPTCHA';
  const tEmptyCaptcha = '';
  const tMessageSuccess = 'recaptcha_success=$tCaptcha';
  const tMessageFailure = 'recaptcha_success=$tEmptyCaptcha';

  setUp(() {
    getRecaptchaUrlUsecase = MockGetRecaptchaUrlUsecase();
    resetPasswordUsecase = MockGetResetPasswordUsecase();
    passwordRecoveryCubit = PasswordRecoveryCubit(
      getRecaptchaUrlUsecase: getRecaptchaUrlUsecase,
      resetPasswordUsecase: resetPasswordUsecase,
    );

    registerFallbackValue(NoParams());
    registerFallbackValue(resetPasswordMock);
    registerFallbackValue(changePasswordSettingsMock);
  });

  group('onUsernameChanged', () {
    const tUsername = 'dumbemail@test.com.br';
    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'emits current state with changed username value ',
      build: () => passwordRecoveryCubit,
      seed: () => PasswordRecoveryState.initial(),
      act: (cubit) => cubit.onUsernameChanged(tUsername),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial().copyWith(username: tUsername),
      ],
    );
  });

  group('onPasswordRecoveryStatusChanged', () {
    const tPasswordRecoveryStatus = PasswordRecoveryStatus.finished;
    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'emits current state with changed passwordRecoveryStatus value ',
      build: () => passwordRecoveryCubit,
      seed: () => PasswordRecoveryState.initial(),
      act: (cubit) =>
          cubit.onPasswordRecoveryStatusChanged(tPasswordRecoveryStatus),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial()
            .copyWith(passwordRecoveryStatus: tPasswordRecoveryStatus),
      ],
    );
  });

  group('onJavaScriptMessage', () {
    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'should validate captcha and emit error state ',
      build: () => passwordRecoveryCubit,
      seed: () => PasswordRecoveryState.initial(),
      act: (cubit) => cubit.onJavaScriptMessage(tMessageFailure),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial().copyWith(
          captcha: tEmptyCaptcha,
          passwordRecoveryStatus: PasswordRecoveryStatus.error,
        ),
      ],
    );

    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'should emit finished state and call resetPassword when captcha is valid ',
      setUp: () {
        when(
          () => resetPasswordUsecase.call(any()),
        ).thenAnswer(
          (_) async {
            return;
          },
        );
      },
      build: () => passwordRecoveryCubit,
      seed: () => PasswordRecoveryState.initial(),
      act: (cubit) => cubit.onJavaScriptMessage(tMessageSuccess),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial().copyWith(
          captcha: tCaptcha,
          passwordRecoveryStatus: PasswordRecoveryStatus.finished,
        ),
        PasswordRecoveryState.initial().copyWith(
          captcha: tCaptcha,
          passwordRecoveryStatus: PasswordRecoveryStatus.finished,
          networkStatus: NetworkStatus.loading,
        ),
        PasswordRecoveryState.initial().copyWith(
          captcha: tCaptcha,
          passwordRecoveryStatus: PasswordRecoveryStatus.finished,
          networkStatus: NetworkStatus.idle,
        ),
      ],
      verify: (_) {
        verify(
          () => resetPasswordUsecase.call(any()),
        ).called(1);
      },
    );
  });

  group('resetPassword', () {
    const tUsername = 'dumb username';
    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'should emit correct states when usecase executes successfully',
      setUp: () {
        when(
          () => resetPasswordUsecase.call(any()),
        ).thenAnswer(
          (_) async {
            return;
          },
        );
      },
      build: () => passwordRecoveryCubit,
      seed: () => PasswordRecoveryState.initial().copyWith(
        captcha: tCaptcha,
        username: tUsername,
        passwordRecoveryStatus: PasswordRecoveryStatus.finished,
      ),
      act: (cubit) => cubit.resetPassword(),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial().copyWith(
          captcha: tCaptcha,
          username: tUsername,
          passwordRecoveryStatus: PasswordRecoveryStatus.finished,
          networkStatus: NetworkStatus.loading,
        ),
        PasswordRecoveryState.initial().copyWith(
          captcha: tCaptcha,
          username: tUsername,
          passwordRecoveryStatus: PasswordRecoveryStatus.finished,
          networkStatus: NetworkStatus.idle,
        ),
      ],
      verify: (_) {
        verify(
          () => resetPasswordUsecase.call(any()),
        ).called(1);
      },
    );

    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'should emit correct states when usecase executes with error',
      setUp: () {
        when(
          () => resetPasswordUsecase.call(any()),
        ).thenThrow(UnknownException());
      },
      build: () => passwordRecoveryCubit,
      seed: () => PasswordRecoveryState.initial().copyWith(
        captcha: tCaptcha,
        username: tUsername,
        passwordRecoveryStatus: PasswordRecoveryStatus.finished,
      ),
      act: (cubit) => cubit.resetPassword(),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial().copyWith(
          captcha: tCaptcha,
          username: tUsername,
          passwordRecoveryStatus: PasswordRecoveryStatus.finished,
          networkStatus: NetworkStatus.loading,
        ),
        PasswordRecoveryState.initial().copyWith(
          captcha: tCaptcha,
          username: tUsername,
          passwordRecoveryStatus: PasswordRecoveryStatus.error,
          networkStatus: NetworkStatus.idle,
        ),
      ],
      verify: (_) {
        verify(
          () => resetPasswordUsecase.call(any()),
        ).called(1);
      },
    );
  });

  group('getRecaptchaUrl', () {
    const tRecaptchaUrl = 'some dumb url';
    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'should emit correct states when usecase executes successfully',
      setUp: () {
        when(
          () => getRecaptchaUrlUsecase.call(any()),
        ).thenAnswer(
          (_) async {
            return tRecaptchaUrl;
          },
        );
      },
      build: () => passwordRecoveryCubit,
      act: (cubit) => cubit.getRecaptchaUrl(changePasswordSettingsMock),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial().copyWith(
          networkStatus: NetworkStatus.loading,
        ),
        PasswordRecoveryState.initial().copyWith(
          networkStatus: NetworkStatus.idle,
          passwordRecoveryStatus: PasswordRecoveryStatus.recaptcha,
          recaptchaUrl: tRecaptchaUrl,
        ),
      ],
      verify: (_) {
        verify(
          () => getRecaptchaUrlUsecase.call(any()),
        ).called(1);
      },
    );

    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'should emit correct states when usecase executes successfully but'
      'recaptchaUrl is empty',
      setUp: () {
        when(
          () => getRecaptchaUrlUsecase.call(any()),
        ).thenAnswer(
          (_) async {
            return '';
          },
        );
      },
      build: () => passwordRecoveryCubit,
      act: (cubit) => cubit.getRecaptchaUrl(changePasswordSettingsMock),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial().copyWith(
          networkStatus: NetworkStatus.loading,
        ),
        PasswordRecoveryState.initial().copyWith(
          networkStatus: NetworkStatus.idle,
          passwordRecoveryStatus: PasswordRecoveryStatus.error,
          recaptchaUrl: '',
        ),
      ],
      verify: (_) {
        verify(
          () => getRecaptchaUrlUsecase.call(any()),
        ).called(1);
      },
    );

    blocTest<PasswordRecoveryCubit, PasswordRecoveryState>(
      'should emit correct states when usecase executes with error',
      setUp: () {
        when(
          () => getRecaptchaUrlUsecase.call(any()),
        ).thenThrow(UnknownException());
      },
      build: () => passwordRecoveryCubit,
      act: (cubit) => cubit.getRecaptchaUrl(changePasswordSettingsMock),
      expect: () => <PasswordRecoveryState>[
        PasswordRecoveryState.initial().copyWith(
          networkStatus: NetworkStatus.loading,
        ),
        PasswordRecoveryState.initial().copyWith(
          networkStatus: NetworkStatus.idle,
          passwordRecoveryStatus: PasswordRecoveryStatus.error,
          recaptchaUrl: '',
        ),
      ],
      verify: (_) {
        verify(
          () => getRecaptchaUrlUsecase.call(any()),
        ).called(1);
      },
    );
  });
}
