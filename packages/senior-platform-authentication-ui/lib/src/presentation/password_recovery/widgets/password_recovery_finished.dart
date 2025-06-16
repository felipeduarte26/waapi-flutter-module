import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../cubit/password_recovery_cubit.dart';

class PasswordRecoveryFinished extends StatelessWidget {
  const PasswordRecoveryFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordRecoveryCubit, PasswordRecoveryState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(SeniorSpacing.normal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: FaIcon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: SeniorColors.primaryColor400,
                  size: SeniorSpacing.xhuge,
                ),
              ),
              const SizedBox(height: SeniorSpacing.xmedium),
              SeniorText.h4(
                context.l10n.recoveryPasswordFinishedTitle,
                textProperties: const TextProperties(
                  textAlign: TextAlign.center,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                color: SeniorColors.neutralColor800,
              ),
              const SizedBox(height: SeniorSpacing.xsmall),
              SeniorText.label(
                context.l10n.recoveryPasswordFinishedDescription,
                textProperties: const TextProperties(
                  textAlign: TextAlign.center,
                ),
                color: SeniorColors.neutralColor500,
              ),
              const SizedBox(height: SeniorSpacing.xxhuge),
              SeniorButton.primary(
                label: context.l10n.backToBeginingBtnText,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
