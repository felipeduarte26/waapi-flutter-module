import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/helper/date_time_helper.dart';
import '../../../../../core/helper/locale_helper.dart';
import '../../../domain/entities/vacation_employee_calendar_view_entity.dart';
import '../../../domain/input_models/vacation_calendar_staff_view_filter_input_model.dart';
import '../../../enums/enum_status_vacation_staff_calendar.dart';
import '../../blocs/vacation_calendar_bloc/vacation_calendar_staff_view_bloc.dart';
import '../../blocs/vacation_calendar_bloc/vacation_calendar_staff_view_event.dart';
import '../../blocs/vacation_calendar_bloc/vacation_calendar_staff_view_state.dart';
import '../vacations_screen/widgets/vacation_status_widget.dart';

class VacationCalendarStaffViewScreen extends StatefulWidget {
  final String employeeId;

  const VacationCalendarStaffViewScreen({
    super.key,
    required this.employeeId,
  });

  @override
  State<VacationCalendarStaffViewScreen> createState() => _VacationCalendarStaffViewScreenState();
}

class _VacationCalendarStaffViewScreenState extends State<VacationCalendarStaffViewScreen> {
  late VacationCalendarStaffViewBloc _vacationCalendarBloc;
  late DateTime dateSelectedCalendar;
  late String lastDateSelectedCalendar;

  late String weekDayName;
  bool firstState = true;
  late String dateStart;
  late String dateEnd;
  EventList<Event> markedDateMap = EventList<Event>(events: {});
  bool showPendingManager = false;
  bool showPendingRH = false;
  bool showScheduled = false;
  bool showCalculated = false;
  Map<String, String>? vacationDetailsPendingWithTheManager = {};
  Map<String, String>? vacationDetailsPendingRH = {};
  Map<String, String>? vacationDetailsScheduled = {};
  Map<String, String>? vacationDetailsCalculated = {};
  List<VacationEmployeeCalendarViewEntity> listVacationCalendarStaffViewEntity = [];
  int employeerCount = 0;
  int employeerInVacationCount = 0;

  @override
  void initState() {
    dateStart = DateTimeHelper.formatToIso8601Date(
      dateTime: DateTime(DateTime.now().year, DateTime.now().month, 1),
    );
    dateEnd = DateTimeHelper.formatToIso8601Date(
      dateTime: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
    );

    _vacationCalendarBloc = Modular.get<VacationCalendarStaffViewBloc>();
    _vacationCalendarBloc.add(
      GetVacationCalendarStaffViewEvent(
        startDate: dateStart,
        endDate: dateEnd,
        filter: VacationCalendarStaffViewFilterInputModel(
          employeeId: widget.employeeId,
        ),
      ),
    );

    dateSelectedCalendar = DateTime.now();

    lastDateSelectedCalendar = DateTimeHelper.formatToIso8601Date(
      dateTime: DateTime.now(),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Modular.dispose<VacationCalendarStaffViewBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VacationCalendarStaffViewBloc, VacationCalendarStaffViewState>(
      listener: (context, state) {
        if (state is LoadedVacationCalendarStaffViewState) {
          getVacationInfor(
            vacationEmployeeCalendarViewModel: state.vacationCalendarStaffViewEntity.vacationEmployeeCalendarViewEntity,
          );
          employeerCount = state.vacationCalendarStaffViewEntity.employeesCount;
          employeerInVacationCount = state.vacationCalendarStaffViewEntity.employeesInVacationCount;
        }
        if (state is EmptyVacationCalendarState) {
          getVacationInfor(
            vacationEmployeeCalendarViewModel: [],
          );
          employeerCount = 0;
          employeerInVacationCount = 0;
        }
      },
      bloc: _vacationCalendarBloc,
      builder: (context, state) {
        if (firstState) {
          weekDayName = DateTimeHelper.getNameWeek(
            appLocalizations: context.translate,
            weekDay: DateTime.now().weekday,
          );

          weekDayName = '$weekDayName (${context.translate.today})';
          if (state is LoadedVacationCalendarStaffViewState) {
            getVacationInfor(
              vacationEmployeeCalendarViewModel:
                  state.vacationCalendarStaffViewEntity.vacationEmployeeCalendarViewEntity,
            );
            employeerCount = state.vacationCalendarStaffViewEntity.employeesCount;
            employeerInVacationCount = state.vacationCalendarStaffViewEntity.employeesInVacationCount;
            firstState = false;
          }
        }

        if (state is LoadedVacationCalendarStaffViewState) {
          markedDateMap = getEventList(
            vacationEmployeeCalendarViewModel: state.vacationCalendarStaffViewEntity.vacationEmployeeCalendarViewEntity,
          );
        }
        if (state is ErrorVacationsCalendarState || state is EmptyVacationCalendarState) {
          markedDateMap = EventList<Event>(events: {});
        }
        if (state is LoadedVacationCalendarStaffViewState ||
            state is ErrorVacationsCalendarState ||
            state is EmptyVacationCalendarState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (state is LoadedVacationCalendarStaffViewState ||
                        state is ErrorVacationsCalendarState ||
                        state is EmptyVacationCalendarState)
                    ? SeniorCalendar(
                        selectedDay: dateSelectedCalendar,
                        // style: seniorCalendarStyle,
                        firstDay: DateTime(DateTime.now().year - 2, 1, 1),
                        lastDay: DateTime(DateTime.now().year + 2, 12, 31),
                        showStrokeTop: false,
                        markedDateMap: markedDateMap,
                        inactiveYesterdays: false,
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
                          _vacationCalendarBloc.add(
                            GetVacationCalendarStaffViewEvent(
                              startDate: dateStart,
                              endDate: dateEnd,
                              filter: VacationCalendarStaffViewFilterInputModel(
                                employeeId: widget.employeeId,
                              ),
                            ),
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

                              if (state is LoadedVacationCalendarStaffViewState) {
                                getVacationInfor(
                                  vacationEmployeeCalendarViewModel:
                                      state.vacationCalendarStaffViewEntity.vacationEmployeeCalendarViewEntity,
                                );
                                employeerCount = state.vacationCalendarStaffViewEntity.employeesCount;
                                employeerInVacationCount =
                                    state.vacationCalendarStaffViewEntity.employeesInVacationCount;
                              }
                              if (state is EmptyVacationCalendarState) {
                                getVacationInfor(
                                  vacationEmployeeCalendarViewModel: [],
                                );
                                employeerCount = 0;
                                employeerInVacationCount = 0;
                              }
                            },
                          );
                        },
                      )
                    : const SizedBox.shrink(),
                const Divider(
                  color: SeniorColors.neutralColor400,
                  thickness: 1,
                  indent: SeniorSpacing.normal,
                  endIndent: SeniorSpacing.normal,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.normal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SeniorText.h4(
                        DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: dateSelectedCalendar,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                      ),
                      SeniorText.label(
                        weekDayName,
                      ),
                    ],
                  ),
                ),
                infoProgrammingWidget(),
                showPendingManager
                    ? VacationStatusWidget(
                        statusTitle: context.translate.pendingWithTheManager,
                        statusVacation: EnumStatusVacationStaffCalendar.leaderReview,
                        vacationDetails: vacationDetailsPendingWithTheManager,
                      )
                    : const SizedBox.shrink(),
                showPendingRH
                    ? VacationStatusWidget(
                        statusTitle: context.translate.pendingWithHR,
                        statusVacation: EnumStatusVacationStaffCalendar.hrReview,
                        vacationDetails: vacationDetailsPendingRH,
                      )
                    : const SizedBox.shrink(),
                showScheduled
                    ? VacationStatusWidget(
                        statusTitle: context.translate.scheduled,
                        statusVacation: EnumStatusVacationStaffCalendar.scheduled,
                        vacationDetails: vacationDetailsScheduled,
                      )
                    : const SizedBox.shrink(),
                showCalculated
                    ? VacationStatusWidget(
                        statusTitle: context.translate.calculated,
                        statusVacation: EnumStatusVacationStaffCalendar.calculated,
                        vacationDetails: vacationDetailsCalculated,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: SeniorSpacing.xmedium,
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget infoProgrammingWidget() {
    if (!noProgrammingFound()) {
      return Padding(
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
          top: SeniorSpacing.normal,
          bottom: SeniorSpacing.normal,
        ),
        child: SeniorText.body(
          getCoworkersOnVacation(
            employeerCount: employeerCount,
            employeerInVacationCount: employeerInVacationCount,
          ),
        ),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SeniorSpacing.xbig,
        ),
        child: SeniorText.label(
          context.translate.noProgrammingWasFound,
          color: SeniorColors.neutralColor500,
        ),
      ),
    );
  }

  bool isToday() {
    return dateSelectedCalendar.day == DateTime.now().day &&
        dateSelectedCalendar.month == DateTime.now().month &&
        dateSelectedCalendar.year == DateTime.now().year;
  }

  String getCoworkersOnVacation({
    required int employeerCount,
    required int employeerInVacationCount,
  }) {
    double result = (employeerInVacationCount * 100) / employeerCount;
    return '${result.floorToDouble()}%${context.translate.ofCoworkersOnVacation}';
  }

  EventList<Event> getEventList({
    required List<VacationEmployeeCalendarViewEntity> vacationEmployeeCalendarViewModel,
  }) {
    Map<DateTime, List<Event>> eventMap = {};
    List<Event> eventList = [];

    vacationEmployeeCalendarViewModel.sort(
      (a, b) => DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: a.start,
      ).isAfter(
        DateTimeHelper.convertStringIso8601toDateTime(
          stringIso8601: b.start,
        ),
      )
          ? 1
          : -1,
    );

    for (var element in vacationEmployeeCalendarViewModel) {
      DateTime eventDateStart = DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: element.start,
      );
      SeniorFormsEnum seniorFormsEnum = getSeniorFormsEnum(
        type: element.type,
      );
      final Duration differenceBetweenDates = DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: element.end,
      ).difference(
        DateTimeHelper.convertStringIso8601toDateTime(
          stringIso8601: element.start,
        ),
      );

      for (int i = 0; i < differenceBetweenDates.inDays + 1; i++) {
        Event event = Event(
          date: eventDateStart.add(
            Duration(days: i),
          ),
          formsDefault: [seniorFormsEnum],
        );

        eventList.add(event);

        eventMap.addAll(
          {
            eventDateStart.add(
              Duration(days: i),
            ): [event],
          },
        );
      }
    }

    for (var e in vacationEmployeeCalendarViewModel) {
      int index = 0;
      for (final map in eventMap.entries) {
        if (map.key ==
                DateTimeHelper.convertStringIso8601toDateTime(stringIso8601: e.start).add(
                  Duration(
                    days: index,
                  ),
                ) &&
            DateTimeHelper.convertStringIso8601toDateTime(
              stringIso8601: e.start,
            )
                .add(
                  Duration(
                    days: index,
                  ),
                )
                .isBefore(
                  DateTimeHelper.convertStringIso8601toDateTime(
                    stringIso8601: e.end,
                  ).add(
                    const Duration(
                      days: 1,
                    ),
                  ),
                )) {
          List<SeniorFormsEnum> formsDefault = [];
          for (var event in map.value) {
            formsDefault = event.formsDefault!;
          }
          bool isFormEnum = false;
          for (var element in formsDefault) {
            if (element.name ==
                getSeniorFormsEnum(
                  type: e.type,
                ).name) {
              isFormEnum = true;
            }
          }

          if (!isFormEnum) {
            formsDefault.add(
              getSeniorFormsEnum(
                type: e.type,
              ),
            );
          }

          eventMap.addAll(
            {
              DateTimeHelper.convertStringIso8601toDateTime(
                stringIso8601: e.start,
              ).add(
                Duration(
                  days: index,
                ),
              ): [
                Event(
                  date: DateTimeHelper.convertStringIso8601toDateTime(
                    stringIso8601: e.start,
                  ).add(
                    Duration(
                      days: index,
                    ),
                  ),
                  formsDefault: formsDefault,
                ),
              ],
            },
          );
          index++;
        }
      }
    }
    return EventList<Event>(
      events: eventMap,
    );
  }

  SeniorFormsEnum getSeniorFormsEnum({
    required EnumStatusVacationStaffCalendar type,
  }) {
    switch (type) {
      case EnumStatusVacationStaffCalendar.hrReview:
        return SeniorFormsEnum.TRIANGLE;
      case EnumStatusVacationStaffCalendar.scheduled:
        return SeniorFormsEnum.TRIANGLE_DOWN;
      case EnumStatusVacationStaffCalendar.calculated:
        return SeniorFormsEnum.CIRCLE;
      case EnumStatusVacationStaffCalendar.leaderReview:
        return SeniorFormsEnum.SQUARE;
    }
  }

  Map<String, String> getVacationInfo({
    required List<VacationEmployeeCalendarViewEntity> vacationEmployeeCalendarViewModel,
    required EnumStatusVacationStaffCalendar enumStatusVacationStaffCalendar,
  }) {
    Map<String, String> map = {};

    for (var element in vacationEmployeeCalendarViewModel) {
      final Duration differenceBetweenDates = DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: element.end,
      ).difference(
        DateTimeHelper.convertStringIso8601toDateTime(
          stringIso8601: element.start,
        ),
      );

      for (var i = 0; i < differenceBetweenDates.inDays + 1; i++) {
        DateTime dateCalendar = DateTimeHelper.convertStringIso8601toDateTime(
          stringIso8601: element.start,
        ).add(
          Duration(
            days: i,
          ),
        );
        if (dateCalendar.day == dateSelectedCalendar.day &&
            dateCalendar.month == dateSelectedCalendar.month &&
            dateCalendar.year == dateSelectedCalendar.year) {
          if (element.type == enumStatusVacationStaffCalendar) {
            map.addAll(
              {
                element.title: '${DateTimeHelper.formatWithDefaultDatePattern(
                  dateTime: DateTimeHelper.convertStringIso8601toDateTime(
                    stringIso8601: element.start,
                  ),
                  locale: LocaleHelper.languageAndCountryCode(
                    locale: Localizations.localeOf(context),
                  ),
                )} até ${DateTimeHelper.formatWithDefaultDatePattern(
                  dateTime: DateTimeHelper.convertStringIso8601toDateTime(
                    stringIso8601: element.end,
                  ),
                  locale: LocaleHelper.languageAndCountryCode(
                    locale: Localizations.localeOf(context),
                  ),
                )}',
              },
            );
          }
        }
      }
    }

    switch (enumStatusVacationStaffCalendar) {
      case EnumStatusVacationStaffCalendar.leaderReview:
        showPendingManager = map.isNotEmpty;
        break;
      case EnumStatusVacationStaffCalendar.hrReview:
        showPendingRH = map.isNotEmpty;
        break;
      case EnumStatusVacationStaffCalendar.scheduled:
        showScheduled = map.isNotEmpty;
        break;
      case EnumStatusVacationStaffCalendar.calculated:
        showCalculated = map.isNotEmpty;
        break;
      default:
    }
    return map;
  }

  void getVacationInfor({
    required List<VacationEmployeeCalendarViewEntity> vacationEmployeeCalendarViewModel,
  }) {
    vacationDetailsPendingWithTheManager = getVacationInfo(
      enumStatusVacationStaffCalendar: EnumStatusVacationStaffCalendar.leaderReview,
      vacationEmployeeCalendarViewModel: vacationEmployeeCalendarViewModel,
    );
    vacationDetailsPendingRH = getVacationInfo(
      enumStatusVacationStaffCalendar: EnumStatusVacationStaffCalendar.hrReview,
      vacationEmployeeCalendarViewModel: vacationEmployeeCalendarViewModel,
    );
    vacationDetailsCalculated = getVacationInfo(
      enumStatusVacationStaffCalendar: EnumStatusVacationStaffCalendar.calculated,
      vacationEmployeeCalendarViewModel: vacationEmployeeCalendarViewModel,
    );
    vacationDetailsScheduled = getVacationInfo(
      enumStatusVacationStaffCalendar: EnumStatusVacationStaffCalendar.scheduled,
      vacationEmployeeCalendarViewModel: vacationEmployeeCalendarViewModel,
    );
  }

  bool noProgrammingFound() {
    return vacationDetailsPendingWithTheManager!.isEmpty &&
        vacationDetailsPendingRH!.isEmpty &&
        vacationDetailsCalculated!.isEmpty &&
        vacationDetailsScheduled!.isEmpty;
  }
}
