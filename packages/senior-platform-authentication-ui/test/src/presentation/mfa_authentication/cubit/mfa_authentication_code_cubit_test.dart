import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/cubit/mfa_authentication_code_cubit.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/mfa_info_mock.dart';
import '../../../../mocks/reset_password_mock.dart';
import '../../../../mocks/token_mock.dart';

class MockLoginMfaUseCase extends Mock implements LoginMFAUsecase {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockSendMfaConfigEmailUsecase extends Mock
    implements SendMFAConfigEmailUsecase {}

void main() {
  late LoginMFAUsecase loginMfaUseCase;
  late AuthenticationBloc authenticationBloc;
  late SendMFAConfigEmailUsecase sendMfaConfigEmailUsecase;
  late MFAAuthenticationCubit mfaAuthenticationCubit;

  setUpAll(
    () => SeniorAuthentication.initialize(
      encryptionKey: encryptionKeyMock,
    ),
  );

  setUp(() {
    loginMfaUseCase = MockLoginMfaUseCase();
    authenticationBloc = MockAuthenticationBloc();
    sendMfaConfigEmailUsecase = MockSendMfaConfigEmailUsecase();
    mfaAuthenticationCubit = MFAAuthenticationCubit(
      loginMFAUsecase: loginMfaUseCase,
      authenticationBloc: authenticationBloc,
      sendMfaConfigEmailUsecase: sendMfaConfigEmailUsecase,
    );
  });

  group(
    'initialize',
    () {
      test('should emit [MFAAuthenticationState.initial()] when initialize',
          () {
        expect(mfaAuthenticationCubit.state, MFAAuthenticationState.initial());
      });
    },
  );

  group(
    'initialize enableBiometry',
    () {
      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'emits correct states when login executes successfully',
        setUp: () {
          mfaAuthenticationCubit.initialize(mfaInfoConfiguredMock, 'username');
          when(
            () => loginMfaUseCase.call(
              loginMFAMock,
            ),
          ).thenAnswer(
            (_) async => authenticationResponseMock,
          );
        },
        build: () => mfaAuthenticationCubit,
        act: (cubit) => cubit.login(
          validationCode: '112233',
          temporaryToken:
              'Dr9BFR82r1W7VKbEikNfmJ3Ch0a+U/YXToC/OdkriM6R2LyRxrLyvBz5aypBMVfqd3ek7Jjz5EdCbdHYo5p2g2GJalzFFvVkNxiLBfIBTseYZa69wyZLxA==',
          tenant: 'apphcmcom',
        ),
        expect: () => <MFAAuthenticationState>[
          const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.loading,
            errorType: null,
            username: 'username',
          ),
        ],
      );
    },
  );

  group(
    'initialize',
    () {
      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'description',
        build: () => MFAAuthenticationCubit(
          loginMFAUsecase: loginMfaUseCase,
          authenticationBloc: authenticationBloc,
          sendMfaConfigEmailUsecase: sendMfaConfigEmailUsecase,
        ),
        act: (cubit) => cubit.initialize(mfaInfoConfiguredMock, 'username'),
        expect: () => [
          MFAAuthenticationState.initial().copyWith(
            mfaStatus: MFAAuthenticationStatus.configured,
            mfaInfo: mfaInfoConfiguredMock,
            username: 'username',
          ),
        ],
      );

      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'emits correct states when login executes successfully',
        setUp: () {
          mfaAuthenticationCubit.initialize(
            mfaInfoConfiguredMock,
            'username',
          );
          when(
            () => loginMfaUseCase.call(
              loginMFAMock,
            ),
          ).thenAnswer(
            (_) async => authenticationResponseMock,
          );
        },
        build: () => mfaAuthenticationCubit,
        act: (cubit) => cubit.login(
          validationCode: '112233',
          temporaryToken:
              'Dr9BFR82r1W7VKbEikNfmJ3Ch0a+U/YXToC/OdkriM6R2LyRxrLyvBz5aypBMVfqd3ek7Jjz5EdCbdHYo5p2g2GJalzFFvVkNxiLBfIBTseYZa69wyZLxA==',
          tenant: 'apphcmcom',
        ),
        expect: () => <MFAAuthenticationState>[
          const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.loading,
            errorType: null,
            username: 'username',
          ),
        ],
      );

      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'emits correct states when needs reset password',
        setUp: () {
          mfaAuthenticationCubit.initialize(
            mfaInfoConfiguredMock,
            'username',
          );
          when(
            () => loginMfaUseCase.call(
              loginMFAMock,
            ),
          ).thenAnswer(
            (_) async => const AuthenticationResponse(
              token: null,
              resetPasswordInfo: resetPasswordInfoMock,
            ),
          );
        },
        build: () => mfaAuthenticationCubit,
        act: (cubit) => cubit.login(
          validationCode: '112233',
          temporaryToken:
              'Dr9BFR82r1W7VKbEikNfmJ3Ch0a+U/YXToC/OdkriM6R2LyRxrLyvBz5aypBMVfqd3ek7Jjz5EdCbdHYo5p2g2GJalzFFvVkNxiLBfIBTseYZa69wyZLxA==',
          tenant: 'apphcmcom',
        ),
        expect: () => <MFAAuthenticationState>[
          const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.loading,
            errorType: null,
            username: 'username',
          ),
          const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.loading,
            errorType: null,
            username: 'username',
            authenticationResponse: AuthenticationResponse(
              resetPasswordInfo: resetPasswordInfoMock,
            ),
          ),
        ],
      );

      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'emits correct states when loginMfa fails with UnauthorizedException',
        setUp: () {
          mfaAuthenticationCubit.initialize(
            mfaInfoConfiguredMock,
            'username',
          );
          when(
            () => loginMfaUseCase.call(
              loginMFAMock,
            ),
          ).thenThrow(
            UnauthorizedException(),
          );
        },
        build: () => mfaAuthenticationCubit,
        act: (cubit) async => await cubit.login(
          validationCode: '112233',
          temporaryToken:
              'Dr9BFR82r1W7VKbEikNfmJ3Ch0a+U/YXToC/OdkriM6R2LyRxrLyvBz5aypBMVfqd3ek7Jjz5EdCbdHYo5p2g2GJalzFFvVkNxiLBfIBTseYZa69wyZLxA==',
          tenant: 'apphcmcom',
        ),
        expect: () => <MFAAuthenticationState>[
          const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.loading,
            errorType: null,
            username: 'username',
          ),
          const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.idle,
            errorType: ErrorType.unauthorized,
            username: 'username',
          ),
        ],
      );

      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'emits correct states when loginMfa fails with Unknown error',
        setUp: () {
          mfaAuthenticationCubit.initialize(
            mfaInfoConfiguredMock,
            'username',
          );
          when(
            () => loginMfaUseCase.call(
              loginMFAMock,
            ),
          ).thenThrow(
            Exception,
          );
          when(
            () => loginMfaUseCase.call(
              loginMFAMock,
            ),
          ).thenThrow(
            Exception,
          );
        },
        build: () => mfaAuthenticationCubit,
        act: (cubit) async => await cubit.login(
          validationCode: '112233',
          temporaryToken:
              'Dr9BFR82r1W7VKbEikNfmJ3Ch0a+U/YXToC/OdkriM6R2LyRxrLyvBz5aypBMVfqd3ek7Jjz5EdCbdHYo5p2g2GJalzFFvVkNxiLBfIBTseYZa69wyZLxA==',
          tenant: 'apphcmcom',
        ),
        expect: () => <MFAAuthenticationState>[
          const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.loading,
            errorType: null,
            username: 'username',
          ),
          const MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.configured,
            status: NetworkStatus.idle,
            errorType: ErrorType.unknown,
            username: 'username',
          ),
        ],
      );

      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'emits correct states when sendMFAConfigEmail executes successfully',
        setUp: () {
          mfaAuthenticationCubit.initialize(
            mfaInfoNotConfiguredMock,
            'username',
          );
          when(
            () => sendMfaConfigEmailUsecase.call(
              sendMFAConfigEmailMock,
            ),
          ).thenAnswer(
            (_) async => const EmailAddress(
              email: 'teste@senior.com.br',
            ),
          );
        },
        build: () => mfaAuthenticationCubit,
        act: (cubit) => cubit.sendMFAConfigEmail(
          temporaryToken: 'temporaryToken',
          tenant: 'tenant',
        ),
        expect: () => <MFAAuthenticationState>[
          MFAAuthenticationState(
              email: '',
              mfaInfo: mfaInfoNotConfiguredMock,
              mfaStatus: MFAAuthenticationStatus.notConfigured,
              status: NetworkStatus.loading,
              errorType: null,
              username: 'username'),
          MFAAuthenticationState(
            email: 'teste@senior.com.br',
            mfaInfo: mfaInfoNotConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.emailSended,
            status: NetworkStatus.idle,
            errorType: null,
            username: 'username',
          ),
        ],
      );

      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'emits correct states when sendMFAConfigEmail fails with UnauthorizedException',
        setUp: () {
          mfaAuthenticationCubit.initialize(
            mfaInfoNotConfiguredMock,
            'username',
          );
          when(
            () => sendMfaConfigEmailUsecase.call(
              sendMFAConfigEmailMock,
            ),
          ).thenThrow(
            UnauthorizedException(),
          );
        },
        build: () => mfaAuthenticationCubit,
        act: (cubit) => cubit.sendMFAConfigEmail(
          temporaryToken:
              'Dr9BFR82r1W7VKbEikNfmJ3Ch0a+U/YXToC/OdkriM6R2LyRxrLyvBz5aypBMVfqd3ek7Jjz5EdCbdHYo5p2g2GJalzFFvVkNxiLBfIBTseYZa69wyZLxA==',
          tenant: 'apphcmcom',
        ),
        expect: () => <MFAAuthenticationState>[
          MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoNotConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.notConfigured,
            status: NetworkStatus.loading,
            errorType: null,
            username: 'username',
          ),
          MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoNotConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.notConfigured,
            status: NetworkStatus.idle,
            errorType: ErrorType.unknown,
            username: 'username',
          ),
          MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoNotConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.notConfigured,
            status: NetworkStatus.idle,
            errorType: null,
            username: 'username',
          ),
        ],
      );

      blocTest<MFAAuthenticationCubit, MFAAuthenticationState>(
        'emits correct states when sendMFAConfigEmail fails with Unknown Error',
        setUp: () {
          mfaAuthenticationCubit.initialize(
            mfaInfoNotConfiguredMock,
            'username',
          );
          when(
            () => sendMfaConfigEmailUsecase.call(
              sendMFAConfigEmailMock,
            ),
          ).thenThrow(
            Exception(),
          );
        },
        build: () => mfaAuthenticationCubit,
        act: (cubit) => cubit.sendMFAConfigEmail(
          temporaryToken:
              'Dr9BFR82r1W7VKbEikNfmJ3Ch0a+U/YXToC/OdkriM6R2LyRxrLyvBz5aypBMVfqd3ek7Jjz5EdCbdHYo5p2g2GJalzFFvVkNxiLBfIBTseYZa69wyZLxA==',
          tenant: 'apphcmcom',
        ),
        expect: () => <MFAAuthenticationState>[
          MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoNotConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.notConfigured,
            status: NetworkStatus.loading,
            errorType: null,
            username: 'username',
          ),
          MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoNotConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.notConfigured,
            status: NetworkStatus.idle,
            errorType: ErrorType.unknown,
            username: 'username',
          ),
          MFAAuthenticationState(
            email: '',
            mfaInfo: mfaInfoNotConfiguredMock,
            mfaStatus: MFAAuthenticationStatus.notConfigured,
            status: NetworkStatus.idle,
            errorType: null,
            username: 'username',
          ),
        ],
      );
    },
  );
}
