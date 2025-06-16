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

import '../../../mocks/encryption_key_mock.dart';

class MockAuthenticationBloc extends MockCubit<AuthenticationState>
    implements AuthenticationBloc {}

class MockBiometricSecurityCubit extends MockCubit<BiometricSecurityState>
    implements BiometricSecurityCubit {}

void main() {
  group('BiometricSecurityForm', () {
    late AuthenticationBloc authenticationBloc;

    setUp(() {
      SeniorAuthentication.initialize(
        enableBiometry: true,
        enableBiometryOnly: true,
        encryptionKey: encryptionKeyMock,
      );
      authenticationBloc = MockAuthenticationBloc();
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
      when(() => authenticationBloc.state)
          .thenReturn(const AuthenticationState.unauthenticated(
        biometryStatus: BiometryStatus.canceled,
      ));

      await tester.pumpWidget(makeTestableWidget());

      expect(find.byType(BiometricSecurityContent), findsOneWidget);
    });
  });
}
