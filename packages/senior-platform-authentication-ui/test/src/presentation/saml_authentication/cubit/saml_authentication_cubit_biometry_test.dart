import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/constants.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/domain/usecases/get_saml_onboarding_enabled_usecase.dart';
import 'package:senior_platform_authentication_ui/src/core/utils/preferences/domain/usecases/store_saml_onboarding_enabled_usecase.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/cubit/saml_authentication_cubit.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/token_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockStoreSAMLOnboardingEnabledUsecase extends Mock
    implements StoreSAMLOnboardingEnabledUsecase {}

class MockGetSAMLOnboardingEnabledUsecase extends Mock
    implements GetSAMLOnboardingEnabledUsecase {}

class MockGetAuthenticationResponseByTokenJsonUsecase extends Mock
    implements GetAuthenticationResponseByTokenJsonUsecase {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late StoreSAMLOnboardingEnabledUsecase storeSAMLOnboardingEnabledUsecase;
  late GetSAMLOnboardingEnabledUsecase getSAMLOnboardingEnabledUsecase;
  late GetAuthenticationResponseByTokenJsonUsecase
      getAuthenticationResponseByTokenJsonUsecase;
  late SAMLAuthenticationCubit samlAuthenticationCubit;
  const taAthenticatedEvent = AuthenticationStatusChanged(
    AuthenticationStatus.authenticated,
    authenticationResponse: authenticationResponseMock,
  );

  setUpAll(
    () => SeniorAuthentication.initialize(
      enableBiometry: true,
      encryptionKey: encryptionKeyMock,
    ),
  );

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    storeSAMLOnboardingEnabledUsecase = MockStoreSAMLOnboardingEnabledUsecase();
    getSAMLOnboardingEnabledUsecase = MockGetSAMLOnboardingEnabledUsecase();
    getAuthenticationResponseByTokenJsonUsecase =
        MockGetAuthenticationResponseByTokenJsonUsecase();
    samlAuthenticationCubit = SAMLAuthenticationCubit(
      authenticationBloc: authenticationBloc,
      storeSAMLOnboardingEnabledUsecase: storeSAMLOnboardingEnabledUsecase,
      getSAMLOnboardingEnabledUsecase: getSAMLOnboardingEnabledUsecase,
      getAuthenticationResponseByTokenJsonUsecase:
          getAuthenticationResponseByTokenJsonUsecase,
    );

    registerFallbackValue(NoParams());
  });

  group('onSAMLAuthenticated', () {
    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'when executing on success flow'
      'emits SAMLAuthenticationScreenStatus.loading'
      'call getAuthenticationResponseByTokenJsonUsecase'
      'add AuthenticationStatusChanged correctly to AuthenticationBloc',
      setUp: () {
        when(() => getAuthenticationResponseByTokenJsonUsecase.call(any()))
            .thenReturn(authenticationResponseMock);
        when(
          () => authenticationBloc.add(taAthenticatedEvent),
        ).thenAnswer((_) {
          return;
        });
      },
      build: () => samlAuthenticationCubit,
      seed: () => SAMLAuthenticationState.initial(),
      act: (cubit) => cubit.onSAMLAuthenticated(tokenModelJson),
      expect: () => <SAMLAuthenticationState>[
        SAMLAuthenticationState.initial().copyWith(
          status: SAMLAuthenticationScreenStatus.loading,
        ),
        SAMLAuthenticationState.initial().copyWith(
          status: SAMLAuthenticationScreenStatus.biometryFlow,
        )
      ],
      verify: (_) {
        verify(() => getAuthenticationResponseByTokenJsonUsecase
            .call(tokenModelJson)).called(1);
      },
    );
  });

  group('verifySeniorXCookies', () {
    const String tCookie =
        "_ga=GA1.4.66352526.1681756174; _gid=GA1.4.1103976207.1681756174; _gat=1; com.senior.domain=.senior.com.br; com.senior.services.url=https%3A%2F%2Fplatform.senior.com.br%2Ft%2Fsenior.com.br%2Fbridge%2F1.0%2F; com.senior.token=%7B%22version%22%3A1%2C%22expires_in%22%3A604800%2C%22username%22%3A%22Yago.Nunes%40senior.com.br%22%2C%22token_type%22%3A%22bearer%22%2C%22access_token%22%3A%22btZSqkQ6DszqHW5yBgowdu8aKVFkoyvR%22%2C%22refresh_token%22%3A%22ktH9o83eUF77yD8dRSbqOrZkGFVqxrPZ%22%2C%22type%22%3A%22internal%22%2C%22email%22%3A%22Yago.Nunes%40senior.com.br%22%2C%22fullName%22%3A%22Yago+Nunes%22%2C%22tenantName%22%3A%22senior%22%2C%22locale%22%3A%22pt-BR%22%7D; com.senior.base.url=https%3A%2F%2Fplatform.senior.com.br";
    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'execute successfully when passing valid cookie',
      setUp: () {
        when(() => getAuthenticationResponseByTokenJsonUsecase.call(any()))
            .thenReturn(authenticationResponseMock);
        when(
          () => authenticationBloc.add(taAthenticatedEvent),
        ).thenAnswer((_) {
          return;
        });
      },
      build: () => samlAuthenticationCubit,
      seed: () => SAMLAuthenticationState.initial(),
      act: (cubit) async => cubit.verifySeniorXCookies(tCookie),
      expect: () => <SAMLAuthenticationState>[
        SAMLAuthenticationState.initial().copyWith(
          status: SAMLAuthenticationScreenStatus.loading,
        ),
        SAMLAuthenticationState.initial().copyWith(
          status: SAMLAuthenticationScreenStatus.biometryFlow,
        )
      ],
    );
  });
}
