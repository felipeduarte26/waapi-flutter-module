import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../cubit/password_recovery_cubit.dart';

class PasswordRecoveryInitial extends StatelessWidget {
  final ChangePasswordSettings changePasswordSettings;
  const PasswordRecoveryInitial({
    super.key,
    required this.changePasswordSettings,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Padding(
      padding: const EdgeInsets.all(SeniorSpacing.normal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SeniorText.h3(
            context.l10n.recoveryPasswordTitle,
            color: SeniorColors.neutralColor800,
          ),
          const SizedBox(
            height: SeniorSpacing.medium,
          ),
          BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>(
            builder: (context, state) {
              return Column(
                children: [
                  SeniorText.label(
                    context.l10n.recoveryPasswordDescription,
                  ),
                  const SizedBox(
                    height: SeniorSpacing.normal,
                  ),
                  RichText(
                    text: TextSpan(
                      style: SeniorTypography.label(
                        color: isDarkMode
                            ? SeniorColors.neutralColor400
                            : SeniorColors.pureBlack,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${context.l10n.note}: ',
                          style: SeniorTypography.labelBold(),
                        ),
                        TextSpan(
                          text: context.l10n.recoveryPasswordDescriptionNote,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: SeniorSpacing.normal),
          SeniorButton.primary(
            label: context.l10n.recoveryPasswordSendEmailBtnText,
            onPressed: () {
              context
                  .read<PasswordRecoveryCubit>()
                  .onPasswordRecoveryStatusChanged(
                      PasswordRecoveryStatus.recaptcha);
            },
          ),
          const SizedBox(height: SeniorSpacing.normal),
          SeniorButton.ghost(
            label: context.l10n.back,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
