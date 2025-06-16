import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import 'face_registration_instructions.dart';

class InstructionsBottonSheet extends StatelessWidget {
  const InstructionsBottonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SeniorText.h4(
              CollectorLocalizations.of(context).facialTipsFacialRecognition,
            ),
            const SizedBox(
              height: SeniorSpacing.xsmall,
            ),
            const FaceRegistrationInstructions(),
          ],
        ),
      ),
    );
  }
}
