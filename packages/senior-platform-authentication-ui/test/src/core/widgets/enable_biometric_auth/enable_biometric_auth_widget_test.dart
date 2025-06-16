import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/cubit/enable_biometric_auth_cubit.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/enable_biometric_auth/enable_biometric_auth_widget.dart';

import '../../../../mocks/token_mock.dart';

class MockEnableBiometricAuthCubit extends MockCubit<EnableBiometricAuthState>
    implements EnableBiometricAuthCubit {}

class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}

class MockAuthenticationResponse extends Mock
    implements AuthenticationResponse {}

void main() {
  late AuthenticationBloc authenticationBloc;
  late EnableBiometricAuthCubit enableBiometricAuthCubit;

  setUp(
    () {
      authenticationBloc = MockAuthenticationBloc();
      enableBiometricAuthCubit = MockEnableBiometricAuthCubit();
    },
  );

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => authenticationBloc,
          ),
          BlocProvider<EnableBiometricAuthCubit>(
            create: (context) => enableBiometricAuthCubit,
          ),
        ],
        child: const BaseAuthenticationScreen(
          child: EnableBiometricAuthWidget(
            authenticationResponse: authenticationResponseMock,
          ),
        ),
      ),
    );
  }

  testWidgets('EnableBiometricAuthWidget should display correctly',
      (WidgetTester tester) async {
    when(() => enableBiometricAuthCubit.state).thenReturn(
        EnableBiometricAuthState.initial().copyWith(
            enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
            biometryStatus: BiometryStatus.unknown));

    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle();
    final buttonYes = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Yes');
    final buttonNo = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'No');
    final modal = find.byWidgetPredicate((widget) =>
        widget is SeniorModal &&
        widget.title == 'Enable access with biometrics');
    expect(buttonYes, findsOneWidget);
    expect(buttonNo, findsOneWidget);
    expect(modal, findsOneWidget);
  });

  testWidgets('EnableBiometricAuthWidget Ontap Yes should work correctly',
      (WidgetTester tester) async {
    when(() => enableBiometricAuthCubit.state)
        .thenReturn(EnableBiometricAuthState.initial().copyWith(
      enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
    ));

    when(() => enableBiometricAuthCubit.biometricAuth(
          authenticationResponse: authenticationResponseMock,
        )).thenAnswer((_) async => {});

    when(() => enableBiometricAuthCubit.authentication(
          biometryStatus: BiometryStatus.success,
          authenticationResponse: authenticationResponseMock,
        )).thenAnswer((_) async => {});

    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle();
    final buttonYes = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Yes');

    await tester.tap(buttonYes);
    await tester.pumpAndSettle();
  });

  testWidgets('EnableBiometricAuthWidget Ontap Yes should work correctly',
      (WidgetTester tester) async {
    when(() => enableBiometricAuthCubit.state)
        .thenReturn(EnableBiometricAuthState.initial().copyWith(
      enableBiometricAuthStatus: BiometricAuthInfo.getAvailableBiometrics,
    ));

    when(() => enableBiometricAuthCubit.authentication(
          biometryStatus: BiometryStatus.unknown,
          authenticationResponse: authenticationResponseMock,
        )).thenAnswer((_) async => {});

    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle();
    final buttonNo = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'No');

    await tester.tap(buttonNo);
    await tester.pumpAndSettle();
  });

  testWidgets('EnableBiometricAuthWidget Ontap Yes should work correctly',
      (WidgetTester tester) async {
    when(() => enableBiometricAuthCubit.state)
        .thenReturn(EnableBiometricAuthState.initial().copyWith(
      enableBiometricAuthStatus: BiometricAuthInfo.biometricsNotRegistered,
    ));

    when(() => enableBiometricAuthCubit.authentication(
          biometryStatus: BiometryStatus.unknown,
          authenticationResponse: authenticationResponseMock,
        )).thenAnswer((_) async => {});

    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle();
    final buttonNo = find.byWidgetPredicate(
        (widget) => widget is SeniorButton && widget.label == 'Continue');

    await tester.tap(buttonNo);
    await tester.pumpAndSettle();
  });
}
