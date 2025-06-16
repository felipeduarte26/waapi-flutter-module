import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/components/senior_badge/components/senior_badge_base.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class BadgesSlider extends StatelessWidget {
  final bool multipleSelect;
  final List<BadgeInfo> badgesInfo;

  const BadgesSlider({
    super.key,
    required this.badgesInfo,
    required this.multipleSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return SizedBox(
      height: SeniorSpacing.xmedium,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: badgesInfo.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: SeniorSpacing.xsmall,
        ),
        itemBuilder: (context, index) {
          final badgeInfo = badgesInfo[index];

          return GestureDetector(
            onTap: () => badgeInfo.callback(!badgeInfo.isSelected),
            child: SeniorBadgeBase(
              backgroundColor:
                  isDark ? SeniorColors.grayscale100 : SeniorColors.pureWhite,
              fontColor: isDark
                  ? SeniorColors.pureWhite
                  : SeniorColors.neutralColor800,
              shape: SeniorBadgeShape.pill,
              selectedBackgroundColor: isDark
                  ? SeniorColors.primaryColor700
                  : SeniorColors.primaryColor100,
              selectedFontColor: isDark
                  ? SeniorColors.primaryColor100
                  : SeniorColors.primaryColor700,
              outlined: true,
              label: badgeInfo.label,
              value: badgeInfo.value,
              selected: badgeInfo.isSelected,
            ),
          );
        },
      ),
    );
  }
}

class BadgeInfo {
  final String label;
  final FilterBadgeType value;
  final Function(dynamic selectedValue) callback;
  final bool isSelected;

  BadgeInfo({
    required this.label,
    required this.value,
    required this.callback,
    required this.isSelected,
  });
}

enum FilterBadgeType {
  filterByEmployee,
  filterByPeriod,
}
