import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/cubit/enable_biometric_auth_cubit.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/enable_biometric_auth_widget.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/cubit/mfa_authentication_code_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/widgets/mfa_authentication_code.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/widgets/mfa_authentication_content.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/widgets/mfa_authentication_request_config_content.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/widgets/mfa_authentication_sended_config_content.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/webview/webview_platform_mock.dart';

class MockMFAAuthenticationCubit extends MockCubit<MFAAuthenticationState>
    implements MFAAuthenticationCubit {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockEnableBiometricAuthCubit extends MockCubit<EnableBiometricAuthState>
    implements EnableBiometricAuthCubit {}

void main() {
  late MFAAuthenticationCubit mfaAuthenticationCubit;
  late AuthenticationBloc authenticationBloc;
  late EnableBiometricAuthCubit enableBiometricAuthCubit;

  setUpAll(() {
    SeniorAuthentication.initialize(
      enableBiometry: true,
      enableBiometryOnly: true,
      encryptionKey: encryptionKeyMock,
    );
    authenticationBloc = MockAuthenticationBloc();
    mfaAuthenticationCubit = MockMFAAuthenticationCubit();
    WebViewPlatform.instance = WebViewPlatformMock();
    enableBiometricAuthCubit = MockEnableBiometricAuthCubit();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authenticationBloc,
          ),
          BlocProvider<MFAAuthenticationCubit>(
            create: (BuildContext context) => mfaAuthenticationCubit,
          ),
        ],
        child:
            const BaseAuthenticationScreen(child: MFAAuthenticationContent()),
      ),
    );
  }

  testWidgets(
      'should render correctly when state.mfaStatus is MFAAuthenticationStatus.configured',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state).thenReturn(
      MFAAuthenticationState.initial().copyWith(
          mfaStatus: MFAAuthenticationStatus.configured,
          mfaInfo: const MFAInfo(),
          email: 'teste@teste',
          status: NetworkStatus.idle),
    );

    await tester.pumpWidget(
      makeTestableWidget(),
    );

    final mFAAuthenticationCodeFinder = find.byType(MFAAuthenticationCode);

    expect(mFAAuthenticationCodeFinder, findsOneWidget);
  });

  testWidgets(
      'should render correctly when state.mfaStatus is  MFAAuthenticationStatus.notConfigured',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state).thenReturn(
      MFAAuthenticationState.initial().copyWith(
        mfaStatus: MFAAuthenticationStatus.notConfigured,
      ),
    );

    await tester.pumpWidget(
      makeTestableWidget(),
    );

    final requestConfigContentFinder =
        find.byType(MfaAuthenticationRequestConfigContent);

    expect(requestConfigContentFinder, findsOneWidget);
  });

  testWidgets(
    'should render correctly when state.mfaStatus is  MFAAuthenticationStatus.changedByADM',
    (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      when(() => mfaAuthenticationCubit.state).thenReturn(
        MFAAuthenticationState.initial().copyWith(
            mfaStatus: MFAAuthenticationStatus.changedByADM,
            mfaInfo: const MFAInfo(),
            email: 'teste@teste',
            status: NetworkStatus.idle),
      );

      await tester.pumpWidget(
        makeTestableWidget(),
      );

      final requestConfigContentFinder =
          find.byType(MfaAuthenticationRequestConfigContent);

      expect(requestConfigContentFinder, findsOneWidget);
    },
  );

  testWidgets(
      'should render correctly when state.mfaStatus is  MFAAuthenticationStatus.emailSended',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => mfaAuthenticationCubit.state).thenReturn(
      MFAAuthenticationState.initial().copyWith(
        mfaStatus: MFAAuthenticationStatus.emailSended,
        mfaInfo: const MFAInfo(),
        email: 'teste@teste',
        status: NetworkStatus.idle,
      ),
    );

    await tester.pumpWidget(
      makeTestableWidget(),
    );

    final sendedConfigContentFinder =
        find.byType(MfaAuthenticationSendedConfigContent);

    expect(sendedConfigContentFinder, findsOneWidget);
  });

  testWidgets(
    'deve renderizar corretamente quando state.mfaStatus é MFAAuthenticationStatus.biometriaFlow',
    (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      const authenticationResponse = AuthenticationResponse();

      when(() => mfaAuthenticationCubit.state).thenReturn(
        MFAAuthenticationState.initial().copyWith(
          mfaStatus: MFAAuthenticationStatus.biometryFlow,
          authenticationResponse: authenticationResponse,
          // Outros campos necessários para o teste
        ),
      );

      when(() => enableBiometricAuthCubit.state).thenReturn(
        const EnableBiometricAuthState(
          enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
        ),
      );

      await tester.pumpWidget(
        makeTestableWidget(),
      );

      final enableBiometricAuthWidgetFinder =
          find.byType(EnableBiometricAuthWidget);

      expect(enableBiometricAuthWidgetFinder, findsOneWidget);
    },
  );
}
