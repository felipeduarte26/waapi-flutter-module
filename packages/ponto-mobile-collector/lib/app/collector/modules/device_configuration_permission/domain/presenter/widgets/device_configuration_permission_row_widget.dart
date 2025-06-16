import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

class DeviceConfigurationPermissionRowWidget extends StatelessWidget {
  final String title;
  final String? description;
  final bool hasPermisssion;

  const DeviceConfigurationPermissionRowWidget({
    super.key,
    required this.title,
    this.description,
    this.hasPermisssion = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.small,
      ),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeniorText.label(
                    title,
                    color: SeniorColors.neutralColor800,
                    darkColor: SeniorColors.pureWhite,
                    style: const TextStyle(fontSize: 14),
                  ),
                  getDescription(),
                ],
              ),
            ),
            const SizedBox(width: SeniorSpacing.xsmall),
            hasPermisssion
                ? const Icon(
                    FontAwesomeIcons.circleCheck,
                    size: SeniorSpacing.normal,
                    color: SeniorColors.primaryColor500,
                  )
                : const Icon(
                    FontAwesomeIcons.circleXmark,
                    size: SeniorSpacing.normal,
                    color: SeniorColors.manchesterColorRed400,
                  ),
          ],
        ),
      ),
    );
  }

  Widget getDescription() {
    if (description != null) {
      return SeniorText.small(
        description!,
        color: SeniorColors.neutralColor800,
        textProperties: const TextProperties(
          softWrap: true,
        ),
        style: const TextStyle(fontSize: 12),
      );
    } else {
      return const SizedBox();
    }
  }
}
