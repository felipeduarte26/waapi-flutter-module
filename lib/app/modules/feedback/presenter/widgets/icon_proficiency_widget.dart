import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../core/helper/icons_helper.dart';
import '../../domain/entities/proficiency_feedback_entity.dart';

class IconProficiencyWidget extends StatefulWidget {
  final ProficiencyFeedbackEntity proficiencyFeedbackEntity;

  const IconProficiencyWidget({
    Key? key,
    required this.proficiencyFeedbackEntity,
  }) : super(key: key);

  @override
  State<IconProficiencyWidget> createState() {
    return _IconProficiencyWidgetState();
  }
}

class _IconProficiencyWidgetState extends State<IconProficiencyWidget> {
  @override
  Widget build(BuildContext context) {
    IconData? icon = IconsHelper.parseProficiencyIconName(
      proficiencyIconName: widget.proficiencyFeedbackEntity.icon,
    );

    if (icon != null) {
      return Padding(
        padding: const EdgeInsets.only(
          right: SeniorSpacing.xsmall,
        ),
        child: SeniorIcon(
          icon: icon,
          style: const SeniorIconStyle(
            color: SeniorColors.pureWhite,
          ),
          size: SeniorSpacing.normal,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
