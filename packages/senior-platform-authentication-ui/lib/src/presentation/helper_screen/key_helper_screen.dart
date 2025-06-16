import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../core/l10n/l10n_extension.dart';

class KeyHelperScreen extends StatelessWidget {
  final Widget? helperContent;

  const KeyHelperScreen({this.helperContent, super.key});

  @override
  Widget build(BuildContext context) {
    return SeniorBackdrop(
      title: SeniorText.label(
        context.l10n.help,
        color: SeniorColors.pureWhite,
      ),
      body: helperContent ??
          SizedBox(
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SeniorText.labelBold(context.l10n.loginWithKeyHelpTitle)
                      ],
                    ),
                    const SizedBox(height: SeniorSpacing.small),
                    SeniorText.label(context.l10n.loginWithKeyHelper),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
