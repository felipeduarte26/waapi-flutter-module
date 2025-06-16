import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/cubit/enable_biometric_auth_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/password_recovery_modal.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/tenant_login_settings_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockUserNameAuthenticationCubit
    extends MockCubit<UserNameAuthenticationState>
    implements UserNameAuthenticationCubit {}

class MockEnableBiometricAuthCubit extends MockCubit<EnableBiometricAuthState>
    implements EnableBiometricAuthCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late UserNameAuthenticationCubit userNameAuthenticationCubit;

  setUpAll(() {
    SeniorAuthentication.initialize(
      enableBiometry: true,
      enableBiometryOnly: true,
      encryptionKey: encryptionKeyMock,
    );
    authenticationBloc = MockAuthenticationBloc();
    userNameAuthenticationCubit = MockUserNameAuthenticationCubit();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authenticationBloc,
          ),
          BlocProvider<UserNameAuthenticationCubit>(
            create: (BuildContext context) => userNameAuthenticationCubit,
          ),
        ],
        child: BaseAuthenticationScreen(
          child: SeniorBackdrop(
            hideLeading: true,
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.solidCircleQuestion),
                onPressed: () {},
              )
            ],
            title: Builder(
                builder: (context) => Text(context.l10n.userNameScreenTitle)),
            body: const UserNameAuthenticationContent(),
          ),
        ),
      ),
    );
  }

  testWidgets(
      'should render correctly when emits [UserNameAuthenticationState.initial]',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => userNameAuthenticationCubit.state)
        .thenReturn(UserNameAuthenticationState.initial());

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder = find.byType(
        BlocBuilder<UserNameAuthenticationCubit, UserNameAuthenticationState>);
    final userNameScreenSubtitleFinder = find.text('Log in');
    final userNameTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.solidUser &&
        widget.label == 'Login');

    final passwordTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.lock &&
        widget.label == 'Password');

    final nextBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Next');
    final loginBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Log in');
    final seniorLoadingFinder = find.byType(SeniorLoading);

    expect(blocBuilderFinder, findsOneWidget);
    expect(userNameScreenSubtitleFinder, findsOneWidget);
    expect(userNameTextFieldFinder, findsOneWidget);
    expect(passwordTextFieldFinder, findsNothing);
    expect(nextBtnFinder, findsOneWidget);
    expect(loginBtnFinder, findsNothing);
    expect(seniorLoadingFinder, findsNothing);
  });

  testWidgets(
      'should render correctly when emits [UserNameAuthenticationState.initial().copyWith(status: NetworkStatus.loading)]',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => userNameAuthenticationCubit.state).thenReturn(
        UserNameAuthenticationState.initial()
            .copyWith(status: NetworkStatus.loading));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder = find.byType(
        BlocBuilder<UserNameAuthenticationCubit, UserNameAuthenticationState>);
    final userNameScreenSubtitleFinder = find.text('Log in');
    final userNameTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.solidUser &&
        widget.label == 'Login');
    final passwordTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.lock &&
        widget.label == 'Password');

    final nextBtnFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorButton &&
        widget.label == 'Next' &&
        widget.busy == true);
    final loginBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Log in');

    expect(blocBuilderFinder, findsOneWidget);
    expect(userNameScreenSubtitleFinder, findsOneWidget);
    expect(userNameTextFieldFinder, findsOneWidget);
    expect(passwordTextFieldFinder, findsNothing);
    expect(nextBtnFinder, findsOneWidget);
    expect(loginBtnFinder, findsNothing);
  });

  testWidgets(
      'should render correctly when tenant login settings is not null and saml is null',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => userNameAuthenticationCubit.state)
        .thenReturn(UserNameAuthenticationState(
      status: NetworkStatus.idle,
      username: '',
      password: '',
      tenantLoginSettings: tenantLoginSettingsMock,
      authenticationFlow: AuthenticationFlow.password,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder = find.byType(
        BlocBuilder<UserNameAuthenticationCubit, UserNameAuthenticationState>);
    final userNameScreenSubtitleFinder = find.text('Log in');
    final userNameTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.solidUser &&
        widget.label == 'Login');

    final passwordTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.lock &&
        widget.label == 'Password');

    final nextBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Next');
    final loginBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Log in');
    final seniorLoadingFinder = find.byType(SeniorLoading);

    expect(blocBuilderFinder, findsOneWidget);
    expect(userNameScreenSubtitleFinder, findsAtLeastNWidgets(2));
    expect(userNameTextFieldFinder, findsOneWidget);
    expect(passwordTextFieldFinder, findsOneWidget);
    expect(nextBtnFinder, findsNothing);
    expect(loginBtnFinder, findsOneWidget);
    expect(seniorLoadingFinder, findsNothing);
  });

  testWidgets(
      'should call onUsernameChanged when userNameTextField text changes',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => userNameAuthenticationCubit.state)
        .thenReturn(UserNameAuthenticationState.initial());

    await tester.pumpWidget(makeTestableWidget());
    const tUserName = 'test';

    final userNameTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.solidUser &&
        widget.label == 'Login');

    await tester.enterText(userNameTextFieldFinder, tUserName);
    await tester.pumpAndSettle();

    verify(() => userNameAuthenticationCubit.onUserNameChanged(tUserName))
        .called(1);
  });

  testWidgets(
      'should call onPasswordChanged when passwordTextField text changes',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => userNameAuthenticationCubit.state)
        .thenReturn(UserNameAuthenticationState(
      status: NetworkStatus.idle,
      username: '',
      password: '',
      tenantLoginSettings: tenantLoginSettingsMock,
      authenticationFlow: AuthenticationFlow.password,
    ));

    await tester.pumpWidget(makeTestableWidget());
    const tPassword = 'test';

    final passwordTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.lock &&
        widget.label == 'Password');

    await tester.enterText(passwordTextFieldFinder, tPassword);
    await tester.pumpAndSettle();

    verify(() => userNameAuthenticationCubit.onPasswordChanged(tPassword))
        .called(1);
  });

  testWidgets('should call login when loginButton is pressed', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    const tUsername = 'somedumbusername@dumb.com.br';
    const tPassword = '123456';

    when(() => userNameAuthenticationCubit.state)
        .thenReturn(UserNameAuthenticationState(
      status: NetworkStatus.idle,
      username: tUsername,
      password: tPassword,
      tenantLoginSettings: tenantLoginSettingsMock,
      authenticationFlow: AuthenticationFlow.password,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final userNameTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.solidUser &&
        widget.label == 'Login');

    await tester.enterText(userNameTextFieldFinder, tUsername);
    await tester.pumpAndSettle();

    final passwordTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.lock &&
        widget.label == 'Password');

    await tester.enterText(passwordTextFieldFinder, tPassword);
    await tester.pumpAndSettle();

    final loginBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Log in');

    await tester.tap(loginBtnFinder);
    await tester.pumpAndSettle();

    verify(() => userNameAuthenticationCubit.login()).called(1);
  });

  testWidgets('should call getTenantLoginSettings when nextButton is pressed',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    const tUsername = 'somedumbusername@dumb.com.br';

    when(() => userNameAuthenticationCubit.state)
        .thenReturn(UserNameAuthenticationState.initial().copyWith(
      username: tUsername,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final userNameTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.solidUser &&
        widget.label == 'Login');

    await tester.enterText(userNameTextFieldFinder, tUsername);
    await tester.pumpAndSettle();

    final nextBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Next');
    await tester.tap(nextBtnFinder);
    await tester.pumpAndSettle();

    verify(() => userNameAuthenticationCubit.getTenantLoginSettings())
        .called(1);
  });

  testWidgets(
      'should call recovery password modal'
      'when tap recovery password button', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    const tUsername = 'somedumbusername@dumb.com.br';
    when(() => userNameAuthenticationCubit.state)
        .thenReturn(UserNameAuthenticationState(
      status: NetworkStatus.idle,
      username: tUsername,
      password: '',
      tenantLoginSettings: tenantLoginSettingsMock,
      authenticationFlow: AuthenticationFlow.password,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final userNameTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.prefixIcon == FontAwesomeIcons.solidUser &&
        widget.label == 'Login');

    await tester.enterText(userNameTextFieldFinder, tUsername);
    await tester.pumpAndSettle();

    final recoverPasswordBtnFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorButton && widget.label == 'Recover password');

    await tester.tap(recoverPasswordBtnFinder);
    await tester.pumpAndSettle();

    final recoveryPasswordModalFinder = find.byType(PasswordRecoveryModal);
    expect(recoveryPasswordModalFinder, findsOneWidget);
  });
}
