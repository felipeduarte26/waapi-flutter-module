import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/components/senior_calendar/senior_calendar.dart';
import 'package:senior_design_system/components/senior_snackbar/senior_snackbar_widget.dart';
import 'package:senior_design_system/components/senior_text/senior_text.dart';
import 'package:senior_design_system/repositories/theme_repository.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../domain/entities/happiness_index_mood_entity.dart';
import '../../../enums/happiness_index_mood_enum.dart';
import 'happiness_index_calendar_day_widget.dart';

class HappinessIndexCalendarWidget extends StatefulWidget {
  final Function(DateTime)? onSelectedDay;
  final Function(HappinessIndexMoodEnum?)? onSelectedDayWithMood;
  final List<HappinessIndexMoodEntity> moods;
  final DateTime selectedDay;

  const HappinessIndexCalendarWidget({
    super.key,
    this.onSelectedDay,
    this.onSelectedDayWithMood,
    required this.moods,
    required this.selectedDay,
  });

  @override
  State<HappinessIndexCalendarWidget> createState() => _HappinessIndexCalendarWidgetState();
}

class _HappinessIndexCalendarWidgetState extends State<HappinessIndexCalendarWidget> {
  late DateTime dateSelectedCalendar;

  @override
  void initState() {
    super.initState();
    dateSelectedCalendar = widget.selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    final seniorCalendarStyle = SeniorCalendarStyle(
      backgroundColor: Colors.transparent,
      selectedDayBackgroundColor: Provider.of<ThemeRepository>(context).isDarkTheme()
          ? SeniorColors.primaryColor500
          : SeniorColors.primaryColor100,
      todayBackgroundColor:
          Provider.of<ThemeRepository>(context).isDarkTheme() ? SeniorColors.grayscale60 : SeniorColors.neutralColor200,
    );

    return SeniorCalendar(
      calendarBuilders: SeniorCalendarBuilder(
        dowBuilder: (context, day) {
          return Center(
            child: SeniorText.small(
              DateFormat.E(
                LocaleHelper.languageAndCountryCode(
                  locale: Localizations.localeOf(context),
                ),
              ).format(day).toUpperCase(),
              color: Colors.grey,
            ),
          );
        },
        outsideBuilder: (context, date, focusedDay) {
          return const SizedBox.shrink();
        },
        selectedBuilder: (context, date, focusedDay) {
          final feeling = widget.moods.firstWhereOrNull((record) {
            return DateUtils.isSameDay(record.date, date);
          });

          return HappinessIndexCalendarDayWidget(
            date: date,
            feeling: feeling?.happinessIndexMood,
            isSelected: true,
          );
        },
        defaultBuilder: (context, date, focusedDay) {
          final feeling = widget.moods.firstWhereOrNull((record) {
            return DateUtils.isSameDay(record.date, date);
          });

          if (dateSelectedCalendar.month != date.month) {
            return const SizedBox.shrink();
          }

          return HappinessIndexCalendarDayWidget(
            date: date,
            feeling: feeling?.happinessIndexMood,
            isSelected: false,
          );
        },
        todayBuilder: (context, date, focusedDay) {
          if (dateSelectedCalendar.month != date.month) {
            return const SizedBox.shrink();
          }

          final feeling = widget.moods.firstWhereOrNull((record) {
            return DateUtils.isSameDay(record.date, date);
          });

          return HappinessIndexCalendarDayWidget(
            date: date,
            feeling: feeling?.happinessIndexMood,
            isSelected: false,
          );
        },
      ),
      selectedDay: dateSelectedCalendar,
      style: seniorCalendarStyle,
      firstDay: DateTime(DateTime.now().year - 2, 1, 1),
      lastDay: DateTime(DateTime.now().year + 2, 12, 31),
      showStrokeTop: false,
      inactiveYesterdays: false,
      locale: LocaleHelper.languageAndCountryCode(
        locale: Localizations.localeOf(context),
      ),
      onPageChanged: (date) {
        setState(() {
          dateSelectedCalendar = date.copyWith(
            day: dateSelectedCalendar.day == 31
                ? dateSelectedCalendar.month == 2
                    ? 28
                    : 30
                : dateSelectedCalendar.day,
          );
          if (DateUtils.isSameDay(dateSelectedCalendar, DateTime.now())) {
            dateSelectedCalendar = DateUtils.dateOnly(DateTime.now());
          }

          final feeling = widget.moods.firstWhereOrNull((record) {
            return DateUtils.isSameDay(record.date, date);
          });

          if (widget.onSelectedDay != null) widget.onSelectedDay!(dateSelectedCalendar);
          if (widget.onSelectedDayWithMood != null) widget.onSelectedDayWithMood!(feeling?.happinessIndexMood);
        });
      },
      onDaySelected: (date) {
        setState(
          () {
            final feeling = widget.moods.firstWhereOrNull((record) {
              return DateUtils.isSameDay(record.date, date);
            });
            if (date.isBefore(DateTime.now()) && date.month == dateSelectedCalendar.month) {
              dateSelectedCalendar = date;
              if (widget.onSelectedDay != null) widget.onSelectedDay!(date);
              if (widget.onSelectedDayWithMood != null) widget.onSelectedDayWithMood!(feeling?.happinessIndexMood);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SeniorSnackBar.warning(
                  message: context.translate.unableViewFutureMarkings,
                ),
              );
            }
          },
        );
      },
    );
  }
}
