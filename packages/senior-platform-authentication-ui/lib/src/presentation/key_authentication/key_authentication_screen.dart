import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../senior_platform_authentication_ui.dart';
import '../../core/l10n/l10n_extension.dart';
import '../helper_screen/key_helper_screen.dart';
import 'widgets/key_authentication_content.dart';

/// Application key registration screen class
///
/// Parameters:
///   - [initialDomain]: Initial domain value to be display ed on the screen for the user.
///   - Passing text by parameter to enable customization for each application.
class KeyAuthenticationScreen extends StatelessWidget {
  final String? initialDomain;
  final String? loginWithKeyConfigurationKey;
  final String? loginWithKeyTitle;
  final String? loginWithKeyHelperKey;
  final String? loginWithKeyHelperDomain;
  final String? loginWithKeyWrongDomain;
  final String? loginWithKeyHelperSecret;
  final String? loginWithKeyWrongKey;
  final String? loginWithKeyWrongSecret;
  final String? loginWithKeyAccessKey;
  final String? loginWithKeySecret;
  final String? loginWithKeyDomain;
  final String? loginWithKeyHelper;
  final String? loginWithKeyDomainNotFound;
  final String? loginWithKeyUnauthorizedErrorMessage;
  final String? loginWithKeyUnauthorizedErrorHelper;
  final Widget? loginWithKeyHelperContent;

  const KeyAuthenticationScreen({
    this.initialDomain,
    this.loginWithKeyConfigurationKey,
    this.loginWithKeyTitle,
    this.loginWithKeyHelperKey,
    this.loginWithKeyHelperDomain,
    this.loginWithKeyWrongDomain,
    this.loginWithKeyHelperSecret,
    this.loginWithKeyWrongKey,
    this.loginWithKeyWrongSecret,
    this.loginWithKeyAccessKey,
    this.loginWithKeySecret,
    this.loginWithKeyDomain,
    this.loginWithKeyHelper,
    this.loginWithKeyDomainNotFound,
    this.loginWithKeyUnauthorizedErrorMessage,
    this.loginWithKeyHelperContent,
    this.loginWithKeyUnauthorizedErrorHelper,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAuthenticationScreen(
      child: BlocProvider<KeyAuthenticationCubit>(
        create: (context) => KeyAuthenticationCubit(
          getTenantLoginSettingsUsecase: GetTenantLoginSettingsUsecase(),
          authenticateKeyUsecase: AuthenticateKeyUsecase(),
          authenticationBloc: context.read<AuthenticationBloc>(),
          checkStatusConnectionUsecase: CheckStatusConnectionUsecase(
            getConnectivityStatusUsecase: GetConnectivityStatusUsecase(),
          ),
        ),
        child: SeniorBackdrop(
          onTapBack: () => Navigator.pop(context),
          hideLeading: false,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.solidCircleQuestion,
                  size: SeniorSpacing.normal,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => KeyHelperScreen(
                          helperContent: loginWithKeyHelperContent),
                    ),
                  );
                },
              ),
            )
          ],
          title: Builder(
              builder: (context) => SeniorText.label(
                    loginWithKeyConfigurationKey ??
                        context.l10n.loginWithKeyConfigurationKey,
                    color: SeniorColors.pureWhite,
                  )),
          body: KeyAuthenticationContent(
            initialDomain: initialDomain,
            loginWithKeyTitle: loginWithKeyTitle,
            loginWithKeyHelperKey: loginWithKeyHelperKey,
            loginWithKeyHelperDomain: loginWithKeyHelperDomain,
            loginWithKeyWrongDomain: loginWithKeyWrongDomain,
            loginWithKeyHelperSecret: loginWithKeyHelperSecret,
            loginWithKeyWrongKey: loginWithKeyWrongKey,
            loginWithKeyWrongSecret: loginWithKeyWrongSecret,
            loginWithKeyAccessKey: loginWithKeyAccessKey,
            loginWithKeySecret: loginWithKeySecret,
            loginWithKeyDomain: loginWithKeyDomain,
            loginWithKeyHelper: loginWithKeyHelper,
            loginWithKeyDomainNotFound: loginWithKeyDomainNotFound,
            loginWithKeyUnauthorizedErrorMessage:
                loginWithKeyUnauthorizedErrorMessage,
            loginWithKeyUnauthorizedErrorHelper:
                loginWithKeyUnauthorizedErrorHelper,
          ),
        ),
      ),
    );
  }
}
