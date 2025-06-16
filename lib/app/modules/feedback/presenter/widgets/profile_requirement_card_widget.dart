import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/widgets/waapi_card_widget.dart';
import '../../enums/feedback_request_status_enum.dart';

class ProfileRequirementCardWidget extends StatefulWidget {
  final ImageProvider imageProvider;
  final String employeeName;
  final String chipLabel;
  final String feedbackFormattedDate;
  final FeedbackRequestStatusEnum status;
  final String labelTitle;
  final Function() onTap;

  const ProfileRequirementCardWidget({
    Key? key,
    required this.imageProvider,
    required this.employeeName,
    required this.chipLabel,
    required this.feedbackFormattedDate,
    required this.status,
    required this.onTap,
    required this.labelTitle,
  }) : super(key: key);

  @override
  State<ProfileRequirementCardWidget> createState() {
    return _ProfileRequirementCardWidgetState();
  }
}

class _ProfileRequirementCardWidgetState extends State<ProfileRequirementCardWidget> {
  Color getColor() {
    switch (widget.status) {
      case FeedbackRequestStatusEnum.sent:
        return SeniorColors.manchesterColorGreen300;
      case FeedbackRequestStatusEnum.attended:
        return SeniorColors.manchesterColorBlue200;
      case FeedbackRequestStatusEnum.waiting:
        return SeniorColors.manchesterColorYellow400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      onTap: widget.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SeniorProfilePicture(
            radius: SeniorCircularElements.small,
            imageProvider: widget.imageProvider,
            name: widget.employeeName,
          ),
          const SizedBox(
            width: SeniorSpacing.normal,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeniorText.small(
                  widget.labelTitle,
                  color: SeniorColors.neutralColor500,
                ),
                const SizedBox(
                  height: 3,
                ),
                SeniorText.label(
                  widget.employeeName,
                  textProperties: const TextProperties(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  color: SeniorColors.secondaryColor900,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SeniorBadge(
                    label: widget.chipLabel,
                    backgroundColor: getColor(),
                    fontColor: SeniorColors.pureBlack,
                  ),
                ],
              ),
              const SizedBox(
                height: 11,
              ),
              SeniorText.small(
                widget.feedbackFormattedDate,
                color: SeniorColors.pureBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
