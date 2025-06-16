import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';
import 'cubit/change_password_form_cubit.dart';
import 'widgets/change_password_form_view.dart';

class ChangePasswordForm extends StatelessWidget {
  /// Password policy settings.
  final PasswordPolicySettings passwordPolicySettings;

  /// Function performed when the submit button is pressed.
  /// Must return the success of execution.
  final Future<bool> Function(String newPassword) submitCallback;

  const ChangePasswordForm({
    super.key,
    required this.passwordPolicySettings,
    required this.submitCallback,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordFormCubit>(
      create: (context) => ChangePasswordFormCubit()
        ..initializePolicies(passwordPolicySettings: passwordPolicySettings),
      child: ChangePasswordFormView(
        passwordPolicySettings: passwordPolicySettings,
        submitCallback: submitCallback,
      ),
    );
  }
}
