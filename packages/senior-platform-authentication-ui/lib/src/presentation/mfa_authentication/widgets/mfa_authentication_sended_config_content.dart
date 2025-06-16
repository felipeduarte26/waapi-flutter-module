import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../cubit/mfa_authentication_code_cubit.dart';

class MfaAuthenticationSendedConfigContent extends StatelessWidget {
  const MfaAuthenticationSendedConfigContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
          right: SeniorSpacing.normal,
          bottom: SeniorSpacing.normal),
      child: BlocBuilder<MFAAuthenticationCubit, MFAAuthenticationState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.cta(context.l10n.requestSendEmail),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SeniorText.label(
                context.l10n
                    .requestSendEmailMessage(_getObscuredEmail(state.email)),
              ),
              const Spacer(),
              SeniorButton.ghost(
                fullWidth: true,
                label: context.l10n.back,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      ),
    );
  }

  String _getObscuredEmail(String email) {
    var obscuredEmail = email;
    try {
      final splitedStr = email.split("@");
      obscuredEmail = email.replaceRange(
          3, splitedStr[0].length, "*" * (splitedStr[0].length - 3));
    } catch (_) {
      obscuredEmail = email;
    }
    return obscuredEmail;
  }
}
