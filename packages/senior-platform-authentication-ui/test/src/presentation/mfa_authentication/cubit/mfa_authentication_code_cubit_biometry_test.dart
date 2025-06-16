import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/cubit/mfa_authentication_code_cubit.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/mfa_info_mock.dart';
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
      enableBiometry: true,
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

  group('initialize enableBiometry', () {
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
              const MFAAuthenticationState(
                email: '',
                mfaInfo: mfaInfoConfiguredMock,
                mfaStatus: MFAAuthenticationStatus.biometryFlow,
                status: NetworkStatus.loading,
                errorType: null,
                authenticationResponse: authenticationResponseMock,
                username: 'username',
              ),
            ]);
  });
}
