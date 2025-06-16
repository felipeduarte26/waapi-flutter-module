import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../repositories/theme_repository.dart';
import '../senior_calendar_style.dart';

class SeniorCalendarHeader extends StatelessWidget {
  /// Creates the calendar header, with title navigation buttons between the months and month identification.
  /// The parameters [headerTitle], [onLeftButtonPressed], [onRightButtonPressed] and [showHeader] are required.
  SeniorCalendarHeader({
    required this.headerTitle,
    this.leftButtonActive = true,
    this.onHeaderTitlePressed,
    required this.onLeftButtonPressed,
    required this.onRightButtonPressed,
    this.rightButtonActive = true,
    required this.showHeader,
    this.showHeaderButtons = true,
    this.style,
  }) : isTitleTouchable = onHeaderTitlePressed != null;

  final String headerTitle;
  final bool isTitleTouchable;
  final bool? leftButtonActive;
  final VoidCallback? onHeaderTitlePressed;
  final VoidCallback onLeftButtonPressed;
  final VoidCallback onRightButtonPressed;
  final bool? rightButtonActive;
  final bool showHeader;
  final bool showHeaderButtons;

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorCalendarStyle.activeHeaderButtonIconColor] the icon color of the calendar header buttons when enabled.
  /// [SeniorCalendarStyle.backgroundColor] the background color of the calendar.
  /// [SeniorCalendarStyle.dayColor] the text color of the day.
  /// [SeniorCalendarStyle.headerButtonBorderColor] the border color of the calendar header buttons.
  /// [SeniorCalendarStyle.headerTextColor] the color of the calendar header text.
  /// [SeniorCalendarStyle.inactiveHeaderButtonIconColor] the icon color of calendar header buttons when they are disabled.
  /// [SeniorCalendarStyle.nextMonthDaysBackgroundColor] the background color of the day of the next month that is appearing on the calendar.
  /// [SeniorCalendarStyle.nextMonthDaysColor] the text color of the day of the next month that is appearing on the calendar.
  /// [SeniorCalendarStyle.previousMonthDaysBackgroundColor] the background color of the day of the previous month that is appearing on the calendar.
  /// [SeniorCalendarStyle.previousMonthDaysColor] the text color of the previous day of the month that is appearing on the calendar.
  /// [SeniorCalendarStyle.selectedDayBackgroundColor] the background color of the day selected in the calendar.
  /// [SeniorCalendarStyle.selectedDayColor] the text color of the day selected in the calendar.
  /// [SeniorCalendarStyle.todayBackgroundColor] today's background color.
  /// [SeniorCalendarStyle.todayColor] today's text color.
  /// [SeniorCalendarStyle.topLineColor] the color of the line that appears at the top of the calendar.
  /// [SeniorCalendarStyle.topTextColor] the color of the text that appears at the top of the calendar.
  /// [SeniorCalendarStyle.weekDaysColor] the text color of the weekday labels.
  final SeniorCalendarStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final headerButtonBorderColor = style?.headerButtonBorderColor ??
        theme.calendarTheme?.style?.headerButtonBorderColor ??
        SeniorColors.grayscale40;

    final activeHeaderButtonIconColor = style?.activeHeaderButtonIconColor ??
        theme.calendarTheme?.style?.activeHeaderButtonIconColor ??
        SeniorColors.grayscale90;

    final inactiveHeaderButtonIconColor =
        style?.inactiveHeaderButtonIconColor ??
            theme.calendarTheme?.style?.inactiveHeaderButtonIconColor ??
            SeniorColors.grayscale40;

    final headerTitleStyle = SeniorTypography.label(
      color: style?.headerTextColor ??
          theme.calendarTheme?.style?.headerTextColor ??
          SeniorColors.grayscale90,
    );

    return showHeader
        ? Container(
            padding:
                const EdgeInsets.symmetric(horizontal: SeniorSpacing.small),
            margin: const EdgeInsets.symmetric(vertical: SeniorSpacing.normal),
            child: DefaultTextStyle(
              style: headerTitleStyle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  showHeaderButtons
                      ? _headerButton(
                          onTap: onLeftButtonPressed,
                          headButtonActive: leftButtonActive!,
                          icon: FontAwesomeIcons.angleLeft,
                          borderColor: headerButtonBorderColor,
                          activeButtonColor: activeHeaderButtonIconColor,
                          inactiveButtonColor: inactiveHeaderButtonIconColor,
                        )
                      : const SizedBox.shrink(),
                  isTitleTouchable
                      ? TextButton(
                          onPressed: onHeaderTitlePressed,
                          child: Text(
                            headerTitle,
                            semanticsLabel: headerTitle,
                            style: headerTitleStyle,
                          ),
                        )
                      : Text(
                          headerTitle,
                          style: headerTitleStyle,
                        ),
                  showHeaderButtons
                      ? _headerButton(
                          onTap: onRightButtonPressed,
                          headButtonActive: rightButtonActive!,
                          icon: FontAwesomeIcons.angleRight,
                          borderColor: headerButtonBorderColor,
                          activeButtonColor: activeHeaderButtonIconColor,
                          inactiveButtonColor: inactiveHeaderButtonIconColor,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _headerButton({
    required bool headButtonActive,
    required IconData icon,
    required Function() onTap,
    required Color borderColor,
    required Color activeButtonColor,
    required Color inactiveButtonColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24.0,
        width: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SeniorSpacing.xsmall),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: Icon(
          icon,
          color: headButtonActive ? activeButtonColor : inactiveButtonColor,
          size: SeniorSpacing.small,
        ),
      ),
    );
  }
}
