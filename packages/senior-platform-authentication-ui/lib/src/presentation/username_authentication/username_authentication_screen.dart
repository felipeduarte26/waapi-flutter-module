import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../senior_platform_authentication_ui.dart';
import '../../core/l10n/l10n_extension.dart';
import '../biometric_security_screen/biometric_security_form.dart';

class UserNameAuthenticationScreen extends StatelessWidget {
  /// link to image helper in network, the helpImageUrl parameter takes precedence over the helpImageAsset
  final String? helpImageAsset;

  /// link to image  helper in assets,the helpImageUrl parameter takes precedence over the helpImageAsset
  final String? helpImageUrl;

  /// link to image in network from loginScren,the loginImageUrl parameter takes precedence over the loginImageAsset
  final String? loginImageAsset;

  /// link to image in assets from loginScren,the loginImageUrl parameter takes precedence over the loginImageAsset
  final String? loginImageUrl;

  final bool hideLeading;

  const UserNameAuthenticationScreen({
    super.key,
    this.loginImageAsset = '',
    this.loginImageUrl = '',
    this.helpImageAsset = '',
    this.helpImageUrl = '',
    this.hideLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAuthenticationScreen(
      child: BlocProvider<UserNameAuthenticationCubit>(
        create: (context) => UserNameAuthenticationCubit(
            checkStoredTokenUsecase: CheckStoredTokenUsecase(
              getUserUsecase: GetUserUsecase(),
              checkStatusConnectionUsecase: CheckStatusConnectionUsecase(
                  getConnectivityStatusUsecase: GetConnectivityStatusUsecase()),
            ),
            secureStorageRepository: SecureStorageRepositoryImpl(),
            getStoredTokenUsecase: GetStoredTokenUsecase(),
            getTenantLoginSettingsUsecase: GetTenantLoginSettingsUsecase(),
            loginUsecase: LoginUsecase(),
            authenticationBloc: context.read<AuthenticationBloc>(),
            checkStatusConnectionUsecase: CheckStatusConnectionUsecase(
                getConnectivityStatusUsecase: GetConnectivityStatusUsecase()),
            loginOfflineUsecase: LoginOfflineUsecase()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: context.read<AuthenticationBloc>(),
          builder: (context, state) {
            if (state.biometryStatus == BiometryStatus.canceled ||
                state.biometryStatus == BiometryStatus.error) {
              return const BiometricSecurityForm();
            }
            if (state.biometryStatus == BiometryStatus.success) {
              return const SizedBox();
            }
            return SeniorBackdrop(
              hideLeading: hideLeading,
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
                          builder: (_) => HelperScreen(
                            isLoginHelp: true,
                            loginImageAsset: loginImageAsset,
                            loginImageUrl: loginImageUrl,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
              title: Builder(
                builder: (context) => SeniorText.label(
                  context.l10n.userNameScreenTitle,
                  color: SeniorColors.pureWhite,
                ),
              ),
              body: UserNameAuthenticationContent(
                helpImageAsset: helpImageAsset,
                helpImageUrl: helpImageUrl,
              ),
            );
          },
        ),
      ),
    );
  }
}
