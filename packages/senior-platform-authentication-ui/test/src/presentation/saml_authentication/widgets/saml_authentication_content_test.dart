import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/cubit/enable_biometric_auth_cubit.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/enable_biometric_auth_widget.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/cubit/saml_authentication_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_content.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_error.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_loading.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_onboarding.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_webview.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/token_mock.dart';
import '../../../../mocks/webview/webview_platform_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockSAMLAuthenticationCubit extends MockCubit<SAMLAuthenticationState>
    implements SAMLAuthenticationCubit {}

class MockEnableBiometricAuthCubit extends MockCubit<EnableBiometricAuthState>
    implements EnableBiometricAuthCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late SAMLAuthenticationCubit samlAuthenticationCubit;
  late EnableBiometricAuthCubit enableBiometricAuthCubit;

  setUpAll(() {
    SeniorAuthentication.initialize(
      enableBiometry: true,
      enableBiometryOnly: true,
      encryptionKey: encryptionKeyMock,
    );
    authenticationBloc = MockAuthenticationBloc();
    samlAuthenticationCubit = MockSAMLAuthenticationCubit();
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
          BlocProvider<SAMLAuthenticationCubit>(
            create: (BuildContext context) => samlAuthenticationCubit,
          ),
        ],
        child: BaseAuthenticationScreen(
          child: SeniorBackdrop(
            title: Builder(
                builder: (context) => Text(context.l10n.samlScreenTitle)),
            body: const SAMLAuthenticationContent(
              username: 'username',
              tenantDomain: 'tenantDomain',
            ),
          ),
        ),
      ),
    );
  }

  testWidgets(
      'should render correctly when state.status is SAMLAuthenticationScreenStatus.onboarding',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => samlAuthenticationCubit.state)
        .thenReturn(SAMLAuthenticationState.initial());

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder = find
        .byType(BlocBuilder<SAMLAuthenticationCubit, SAMLAuthenticationState>);
    final onboardingFinder = find.byType(SAMLAuthenticationOnboarding);

    expect(blocBuilderFinder, findsOneWidget);
    expect(onboardingFinder, findsOneWidget);
  });

  testWidgets(
      'should render correctly when state.status is SAMLAuthenticationScreenStatus.loading',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => samlAuthenticationCubit.state)
        .thenReturn(SAMLAuthenticationState.initial().copyWith(
      status: SAMLAuthenticationScreenStatus.loading,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder = find
        .byType(BlocBuilder<SAMLAuthenticationCubit, SAMLAuthenticationState>);
    final loadingFinder = find.byType(SAMLAuthenticationLoading);

    expect(blocBuilderFinder, findsOneWidget);
    expect(loadingFinder, findsOneWidget);
  });

  testWidgets(
      'should render correctly when state.status is SAMLAuthenticationScreenStatus.error',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => samlAuthenticationCubit.state)
        .thenReturn(SAMLAuthenticationState.initial().copyWith(
      status: SAMLAuthenticationScreenStatus.error,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder = find
        .byType(BlocBuilder<SAMLAuthenticationCubit, SAMLAuthenticationState>);
    final errorFinder = find.byType(SAMLAuthenticationError);

    expect(blocBuilderFinder, findsOneWidget);
    expect(errorFinder, findsOneWidget);
  });

  testWidgets(
      'should render correctly when state.status is SAMLAuthenticationScreenStatus.webview',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => samlAuthenticationCubit.state)
        .thenReturn(SAMLAuthenticationState.initial().copyWith(
      status: SAMLAuthenticationScreenStatus.webview,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder = find
        .byType(BlocBuilder<SAMLAuthenticationCubit, SAMLAuthenticationState>);
    final webviewFinder = find.byType(SAMLAuthenticationWebview);

    expect(blocBuilderFinder, findsOneWidget);
    expect(webviewFinder, findsOneWidget);
  });

  testWidgets(
      'should render correctly when state.status is SAMLAuthenticationScreenStatus.webview',
      (tester) async {
    when(() => authenticationBloc.state).thenReturn(
      const AuthenticationState.authenticated(
        token: tokenMock,
      ),
    );

    when(() => samlAuthenticationCubit.state).thenReturn(
        SAMLAuthenticationState.initial().copyWith(
            status: SAMLAuthenticationScreenStatus.biometryFlow,
            authenticationResponse: const AuthenticationResponse()));

    when(() => enableBiometricAuthCubit.state).thenReturn(
      const EnableBiometricAuthState(
        enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    final enableBiometricAuthWidgetFinder =
        find.byType(EnableBiometricAuthWidget);

    expect(enableBiometricAuthWidgetFinder, findsOneWidget);
  });
}
