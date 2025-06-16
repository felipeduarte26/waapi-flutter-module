import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../enums/happiness_index_mood_enum.dart';

const spacesCount = 6;
const spacesWidth = 16;
const feelingsCount = 5;

class HappinessIndexMoodWidget extends StatelessWidget {
  static const double _borderRadius = 9999;

  final HappinessIndexMoodEnum mood;
  final bool isSelected;
  final bool isDefined;
  final Function(HappinessIndexMoodEnum selectedMood)? onSelectedMood;
  final bool disabled;
  final double? size;
  final double? iconSize;
  final bool opacityInIcon;
  final bool showBadgeOnMood;

  const HappinessIndexMoodWidget({
    Key? key,
    required this.mood,
    required this.isSelected,
    required this.isDefined,
    this.onSelectedMood,
    required this.disabled,
    this.size,
    this.iconSize,
    this.opacityInIcon = false,
    this.showBadgeOnMood = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: _getMoodBackgroundColor(
            disabled: disabled,
            isDefined: isDefined,
            isSelected: isSelected,
            mood: mood,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(_borderRadius),
            onTap: onSelectedMood != null
                ? () {
                    onSelectedMood!(mood);
                  }
                : null,
            child: AnimatedContainer(
              duration: kThemeAnimationDuration,
              curve: Curves.easeInOutCubicEmphasized,
              width: size ?? (context.widthSize - (spacesCount * spacesWidth)) / feelingsCount,
              height: size ?? (context.widthSize - (spacesCount * spacesWidth)) / feelingsCount,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_borderRadius),
                border: (!isDefined || !isSelected)
                    ? null
                    : Border.all(
                        color: getSelectedBoxColorOfTheMood(
                          mood: mood,
                        ),
                        width: SeniorRadius.xsmall,
                      ),
              ),
              child: _MoodIcon(
                mood: mood,
                isDefined: isDefined,
                isSelected: isSelected,
                isDisabled: disabled,
                iconSize: iconSize,
                opacityInIcon: opacityInIcon,
              ),
            ),
          ),
        ),
        if (showBadgeOnMood && isSelected)
          const SizedBox(
            height: SeniorSpacing.xsmall,
          ),
        if (showBadgeOnMood && isSelected)
          SizedOverflowBox(
            size: const Size(SeniorSpacing.xbig, SeniorSpacing.medium),
            child: SeniorBadge(
              backgroundColor: _getMoodBackgroundColor(
                mood: mood,
                isDefined: isDefined,
                isSelected: isSelected,
                disabled: disabled,
              ),
              fontColor: SeniorColors.grayscale100,
              label: _getMoodName(
                localization: context.translate,
                mood: mood,
              ),
            ),
          ),
      ],
    );
  }
}

class _MoodIcon extends StatelessWidget {
  final HappinessIndexMoodEnum mood;
  final bool isDefined;
  final bool isSelected;
  final bool isDisabled;
  final double? iconSize;
  final bool opacityInIcon;

  const _MoodIcon({
    Key? key,
    required this.mood,
    required this.isDefined,
    required this.isSelected,
    required this.isDisabled,
    this.iconSize,
    this.opacityInIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = SeniorColors.pureBlack.withOpacity((!isDefined || isSelected) ? 1.0 : 0.25);
    final disabledIconColor = SeniorColors.pureBlack.withOpacity(0.25);

    switch (mood) {
      case HappinessIndexMoodEnum.great:
        return SeniorIcon(
          icon: FontAwesomeIcons.faceSmileBeam,
          style: SeniorIconStyle(
            color: opacityInIcon
                ? SeniorColors.grayscale70
                : isDisabled
                    ? disabledIconColor
                    : iconColor,
          ),
          size: iconSize ?? SeniorSpacing.xbig,
        );
      case HappinessIndexMoodEnum.fine:
        return SeniorIcon(
          icon: FontAwesomeIcons.faceSmile,
          style: SeniorIconStyle(
            color: opacityInIcon
                ? SeniorColors.grayscale70
                : isDisabled
                    ? disabledIconColor
                    : iconColor,
          ),
          size: iconSize ?? SeniorSpacing.xbig,
        );
      case HappinessIndexMoodEnum.upset:
        return SeniorIcon(
          icon: FontAwesomeIcons.faceFrown,
          style: SeniorIconStyle(
            color: opacityInIcon
                ? SeniorColors.grayscale70
                : isDisabled
                    ? disabledIconColor
                    : iconColor,
          ),
          size: iconSize ?? SeniorSpacing.xbig,
        );
      case HappinessIndexMoodEnum.angry:
        return SeniorIcon(
          icon: FontAwesomeIcons.faceDisappointed,
          style: SeniorIconStyle(
            color: opacityInIcon
                ? SeniorColors.grayscale70
                : isDisabled
                    ? disabledIconColor
                    : iconColor,
          ),
          size: iconSize ?? SeniorSpacing.xbig,
        );
      case HappinessIndexMoodEnum.neutral:
        return SeniorIcon(
          icon: FontAwesomeIcons.faceMeh,
          style: SeniorIconStyle(
            color: opacityInIcon
                ? SeniorColors.grayscale70
                : isDisabled
                    ? disabledIconColor
                    : iconColor,
          ),
          size: iconSize ?? SeniorSpacing.xbig,
        );
    }
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

Color _getMoodBackgroundColor({
  required HappinessIndexMoodEnum mood,
  required bool isDefined,
  required bool isSelected,
  required bool disabled,
}) {
  if ((!isDefined || isSelected) && !disabled) {
    return getSelectedColorOfTheMood(
      mood: mood,
    );
  }

  return getSelectedColorOfTheMood(
    mood: mood,
  ).withOpacity(0.25);
}

Color getSelectedColorOfTheMood({
  required HappinessIndexMoodEnum mood,
}) {
  switch (mood) {
    case HappinessIndexMoodEnum.great:
      return SeniorColors.manchesterColorGreen200;
    case HappinessIndexMoodEnum.fine:
      return SeniorColors.manchesterColorBlue200;
    case HappinessIndexMoodEnum.upset:
      return SeniorColors.manchesterColorOrange200;
    case HappinessIndexMoodEnum.angry:
      return SeniorColors.manchesterColorRed200;
    case HappinessIndexMoodEnum.neutral:
      return SeniorColors.grayscale30;
  }
}

Color getSelectedBoxColorOfTheMood({
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
