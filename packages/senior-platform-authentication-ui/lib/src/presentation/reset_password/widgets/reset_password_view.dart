import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/widgets/change_password_form/change_password_form.dart';
import '../cubit/reset_password_cubit.dart';

class ResetPasswordView extends StatelessWidget {
  final PasswordPolicySettings passwordPolicySettings;

  const ResetPasswordView({
    super.key,
    required this.passwordPolicySettings,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(SeniorSpacing.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SeniorText.label(
              context.l10n.resetPasswordScreenDescription,
              color: SeniorColors.neutralColor800,
            ),
            Expanded(
              child: ChangePasswordForm(
                passwordPolicySettings: passwordPolicySettings,
                submitCallback: (newPassword) => context
                    .read<ResetPasswordCubit>()
                    .loginWithResetPassword(newPassword),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
