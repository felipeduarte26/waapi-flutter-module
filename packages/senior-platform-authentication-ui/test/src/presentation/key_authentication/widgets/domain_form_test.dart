import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/presentation/key_authentication/widgets/domain_form.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockKeyAuthenticationCubit extends MockCubit<KeyAuthenticationState>
    implements KeyAuthenticationCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late KeyAuthenticationCubit keyAuthenticationCubit;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    keyAuthenticationCubit = MockKeyAuthenticationCubit();
  });

  group('DomainForm', () {
    Widget makeTestableWidget() {
      return SeniorDesignSystem(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (BuildContext context) => authenticationBloc,
            ),
            BlocProvider<KeyAuthenticationCubit>(
              create: (BuildContext context) => keyAuthenticationCubit,
            ),
          ],
          child: BaseAuthenticationScreen(
            child: SeniorBackdrop(
              hideLeading: true,
              title: Builder(
                  builder: (context) => Text(context.l10n.loginWithKeyTitle)),
              body: const DomainForm(initialDomain: ''),
            ),
          ),
        ),
      );
    }

    testWidgets('should render correctly test', (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      when(() => keyAuthenticationCubit.state)
          .thenReturn(KeyAuthenticationState.initial());
      when(() => keyAuthenticationCubit.getTenantLoginSettings()).thenAnswer(
          (_) async => const TenantLoginSettings(
              tenantName: '',
              cookieDomain: '',
              changePasswordSettings: ChangePasswordSettings(allowed: true),
              rememberMeSettings: RememberMeSettings(allowed: true),
              loginProviders: LoginProviders(),
              authenticationTypes: [],
              tenantDomain: ''));
      await tester.pumpWidget(makeTestableWidget());

      expect(find.text('Domain'), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.solidUser), findsOneWidget);

      final domainTextFieldFinder = find.byWidgetPredicate((widget) =>
          widget is SeniorTextField &&
          widget.prefixIcon == FontAwesomeIcons.solidUser);

      await tester.enterText(domainTextFieldFinder, 'domain');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(domainTextFieldFinder, findsOneWidget);
    });
  });
}
