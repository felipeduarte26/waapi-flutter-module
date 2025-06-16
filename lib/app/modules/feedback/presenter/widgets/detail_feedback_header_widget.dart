import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class DetailFeedbackHeaderWidget extends StatelessWidget {
  final ImageProvider imageProvider;
  final String employeeName;
  final String feedbackFormattedDate;
  final Widget proficiency;
  final Function()? onTap;

  const DetailFeedbackHeaderWidget({
    Key? key,
    required this.imageProvider,
    required this.employeeName,
    required this.feedbackFormattedDate,
    required this.proficiency,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SeniorSpacing.huge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SeniorProfilePicture(
                key: const Key('feedback_detail_header_widget-profile_picture'),
                imageProvider: imageProvider,
                radius: SeniorSpacing.normal,
                name: employeeName,
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
                                employeeName,
                                key: const Key('feedback_detail_header_widget-user_name-label'),
                                textProperties: const TextProperties(
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ),
                          SeniorText.small(
                            feedbackFormattedDate,
                            key: const Key('feedback_detail_header_widget-feedback_date-label'),
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
        ],
      ),
    );
  }
}
