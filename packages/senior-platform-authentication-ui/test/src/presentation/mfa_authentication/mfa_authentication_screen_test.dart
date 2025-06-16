import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/cubit/mfa_authentication_code_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/mfa_authentication_screen.dart';

import '../../../mocks/mfa_info_mock.dart';
import '../../../mocks/token_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late AuthenticationBloc authenticationBloc;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
  });

  Widget makeTestableConfiguredWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
          child: const MFAAuthenticationScreen(
            username: 'username',
            mfaInfo: mfaInfoUnconfiguredMock,
            helpImageAsset: 'images/help.png',
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (widgetTester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.authenticated(
      token: tokenMock,
    ));

    await widgetTester.pumpWidget(makeTestableConfiguredWidget());

    final seniorBackdropFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorBackdrop && widget.onTapBack != null);

    final blocProviderFinder =
        find.byType(BlocProvider<MFAAuthenticationCubit>);

    final mfaAuthenticationCodeFinder = find.byType(MFAAuthenticationScreen);
    expect(seniorBackdropFinder, findsOneWidget);
    expect(blocProviderFinder, findsOneWidget);
    expect(mfaAuthenticationCodeFinder, findsOneWidget);
  });

  testWidgets('should render correctly', (widgetTester) async {
    when(() => authenticationBloc.state).thenReturn(
      const AuthenticationState.authenticated(
        token: tokenMock,
      ),
    );

    await widgetTester.pumpWidget(makeTestableConfiguredWidget());

    await widgetTester.pumpAndSettle();

    final seniorBackdropFinder = find.byType(
      IconButton,
      skipOffstage: false,
    );

    await widgetTester.pumpAndSettle();

    await widgetTester.pumpAndSettle();

    //final image = find.byType(Image);
    final text = find.byType(Text);
    expect(seniorBackdropFinder, findsAtLeastNWidgets(2));
    expect(text, findsAtLeastNWidgets(5));
    //expect(image, findsOneWidget);
  });
}
