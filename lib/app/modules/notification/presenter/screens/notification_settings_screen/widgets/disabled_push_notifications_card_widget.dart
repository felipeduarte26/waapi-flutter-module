import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';

class DisabledPushNotificationsCardWidget extends StatelessWidget {
  final bool visible;

  const DisabledPushNotificationsCardWidget({
    Key? key,
    this.visible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: SeniorSpacing.normal,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.normal,
            ),
            child: Align(
              alignment: Alignment.center,
              child: SeniorText.cta(
                context.translate.pushNotificationDisabled,
                color: SeniorColors.neutralColor800,
                textProperties: const TextProperties(
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: SeniorSpacing.normal,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.normal,
            ),
            child: Align(
              alignment: Alignment.center,
              child: SeniorText.small(
                context.translate.descriptionEnableNotifications,
                color: SeniorColors.neutralColor500,
                textProperties: const TextProperties(
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: SeniorSpacing.normal,
          ),
        ],
      ),
    );
  }
}
