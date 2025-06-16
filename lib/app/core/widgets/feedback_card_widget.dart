import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../helper/string_helper.dart';
import 'proficiency_tag_widget.dart';
import 'waapi_card_widget.dart';

class FeedbackCardWidget extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String feedbackDate;
  final bool disabled;
  final Function()? onTap;
  final String feedbackMessage;
  final SeniorRating? seniorRating;
  final ProficiencyTagWidget? proficiencyTagWidget;
  final double? width;

  const FeedbackCardWidget({
    Key? key,
    required this.imageUrl,
    required this.userName,
    required this.feedbackDate,
    required this.feedbackMessage,
    required this.disabled,
    this.onTap,
    this.seniorRating,
    this.proficiencyTagWidget,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      disabled: disabled,
      onTap: onTap,
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SeniorProfilePicture(
                key: const Key('feedback_card-profile_picture'),
                imageProvider: CachedNetworkImageProvider(imageUrl),
                radius: SeniorCircularElements.small,
                name: userName,
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
                                userName,
                                key: const Key('feedback_card-user_name-label'),
                                textProperties: const TextProperties(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          SeniorText.small(
                            feedbackDate,
                            key: const Key('feedback_card-feedback_date-label'),
                            textProperties: const TextProperties(
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      proficiencyTagWidget != null ? proficiencyTagWidget! : const SizedBox.shrink(),
                      seniorRating != null
                          ? FittedBox(
                              child: seniorRating!,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.xsmall,
            ),
            child: SeniorText.small(
              StringHelper.removeAllLineBreaks(
                value: feedbackMessage,
              ),
              key: const Key('feedback_card-feedback_message'),
              textProperties: const TextProperties(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
