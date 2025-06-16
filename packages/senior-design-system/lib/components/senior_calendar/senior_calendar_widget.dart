import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../repositories/theme_repository.dart';
import '../../service/services.dart';
import '../components.dart';
import 'components/header_chevron_icon.dart';
import 'components/senior_stroke_top.dart';

enum SeniorCalendarFormat { month, week }

class SeniorCalendarBuilder extends CalendarBuilders {
  SeniorCalendarBuilder({
    FocusedDayBuilder? prioritizedBuilder,
    FocusedDayBuilder? todayBuilder,
    FocusedDayBuilder? selectedBuilder,
    FocusedDayBuilder? rangeStartBuilder,
    FocusedDayBuilder? rangeEndBuilder,
    FocusedDayBuilder? withinRangeBuilder,
    FocusedDayBuilder? outsideBuilder,
    FocusedDayBuilder? disabledBuilder,
    FocusedDayBuilder? holidayBuilder,
    FocusedDayBuilder? defaultBuilder,
    HighlightBuilder? rangeHighlightBuilder,
    SingleMarkerBuilder? singleMarkerBuilder,
    MarkerBuilder? markerBuilder,
    DayBuilder? dowBuilder,
    DayBuilder? headerTitleBuilder,
    Widget? Function(BuildContext context, int weekNumber)? weekNumberBuilder,
  }) : super(
          prioritizedBuilder: prioritizedBuilder,
          todayBuilder: todayBuilder,
          selectedBuilder: selectedBuilder,
          rangeStartBuilder: rangeStartBuilder,
          rangeEndBuilder: rangeEndBuilder,
          withinRangeBuilder: withinRangeBuilder,
          outsideBuilder: outsideBuilder,
          disabledBuilder: disabledBuilder,
          holidayBuilder: holidayBuilder,
          defaultBuilder: defaultBuilder,
          rangeHighlightBuilder: rangeHighlightBuilder,
          singleMarkerBuilder: singleMarkerBuilder,
          markerBuilder: markerBuilder,
          dowBuilder: dowBuilder,
          headerTitleBuilder: headerTitleBuilder,
          weekNumberBuilder: weekNumberBuilder,
        );
}

class SeniorCalendar extends StatefulWidget {
  const SeniorCalendar({
    Key? key,
    required this.firstDay,
    required this.lastDay,
    required this.selectedDay,
    this.calendarFormat = SeniorCalendarFormat.month,
    this.sixWeekMonthsEnforced = true,
    this.availableCalendarFormats = const {
      CalendarFormat.month: 'Month',
      CalendarFormat.week: 'Week',
    },
    this.onDaySelected,
    this.style,
    this.headButtonActive = true,
    this.headerText,
    this.titleDatePattern,
    this.locale = 'pt_BR',
    this.highlightToday = true,
    this.markedDateMap,
    this.onChangeFormat,
    this.rangeEndDay,
    this.rangeStartDay,
    this.onRangeSelected,
    this.inactiveYesterdays = false,
    this.bottomText,
    this.showStrokeTop = false,
    this.calendarTitle,
    this.margin,
    this.dateConnective,
    this.onPageChanged,
    this.calendarBuilders,
    this.hideSelectedDay = false,
  }) : super(key: key);

  /// The first date available on the calendar
  final DateTime firstDay;

  /// The last date available on the calendar
  final DateTime lastDay;

  /// The selected date on the calendar
  final DateTime selectedDay;

  /// The calendar's format
  final SeniorCalendarFormat calendarFormat;

  /// If true, the calendar will always have 6 weeks, even if the month is incomplete
  final bool sixWeekMonthsEnforced;

  /// The available calendar formats
  final Map<CalendarFormat, String> availableCalendarFormats;

  /// Callback function executed when a day is selected
  final void Function(DateTime focusedDay)? onDaySelected;

  /// Callback function executed when the calendar format is changed
  final void Function(SeniorCalendarFormat format)? onChangeFormat;

  /// The component's style definitions.
  final SeniorCalendarStyle? style;

  /// If true, the header buttons will be active
  final bool headButtonActive;

  /// change the text of the calendar's default header
  final String? headerText;

  /// Title data pattern
  final String? titleDatePattern;

  /// change the calendar's default locale
  final String locale;

  /// If true, the current day will be highlighted
  final bool highlightToday;

  /// List of events for the days to be able to make an appointment on the day
  final EventList<Event>? markedDateMap;

  /// First day selected in a range mode
  final DateTime? rangeStartDay;

  /// Last day selected in a range mode
  final DateTime? rangeEndDay;

  /// The date connective used in a range mode
  final String? dateConnective;

  /// Callback function executed when a range is selected
  final Function(DateTime? start, DateTime? end)? onRangeSelected;

  /// Disable the days before today
  final bool inactiveYesterdays;

  /// The calendar's bottom text
  final String? bottomText;

  /// If true, the calendar will show the stroke on the top
  final bool showStrokeTop;

  /// The calendar's title
  final String? calendarTitle;

  /// The calendar's margin
  final EdgeInsets? margin;

  /// Called whenever currently visible calendar page is changed.
  final void Function(DateTime focusedDay)? onPageChanged;

  final SeniorCalendarBuilder? calendarBuilders;

  // Hide selected day in the calendar;
  final bool? hideSelectedDay;

  @override
  State<SeniorCalendar> createState() => _SeniorCalendarState();

  void pickCalendar(BuildContext context) {
    SeniorBottomSheet.showDynamicBottomSheet(
      context: context,
      content: [
        SeniorCalendar(
          firstDay: firstDay,
          lastDay: lastDay,
          selectedDay: selectedDay,
          calendarFormat: calendarFormat,
          sixWeekMonthsEnforced: sixWeekMonthsEnforced,
          availableCalendarFormats: availableCalendarFormats,
          onDaySelected: onDaySelected,
          style: style,
          headButtonActive: headButtonActive,
          headerText: headerText,
          titleDatePattern: titleDatePattern,
          locale: locale,
          highlightToday: highlightToday,
          markedDateMap: markedDateMap,
          onChangeFormat: onChangeFormat,
          rangeEndDay: rangeEndDay,
          rangeStartDay: rangeStartDay,
          onRangeSelected: onRangeSelected,
          inactiveYesterdays: inactiveYesterdays,
          bottomText: bottomText,
          showStrokeTop: showStrokeTop,
          calendarTitle: calendarTitle,
          margin: margin,
          dateConnective: dateConnective,
        )
      ],
      hasCloseButton: false,
    );
  }
}

class _SeniorCalendarState extends State<SeniorCalendar> {
  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();

    if (widget.titleDatePattern == null) {
      dateFormat = DateFormat('MMMM yyyy', widget.locale);
    } else {
      dateFormat = DateFormat(widget.titleDatePattern, widget.locale);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final inactiveHeaderButtonIconColor =
        widget.style?.inactiveHeaderButtonIconColor ??
            theme.calendarTheme?.style?.inactiveHeaderButtonIconColor ??
            SeniorColors.grayscale40;

    final activeHeaderButtonIconColor =
        widget.style?.activeHeaderButtonIconColor ??
            theme.calendarTheme?.style?.activeHeaderButtonIconColor ??
            SeniorColors.grayscale90;

    final headerButtonBorderColor = widget.style?.headerButtonBorderColor ??
        theme.calendarTheme?.style?.headerButtonBorderColor ??
        SeniorColors.grayscale40;

    final headerTitleStyle = SeniorTypography.label(
      color: widget.style?.headerTextColor ??
          theme.calendarTheme?.style?.headerTextColor ??
          SeniorColors.grayscale90,
    );

    final daysColor = widget.style?.dayColor ??
        theme.calendarTheme?.style?.dayColor ??
        SeniorColors.grayscale80;

    final todayBackgroundColor = widget.style?.todayBackgroundColor ??
        theme.calendarTheme?.style?.todayBackgroundColor ??
        SeniorColors.grayscale20;

    final Color todayColor = widget.style?.todayColor ??
        theme.calendarTheme?.style?.todayColor ??
        SeniorColors.grayscale80;

    final Color selectedDayColor = widget.style?.selectedDayColor ??
        theme.calendarTheme?.style?.selectedDayColor ??
        SeniorColors.grayscale80;

    final selectedDayBackgroundColor =
        widget.style?.selectedDayBackgroundColor ??
            theme.calendarTheme?.style?.selectedDayBackgroundColor ??
            SeniorColors.primaryColor100;

    final disabledTextStyle = widget.style?.nextMonthDaysColor ??
        theme.calendarTheme?.style?.nextMonthDaysColor ??
        SeniorColors.grayscale50;

    final colorSquareDefaultMarkedDay =
        widget.style?.colorSquareDefaultMarkedDay ??
            theme.calendarTheme?.style?.colorSquareDefaultMarkedDay ??
            SeniorColors.primaryColor100;

    final colorTriangleDefaultMarkedDay =
        widget.style?.colorTriangleDefaultMarkedDay ??
            theme.calendarTheme?.style?.colorTriangleDefaultMarkedDay ??
            SeniorColors.primaryColor100;

    final colorTriangleDownDefaultMarkedDay =
        widget.style?.colorTriangleDownDefaultMarkedDay ??
            theme.calendarTheme?.style?.colorTriangleDownDefaultMarkedDay ??
            SeniorColors.primaryColor100;

    final colorCircleDefaultMarkedDay =
        widget.style?.colorCircleDefaultMarkedDay ??
            theme.calendarTheme?.style?.colorCircleDefaultMarkedDay ??
            SeniorColors.primaryColor100;

    final colorRangeHighlightBackground = widget.style?.colorRangeHighlightBackground ??
              theme.calendarTheme?.style?.colorRangeHighlightBackground ??
               SeniorColors.primaryColor100;

    final rangeBoundaryColor = widget.style?.rangeBoundaryColor
      ?? theme.calendarTheme?.style?.rangeBoundaryColor
      ?? colorRangeHighlightBackground;

    final rangeDayTextColor = SeniorServiceColor.contrastRatio(SeniorColors.pureWhite, colorRangeHighlightBackground) >= 4.5 ? SeniorColors.pureWhite : SeniorColors.pureBlack;

    final rangeDecoration = BoxDecoration(
      color: rangeBoundaryColor,
      shape: BoxShape.circle
    );

    final selectedDayColorByConstratRatio = SeniorServiceColor.contrastRatio(selectedDayColor, selectedDayBackgroundColor) >= 4.5 ? selectedDayColor : rangeDayTextColor;

    return Container(
      margin: widget.margin ?? const EdgeInsets.all(SeniorSpacing.normal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.showStrokeTop
              ? SeniorStrokeTop(
                  seniorCalendarStyle: widget.style,
                )
              : const SizedBox.shrink(),
          widget.calendarTitle != null
              ? Container(
                  width: double.infinity,
                  child: Text(
                    widget.calendarTitle!,
                    style: SeniorTypography.label(
                      color: widget.style?.topTextColor ??
                          theme.calendarTheme?.style?.topTextColor ??
                          SeniorColors.grayscale70,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              : const SizedBox.shrink(),
          TableCalendar(
            availableGestures: AvailableGestures.horizontalSwipe,
            enabledDayPredicate: (day) {
              return !widget.inactiveYesterdays ||
                  day.isAfter(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                    ),
                  ) ||
                  isSameDay(
                    day,
                    DateTime.now(),
                  );
            },
            rangeStartDay: widget.rangeStartDay,
            rangeEndDay: widget.rangeEndDay,
            rangeSelectionMode: widget.onRangeSelected == null
                ? RangeSelectionMode.disabled
                : RangeSelectionMode.toggledOn,
            onRangeSelected: (start, end, focusedDay) {
              widget.onRangeSelected!(start, end);
            },
            onPageChanged: widget.onPageChanged,
            calendarBuilders: widget.calendarBuilders ??
                CalendarBuilders(
                  dowBuilder: (context, day) {
                    return Center(
                      child: Text(
                        DateFormat.E(widget.locale).format(day).toUpperCase(),
                        style: SeniorTypography.small(color: daysColor),
                      ),
                    );
                  },
                  markerBuilder: (context, day, _) {
                    if (widget.markedDateMap == null) {
                      return const SizedBox.shrink();
                    }

                    final events = widget.markedDateMap!.getEvents(day);

                    bool hasForm(SeniorFormsEnum form) => events.any(
                          (element) {
                            if (element.formsDefault == null) {
                              return false;
                            }
                            return element.formsDefault!.contains(form);
                          },
                        );

                    return SeniorDefaultMarkedDay(
                      showCircle: hasForm(SeniorFormsEnum.CIRCLE),
                      showSquare: hasForm(SeniorFormsEnum.SQUARE),
                      showTriangle: hasForm(SeniorFormsEnum.TRIANGLE),
                      showTriangleDown: hasForm(SeniorFormsEnum.TRIANGLE_DOWN),
                      colorSquareDefaultMarkedDay: colorSquareDefaultMarkedDay,
                      colorTriangleDefaultMarkedDay:
                          colorTriangleDefaultMarkedDay,
                      colorTriangleDownDefaultMarkedDay:
                          colorTriangleDownDefaultMarkedDay,
                      colorCircleDefaultMarkedDay: colorCircleDefaultMarkedDay,
                    );
                  },
                ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                widget.onDaySelected?.call(selectedDay);
              });
            },
            calendarStyle: CalendarStyle(
              isTodayHighlighted: widget.highlightToday,
              todayDecoration: BoxDecoration(
                color: todayBackgroundColor,
                shape: BoxShape.circle,
              ),
              todayTextStyle: SeniorTypography.label(color: todayColor),
              defaultTextStyle: SeniorTypography.label(color: daysColor),
              selectedDecoration: widget.hideSelectedDay! ? const BoxDecoration() : BoxDecoration(
                color: selectedDayBackgroundColor,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: SeniorTypography.label(color: selectedDayColorByConstratRatio),
              disabledTextStyle:
                  SeniorTypography.label(color: disabledTextStyle),
              outsideTextStyle:
                  SeniorTypography.label(color: disabledTextStyle),
              weekendTextStyle:
                  SeniorTypography.label(color: disabledTextStyle),
              holidayTextStyle:
                  SeniorTypography.label(color: disabledTextStyle),
              holidayDecoration: const BoxDecoration(),
              rangeHighlightColor: colorRangeHighlightBackground,
              withinRangeTextStyle: TextStyle(
                color: rangeDayTextColor
              ),
              rangeStartDecoration: rangeDecoration,
              rangeEndDecoration: rangeDecoration,
              rangeStartTextStyle: SeniorTypography.label(color: rangeDayTextColor),
              rangeEndTextStyle: SeniorTypography.label(color: rangeDayTextColor),
            ),
            focusedDay: widget.selectedDay,
            selectedDayPredicate: (day) => isSameDay(day, widget.selectedDay),
            firstDay: widget.firstDay,
            lastDay: widget.lastDay,
            sixWeekMonthsEnforced: true,
            locale: widget.locale,
            calendarFormat: widget.calendarFormat == SeniorCalendarFormat.month
                ? CalendarFormat.month
                : CalendarFormat.week,
            daysOfWeekHeight: SeniorSpacing.xmedium,
            headerStyle: HeaderStyle(
              leftChevronMargin: EdgeInsets.zero,
              rightChevronMargin: EdgeInsets.zero,
              titleTextStyle: headerTitleStyle,
              rightChevronIcon: HeaderChevronIcon(
                headButtonActive: widget.headButtonActive,
                icon: FontAwesomeIcons.angleRight,
                borderColor: headerButtonBorderColor,
                activeButtonColor: activeHeaderButtonIconColor,
                inactiveButtonColor: inactiveHeaderButtonIconColor,
              ),
              leftChevronIcon: HeaderChevronIcon(
                headButtonActive: widget.headButtonActive,
                icon: FontAwesomeIcons.angleLeft,
                borderColor: headerButtonBorderColor,
                activeButtonColor: activeHeaderButtonIconColor,
                inactiveButtonColor: inactiveHeaderButtonIconColor,
              ),
              titleCentered: true,
              formatButtonVisible: false,
              titleTextFormatter: (date, locale) {
                return buildHeaderText(date);
              },
            ),
          ),
          SeniorCalendarFooter(
            text: widget.bottomText,
            style: widget.style,
          ),
          widget.onChangeFormat != null
              ? SeniorBottomGesture(
                  downDirection:
                      widget.calendarFormat == SeniorCalendarFormat.week,
                  color: widget.style?.colorGestureBottom ??
                      theme.calendarTheme?.style?.colorGestureBottom ??
                      SeniorColors.grayscale20,
                  onTap: () => {
                    widget.onChangeFormat?.call(
                      widget.calendarFormat == SeniorCalendarFormat.month
                          ? SeniorCalendarFormat.week
                          : SeniorCalendarFormat.month,
                    ),
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  String buildHeaderText(DateTime selectedDate) {
    if (widget.headerText != null) {
      return widget.headerText!;
    } else {
      final selectedDateText = dateFormat.format(selectedDate);

      final weekendDateFormat = DateFormat.yMd(widget.locale);

      if (widget.calendarFormat == SeniorCalendarFormat.week) {
        return '${weekendDateFormat.format(findFirstDateOfTheWeek(selectedDate))} ${widget.dateConnective ?? '-'} ${weekendDateFormat.format(findLastDateOfTheWeek(selectedDate))}';
      }

      return '${selectedDateText[0].toUpperCase()}${selectedDateText.substring(1).toLowerCase()}';
    }
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(
      Duration(
        days: dateTime.weekday,
      ),
    );
  }

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime.add(
      Duration(
        days: DateTime.daysPerWeek - dateTime.weekday - 1,
      ),
    );
  }
}
