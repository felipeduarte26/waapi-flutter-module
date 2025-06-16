import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/cubit/password_recovery_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_initial.dart';

import '../../../../mocks/change_password_settings_mock.dart';

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
          child: PasswordRecoveryInitial(
            changePasswordSettings: changePasswordSettingsMock,
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    const tUsername = 'somedumbusername@dumb.com.br';
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state).thenReturn(
      PasswordRecoveryState.initial().copyWith(username: tUsername),
    );

    await tester.pumpWidget(makeTestableWidget());

    final passwordRecoveryFinishedFinder = find.byType(PasswordRecoveryInitial);
    final passwordRecoveryTitleFinder =
        find.text('Send email for password resetting?');
    final passwordRecoveryDescriptionFinder = find.text(
        'If the provided user is registered in our database, we will send an email with instructions for password recovery.');
    final sendEmailBtn = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Send email');
    final backBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Back');

    expect(passwordRecoveryFinishedFinder, findsOneWidget);
    expect(passwordRecoveryTitleFinder, findsOneWidget);
    expect(passwordRecoveryDescriptionFinder, findsOneWidget);
    expect(sendEmailBtn, findsOneWidget);
    expect(backBtnFinder, findsOneWidget);
  });

  testWidgets(
      'should call onPasswordRecoveryStatusChanged'
      'when sendEmail button is pressed', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state).thenReturn(
      PasswordRecoveryState.initial().copyWith(),
    );

    await tester.pumpWidget(makeTestableWidget());

    final sendEmailBtn = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Send email');

    await tester.tap(sendEmailBtn);
    await tester.pumpAndSettle();

    verify(() => passwordRecoveryCubit.onPasswordRecoveryStatusChanged(
        PasswordRecoveryStatus.recaptcha)).called(1);
  });
}
