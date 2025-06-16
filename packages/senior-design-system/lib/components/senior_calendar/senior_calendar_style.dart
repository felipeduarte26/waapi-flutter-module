import 'package:flutter/material.dart';

class SeniorCalendarStyle {
  /// Style definitions for the SeniorCalendar component.
  const SeniorCalendarStyle({
    this.activeHeaderButtonIconColor,
    this.backgroundColor,
    this.bottomTextColor,
    this.dayColor,
    this.headerButtonBorderColor,
    this.headerTextColor,
    this.inactiveHeaderButtonIconColor,
    this.nextMonthDaysBackgroundColor,
    this.nextMonthDaysColor,
    this.previousMonthDaysBackgroundColor,
    this.previousMonthDaysColor,
    this.selectedDayBackgroundColor,
    this.selectedDayColor,
    this.todayBackgroundColor,
    this.todayColor,
    this.topLineColor,
    this.topTextColor,
    this.weekDaysColor,
    this.colorCircleDefaultMarkedDay,
    this.colorSquareDefaultMarkedDay,
    this.colorTriangleDefaultMarkedDay,
    this.colorTriangleDownDefaultMarkedDay,
    this.colorGestureBottom,
    this.colorRangeHighlightBackground,
    this.colorDaysRangeHighlight,
    this.rangeBoundaryColor,
  });

  /// Defines the icon color of the calendar header buttons when enabled.
  final Color? activeHeaderButtonIconColor;

  /// Defines the background color of the calendar.
  final Color? backgroundColor;

  /// Defines the text color of footer.
  final Color? bottomTextColor;

  /// Defines the text color of the day.
  final Color? dayColor;

  /// Defines the border color of the calendar header buttons.
  final Color? headerButtonBorderColor;

  /// Defines the color of the calendar header text.
  final Color? headerTextColor;

  /// Defines the icon color of calendar header buttons when they are disabled.
  final Color? inactiveHeaderButtonIconColor;

  /// Defines the background color of the day of the next month that is appearing on the calendar.
  final Color? nextMonthDaysBackgroundColor;

  /// Defines the text color of the day of the next month that is appearing on the calendar.
  final Color? nextMonthDaysColor;

  /// Defines the background color of the day of the previous month that is appearing on the calendar.
  final Color? previousMonthDaysBackgroundColor;

  /// Defines the text color of the previous day of the month that is appearing on the calendar.
  final Color? previousMonthDaysColor;

  /// Defines the background color of the day selected in the calendar.
  final Color? selectedDayBackgroundColor;

  /// Defines the text color of the day selected in the calendar.
  final Color? selectedDayColor;

  /// Defines today's background color.
  final Color? todayBackgroundColor;

  /// Defines today's text color.
  final Color? todayColor;

  /// Defines the color of the line that appears at the top of the calendar.
  final Color? topLineColor;

  /// Defines the color of the text that appears at the top of the calendar.
  final Color? topTextColor;

  /// Defines the text color of the weekday labels.
  final Color? weekDaysColor;

  /// defines marked Circle color
  final Color? colorCircleDefaultMarkedDay;

  /// defines marked Square color
  final Color? colorSquareDefaultMarkedDay;

  /// defines marked Triangle color
  final Color? colorTriangleDefaultMarkedDay;

  /// defines marked TriangleDown color
  final Color? colorTriangleDownDefaultMarkedDay;

  /// Defines the color of the bottom button of the calendar
  final Color? colorGestureBottom;

  /// Range highlight color Background
  final Color? colorRangeHighlightBackground;

  @Deprecated('Use selectedDayBackgroundColor instead')
  /// Range highlight color Day
  final Color? colorDaysRangeHighlight;

  // Color range highlight
  final Color? rangeBoundaryColor;

  /// Creates a new instance of [SeniorCalendarStyle] with the option to override specific properties.
  SeniorCalendarStyle copyWith({
    Color? activeHeaderButtonIconColor,
    Color? backgroundColor,
    Color? bottomTextColor,
    Color? dayColor,
    Color? headerButtonBorderColor,
    Color? headerTextColor,
    Color? inactiveHeaderButtonIconColor,
    Color? nextMonthDaysBackgroundColor,
    Color? nextMonthDaysColor,
    Color? previousMonthDaysBackgroundColor,
    Color? previousMonthDaysColor,
    Color? selectedDayBackgroundColor,
    Color? selectedDayColor,
    Color? todayBackgroundColor,
    Color? todayColor,
    Color? topLineColor,
    Color? topTextColor,
    Color? weekDaysColor,
    Color? colorCircleDefaultMarkedDay,
    Color? colorSquareDefaultMarkedDay,
    Color? colorTriangleDefaultMarkedDay,
    Color? colorTriangleDownDefaultMarkedDay,
    Color? colorGestureBottom,
    Color? colorRangeHighlightBackground,
    Color? colorDaysRangeHighlight,
    Color? rangeBoundaryColor,
  }) {
    return SeniorCalendarStyle(
      activeHeaderButtonIconColor:
          activeHeaderButtonIconColor ?? this.activeHeaderButtonIconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      bottomTextColor: bottomTextColor ?? this.bottomTextColor,
      dayColor: dayColor ?? this.dayColor,
      headerButtonBorderColor:
          headerButtonBorderColor ?? this.headerButtonBorderColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      inactiveHeaderButtonIconColor:
          inactiveHeaderButtonIconColor ?? this.inactiveHeaderButtonIconColor,
      nextMonthDaysBackgroundColor:
          nextMonthDaysBackgroundColor ?? this.nextMonthDaysBackgroundColor,
      nextMonthDaysColor: nextMonthDaysColor ?? this.nextMonthDaysColor,
      previousMonthDaysBackgroundColor:
          previousMonthDaysBackgroundColor ?? this.previousMonthDaysBackgroundColor,
      previousMonthDaysColor:
          previousMonthDaysColor ?? this.previousMonthDaysColor,
      selectedDayBackgroundColor:
          selectedDayBackgroundColor ?? this.selectedDayBackgroundColor,
      selectedDayColor: selectedDayColor ?? this.selectedDayColor,
      todayBackgroundColor: todayBackgroundColor ?? this.todayBackgroundColor,
      todayColor: todayColor ?? this.todayColor,
      topLineColor: topLineColor ?? this.topLineColor,
      topTextColor: topTextColor ?? this.topTextColor,
      weekDaysColor: weekDaysColor ?? this.weekDaysColor,
      colorCircleDefaultMarkedDay:
          colorCircleDefaultMarkedDay ?? this.colorCircleDefaultMarkedDay,
      colorSquareDefaultMarkedDay:
          colorSquareDefaultMarkedDay ?? this.colorSquareDefaultMarkedDay,
      colorTriangleDefaultMarkedDay:
          colorTriangleDefaultMarkedDay ?? this.colorTriangleDefaultMarkedDay,
      colorTriangleDownDefaultMarkedDay: colorTriangleDownDefaultMarkedDay ??
          this.colorTriangleDownDefaultMarkedDay,
      colorGestureBottom: colorGestureBottom ?? this.colorGestureBottom,
      colorRangeHighlightBackground: colorRangeHighlightBackground ??
          this.colorRangeHighlightBackground,
      colorDaysRangeHighlight:
          colorDaysRangeHighlight ?? this.colorDaysRangeHighlight,
      rangeBoundaryColor: rangeBoundaryColor ?? this.rangeBoundaryColor,
    );
  }
}
