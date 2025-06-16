import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../cubit/password_recovery_cubit.dart';
import 'password_recovery_error.dart';
import 'password_recovery_finished.dart';
import 'password_recovery_initial.dart';
import 'password_recovery_recaptcha.dart';

class PasswordRecoveryContent extends StatelessWidget {
  final ChangePasswordSettings changePasswordSettings;

  const PasswordRecoveryContent({
    super.key,
    required this.changePasswordSettings,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>(
      buildWhen: (previous, current) =>
          previous.passwordRecoveryStatus != current.passwordRecoveryStatus,
      builder: (context, state) {
        if (state.passwordRecoveryStatus == PasswordRecoveryStatus.initial) {
          return PasswordRecoveryInitial(
              changePasswordSettings: changePasswordSettings);
        }

        if (state.passwordRecoveryStatus == PasswordRecoveryStatus.recaptcha) {
          return PasswordRecoveryRecaptcha(
              changePasswordSettings: changePasswordSettings);
        }

        if (state.passwordRecoveryStatus == PasswordRecoveryStatus.error) {
          return const PasswordRecoveryError();
        }

        return const PasswordRecoveryFinished();
      },
    );
  }
}
