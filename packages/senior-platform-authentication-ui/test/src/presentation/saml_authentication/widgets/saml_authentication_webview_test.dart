import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/base_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/cubit/saml_authentication_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../mocks/webview/webview_platform_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockSAMLAuthenticationCubit extends MockCubit<SAMLAuthenticationState>
    implements SAMLAuthenticationCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late SAMLAuthenticationCubit samlAuthenticationCubit;
  const webviewKey = Key('webviewKey');

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    samlAuthenticationCubit = MockSAMLAuthenticationCubit();
    WebViewPlatform.instance = WebViewPlatformMock();
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
            body: const SAMLAuthenticationWebview(
              tenantDomain: 'tenantDomain',
              username: 'username',
              key: webviewKey,
            ),
          ),
        ),
      ),
    );
  }

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
    final webviewFinder = find.byType(WebViewWidget);
    expect(webviewFinder, findsOneWidget);
  });

  testWidgets('should check for seniorx token Correct', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => samlAuthenticationCubit.state)
        .thenReturn(SAMLAuthenticationState.initial().copyWith(
      status: SAMLAuthenticationScreenStatus.webview,
    ));

    when(() => samlAuthenticationCubit.verifySeniorXCookies(any()))
        .thenReturn(true);

    await tester.pumpWidget(makeTestableWidget());
    final webviewFinder = find.byType(WebViewWidget);
    expect(webviewFinder, findsOneWidget);

    final webViewState = tester.state(find.byKey(webviewKey));
    if (webViewState is SAMLAuthenticationWebviewState) {
      webViewState.checkForSeniorXCookies();
    }
  });
}
