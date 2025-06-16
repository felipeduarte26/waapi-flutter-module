import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/presentation/biometric_security_screen/biometric_security_content.dart';
import 'package:senior_platform_authentication_ui/src/presentation/biometric_security_screen/cubit/biometric_security_cubit.dart';
import 'package:senior_platform_authentication_ui/src/presentation/biometric_security_screen/cubit/biometric_security_state.dart';

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockBiometricSecurityCubit extends MockCubit<BiometricSecurityState>
    implements BiometricSecurityCubit {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late BiometricSecurityCubit biometricSecurityCubit;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    biometricSecurityCubit = MockBiometricSecurityCubit();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
        child: const UserNameAuthenticationScreen(),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    when(() => authenticationBloc.state).thenReturn(
      const AuthenticationState.unauthenticated(
        biometryStatus: BiometryStatus.canceled,
      ),
    );
    when(() => biometricSecurityCubit.state)
        .thenReturn(BiometricSecurityState.initial());

    await tester.pumpWidget(makeTestableWidget());

    final buttonExit = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Sign Out');

    expect(find.byType(BiometricSecurityContent), findsOneWidget);
    expect(buttonExit, findsOneWidget);
  });
}
