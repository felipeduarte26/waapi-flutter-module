import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/generic_error.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/cubit/password_recovery_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/password_recovery/widgets/password_recovery_error.dart';

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
          child: PasswordRecoveryError(),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state)
        .thenReturn(const AuthenticationState.unknown());
    when(() => passwordRecoveryCubit.state)
        .thenReturn(PasswordRecoveryState.initial().copyWith(
      passwordRecoveryStatus: PasswordRecoveryStatus.error,
    ));

    await tester.pumpWidget(makeTestableWidget());

    final passwordRecoveryErrorFinder = find.byType(PasswordRecoveryError);
    final genericErrorFinder = find.byType(GenericError);

    expect(passwordRecoveryErrorFinder, findsOneWidget);
    expect(genericErrorFinder, findsOneWidget);
  });
}
