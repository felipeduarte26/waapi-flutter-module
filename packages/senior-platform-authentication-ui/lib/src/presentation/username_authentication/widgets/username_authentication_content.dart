import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../senior_platform_authentication_ui.dart';
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/widgets/enable_biometric_auth/enable_biometric_auth_form.dart';
import '../../mfa_authentication/mfa_authentication_screen.dart';
import '../../reset_password/reset_password_screen.dart';
import '../../saml_authentication/saml_authentication_screen.dart';
import 'username_authentication_form.dart';

class UserNameAuthenticationContent extends StatefulWidget {
  final String? helpImageUrl;
  final String? helpImageAsset;
  final String? usernameHint;
  final bool showUserNameScreenSubTitle;
  final String? loginBtnText;
  const UserNameAuthenticationContent({
    super.key,
    this.helpImageUrl = '',
    this.helpImageAsset = '',
    this.usernameHint,
    this.showUserNameScreenSubTitle = true,
    this.loginBtnText,
  });

  @override
  State<UserNameAuthenticationContent> createState() =>
      _UserNameAuthenticationContentState();
}

class _UserNameAuthenticationContentState
    extends State<UserNameAuthenticationContent> {
  BiometryStatus biometryStatus = BiometryStatus.unknown;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      builder: (context, state) {
        if (state.biometryStatus == BiometryStatus.error) {
          context.read<AuthenticationBloc>().add(
                const ErrorAuthentication(),
              );
        }

        return Padding(
          padding: const EdgeInsets.only(
            left: SeniorSpacing.normal,
            top: SeniorSpacing.normal,
            right: SeniorSpacing.normal,
          ),
          child: BlocListener<UserNameAuthenticationCubit,
              UserNameAuthenticationState>(
            listenWhen: (previous, current) =>
                (previous.errorType != current.errorType) ||
                (previous.authenticationFlow != current.authenticationFlow),
            listener: (context, state) {
              if (state.errorType != null &&
                  state.status == NetworkStatus.idle) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SeniorSnackBar.error(
                      message:
                          _getSnackbarErrorMessage(context, state.errorType!),
                      action: SeniorSnackBarAction(
                        label: context.l10n.ok,
                        onPressed: () =>
                            ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      ),
                    ),
                  );
              }

              if (state.authenticationFlow == AuthenticationFlow.saml) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SAMLAuthenticationScreen(
                      username: state.username,
                      tenantDomain:
                          state.tenantLoginSettings?.tenantDomain ?? '',
                    ),
                  ),
                );
              }

              if (state.authenticationFlow == AuthenticationFlow.mfa) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MFAAuthenticationScreen(
                      mfaInfo: state.mfaInfo!,
                      helpImageAsset: widget.helpImageAsset,
                      helpImageUrl: widget.helpImageUrl,
                      username: state.username,
                    ),
                  ),
                );
              }

              if (state.authenticationFlow ==
                      AuthenticationFlow.resetPassword &&
                  state.authenticationResponse?.resetPasswordInfo != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResetPasswordScreen(
                      resetPasswordInfo:
                          state.authenticationResponse!.resetPasswordInfo!,
                      username: state.username,
                    ),
                  ),
                );
              }

              if (state.authenticationFlow == AuthenticationFlow.biometryFlow &&
                  state.authenticationResponse != null) {
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => EnableBiometricAuthForm(
                      authenticationResponse: state.authenticationResponse!,
                    ),
                  ),
                  (route) => false, // Condição para não remover nenhuma rota
                );
              }
            },
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: UserNameAuthenticationForm(
                    loginBtnText: widget.loginBtnText,
                    showUserNameScreenSubTitle:
                        widget.showUserNameScreenSubTitle,
                    usernameHint: widget.usernameHint,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getSnackbarErrorMessage(BuildContext context, ErrorType errorType) {
    if (errorType == ErrorType.tenantNotFound) {
      return context.l10n.tenantNotFoundErrorMessage;
    }

    if (errorType == ErrorType.unauthorized) {
      return context.l10n.unauthorizedErrorMessage;
    }

    if (errorType == ErrorType.biometricError) {
      return context.l10n.errorTryingAuthenticateWithBiometrics;
    }

    if (errorType == ErrorType.disableLoginOffline) {
      return context.l10n.checkInternetConnectionTryAgain;
    }

    if (SeniorAuthentication.enableLoginOffline &&
        errorType == ErrorType.loginOfflineUnauthorized) {
      return context.l10n.unableToLogInOffline;
    }

    return context.l10n.genericErrorMessage;
  }
}
