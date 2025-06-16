import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/enable_biometric_auth/enable_biometric_auth_form.dart';
import '../cubit/mfa_authentication_code_cubit.dart';
import 'mfa_authentication_code.dart';
import 'mfa_authentication_request_config_content.dart';
import 'mfa_authentication_sended_config_content.dart';

class MFAAuthenticationContent extends StatelessWidget {
  const MFAAuthenticationContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MFAAuthenticationCubit, MFAAuthenticationState>(
      builder: (context, state) {
        if (state.mfaStatus == MFAAuthenticationStatus.configured) {
          return MFAAuthenticationCode(
            mfaInfo: state.mfaInfo,
            username: state.username,
          );
        }

        if (state.mfaStatus == MFAAuthenticationStatus.notConfigured) {
          return const MfaAuthenticationRequestConfigContent();
        }

        if (state.mfaStatus == MFAAuthenticationStatus.changedByADM) {
          return const MfaAuthenticationRequestConfigContent(redefine: true);
        }

        if (state.mfaStatus == MFAAuthenticationStatus.emailSended) {
          return const MfaAuthenticationSendedConfigContent();
        }
        // If whoever implemented the package, has enabled biometrics will enter the if, it will go up a modal asking if the user, who enables biometrics for the application.
        if (state.mfaStatus == MFAAuthenticationStatus.biometryFlow) {
          return EnableBiometricAuthForm(
            authenticationResponse: state.authenticationResponse!,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
