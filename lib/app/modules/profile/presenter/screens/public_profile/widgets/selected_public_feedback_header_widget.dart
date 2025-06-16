import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';

class SelectedPublicFeedbackHeaderWidget extends StatelessWidget {
  final ImageProvider fromPhoto;
  final String fromEmployeeName;
  final String feedbackFormattedDate;
  final Widget proficiency;
  final ImageProvider toPhoto;
  final String toEmployeeName;

  const SelectedPublicFeedbackHeaderWidget({
    Key? key,
    required this.fromPhoto,
    required this.fromEmployeeName,
    required this.feedbackFormattedDate,
    required this.proficiency,
    required this.toPhoto,
    required this.toEmployeeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    return SizedBox(
      height: 140,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeniorText.small(context.translate.sentBy),
          const SizedBox(
            height: SeniorSpacing.xxsmall,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SeniorProfilePicture(
                key: const Key('selected_public_feedback_header_widget-profile_picture'),
                imageProvider: fromPhoto,
                radius: SeniorSpacing.xmedium,
                name: fromEmployeeName,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.xsmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SeniorSpacing.xxsmall,
                              ),
                              child: SeniorText.label(
                                fromEmployeeName,
                                key: const Key('selected_public_feedback_header_widget-user_name-label'),
                                textProperties: const TextProperties(
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ),
                          SeniorText.small(
                            feedbackFormattedDate,
                            key: const Key('selected_public_feedback_header_widget-feedback_date-label'),
                          ),
                        ],
                      ),
                      proficiency,
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.xxsmall),
            child: SeniorText.small(context.translate.receivedBy),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SeniorIcon(
                icon: FontAwesomeIcons.arrowTurnDownRight,
                size: SeniorIconSize.medium,
                style: SeniorIconStyle(
                  color: isDark ? SeniorColors.grayscale5 : SeniorColors.grayscale60,
                ),
              ),
              const SizedBox(
                width: SeniorSpacing.xsmall,
              ),
              SeniorProfilePicture(
                key: const Key('selected_public_feedback_header_widget-profile_picture_to'),
                imageProvider: toPhoto,
                radius: SeniorSpacing.normal,
                name: toEmployeeName,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.xsmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SeniorSpacing.xxsmall,
                              ),
                              child: SeniorText.label(
                                toEmployeeName,
                                key: const Key('selected_public_feedback_header_widget-user_name_to-label'),
                                textProperties: const TextProperties(
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
