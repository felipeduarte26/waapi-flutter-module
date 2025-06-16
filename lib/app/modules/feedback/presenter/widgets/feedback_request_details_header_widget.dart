import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/locale_helper.dart';
import '../../domain/entities/feedback_request_by_me_entity.dart';
import '../../domain/entities/feedback_request_entity.dart';
import '../../enums/feedback_request_status_enum.dart';

class FeedbackRequestDetailsHeaderWidget extends StatelessWidget {
  final FeedbackRequestEntity feedbackRequestEntity;
  final VoidCallback? onTap;

  const FeedbackRequestDetailsHeaderWidget({
    Key? key,
    required this.feedbackRequestEntity,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SeniorProfilePicture(
            key: const Key('feedback-detail_requests_header_widget-profile_picture'),
            imageProvider: CachedNetworkImageProvider(getUrlPhoto()),
            radius: SeniorCircularElements.small,
            name: getRequesterName(),
          ),
          const SizedBox(
            width: SeniorSpacing.xsmall,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeniorText.body(
                  feedbackRequestEntity is FeedbackRequestByMeEntity
                      ? context.translate.sentTo
                      : context.translate.receivedFrom,
                  color: SeniorColors.secondaryColor600,
                ),
                SeniorText.label(
                  getRequesterName(),
                  key: const Key('feedback-detail_requests_header_widget-user_name_label'),
                  textProperties: const TextProperties(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SeniorBadge(
                label: getLabelBadge(context),
                backgroundColor: getColor(),
                fontColor: SeniorColors.pureBlack,
              ),
              const SizedBox(
                height: SeniorSpacing.xxsmall,
              ),
              SeniorText.small(
                DateTimeHelper.formatWithDefaultDatePattern(
                  dateTime: feedbackRequestEntity.when,
                  locale: LocaleHelper.languageAndCountryCode(
                    locale: Localizations.localeOf(context),
                  ),
                ),
                key: const Key('feedback_detail_header_widget-feedback_date-label'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getLabelBadge(BuildContext context) {
    if (feedbackRequestEntity is FeedbackRequestByMeEntity) {
      if (feedbackRequestEntity.status == FeedbackRequestStatusEnum.waiting) {
        return context.translate.sent;
      }
      return context.translate.handled;
    }
    if (feedbackRequestEntity.status == FeedbackRequestStatusEnum.waiting) {
      return context.translate.waiting;
    }
    return context.translate.handled;
  }

  Color getColor() {
    if (feedbackRequestEntity is FeedbackRequestByMeEntity) {
      if (feedbackRequestEntity.status == FeedbackRequestStatusEnum.waiting) {
        return SeniorColors.manchesterColorGreen300;
      }
      return SeniorColors.manchesterColorBlue200;
    }
    if (feedbackRequestEntity.status == FeedbackRequestStatusEnum.waiting) {
      return SeniorColors.manchesterColorYellow400;
    }
    return SeniorColors.manchesterColorBlue200;
  }

  String getUrlPhoto() {
    if (feedbackRequestEntity is FeedbackRequestByMeEntity) {
      return feedbackRequestEntity.photoLinkTo;
    }
    return feedbackRequestEntity.photoLinkFrom;
  }

  String getRequesterName() {
    if (feedbackRequestEntity is FeedbackRequestByMeEntity) {
      return feedbackRequestEntity.nameTo;
    }
    return feedbackRequestEntity.nameFrom;
  }
}
