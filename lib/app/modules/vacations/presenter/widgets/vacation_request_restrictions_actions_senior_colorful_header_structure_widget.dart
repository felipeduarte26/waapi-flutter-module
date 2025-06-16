import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';

class VacationRequestRestrictionsActionsSeniorColorfulHeaderStructureWidget extends StatelessWidget {
  final int numberRestrictionRequest;
  final VoidCallback onTapRestrictions;

  const VacationRequestRestrictionsActionsSeniorColorfulHeaderStructureWidget({
    Key? key,
    required this.numberRestrictionRequest,
    required this.onTapRestrictions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            IconButton(
              key: const Key('vacations-vacation_request_screen-action_button_appbar-restrictions'),
              icon: const SeniorIcon(
                icon: FontAwesomeIcons.solidCircleExclamation,
                size: SeniorIconSize.small,
              ),
              onPressed: onTapRestrictions,
              tooltip: context.translate.titleNotifications,
            ),
            numberRestrictionRequest == 0
                ? const SizedBox.shrink()
                : Positioned(
                    right: SeniorSpacing.xsmall,
                    top: SeniorSpacing.xsmall,
                    child: IgnorePointer(
                      child: CircleAvatar(
                        backgroundColor: SeniorColors.manchesterColorRed500,
                        radius: SeniorSpacing.xsmall,
                        child: SeniorText.small(
                          numberRestrictionRequest > 9 ? '9+' : numberRestrictionRequest.toString(),
                          color: SeniorColors.pureWhite,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
