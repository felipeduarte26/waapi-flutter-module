import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import 'cubit/password_recovery_cubit.dart';
import 'widgets/password_recovery_content.dart';

class PasswordRecoveryModal extends StatelessWidget {
  final ChangePasswordSettings changePasswordSettings;
  final String username;

  const PasswordRecoveryModal({
    super.key,
    required this.changePasswordSettings,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PasswordRecoveryCubit>(
      create: (context) => PasswordRecoveryCubit(
        getRecaptchaUrlUsecase: GetRecaptchaUrlUsecase(),
        resetPasswordUsecase: ResetPasswordUsecase(),
      )..onUsernameChanged(username),
      child: SafeArea(
        child: PasswordRecoveryContent(
            changePasswordSettings: changePasswordSettings),
      ),
    );
  }
}
