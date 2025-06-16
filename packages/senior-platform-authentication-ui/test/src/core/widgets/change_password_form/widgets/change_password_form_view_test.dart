import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/change_password_form/cubit/change_password_form_cubit.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/change_password_form/widgets/change_password_form_view.dart';

class MockChangePasswordFormCubit extends MockCubit<ChangePasswordFormState>
    implements ChangePasswordFormCubit {}

void main() {
  final tPasswordPolicySettings = PasswordPolicySettings(
    minimumPasswordLength: 6,
    maximumPasswordLength: 30,
    requireNumbers: true,
    requireLowercase: true,
    requireUppercase: true,
    requireSpecialCharacters: true,
  );
  Future<bool> mockedCallback(String _) async => false;

  late ChangePasswordFormCubit changePasswordFormCubit;

  setUp(() {
    changePasswordFormCubit = MockChangePasswordFormCubit();
  });

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: SeniorBackdrop(
          title: Builder(
              builder: (context) =>
                  Text(context.l10n.resetPasswordScreenTitle)),
          body: BlocProvider(
            create: (context) => changePasswordFormCubit,
            child: ChangePasswordFormView(
              passwordPolicySettings: tPasswordPolicySettings,
              submitCallback: mockedCallback,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('change password form should render correctly', (tester) async {
    when(() => changePasswordFormCubit.state)
        .thenReturn(ChangePasswordFormState.initial());

    await tester.pumpWidget(makeTestableWidget());

    final blocConsumerFinder = find
        .byType(BlocConsumer<ChangePasswordFormCubit, ChangePasswordFormState>);
    final customScrollView = find.byType(CustomScrollView);
    final newPasswordTextFieldinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField && widget.label == 'New password');
    final confirmNewPasswordTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.label == 'Confirm your new password');
    final submitButtonFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorButton && widget.label == 'Redefine password');

    expect(customScrollView, findsOneWidget);
    expect(blocConsumerFinder, findsOneWidget);
    expect(newPasswordTextFieldinder, findsOneWidget);
    expect(confirmNewPasswordTextFieldFinder, findsOneWidget);
    expect(submitButtonFinder, findsOneWidget);
  });

  testWidgets(
      'should show snackbar with error message'
      'when errorType is emitted by cubit', (tester) async {
    whenListen(
      changePasswordFormCubit,
      Stream<ChangePasswordFormState>.fromIterable([
        ChangePasswordFormState.initial().copyWith(
          networkStatus: NetworkStatus.loading,
        ),
        ChangePasswordFormState.initial().copyWith(
          networkStatus: NetworkStatus.idle,
          errorType: ErrorType.unknown,
        )
      ]),
      initialState: ChangePasswordFormState.initial(),
    );

    expect(changePasswordFormCubit.state,
        equals(ChangePasswordFormState.initial()));

    await tester.pumpWidget(makeTestableWidget());

    final submitButtonFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorButton && widget.label == 'Redefine password');
    await tester.tap(submitButtonFinder);
    await tester.pump();

    await expectLater(find.byType(SnackBar), findsOneWidget);
    await expectLater(
        find.text('A problem has occurred. Please try again.'), findsOneWidget);
  });

  testWidgets(
      'should call onPasswordChanged when newPasswordTextField text changes',
      (tester) async {
    when(() => changePasswordFormCubit.state)
        .thenReturn(ChangePasswordFormState.initial());

    await tester.pumpWidget(makeTestableWidget());
    const tNewPassword = 'password';

    final newPasswordTextFieldinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField && widget.label == 'New password');

    await tester.enterText(newPasswordTextFieldinder, tNewPassword);
    await tester.pumpAndSettle();

    verify(() => changePasswordFormCubit.onPasswordChanged(tNewPassword))
        .called(1);
  });

  testWidgets(
      'should call onConfirmPasswordChanged when ConfirmNewPasswordTextField text changes',
      (tester) async {
    when(() => changePasswordFormCubit.state)
        .thenReturn(ChangePasswordFormState.initial());

    await tester.pumpWidget(makeTestableWidget());
    const tNewPassword = 'password';

    final confirmNewPasswordTextFieldFinder = find.byWidgetPredicate((widget) =>
        widget is SeniorTextField &&
        widget.label == 'Confirm your new password');

    await tester.enterText(confirmNewPasswordTextFieldFinder, tNewPassword);
    await tester.pumpAndSettle();

    verify(() => changePasswordFormCubit.onConfirmPasswordChanged(tNewPassword))
        .called(1);
  });
}
