import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/color_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/icons_helper.dart';
import '../../../../../../core/widgets/proficiency_tag_widget.dart';
import '../../../../domain/entities/feedback_entity.dart';
import '../../../widgets/detail_feedback_header_widget.dart';

class ScreenshotDetailsReceivedFeedbacksWidget extends StatefulWidget {
  final FeedbackEntity receivedFeedbackEntity;
  final String languageCode;

  const ScreenshotDetailsReceivedFeedbacksWidget({
    Key? key,
    required this.receivedFeedbackEntity,
    required this.languageCode,
  }) : super(key: key);

  @override
  State<ScreenshotDetailsReceivedFeedbacksWidget> createState() {
    return _ScreenshotDetailsReceivedFeedbacksWidgetState();
  }
}

class _ScreenshotDetailsReceivedFeedbacksWidgetState extends State<ScreenshotDetailsReceivedFeedbacksWidget> {
  @override
  Widget build(BuildContext context) {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: Container(
        color: SeniorColors.pureWhite,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(SeniorSpacing.normal),
          child: Column(
            children: [
              DetailFeedbackHeaderWidget(
                imageProvider: CachedNetworkImageProvider(widget.receivedFeedbackEntity.fromPhotoUrl),
                employeeName: widget.receivedFeedbackEntity.fromName,
                feedbackFormattedDate: DateTimeHelper.formatWithDefaultDatePattern(
                  dateTime: widget.receivedFeedbackEntity.when,
                  locale: widget.languageCode,
                ),
                proficiency: widget.receivedFeedbackEntity.proficiency != null
                    ? ProficiencyTagWidget(
                        key: const Key('feedback-proficiency_tag_widget-proficiency_tag'),
                        label: widget.receivedFeedbackEntity.proficiency!.name,
                        color: ColorExtension.fromHex(
                          hexString: widget.receivedFeedbackEntity.proficiency!.color,
                        ),
                        icon: IconsHelper.parseProficiencyIconName(
                          proficiencyIconName: widget.receivedFeedbackEntity.proficiency!.icon,
                        ),
                      )
                    : SeniorRating(
                        key: const Key('feedback-proficiency_tag_widget-senior_rating'),
                        itemCount: 5,
                        initialRating: widget.receivedFeedbackEntity.starCount.toDouble(),
                        onRatingUpdate: (_) {},
                        ignoreGestures: true,
                      ),
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SizedBox(
                width: double.infinity,
                child: SeniorQuotes(
                  key: const Key('feedback-senior_quotes-quotes'),
                  message: widget.receivedFeedbackEntity.message,
                  isScrollable: false,
                ),
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              SizedBox(
                height: SeniorSpacing.xxbig,
                child: Center(
                  child: SvgPicture.asset(AssetsPath.poweredBySenior),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
