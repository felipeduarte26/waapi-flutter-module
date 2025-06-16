import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/enable_biometric_auth_form.dart';
import 'package:senior_platform_authentication_ui/src/presentation/mfa_authentication/mfa_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/reset_password_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/saml_authentication/saml_authentication_screen.dart';
import 'package:senior_platform_authentication_ui/src/presentation/username_authentication/widgets/username_authentication_form.dart';

import '../../../../mocks/encryption_key_mock.dart';
import '../../../../mocks/reset_password_mock.dart';
import '../../../../mocks/tenant_login_settings_mock.dart';
import '../../../../mocks/token_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockUserNameAuthenticationCubit
    extends MockCubit<UserNameAuthenticationState>
    implements UserNameAuthenticationCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late UserNameAuthenticationCubit userNameAuthenticationCubit;

  setUpAll(() {
    SeniorAuthentication.initialize(
      automaticLogon: true,
      enableLoginOffline: true,
      restUrl:
          'https://cloud-leaf.senior.com.br/t/senior.com.br/bridge/1.0/rest',
      platformEnvironment: PlatformEnvironment.production,
      enableBiometry: true,
      enableBiometryOnly: false,
      encryptionKey: encryptionKeyMock,
    );
  });

  setUp(() {
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

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    when(() => userNameAuthenticationCubit.state)
        .thenReturn(UserNameAuthenticationState.initial());

    await tester.pumpWidget(makeTestableWidget());

    final blocListenerFinder = find.byType(
        BlocListener<UserNameAuthenticationCubit, UserNameAuthenticationState>);
    final customScrollViewFinder = find.byType(CustomScrollView);
    final sliverFillRemainingFinder = find.byType(SliverFillRemaining);
    final userNameAuthenticationFormFinder =
        find.byType(UserNameAuthenticationForm);

    expect(blocListenerFinder, findsAtLeastNWidgets(1));
    expect(customScrollViewFinder, findsOneWidget);
    expect(sliverFillRemainingFinder, findsOneWidget);
    expect(userNameAuthenticationFormFinder, findsOneWidget);
  });

  testWidgets(
      'should show snackbar with correct error message when loginOfflineUnauthorized is caught in cubit',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    whenListen(
      userNameAuthenticationCubit,
      Stream<UserNameAuthenticationState>.fromIterable([
        UserNameAuthenticationState.initial().copyWith(
          status: NetworkStatus.loading,
        ),
        UserNameAuthenticationState.initial().copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.loginOfflineUnauthorized,
        )
      ]),
      initialState: UserNameAuthenticationState.initial(),
    );

    expect(userNameAuthenticationCubit.state,
        equals(UserNameAuthenticationState.initial()));

    await tester.pumpWidget(makeTestableWidget());

    final nextBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Next');
    await tester.tap(nextBtnFinder);
    await tester.pump();

    await expectLater(find.byType(SnackBar), findsOneWidget);
    await expectLater(
        find.text(
            'Unable to log in. Check your access credentials and your internet connection.'),
        findsOneWidget);
  });
  testWidgets(
      'should show snackbar with correct error message when TenantNotFoundException is caught in cubit',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    whenListen(
      userNameAuthenticationCubit,
      Stream<UserNameAuthenticationState>.fromIterable([
        UserNameAuthenticationState.initial().copyWith(
          status: NetworkStatus.loading,
        ),
        UserNameAuthenticationState.initial().copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.tenantNotFound,
        )
      ]),
      initialState: UserNameAuthenticationState.initial(),
    );

    expect(userNameAuthenticationCubit.state,
        equals(UserNameAuthenticationState.initial()));

    await tester.pumpWidget(makeTestableWidget());

    final nextBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Next');
    await tester.tap(nextBtnFinder);
    await tester.pump();

    await expectLater(find.byType(SnackBar), findsOneWidget);
    await expectLater(
        find.text('Tenant not found. Please try again.'), findsOneWidget);
  });

  testWidgets(
      'should show snackbar with correct error message when unknown exception is caught in cubit',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    whenListen(
      userNameAuthenticationCubit,
      Stream<UserNameAuthenticationState>.fromIterable([
        UserNameAuthenticationState.initial().copyWith(
          status: NetworkStatus.loading,
        ),
        UserNameAuthenticationState.initial().copyWith(
          status: NetworkStatus.idle,
          errorType: ErrorType.unknown,
        )
      ]),
      initialState: UserNameAuthenticationState.initial(),
    );

    expect(userNameAuthenticationCubit.state,
        equals(UserNameAuthenticationState.initial()));

    await tester.pumpWidget(makeTestableWidget());

    final nextBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Next');
    await tester.tap(nextBtnFinder);
    await tester.pump();

    await expectLater(find.byType(SnackBar), findsOneWidget);
    await expectLater(
        find.text('A problem has occurred. Please try again.'), findsOneWidget);
  });

  testWidgets(
      'should show snackbar with correct error message when UnauthorizedException is caught in cubit',
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
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());

    whenListen(
      userNameAuthenticationCubit,
      Stream<UserNameAuthenticationState>.fromIterable([
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: '',
          password: '',
          tenantLoginSettings: tenantLoginSettingsMock,
          authenticationFlow: AuthenticationFlow.password,
        ),
        UserNameAuthenticationState(
          status: NetworkStatus.idle,
          username: '',
          password: '',
          tenantLoginSettings: tenantLoginSettingsMock,
          errorType: ErrorType.unauthorized,
          authenticationFlow: AuthenticationFlow.password,
        ),
      ]),
      initialState: UserNameAuthenticationState(
        status: NetworkStatus.idle,
        username: '',
        password: '',
        tenantLoginSettings: tenantLoginSettingsMock,
        authenticationFlow: AuthenticationFlow.password,
      ),
    );

    await tester.pumpWidget(makeTestableWidget());

    final loginBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Log in');

    await tester.tap(loginBtnFinder, warnIfMissed: false);
    await tester.pump();

    await expectLater(find.byType(SnackBar), findsOneWidget);
    await expectLater(
        find.text('Incorrect email or password. Please try again.'),
        findsOneWidget);
  });

  testWidgets(
    'should navigate to MFAAuthenticationScreen when authenticationFlow is MFA',
    (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      whenListen(
        userNameAuthenticationCubit,
        Stream<UserNameAuthenticationState>.fromIterable([
          UserNameAuthenticationState.initial().copyWith(
            status: NetworkStatus.idle,
            authenticationFlow: AuthenticationFlow.mfa,
            tenantLoginSettings: tenantLoginSettingsMock,
            mfaInfo: const MFAInfo(
              mfaStatus: 'status',
              temporaryToken: 'temporaryToken',
              tenant: 'tenant',
            ),
            username: 'username',
          ),
        ]),
        initialState: UserNameAuthenticationState.initial(),
      );

      await tester.pumpWidget(makeTestableWidget());

      final btnFinder =
          find.byWidgetPredicate((widget) => widget is SeniorButton);
      await tester.tap(btnFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byType(MFAAuthenticationScreen), findsOneWidget);

      final mfaScreen = tester.widget<MFAAuthenticationScreen>(
          find.byType(MFAAuthenticationScreen));
      expect(mfaScreen.mfaInfo.mfaStatus, 'status');
      expect(mfaScreen.username, 'username');
    },
  );

  testWidgets(
    'should navigate to ResetPasswordScreen when authenticationFlow is reset password',
    (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      whenListen(
        userNameAuthenticationCubit,
        Stream<UserNameAuthenticationState>.fromIterable([
          UserNameAuthenticationState.initial().copyWith(
            status: NetworkStatus.idle,
            authenticationFlow: AuthenticationFlow.resetPassword,
            tenantLoginSettings: tenantLoginSettingsMock,
            authenticationResponse: const AuthenticationResponse(
              resetPasswordInfo: resetPasswordInfoMock,
            ),
            username: 'username',
          ),
        ]),
        initialState: UserNameAuthenticationState.initial(),
      );

      await tester.pumpWidget(makeTestableWidget());

      final btnFinder =
          find.byWidgetPredicate((widget) => widget is SeniorButton);
      await tester.tap(btnFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byType(ResetPasswordScreen), findsOneWidget);

      final resetPasswordScreen =
          tester.widget<ResetPasswordScreen>(find.byType(ResetPasswordScreen));
      expect(resetPasswordScreen.resetPasswordInfo, resetPasswordInfoMock);
    },
  );

    testWidgets(
    'should navigate to SAMLAuthenticationScreen when authenticationFlow is SAML',
    (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      whenListen(
        userNameAuthenticationCubit,
        Stream<UserNameAuthenticationState>.fromIterable([
          UserNameAuthenticationState.initial().copyWith(
            status: NetworkStatus.idle,
            authenticationFlow: AuthenticationFlow.saml,
            tenantLoginSettings: tenantLoginSettingsMock,
            username: 'username',
          ),
        ]),
        initialState: UserNameAuthenticationState.initial(),
      );

      await tester.pumpWidget(makeTestableWidget());

      final btnFinder =
          find.byWidgetPredicate((widget) => widget is SeniorButton);
      await tester.tap(btnFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byType(SAMLAuthenticationScreen), findsOneWidget);

      final samlPasswordScreen =
          tester.widget<SAMLAuthenticationScreen>(find.byType(SAMLAuthenticationScreen));
      expect(samlPasswordScreen.tenantDomain, tenantLoginSettingsMock.tenantDomain);
    },
  );

  
    testWidgets(
    'should view EnableBiometricAuthForm when authenticationFlow is biometryFlow',
    (tester) async {
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unknown());

      whenListen(
        userNameAuthenticationCubit,
        Stream<UserNameAuthenticationState>.fromIterable([
          UserNameAuthenticationState.initial().copyWith(
            status: NetworkStatus.idle,
            authenticationFlow: AuthenticationFlow.biometryFlow,
            tenantLoginSettings: tenantLoginSettingsMock,
            authenticationResponse: authenticationResponseMock,
            username: 'username',
          ),
        ]),
        initialState: UserNameAuthenticationState.initial(),
      );

      await tester.pumpWidget(makeTestableWidget());

      final btnFinder =
          find.byWidgetPredicate((widget) => widget is SeniorButton);
      await tester.tap(btnFinder, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byType(EnableBiometricAuthForm), findsOneWidget);

      final biometricForm =
          tester.widget<EnableBiometricAuthForm>(find.byType(EnableBiometricAuthForm));
      expect(biometricForm.authenticationResponse, authenticationResponseMock);
    },
  );
}
