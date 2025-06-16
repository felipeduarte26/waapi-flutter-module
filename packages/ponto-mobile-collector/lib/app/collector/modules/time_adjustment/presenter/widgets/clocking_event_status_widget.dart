import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_icon_size.dart';
import 'package:senior_design_tokens/tokens/senior_radius.dart';

class ClockingEventStatusWidget extends StatelessWidget {
  final bool isSynchronized;
  final bool isOdd;
  final bool isRemoteness;
  final bool isOvernight;

  const ClockingEventStatusWidget({
    super.key,
    this.isOdd = false,
    this.isRemoteness = false,
    this.isSynchronized = false,
    this.isOvernight = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Row(
      children: [
        if (!isSynchronized)
          Container(
            margin: const EdgeInsets.all(1.0),
            height: SeniorIconSize.medium,
            width: SeniorIconSize.medium,
            decoration: BoxDecoration(
              color: isDark
                  ? SeniorColors.manchesterColorBlue800
                  : SeniorColors.manchesterColorBlue100,
              borderRadius: BorderRadius.circular(
                SeniorRadius.medium,
              ),
            ),
            child: Icon(
              FontAwesomeIcons.rotate,
              color: isDark
                  ? SeniorColors.manchesterColorBlue500
                  : SeniorColors.manchesterColorBlue600,
              size: SeniorIconSize.small,
            ),
          ),
        if (isOdd)
          Container(
            margin: const EdgeInsets.all(1.0),
            height: SeniorIconSize.medium,
            width: SeniorIconSize.medium,
            decoration: BoxDecoration(
              color: isDark
                  ? SeniorColors.manchesterColorRed800
                  : SeniorColors.manchesterColorRed100,
              borderRadius: BorderRadius.circular(
                SeniorRadius.medium,
              ),
            ),
            child: Icon(
              FontAwesomeIcons.solidCalendarXmark,
              color: isDark
                  ? SeniorColors.manchesterColorRed500
                  : SeniorColors.manchesterColorRed600,
              size: SeniorIconSize.small,
            ),
          ),
        if (isRemoteness)
          Container(
            margin: const EdgeInsets.all(1.0),
            height: SeniorIconSize.medium,
            width: SeniorIconSize.medium,
            decoration: BoxDecoration(
              color: SeniorColors.manchesterColorOrange100,
              borderRadius: BorderRadius.circular(
                SeniorRadius.medium,
              ),
            ),
            child: const Icon(
              FontAwesomeIcons.userInjured,
              color: SeniorColors.manchesterColorYellow600,
              size: SeniorIconSize.small,
            ),
          ),
        if (isOvernight)
          Container(
            margin: const EdgeInsets.all(1.0),
            height: SeniorIconSize.medium,
            width: SeniorIconSize.medium,
            decoration: BoxDecoration(
              color: isDark
                  ? SeniorColors.manchesterColorBlue800
                  : SeniorColors.manchesterColorBlue100,
              borderRadius: BorderRadius.circular(
                SeniorRadius.medium,
              ),
            ),
            child: Icon(
              FontAwesomeIcons.solidMoon,
              color: isDark
                  ? SeniorColors.manchesterColorBlue500
                  : SeniorColors.manchesterColorBlue600,
              size: SeniorIconSize.small,
            ),
          ),
      ],
    );
  }
}
