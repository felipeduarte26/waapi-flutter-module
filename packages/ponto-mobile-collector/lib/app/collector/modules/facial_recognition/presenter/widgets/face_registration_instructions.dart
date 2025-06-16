import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import 'instruction_item.dart';

class FaceRegistrationInstructions extends StatelessWidget {
  const FaceRegistrationInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InstructionItem(
          icon: FontAwesomeIcons.solidEye,
          content: CollectorLocalizations.of(context)
              .facialPositionCellPhoneEyeCamera,
        ),
        InstructionItem(
          icon: FontAwesomeIcons.solidSun,
          content: CollectorLocalizations.of(context)
              .facialBeBrightEnvironmentPeopleBackground,
        ),
        InstructionItem(
          icon: FontAwesomeIcons.glasses,
          content: CollectorLocalizations.of(context)
              .facialAvoidWearingAccessoriesGlasses,
        ),
        InstructionItem(
          icon: FontAwesomeIcons.mobileScreen,
          content: CollectorLocalizations.of(context)
              .facialAvoidShakingYourCellPhone,
        ),
        InstructionItem(
          icon: FontAwesomeIcons.solidFaceTired,
          content: CollectorLocalizations.of(context)
              .facialAvoidMakingFacesOrExpressions,
        ),
        InstructionItem(
          icon: FontAwesomeIcons.solidLightbulb,
          content:
              CollectorLocalizations.of(context).facialIfNecessaryAskHelpCamera,
        ),
      ],
    );
  }
}
