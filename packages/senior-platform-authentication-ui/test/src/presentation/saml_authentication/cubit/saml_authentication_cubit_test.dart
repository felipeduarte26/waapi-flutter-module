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

  setUpAll(() => SeniorAuthentication.initialize(
        encryptionKey: encryptionKeyMock,
      ));

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

  group('onCheckBoxMessageChanged', () {
    const enabled = true;
    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'emits current state with changed onboardingEnabled value ',
      build: () => samlAuthenticationCubit,
      seed: () => SAMLAuthenticationState.initial(),
      act: (cubit) => cubit.onCheckBoxMessageChanged(enabled),
      expect: () => <SAMLAuthenticationState>[
        SAMLAuthenticationState.initial().copyWith(onboardingEnabled: !enabled),
      ],
    );
  });

  group('storeOnboardingEnabled', () {
    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'emits current state with SAMLAuthenticationScreenStatus.webview'
      'store onboardingEnabled value on preferences',
      setUp: () {
        when(() => storeSAMLOnboardingEnabledUsecase.call(any()))
            .thenAnswer((_) async {
          return;
        });
      },
      build: () => samlAuthenticationCubit,
      seed: () => SAMLAuthenticationState.initial(),
      act: (cubit) => cubit.storeOnboardingEnabled(),
      expect: () => <SAMLAuthenticationState>[
        SAMLAuthenticationState.initial().copyWith(
          status: SAMLAuthenticationScreenStatus.webview,
        ),
      ],
      verify: (_) async {
        verify(() => storeSAMLOnboardingEnabledUsecase.call(true)).called(1);
      },
    );
  });

  group('checkOnboardingEnabled', () {
    const enabled = true;
    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'emits current state with SAMLAuthenticationScreenStatus.webview'
      'when onboardingEnabled is false',
      setUp: () {
        when(() => getSAMLOnboardingEnabledUsecase.call(any()))
            .thenAnswer((_) async {
          return !enabled;
        });
      },
      build: () => samlAuthenticationCubit,
      seed: () => SAMLAuthenticationState.initial(),
      act: (cubit) async => await cubit.checkOnboardingEnabled(),
      expect: () => <SAMLAuthenticationState>[
        SAMLAuthenticationState.initial().copyWith(
          status: SAMLAuthenticationScreenStatus.webview,
        ),
      ],
      verify: (_) async {
        verify(() => getSAMLOnboardingEnabledUsecase.call(any())).called(1);
      },
    );

    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'emits current state with SAMLAuthenticationScreenStatus.onboarding'
      'when onboardingEnabled is true',
      setUp: () {
        when(() => getSAMLOnboardingEnabledUsecase.call(any()))
            .thenAnswer((_) async {
          return enabled;
        });
      },
      build: () => samlAuthenticationCubit,
      act: (cubit) async => await cubit.checkOnboardingEnabled(),
      expect: () => <SAMLAuthenticationState>[
        SAMLAuthenticationState.initial(),
      ],
      verify: (_) async {
        verify(() => getSAMLOnboardingEnabledUsecase.call(any())).called(1);
      },
    );
  });

  group('onSAMLAuthenticated', () {
    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'stop execution when SAMLAuthenticationScreenStatus.loading',
      build: () => samlAuthenticationCubit,
      seed: () => SAMLAuthenticationState.initial().copyWith(
        status: SAMLAuthenticationScreenStatus.loading,
      ),
      act: (cubit) => cubit.onSAMLAuthenticated(tokenModelJson),
      expect: () => [],
      verify: (_) async {
        verifyNever(
            () => getAuthenticationResponseByTokenJsonUsecase.call(any()));
      },
    );

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
        )
      ],
      verify: (_) {
        verify(() => getAuthenticationResponseByTokenJsonUsecase
            .call(tokenModelJson)).called(1);

        verify(
          () => authenticationBloc.add(taAthenticatedEvent),
        ).called(1);
      },
    );

    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'when executing on failure flow'
      'emits SAMLAuthenticationScreenStatus.error',
      setUp: () {
        when(() => getAuthenticationResponseByTokenJsonUsecase.call(any()))
            .thenThrow(Exception('Opss'));
      },
      build: () => samlAuthenticationCubit,
      seed: () => SAMLAuthenticationState.initial(),
      act: (cubit) => cubit.onSAMLAuthenticated(tokenModelJson),
      expect: () => <SAMLAuthenticationState>[
        SAMLAuthenticationState.initial().copyWith(
          status: SAMLAuthenticationScreenStatus.loading,
        ),
        SAMLAuthenticationState.initial().copyWith(
          status: SAMLAuthenticationScreenStatus.error,
        ),
      ],
      verify: (_) {
        verify(() => getAuthenticationResponseByTokenJsonUsecase
            .call(tokenModelJson)).called(1);

        verifyNever(
          () => authenticationBloc.add(taAthenticatedEvent),
        );
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
      ],
    );

    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'should not call onSAMLAuthenticated when cookie is empty',
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
      act: (cubit) async => cubit.verifySeniorXCookies(''),
      expect: () => [],
    );

    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'should not call onSAMLAuthenticated when cookie is not a valid String',
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
      act: (cubit) async => cubit.verifySeniorXCookies('some string not valid'),
      expect: () => [],
    );

    blocTest<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      'should not call onSAMLAuthenticated when cookie is not a String',
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
      act: (cubit) async => cubit.verifySeniorXCookies(10),
      expect: () => [],
    );
  });
}
