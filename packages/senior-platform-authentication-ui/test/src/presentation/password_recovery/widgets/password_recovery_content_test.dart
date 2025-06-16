import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/cubit/password_recovery_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_content.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_error.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_finished.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_initial.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_recaptcha.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../mocks/change_password_settings_mock.dart';
import '../../../../mocks/webview/webview_platform_mock.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockPasswordRecoveryCubit extends MockCubit<PasswordRecoveryState>
    implements PasswordRecoveryCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late PasswordRecoveryCubit passwordRecoveryCubit;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    passwordRecoveryCubit = MockPasswordRecoveryCubit();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authenticationBloc,
          ),
          BlocProvider<PasswordRecoveryCubit>(
            create: (BuildContext context) => passwordRecoveryCubit,
          ),
        ],
        child: const BaseAuthenticationScreen(
          child: PasswordRecoveryContent(
              changePasswordSettings: changePasswordSettingsMock),
        ),
      ),
    );
  }

  testWidgets('should render correctly when PasswordRecoveryStatus.initial',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state)
        .thenReturn(PasswordRecoveryState.initial());

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder =
        find.byType(BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>);
    final passwordRecoveryInitialFinder = find.byType(PasswordRecoveryInitial);

    expect(blocBuilderFinder, findsAtLeastNWidgets(1));
    expect(passwordRecoveryInitialFinder, findsOneWidget);
  });

  testWidgets('should render correctly when PasswordRecoveryStatus.recaptcha',
      (tester) async {
    WebViewPlatform.instance = WebViewPlatformMock();
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state)
        .thenReturn(PasswordRecoveryState.initial().copyWith(
      passwordRecoveryStatus: PasswordRecoveryStatus.recaptcha,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder =
        find.byType(BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>);
    final passwordRecoveryRecaptchaFinder =
        find.byType(PasswordRecoveryRecaptcha);

    expect(blocBuilderFinder, findsAtLeastNWidgets(1));
    expect(passwordRecoveryRecaptchaFinder, findsOneWidget);
  });

  testWidgets('should render correctly when PasswordRecoveryStatus.error',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state)
        .thenReturn(PasswordRecoveryState.initial().copyWith(
      passwordRecoveryStatus: PasswordRecoveryStatus.error,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder =
        find.byType(BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>);
    final passwordRecoveryErrorFinder = find.byType(PasswordRecoveryError);

    expect(blocBuilderFinder, findsAtLeastNWidgets(1));
    expect(passwordRecoveryErrorFinder, findsOneWidget);
  });

  testWidgets('should render correctly when PasswordRecoveryStatus.finished',
      (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state)
        .thenReturn(PasswordRecoveryState.initial().copyWith(
      passwordRecoveryStatus: PasswordRecoveryStatus.finished,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final blocBuilderFinder =
        find.byType(BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>);
    final passwordRecoveryFinishedFinder =
        find.byType(PasswordRecoveryFinished);

    expect(blocBuilderFinder, findsAtLeastNWidgets(1));
    expect(passwordRecoveryFinishedFinder, findsOneWidget);
  });
}
