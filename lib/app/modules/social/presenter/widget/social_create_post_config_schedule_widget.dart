import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/locale_helper.dart';
import '../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../profile/helper/dropdown_item_list_enum.dart';

List<String> generateHourListFromCurrentTime() {
  DateTime now = DateTime.now();
  int currentHour = now.hour;
  int currentMinute = now.minute;

  if (currentMinute > 0 && currentMinute <= 30) {
    currentMinute = 30;
  } else if (currentMinute > 30) {
    currentMinute = 0;
    currentHour++;
  }

  List<String> hourList = [];
  for (int hour = currentHour; hour < 24; hour++) {
    for (int minute = (hour == currentHour) ? currentMinute : 0; minute < 60; minute += 30) {
      hourList.add('$hour:${minute.toString().padLeft(2, '0')}');
    }
  }

  return hourList;
}

class SocialCreatePostConfigScheduleWidget extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onHourChanged;
  final DateTime? dateSelected;
  final String? hourSelected;

  const SocialCreatePostConfigScheduleWidget({
    super.key,
    required this.onDateChanged,
    required this.onHourChanged,
    required this.dateSelected,
    required this.hourSelected,
  });

  @override
  State<SocialCreatePostConfigScheduleWidget> createState() => _SocialCreatePostConfigScheduleWidgetState();
}

class _SocialCreatePostConfigScheduleWidgetState extends State<SocialCreatePostConfigScheduleWidget> {
  late DateTime dateSelectedCalendar;
  final TextEditingController hourController = TextEditingController();

  late String weekDayName;
  bool firstState = true;
  late String dateStart;
  late String dateEnd;

  int employeerInVacationCount = 0;
  late SeniorCalendarStyle seniorCalendarStyle;
  bool isScheduled = false;
  @override
  void initState() {
    dateStart = DateTimeHelper.formatToIso8601Date(
      dateTime: DateTime(DateTime.now().year, DateTime.now().month, 1),
    );
    dateEnd = DateTimeHelper.formatToIso8601Date(
      dateTime: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
    );
    dateSelectedCalendar = widget.dateSelected ?? DateTime.now();

    hourController.addListener(() {
      setState(() {});
    });

    if (widget.hourSelected != null) {
      hourController.text = widget.hourSelected!;
      isScheduled = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    hourController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    bool isDarkColor = themeRepository.isDarkTheme();
    seniorCalendarStyle = SeniorCalendarStyle(
      backgroundColor: Colors.transparent,
      selectedDayBackgroundColor: isDarkColor
          ? SeniorColors.primaryColor500
          : themeRepository.isCustomTheme()
              ? themeRepository.theme.primaryColor?.withOpacity(0.3)
              : SeniorColors.primaryColor100,
      todayBackgroundColor: isDarkColor ? SeniorColors.grayscale60 : SeniorColors.neutralColor200,
    );

    weekDayName = DateTimeHelper.getNameWeek(
      appLocalizations: context.translate,
      weekDay: DateTime.now().weekday,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SeniorText.cta(
            context.translate.schedulePublication,
          ),
          const SizedBox(
            height: SeniorSpacing.normal,
          ),
          SeniorCalendar(
            selectedDay: dateSelectedCalendar,
            style: seniorCalendarStyle,
            firstDay: DateTime(DateTime.now().year - 2, 1, 1),
            lastDay: DateTime(DateTime.now().year + 2, 12, 31),
            showStrokeTop: false,
            inactiveYesterdays: true,
            highlightToday: true,
            locale: LocaleHelper.languageAndCountryCode(
              locale: Localizations.localeOf(context),
            ),
            onPageChanged: (date) {
              dateStart = DateTimeHelper.formatToIso8601Date(
                dateTime: DateTime(date.year, date.month, 1),
              );
              dateEnd = DateTimeHelper.formatToIso8601Date(
                dateTime: DateTime(date.year, date.month + 1, 0),
              );

              dateSelectedCalendar = date.copyWith(
                day: dateSelectedCalendar.day == 31
                    ? dateSelectedCalendar.month == 2
                        ? 28
                        : 30
                    : dateSelectedCalendar.day,
              );

              weekDayName = DateTimeHelper.getNameWeek(
                appLocalizations: context.translate,
                weekDay: dateSelectedCalendar.weekday,
              );
              DateTimeHelper.formatToIso8601Date(dateTime: date) ==
                      DateTimeHelper.formatToIso8601Date(dateTime: DateTime.now())
                  ? weekDayName = '$weekDayName (${context.translate.today})'
                  : weekDayName;
            },
            onDaySelected: (date) {
              setState(
                () {
                  dateSelectedCalendar = date;

                  weekDayName = DateTimeHelper.getNameWeek(
                    appLocalizations: context.translate,
                    weekDay: date.weekday,
                  );
                  DateTimeHelper.formatToIso8601Date(dateTime: date) ==
                          DateTimeHelper.formatToIso8601Date(dateTime: DateTime.now())
                      ? weekDayName = '$weekDayName (${context.translate.today})'
                      : weekDayName;

                  getSeniorCalendarStyle(
                    isColorSelected: true,
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: SeniorDropdownButton(
              value: isScheduled ? hourController.text : context.translate.time,
              items: DropdownItemListEnum<String>().dropdownItemList(
                values: generateHourListFromCurrentTime(),
                title: (hourSelect) => hourSelect,
              ),
              onSelected: (hourSelect) {
                setState(() {
                  hourController.text = hourSelect;
                  isScheduled = true;
                });
              },
              label: context.translate.time,
              showUnderline: true,
              style: SeniorDropdownButtonStyle(
                underlineColor: themeRepository.isCustomTheme()
                    ? SeniorServiceColor.getContrastAdjustedColorTheme(color: themeRepository.theme.primaryColor!)
                    : SeniorColors.primaryColor600,
                selectedItemTextColor: SeniorColors.pureBlack,
              ),
            ),
          ),
          Visibility(
            visible: isScheduled,
            child: SeniorButton.ghost(
              icon: FontAwesomeIcons.trashCan,
              fullWidth: true,
              label: context.translate.clearSelection,
              onPressed: () {
                _showDialogShortLink(context: context);
              },
              style: const SeniorButtonStyle(
                borderColor: SeniorColors.manchesterColorRed500,
                contentColor: SeniorColors.manchesterColorRed500,
              ),
            ),
          ),
          EmployeeBottomSheetWidget(
            horizontalPadding: false,
            seniorButtons: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  disabled: hourController.text.isEmpty,
                  fullWidth: true,
                  label: context.translate.confirm,
                  onPressed: () {
                    List<String> parts = hourController.text.split(':');
                    int hour = int.parse(parts[0]);
                    int minute = int.parse(parts[1]);
                    DateTime combinedDateTime = DateTime(
                      dateSelectedCalendar.year,
                      dateSelectedCalendar.month,
                      dateSelectedCalendar.day,
                      hour,
                      minute,
                    );
                    widget.onDateChanged(combinedDateTime);
                    widget.onHourChanged(hourController.text);
                    setState(() {});
                    Modular.to.pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: SeniorButton.ghost(
                  fullWidth: true,
                  label: context.translate.back,
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getSeniorCalendarStyle({required bool isColorSelected}) {
    seniorCalendarStyle = SeniorCalendarStyle(
      backgroundColor: Colors.transparent,
      selectedDayBackgroundColor: isColorSelected
          ? Provider.of<ThemeRepository>(context, listen: false).isDarkTheme()
              ? SeniorColors.primaryColor500
              : SeniorColors.primaryColor100
          : Colors.transparent,
      todayBackgroundColor: isToday()
          ? Provider.of<ThemeRepository>(context, listen: false).isDarkTheme()
              ? SeniorColors.grayscale60
              : SeniorColors.neutralColor200
          : null,
    );
  }

  bool isToday() {
    return dateSelectedCalendar.day == DateTime.now().day &&
        dateSelectedCalendar.month == DateTime.now().month &&
        dateSelectedCalendar.year == DateTime.now().year;
  }

  Future<void> _showDialogShortLink({
    required BuildContext context,
  }) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.clearSchedulingData,
          content: context.translate.confirmingInformationFilledAboutPublicationScheduleWillUndone,
          defaultAction: SeniorModalAction(
            label: context.translate.no,
            action: Modular.to.pop,
          ),
          otherAction: SeniorModalAction(
            label: context.translate.yes,
            action: () async {
              widget.onDateChanged(dateSelectedCalendar);
              widget.onHourChanged('');
              hourController.clear();
              dateSelectedCalendar = DateTime.now();
              setState(() {
                isScheduled = false;
              });
              Modular.to.pop();
              Modular.to.pop();
            },
            danger: true,
          ),
        );
      },
    );
  }
}
