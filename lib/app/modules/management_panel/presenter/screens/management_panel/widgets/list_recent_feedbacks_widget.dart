import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/color_extension.dart';
import '../../../../../../core/extension/media_query_extension.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/icons_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/helper/snackbar_helper.dart';
import '../../../../../../core/widgets/feedback_card_widget.dart';
import '../../../../../../core/widgets/proficiency_tag_widget.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../feedback/domain/entities/feedback_entity.dart';

class ListRecentFeedbacksWidget extends StatelessWidget {
  final bool disabled;
  final List<FeedbackEntity> latestFeedbacks;

  const ListRecentFeedbacksWidget({
    Key? key,
    required this.latestFeedbacks,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 102,
      child: ListView.separated(
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
          right: SeniorSpacing.normal,
          top: SeniorSpacing.xxxsmall,
          bottom: SeniorSpacing.xxxsmall,
        ),
        key: const Key('management-Panel_screen-latest_feedbacks-list_view'),
        scrollDirection: Axis.horizontal,
        itemCount: latestFeedbacks.length,
        itemBuilder: (_, index) {
          return FeedbackCardWidget(
            key: Key('management-Panel_screen-latest_feedbacks-list_view-rating_stars-$index'),
            width: context.widthSize * 0.8,
            imageUrl: latestFeedbacks[index].fromPhotoUrl,
            userName: latestFeedbacks[index].fromName,
            disabled: disabled,
            feedbackDate: DateTimeHelper.formatWithDefaultDatePattern(
              dateTime: latestFeedbacks[index].when,
              locale: LocaleHelper.languageAndCountryCode(
                locale: Localizations.localeOf(context),
              ),
            ),
            feedbackMessage: latestFeedbacks[index].message,
            seniorRating: latestFeedbacks[index].proficiency != null
                ? null
                : SeniorRating(
                    itemCount: 5,
                    initialRating: latestFeedbacks[index].starCount.toDouble(),
                    ignoreGestures: true,
                    onRatingUpdate: (_) {},
                  ),
            proficiencyTagWidget: latestFeedbacks[index].proficiency == null
                ? null
                : ProficiencyTagWidget(
                    color: ColorExtension.fromHex(
                      hexString: latestFeedbacks[index].proficiency!.color,
                    ),
                    label: latestFeedbacks[index].proficiency!.name,
                    icon: IconsHelper.parseProficiencyIconName(
                      proficiencyIconName: latestFeedbacks[index].proficiency!.icon,
                    ),
                  ),
            onTap: () {
              if (disabled) {
                SnackbarHelper.showSnackbar(
                  context: context,
                  message: context.translate.featureIsNotAvailableOffline,
                );
              } else {
                Modular.to.pushNamed(
                  FeedbackRoutes.toFeedbacksDetailsReceivedScreenRoute,
                  arguments: {
                    'receivedFeedbackId': latestFeedbacks[index].id,
                  },
                );
              }
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          width: SeniorSpacing.normal,
        ),
      ),
    );
  }
}
