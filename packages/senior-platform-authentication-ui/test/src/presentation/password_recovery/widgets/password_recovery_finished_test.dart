import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/cubit/password_recovery_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_finished.dart';

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
          child: PasswordRecoveryFinished(),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state)
        .thenReturn(PasswordRecoveryState.initial().copyWith(
      passwordRecoveryStatus: PasswordRecoveryStatus.finished,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final passwordRecoveryFinishedFinder =
        find.byType(PasswordRecoveryFinished);
    final iconFinder = find.byWidgetPredicate((widget) =>
        widget is FaIcon && widget.icon == FontAwesomeIcons.solidCircleCheck);
    final finishedTitleFinder =
        find.text('Password reset request sent to your email.');
    final finishedDescriptionFinder = find.text(
        'Check your inbox. If you are a registered user, we will send you an email with instructions on how to recover your password.');
    final backToBeginingBtnFinder = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Home');

    expect(passwordRecoveryFinishedFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
    expect(finishedTitleFinder, findsOneWidget);
    expect(finishedDescriptionFinder, findsOneWidget);
    expect(backToBeginingBtnFinder, findsOneWidget);
  });
}
