import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../cubit/password_recovery_cubit.dart';
import 'recaptcha_webview.dart';

class PasswordRecoveryRecaptcha extends StatefulWidget {
  final ChangePasswordSettings changePasswordSettings;
  const PasswordRecoveryRecaptcha({
    super.key,
    required this.changePasswordSettings,
  });

  @override
  State<PasswordRecoveryRecaptcha> createState() =>
      _PasswordRecoveryRecaptchaState();
}

class _PasswordRecoveryRecaptchaState extends State<PasswordRecoveryRecaptcha> {
  @override
  void initState() {
    super.initState();
    _getRecaptchaUrl();
  }

  void _getRecaptchaUrl() async {
    context
        .read<PasswordRecoveryCubit>()
        .getRecaptchaUrl(widget.changePasswordSettings);
  }

  @override
  Widget build(BuildContext context) {
    final siteKey = widget.changePasswordSettings.customRecaptchaSiteKey ?? '';
    return Padding(
      padding: const EdgeInsets.all(SeniorSpacing.normal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SeniorText.h3(
            context.l10n.recoveryPasswordRecaptchaTitle,
            color: SeniorColors.neutralColor800,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: SeniorSpacing.medium),
          BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>(
            buildWhen: (previous, current) =>
                previous.recaptchaUrl != current.recaptchaUrl,
            builder: (_, state) {
              return state.recaptchaUrl.isNotEmpty
                  ? RecaptchaWebView(
                      recaptchaUrl: state.recaptchaUrl,
                      customRecaptchaSiteKey: siteKey,
                    )
                  : const SizedBox.shrink();
            },
          ),
          const SizedBox(height: SeniorSpacing.medium),
        ],
      ),
    );
  }
}
