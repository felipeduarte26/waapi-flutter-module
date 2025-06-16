import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../cubit/saml_authentication_cubit.dart';

class SAMLAuthenticationOnboarding extends StatelessWidget {
  final String username;
  const SAMLAuthenticationOnboarding({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(SeniorSpacing.normal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SeniorText.h3(context.l10n.samlGreetingsMessage),
            SeniorText.label(username),
            const SizedBox(height: SeniorIconSize.medium),
            SeniorText.label(context.l10n.samlWelcomeMessage),
            const SizedBox(height: SeniorIconSize.medium),
            const _CheckBoxMessage(),
            const Spacer(),
            SeniorButton.primary(
              label: context.l10n.samlValidateCredentialsBtnText,
              onPressed: () async {
                if (context.mounted) {
                  await context
                      .read<SAMLAuthenticationCubit>()
                      .storeOnboardingEnabled();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckBoxMessage extends StatefulWidget {
  const _CheckBoxMessage();

  @override
  State<_CheckBoxMessage> createState() => _CheckBoxMessageState();
}

class _CheckBoxMessageState extends State<_CheckBoxMessage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SeniorCheckbox(
      value: isChecked,
      title: context.l10n.samlCheckboxMessage,
      onChanged: (bool? value) async {
        setState(() {
          isChecked = value!;
        });

        if (context.mounted) {
          context
              .read<SAMLAuthenticationCubit>()
              .onCheckBoxMessageChanged(value!);
        }
      },
    );
  }
}
