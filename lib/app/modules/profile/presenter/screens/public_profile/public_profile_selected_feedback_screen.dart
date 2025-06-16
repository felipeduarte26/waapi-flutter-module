import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/color_extension.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/icons_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../../../core/widgets/proficiency_tag_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../feedback/domain/entities/feedback_entity.dart';
import '../../../../feedback/presenter/widgets/feedback_list_skills_widget.dart';
import 'widgets/selected_public_feedback_header_widget.dart';

class PublicProfileSelectedFeedbackScreen extends StatelessWidget {
  final FeedbackEntity feedback;

  const PublicProfileSelectedFeedbackScreen({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => Modular.to.pop,
      child: Scaffold(
        body: WaapiColorfulHeader(
          onTapBack: () => Modular.to.pop(),
          hasTopPadding: false,
          titleLabel: context.translate.feedbackTitle,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: SeniorSpacing.normal,
                  right: SeniorSpacing.normal,
                  top: SeniorSpacing.normal,
                ),
                child: SelectedPublicFeedbackHeaderWidget(
                  fromPhoto: CachedNetworkImageProvider(
                    feedback.fromPhotoUrl,
                  ),
                  fromEmployeeName: feedback.fromName,
                  toPhoto: CachedNetworkImageProvider(
                    feedback.toPhotoUrl,
                  ),
                  toEmployeeName: feedback.toName,
                  feedbackFormattedDate: DateTimeHelper.formatWithDefaultDatePattern(
                    dateTime: feedback.when,
                    locale: LocaleHelper.languageAndCountryCode(
                      locale: Localizations.localeOf(context),
                    ),
                  ),
                  proficiency: feedback.proficiency != null
                      ? ProficiencyTagWidget(
                          key: const Key('selected_feedback_screen-proficiency_tag_widget-proficiency_tag'),
                          label: feedback.proficiency!.name,
                          color: ColorExtension.fromHex(
                            hexString: feedback.proficiency!.color,
                          ),
                          icon: IconsHelper.parseProficiencyIconName(
                            proficiencyIconName: feedback.proficiency!.icon,
                          ),
                        )
                      : SeniorRating(
                          key: const Key('selected_feedback_screen-proficiency_tag_widget-senior_rating'),
                          itemCount: 5,
                          initialRating: feedback.starCount.toDouble(),
                          onRatingUpdate: (_) {},
                          ignoreGestures: true,
                        ),
                ),
              ),
              SeniorQuotes(
                key: const Key('selected_feedback_screen-senior_quotes-quotes'),
                message: feedback.message,
                isScrollable: true,
              ),
              feedback.skills != null
                  ? FeedbackListSkillsWidget(
                      skills: feedback.skills!,
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: context.bottomSize + SeniorSpacing.xsmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
