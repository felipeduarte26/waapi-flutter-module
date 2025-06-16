import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/enable_biometric_auth/enable_biometric_auth_form.dart';
import '../cubit/saml_authentication_cubit.dart';
import 'saml_authentication_error.dart';
import 'saml_authentication_loading.dart';
import 'saml_authentication_onboarding.dart';
import 'saml_authentication_webview.dart';

class SAMLAuthenticationContent extends StatelessWidget {
  final String username;
  final String tenantDomain;

  const SAMLAuthenticationContent({
    super.key,
    required this.username,
    required this.tenantDomain,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SAMLAuthenticationCubit, SAMLAuthenticationState>(
      builder: (context, state) {
        if (state.status == SAMLAuthenticationScreenStatus.onboarding) {
          return SAMLAuthenticationOnboarding(
            username: username,
          );
        }

        if (state.status == SAMLAuthenticationScreenStatus.loading) {
          return const SAMLAuthenticationLoading();
        }

        if (state.status == SAMLAuthenticationScreenStatus.error) {
          return const SAMLAuthenticationError();
        }
        // If whoever implemented the package, has enabled biometrics will enter the if, it will go up a modal asking if the user, who enables biometrics for the application.
        if (state.status == SAMLAuthenticationScreenStatus.biometryFlow) {
          return EnableBiometricAuthForm(
            authenticationResponse: state.authenticationResponse!,
          );
        }

        return SAMLAuthenticationWebview(
          tenantDomain: tenantDomain,
          username: username,
        );
      },
    );
  }
}
