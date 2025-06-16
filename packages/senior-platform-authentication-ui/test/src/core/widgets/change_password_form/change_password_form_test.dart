import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/change_password_form/change_password_form.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/change_password_form/cubit/change_password_form_cubit.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/change_password_form/widgets/change_password_form_view.dart';

void main() {
  final tPasswordPolicySettings = PasswordPolicySettings(
    minimumPasswordLength: 6,
    maximumPasswordLength: 30,
    requireNumbers: true,
    requireLowercase: true,
    requireUppercase: true,
    requireSpecialCharacters: true,
  );
  Future<bool> mockedCallback(String _) async => true;

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: SeniorBackdrop(
          title: Builder(
              builder: (context) =>
                  Text(context.l10n.resetPasswordScreenTitle)),
          body: ChangePasswordForm(
            passwordPolicySettings: tPasswordPolicySettings,
            submitCallback: mockedCallback,
          ),
        ),
      ),
    );
  }

  testWidgets('change password form should render correctly', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    final blocProviderFinder =
        find.byType(BlocProvider<ChangePasswordFormCubit>);
    final changePasswordFormViewFinder = find.byType(ChangePasswordFormView);

    expect(blocProviderFinder, findsOneWidget);
    expect(changePasswordFormViewFinder, findsOneWidget);
  });
}
