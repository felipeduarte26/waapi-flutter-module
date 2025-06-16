import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/cubit/saml_authentication_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/saml_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_content.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

void main() {
  late AuthenticationBloc authenticationBloc;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: BlocProvider<AuthenticationBloc>(
          create: (context) => authenticationBloc,
          child: const SAMLAuthenticationScreen(
            tenantDomain: 'tenantDomain',
            username: 'userName',
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    await tester.pumpWidget(makeTestableWidget());

    final seniorBackdropFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorBackdrop && widget.hideLeading == false);
    final blocProviderFinder =
        find.byType(BlocProvider<SAMLAuthenticationCubit>);
    final contentFinder = find.byType(SAMLAuthenticationContent);

    expect(seniorBackdropFinder, findsOneWidget);
    expect(blocProviderFinder, findsOneWidget);
    expect(contentFinder, findsOneWidget);
  });
}
