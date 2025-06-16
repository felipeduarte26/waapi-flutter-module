import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../core/l10n/l10n_extension.dart';
import 'widgets/image_helper_widget.dart';
import 'widgets/login_helper_widget.dart';
import 'widgets/mfa_login_helper_widget.dart';

class HelperScreen extends StatelessWidget {
  /// If true, will show the MFA helper screen
  final bool? isMfaHelp;

  /// If true, will show the Login helper screen
  final bool? isLoginHelp;

  /// link to image in network
  final String? helpImageUrl;

  /// link to image in assets
  final String? helpImageAsset;

  /// link to image in network
  final String? loginImageUrl;

  /// link to image in assets
  final String? loginImageAsset;

  const HelperScreen({
    this.isLoginHelp = false,
    this.isMfaHelp = false,
    super.key,
    this.helpImageUrl = '',
    this.helpImageAsset = '',
    this.loginImageUrl = '',
    this.loginImageAsset = '',
  });

  @override
  Widget build(BuildContext context) {
    bool mfahelp = (helpImageUrl!.isNotEmpty || helpImageAsset!.isNotEmpty);
    bool loginHelp = (loginImageUrl!.isNotEmpty || loginImageAsset!.isNotEmpty);
    String? netWorkLink = '';
    String? assetLink = '';
    if (mfahelp) {
      netWorkLink = helpImageUrl;
      assetLink = helpImageAsset;
    }

    if (loginHelp) {
      netWorkLink = loginImageUrl;
      assetLink = loginImageAsset;
    }
    return SeniorBackdrop(
      title: SeniorText.label(
        context.l10n.help,
        color: SeniorColors.pureWhite,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (mfahelp || loginHelp)
                  Container(
                    padding: const EdgeInsets.only(
                      left: SeniorSpacing.normal,
                      right: SeniorSpacing.normal,
                      top: SeniorSpacing.normal,
                      bottom: SeniorSpacing.xmedium,
                    ),
                    height: 160,
                    child: ImageHelperWidget(
                      urlLink: netWorkLink,
                      assetLink: assetLink,
                    ),
                  ),
                if (isMfaHelp == true)
                  const MfaLoginHelperWidget()
                else if (isLoginHelp == true)
                  const LoginHelperWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///  return "•";
}
