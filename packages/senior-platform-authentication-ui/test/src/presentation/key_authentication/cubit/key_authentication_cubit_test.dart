import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/login_with_key_mock.dart';
import '../../../../mocks/tenant_login_mock.dart';
import '../../../../mocks/tenant_login_settings_mock.dart';
import '../../../../mocks/token_mock.dart';

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

class MockCheckStatusConnectionUsecase extends Mock
    implements CheckStatusConnectionUsecase {}

class MockAuthenticateKeyUsecase extends Mock
    implements AuthenticateKeyUsecase {}

class MockGetTenantLoginSettingsUsecase extends Mock
    implements GetTenantLoginSettingsUsecase {}

void main() {
  late KeyAuthenticationCubit keyAuthenticationCubit;
  late MockCheckStatusConnectionUsecase checkStatusConnectionUsecase;
  late AuthenticationBloc authenticationBloc;
  late AuthenticateKeyUsecase authenticateKeyUsecase;
  late GetTenantLoginSettingsUsecase getTenantLoginSettingsUsecase;
  const tDomain = 'domain';
  const tAccessKey = 'accessKey';
  const tSecret = 'secret';
  const tKeyAuthenticationState = KeyAuthenticationState(
    accessKey: tAccessKey,
    keyAuthenticationFlow: KeyAuthenticationFlow.secret,
    secret: tSecret,
    tenantName: tDomain,
    status: NetworkStatus.idle,
    errorType: null,
  );

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    checkStatusConnectionUsecase = MockCheckStatusConnectionUsecase();
    authenticateKeyUsecase = MockAuthenticateKeyUsecase();
    getTenantLoginSettingsUsecase = MockGetTenantLoginSettingsUsecase();

    keyAuthenticationCubit = KeyAuthenticationCubit(
      authenticationBloc: authenticationBloc,
      checkStatusConnectionUsecase: checkStatusConnectionUsecase,
      getTenantLoginSettingsUsecase: getTenantLoginSettingsUsecase,
      authenticateKeyUsecase: authenticateKeyUsecase,
    );
  });

  group('onDomainChanged', () {
    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state with new Domain when onDomainChanged '
      'event is fired with Domain text test',
      build: () => keyAuthenticationCubit,
      seed: () => KeyAuthenticationState.initial(),
      act: (cubit) => cubit.onDomainChanged(tDomain),
      expect: () => <KeyAuthenticationState>[
        KeyAuthenticationState.initial().copyWith(
          tenantName: tDomain,
          keyAuthenticationFlow: KeyAuthenticationFlow.domain,
        ),
      ],
    );
  });

  group('onAccessKeyChanged', () {
    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state with new AccessKey when onAccessKeyChanged '
      'event is fired with AccessKey text test',
      build: () => keyAuthenticationCubit,
      seed: () => KeyAuthenticationState.initial(),
      act: (cubit) => cubit.onAccessKeyChanged(tAccessKey),
      expect: () => <KeyAuthenticationState>[
        KeyAuthenticationState.initial().copyWith(
          accessKey: tAccessKey,
          keyAuthenticationFlow: KeyAuthenticationFlow.accessKey,
        ),
      ],
    );
  });

  group('onSecretChanged', () {
    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state with new Secret when onSecretChanged '
      'event is fired with Secret text test',
      build: () => keyAuthenticationCubit,
      seed: () => KeyAuthenticationState.initial(),
      act: (cubit) => cubit.onSecretChanged(tSecret),
      expect: () => <KeyAuthenticationState>[
        KeyAuthenticationState.initial().copyWith(
          secret: tSecret,
          keyAuthenticationFlow: KeyAuthenticationFlow.secret,
        ),
      ],
    );
  });

  group('login', () {
    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state with login execute successfully test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
        registerFallbackValue(loginWithKeyMock);
        when(
          () => checkStatusConnectionUsecase.call(NoParams()),
        ).thenAnswer((_) async => true);
        when(
          () => authenticateKeyUsecase.call(any(), any()),
        ).thenAnswer((_) async => authenticationResponseMock);
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) {
        cubit.emit(tKeyAuthenticationState.copyWith(
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ));
        return cubit.login();
      },
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ),
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.loading,
          errorType: null,
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ),
      ],
      verify: (bloc) {
        verify(() => checkStatusConnectionUsecase.call(NoParams())).called(1);
        verify(() => authenticateKeyUsecase.call(any(), any())).called(1);
        verifyNoMoreInteractions(checkStatusConnectionUsecase);
        verifyNoMoreInteractions(authenticateKeyUsecase);
      },
    );

    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state with login throw BadRequestException test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
        registerFallbackValue(loginWithKeyMock);
        when(
          () => checkStatusConnectionUsecase.call(NoParams()),
        ).thenAnswer((_) async => true);
        when(
          () => authenticateKeyUsecase.call(any(), any()),
        ).thenThrow(BadRequestException());
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) {
        cubit.emit(tKeyAuthenticationState.copyWith(
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ));
        return cubit.login();
      },
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ),
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.loading,
          errorType: null,
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ),
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.unauthorized,
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ),
      ],
      verify: (bloc) {
        verify(() => checkStatusConnectionUsecase.call(NoParams())).called(1);
        verify(() => authenticateKeyUsecase.call(any(), any())).called(1);
        verifyNoMoreInteractions(checkStatusConnectionUsecase);
        verifyNoMoreInteractions(authenticateKeyUsecase);
      },
    );

    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state with login throw Exception test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
        registerFallbackValue(loginWithKeyMock);
        when(
          () => checkStatusConnectionUsecase.call(NoParams()),
        ).thenAnswer((_) async => true);
        when(
          () => authenticateKeyUsecase.call(any(), any()),
        ).thenThrow(Exception());
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) {
        cubit.emit(tKeyAuthenticationState.copyWith(
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ));
        return cubit.login();
      },
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ),
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.loading,
          errorType: null,
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ),
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.unknown,
          domainOK: true,
          secretOK: true,
          accessKeyOK: true,
        ),
      ],
      verify: (bloc) {
        verify(() => checkStatusConnectionUsecase.call(NoParams())).called(1);
        verify(() => authenticateKeyUsecase.call(any(), any())).called(1);
        verifyNoMoreInteractions(checkStatusConnectionUsecase);
        verifyNoMoreInteractions(authenticateKeyUsecase);
      },
    );
  });

  group('getTenantLoginSettings', () {
    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits no state when tenantName is empty test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState.copyWith(tenantName: ''),
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <KeyAuthenticationState>[],
    );

    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state with is not online test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
        registerFallbackValue(loginWithKeyMock);
        when(
          () => checkStatusConnectionUsecase.call(NoParams()),
        ).thenAnswer((_) async => false);
        when(
          () => authenticateKeyUsecase.call(any()),
        ).thenThrow(Exception());
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          keyAuthenticationFlow: KeyAuthenticationFlow.offline,
        ),
      ],
    );

    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state execute successfully test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
        registerFallbackValue(tenantLoginMock);
        when(
          () => checkStatusConnectionUsecase.call(NoParams()),
        ).thenAnswer((_) async => true);
        when(
          () => getTenantLoginSettingsUsecase.call(any()),
        ).thenAnswer((_) async => tenantLoginSettingsMock);
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.loading,
          errorType: null,
          keyAuthenticationFlow: KeyAuthenticationFlow.domain,
        ),
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.idle,
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: null,
          keyAuthenticationFlow: KeyAuthenticationFlow.accessKey,
          domainOK: true,
        ),
      ],
    );

    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state when throw TenantNotFoundException test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
        registerFallbackValue(tenantLoginMock);
        when(
          () => checkStatusConnectionUsecase.call(NoParams()),
        ).thenAnswer((_) async => true);
        when(
          () => getTenantLoginSettingsUsecase.call(any()),
        ).thenThrow(TenantNotFoundException());
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.loading,
          errorType: null,
          keyAuthenticationFlow: KeyAuthenticationFlow.domain,
        ),
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.idle,
          tenantLoginSettings: null,
          errorType: ErrorType.domainNotFound,
          keyAuthenticationFlow: KeyAuthenticationFlow.domain,
        ),
        tKeyAuthenticationState.copyWith(
          errorType: null,
          keyAuthenticationFlow: KeyAuthenticationFlow.domain,
        ),
      ],
    );

    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state when throw Exception test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
        registerFallbackValue(tenantLoginMock);
        when(
          () => checkStatusConnectionUsecase.call(NoParams()),
        ).thenAnswer((_) async => true);
        when(
          () => getTenantLoginSettingsUsecase.call(any()),
        ).thenThrow(Exception());
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) => cubit.getTenantLoginSettings(),
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.loading,
          errorType: null,
          keyAuthenticationFlow: KeyAuthenticationFlow.domain,
        ),
        tKeyAuthenticationState.copyWith(
          status: NetworkStatus.idle,
          tenantLoginSettings: null,
          errorType: ErrorType.unknown,
          keyAuthenticationFlow: KeyAuthenticationFlow.unknown,
        ),
        tKeyAuthenticationState.copyWith(
          errorType: null,
          keyAuthenticationFlow: KeyAuthenticationFlow.unknown,
        ),
      ],
    );
  });
  group('form status', () {
    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state when set domain ok test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) => cubit.setDomainOK = true,
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          domainOK: true,
        ),
      ],
    );

    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state when set access key ok test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) => cubit.setAccessKeyOk = true,
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          accessKeyOK: true,
        ),
      ],
    );

    blocTest<KeyAuthenticationCubit, KeyAuthenticationState>(
      'emits current state when set secret ok test',
      setUp: () {
        SeniorAuthentication.enableLoginWithKey = true;
      },
      tearDown: () {
        SeniorAuthentication.enableLoginWithKey = false;
      },
      build: () => keyAuthenticationCubit,
      seed: () => tKeyAuthenticationState,
      act: (cubit) => cubit.setSecretOk = true,
      expect: () => <KeyAuthenticationState>[
        tKeyAuthenticationState.copyWith(
          secretOK: true,
        ),
      ],
    );
  });
}
