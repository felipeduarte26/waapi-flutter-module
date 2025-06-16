import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/components/senior_button/components/components.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/src/core/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/base_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/cubit/saml_authentication_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/widgets/saml_authentication_onboarding.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockSAMLAuthenticationCubit extends MockCubit<SAMLAuthenticationState>
    implements SAMLAuthenticationCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late SAMLAuthenticationCubit samlAuthenticationCubit;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    samlAuthenticationCubit = MockSAMLAuthenticationCubit();
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
            body: const SAMLAuthenticationOnboarding(
              username: 'Fulano',
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => samlAuthenticationCubit.state)
        .thenReturn(SAMLAuthenticationState.initial().copyWith(
      status: SAMLAuthenticationScreenStatus.onboarding,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final greetingsMessageFinder = find.text('Hello!');
    final welcomeMessageFinder = find.text(
        'Your company uses SAML security layers for authentication, so we need to externally validate your password and login.');
    final userNameTextFinder = find.text('Fulano');
    final checkBoxMessageFinder = find.byType(SeniorCheckbox);
    final btnFinder = find.byType(SeniorButtonPrimary);

    expect(greetingsMessageFinder, findsOneWidget);
    expect(welcomeMessageFinder, findsOneWidget);
    expect(userNameTextFinder, findsOneWidget);
    expect(checkBoxMessageFinder, findsOneWidget);
    expect(btnFinder, findsOneWidget);
  });

  testWidgets('SeniorCheckBox should perform tap correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => samlAuthenticationCubit.state)
        .thenReturn(SAMLAuthenticationState.initial().copyWith(
      status: SAMLAuthenticationScreenStatus.onboarding,
    ));

    when(() => samlAuthenticationCubit.onCheckBoxMessageChanged(any()))
        .thenAnswer((_) {
      return;
    });

    await tester.pumpWidget(makeTestableWidget());

    final checkBoxMessageFinder = find.byType(Checkbox);
    var checkbox = tester.firstWidget<Checkbox>(checkBoxMessageFinder);
    expect(checkbox.value, false);

    await tester.tap(checkBoxMessageFinder, warnIfMissed: false);
    await tester.pumpAndSettle();

    checkbox = tester.firstWidget<Checkbox>(checkBoxMessageFinder);
    expect(checkbox.value, true);

    verify(() => samlAuthenticationCubit.onCheckBoxMessageChanged(true))
        .called(1);
  });

  testWidgets('SeniorButton should perform tap correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => samlAuthenticationCubit.state)
        .thenReturn(SAMLAuthenticationState.initial().copyWith(
      status: SAMLAuthenticationScreenStatus.onboarding,
    ));

    when(() => samlAuthenticationCubit.storeOnboardingEnabled())
        .thenAnswer((_) {
      return;
    });

    await tester.pumpWidget(makeTestableWidget());

    final btnFinder = find.byType(SeniorButtonPrimary);

    await tester.tap(btnFinder, warnIfMissed: false);
    await tester.pumpAndSettle();

    verify(() => samlAuthenticationCubit.storeOnboardingEnabled()).called(1);
  });
}
