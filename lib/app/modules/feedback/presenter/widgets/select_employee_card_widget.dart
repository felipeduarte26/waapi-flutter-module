import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../domain/entities/employee_entity.dart';
import 'feedback_selector_card_widget.dart';

class SelectEmployeeCardWidget extends StatelessWidget {
  final EmployeeEntity? employeeEntity;
  final VoidCallback onTap;
  final String descriptionLabel;
  final String descriptionLabelCoworker;
  final bool disabled;
  final VoidCallback onTapClearSelection;
  final bool visibleCloseButton;

  const SelectEmployeeCardWidget({
    Key? key,
    required this.employeeEntity,
    required this.onTap,
    required this.descriptionLabel,
    required this.descriptionLabelCoworker,
    this.disabled = false,
    required this.onTapClearSelection,
    this.visibleCloseButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (employeeEntity == null) {
      return FeedbackSelectorCardWidget(
        key: const Key(
          'feedback-employee_select-card_empty',
        ),
        icon: const SeniorIcon(
          icon: FontAwesomeIcons.solidUserPlus,
          size: SeniorIconSize.medium,
        ),
        onTap: disabled ? () {} : onTap,
        title: SeniorText.label(
          context.translate.findCoworker,
          color: SeniorColors.neutralColor700,
          textProperties: const TextProperties(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(
            top: SeniorSpacing.xsmall,
          ),
          child: SeniorText.small(
            descriptionLabel,
            color: SeniorColors.secondaryColor700,
          ),
        ),
      );
    }

    return FeedbackSelectorCardWidget(
      onTapIcon: onTapClearSelection,
      key: const Key('feedback-employee_select-card_selected'),
      icon: visibleCloseButton
          ? SeniorIcon(
              icon: FontAwesomeIcons.xmark,
              style: SeniorIconStyle(
                color: Provider.of<ThemeRepository>(context).isDarkTheme()
                    ? SeniorColors.pureWhite
                    : SeniorColors.pureBlack,
              ),
              size: SeniorIconSize.small,
            )
          : null,
      onTap: null,
      title: SeniorText.small(
        descriptionLabelCoworker,
        color: SeniorColors.neutralColor700,
        textProperties: const TextProperties(
          overflow: TextOverflow.ellipsis,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(
          top: SeniorSpacing.xxsmall,
        ),
        child: Row(
          children: [
            SeniorProfilePicture(
              radius: SeniorCircularElements.small,
              name: employeeEntity!.name,
              imageProvider: CachedNetworkImageProvider(employeeEntity!.photoUrl),
            ),
            const SizedBox(
              width: SeniorSpacing.xsmall,
            ),
            Expanded(
              child: SeniorText.labelBold(
                employeeEntity!.name,
                textProperties: const TextProperties(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
