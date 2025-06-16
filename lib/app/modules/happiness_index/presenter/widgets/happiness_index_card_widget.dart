import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/locale_helper.dart';
import '../../domain/entities/happiness_index_mood_entity.dart';
import '../../enums/happiness_index_mood_enum.dart';
import 'happiness_index_mood_widget.dart';

class HappinessIndexCardWidget extends StatefulWidget {
  final bool disabled;
  final HappinessIndexMoodEntity happinessIndexMoodEntity;
  final VoidCallback onTap;

  const HappinessIndexCardWidget({
    super.key,
    required this.disabled,
    required this.happinessIndexMoodEntity,
    required this.onTap,
  });

  @override
  State<HappinessIndexCardWidget> createState() => _HappinessIndexCardWidgetState();
}

class _HappinessIndexCardWidgetState extends State<HappinessIndexCardWidget> {
  @override
  Widget build(BuildContext context) {
    final moodEntity = widget.happinessIndexMoodEntity;

    int totalReasons = 0;
    if (moodEntity.happinessIndexGroups != null && moodEntity.happinessIndexGroups!.isNotEmpty) {
      for (var group in moodEntity.happinessIndexGroups!) {
        for (var subgroup in group.subgroups!) {
          totalReasons += subgroup.reasons!.length;
        }
      }
    }

    final notes = moodEntity.note;

    final labelReasons = totalReasons > 1 ? context.translate.reasonsRecorded : context.translate.reasonRecorded;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: SeniorCard(
        onTap: () {
          widget.onTap.call();
        },
        rightIcon: FontAwesomeIcons.chevronRight,
        margin: EdgeInsets.zero,
        highLightBorder: CardHighLightBorder(
          color: _getSelectedBoxColorOfTheMood(
            mood: widget.happinessIndexMoodEntity.happinessIndexMood,
          ),
          position: CardBorderPosition.left,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HappinessIndexMoodWidget(
              mood: widget.happinessIndexMoodEntity.happinessIndexMood,
              isSelected: true,
              isDefined: true,
              size: SeniorSpacing.xbig,
              iconSize: SeniorIconSize.medium,
              disabled: widget.disabled,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.small,
              ),
              width: 1,
              height: SeniorSpacing.huge +
                  (totalReasons > 0 ? SeniorSpacing.medium : 0) +
                  (notes != null && notes.isNotEmpty ? SeniorSpacing.medium : 0),
              color: SeniorColors.grayscale30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.happinessIndexMoodEntity.date.hour != 0 ||
                      widget.happinessIndexMoodEntity.date.minute != 0 ||
                      widget.happinessIndexMoodEntity.date.second != 0)
                    SeniorText.small(
                      DateFormat(
                        'HH:mm',
                        LocaleHelper.languageAndCountryCode(
                          locale: Localizations.localeOf(context),
                        ),
                      ).format(widget.happinessIndexMoodEntity.date),
                      color: SeniorColors.grayscale90,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: SeniorSpacing.xxsmall,
                    ),
                    child: SeniorText.cta(
                      _getMoodName(
                        localization: context.translate,
                        mood: widget.happinessIndexMoodEntity.happinessIndexMood,
                      ),
                      color: SeniorColors.grayscale90,
                    ),
                  ),
                  if (totalReasons > 0)
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: SeniorSpacing.xxsmall,
                      ),
                      child: SeniorBadge(
                        backgroundColor: _getSelectedBoxColorOfTheMood(
                          mood: widget.happinessIndexMoodEntity.happinessIndexMood,
                        ),
                        fontColor: SeniorColors.grayscale90,
                        label: '$totalReasons $labelReasons',
                      ),
                    ),
                  if (notes != null && notes.isNotEmpty)
                    SeniorText.small(
                      notes,
                      textProperties: const TextProperties(
                        overflow: TextOverflow.ellipsis,
                      ),
                      emphasis: true,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _getMoodName({
  required AppLocalizations localization,
  required HappinessIndexMoodEnum mood,
}) {
  switch (mood) {
    case HappinessIndexMoodEnum.great:
      return localization.happinessIndexIncredible;
    case HappinessIndexMoodEnum.fine:
      return localization.happinessIndexFine;
    case HappinessIndexMoodEnum.upset:
      return localization.happinessIndexUpset;
    case HappinessIndexMoodEnum.angry:
      return localization.happinessIndexAngry;
    case HappinessIndexMoodEnum.neutral:
      return localization.happinessIndexNeutral;
  }
}

Color _getSelectedBoxColorOfTheMood({
  required HappinessIndexMoodEnum mood,
}) {
  switch (mood) {
    case HappinessIndexMoodEnum.great:
      return SeniorColors.manchesterColorGreen400;
    case HappinessIndexMoodEnum.fine:
      return SeniorColors.manchesterColorBlue400;
    case HappinessIndexMoodEnum.upset:
      return SeniorColors.manchesterColorOrange400;
    case HappinessIndexMoodEnum.angry:
      return SeniorColors.manchesterColorRed400;
    case HappinessIndexMoodEnum.neutral:
      return SeniorColors.grayscale40;
  }
}
