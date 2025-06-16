import './senior_calendar_style.dart';

class SeniorCalendarThemeData {
  /// Theme definitions for the SeniorCheckbox component.
  const SeniorCalendarThemeData({
    this.style,
  });

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
  /// [SeniorCalendarStyle.colorCircleDefaultMarkedDay] the color of the circle that appears on the day of the calendar when it is marked.
  /// [SeniorCalendarStyle.colorTriangleDownDefaultMarkedDay] the color of the triangleDown that appears on the day of the calendar when it is marked.
  /// [SeniorCalendarStyle.colorTriangleDefaultMarkedDay] the color of the triangle that appears on the day of the calendar when it is marked.
  /// [SeniorCalendarStyle.colorSquareDefaultMarkedDay] the color of the Square that appears on the day of the calendar when it is marked.
  final SeniorCalendarStyle? style;

  /// Creates a new instance of [SeniorCalendarThemeData] with the option to override specific properties.
  SeniorCalendarThemeData copyWith({
    SeniorCalendarStyle? style,
  }) {
    return SeniorCalendarThemeData(
      style: style ?? this.style,
    );
  }
}