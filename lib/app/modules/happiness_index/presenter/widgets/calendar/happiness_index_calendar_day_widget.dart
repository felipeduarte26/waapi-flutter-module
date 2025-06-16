import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/components/senior_text/senior_text.dart';
import 'package:senior_design_system/repositories/theme_repository.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_icon_size.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../enums/happiness_index_mood_enum.dart';
import '../happiness_index_mood_widget.dart';

class HappinessIndexCalendarDayWidget extends StatelessWidget {
  const HappinessIndexCalendarDayWidget({
    super.key,
    required this.date,
    required this.feeling,
    required this.isSelected,
  });

  final DateTime date;
  final HappinessIndexMoodEnum? feeling;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Builder(
          builder: (_) {
            if (date.isAfter(DateTime.now())) {
              return Container(
                height: SeniorSpacing.big,
                width: SeniorSpacing.big,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Provider.of<ThemeRepository>(context).isDarkTheme()
                      ? SeniorColors.grayscale80.withOpacity(0.35)
                      : SeniorColors.grayscale20.withOpacity(0.35),
                ),
              );
            } else if (feeling == null) {
              return Container(
                height: SeniorSpacing.big,
                width: SeniorSpacing.big,
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(
                          color: SeniorColors.grayscale50,
                          width: 2,
                        )
                      : null,
                  shape: BoxShape.circle,
                  color: Provider.of<ThemeRepository>(context).isDarkTheme()
                      ? SeniorColors.grayscale80
                      : SeniorColors.grayscale20,
                ),
              );
            } else {
              return HappinessIndexMoodWidget(
                mood: feeling!,
                isSelected: isSelected,
                isDefined: isSelected,
                size: SeniorSpacing.big,
                iconSize: SeniorIconSize.medium,
                disabled: false,
                opacityInIcon: !isSelected,
                showBadgeOnMood: false,
              );
            }
          },
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 1,
          ),
          width: SeniorSpacing.xmedium,
          decoration: BoxDecoration(
            color: _getBoxColor(),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: SeniorText.small(
              date.day.toString(),
              color: isSelected ? SeniorColors.pureWhite : SeniorColors.grayscale100,
            ),
          ),
        ),
      ],
    );
  }

  Color _getBoxColor() {
    if (isSelected) {
      if (feeling == null) {
        return SeniorColors.grayscale60;
      }
      return getSelectedBoxColorOfTheMood(mood: feeling!);
    } else {
      return Colors.transparent;
    }
  }
}
