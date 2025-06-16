import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';
import 'package:senior_platform_authentication_ui/src/core/l10n/l10n_extension.dart';
import 'package:senior_platform_authentication_ui/src/core/widgets/change_password_form/change_password_form.dart';
import 'package:senior_platform_authentication_ui/src/presentation/reset_password/widgets/reset_password_view.dart';

void main() {
  final tPasswordPolicySettings = PasswordPolicySettings(
    minimumPasswordLength: 6,
    maximumPasswordLength: 30,
    requireNumbers: true,
    requireLowercase: true,
    requireUppercase: true,
    requireSpecialCharacters: true,
  );

  Widget makeTestableWidget() {
    return SeniorDesignSystem(
      child: BaseAuthenticationScreen(
        child: SeniorBackdrop(
          title: Builder(
              builder: (context) =>
                  Text(context.l10n.resetPasswordScreenTitle)),
          body: ResetPasswordView(
            passwordPolicySettings: tPasswordPolicySettings,
          ),
        ),
      ),
    );
  }

  testWidgets('should render correctly', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    final descriptionTextFinder =
        find.text('To proceed, you must create a new password:');
    final changePasswordFormFinder = find.byType(ChangePasswordForm);

    expect(descriptionTextFinder, findsOneWidget);
    expect(changePasswordFormFinder, findsOneWidget);
  });
}
