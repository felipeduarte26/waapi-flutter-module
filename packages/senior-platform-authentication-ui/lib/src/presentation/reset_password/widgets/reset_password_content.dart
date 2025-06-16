import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/widgets/enable_biometric_auth/enable_biometric_auth_form.dart';
import '../cubit/reset_password_cubit.dart';
import 'reset_password_error.dart';
import 'reset_password_loading.dart';
import 'reset_password_view.dart';

class ResetPasswordContent extends StatelessWidget {
  const ResetPasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        if (state.biometricFlow) {
          return EnableBiometricAuthForm(
            authenticationResponse: state.authenticationResponse!,
          );
        }
        if (state.networkStatus == NetworkStatus.loading) {
          return const ResetPasswordLoading();
        }

        if (state.networkStatus == NetworkStatus.idle &&
            state.passwordPolicySettings != null) {
          return ResetPasswordView(
              passwordPolicySettings: state.passwordPolicySettings!);
        }

        return const ResetPasswordError();
      },
    );
  }
}
