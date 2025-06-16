import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../l10n/l10n_extension.dart';

class GenericError extends StatelessWidget {
  const GenericError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SeniorSpacing.normal),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.exclamation,
            size: 66,
            color: SeniorColors.primaryColor400,
          ),
          const SizedBox(height: SeniorSpacing.xmedium),
          SeniorText.h4(
            context.l10n.genericErrorTitle,
            textProperties: const TextProperties(
              textAlign: TextAlign.center,
            ),
            color: SeniorColors.secondaryColor900,
          ),
          const SizedBox(height: SeniorSpacing.xsmall),
          SeniorText.label(
            context.l10n.genericErrorDescription,
            textProperties: const TextProperties(
              textAlign: TextAlign.center,
            ),
            color: SeniorColors.neutralColor500,
          ),
          const SizedBox(height: SeniorSpacing.normal),
        ],
      ),
    );
  }
}
