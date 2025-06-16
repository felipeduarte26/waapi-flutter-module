// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/components/senior_text/senior_text_widget.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/constants/assets_path.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/error_state_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/happiness_index_routes.dart';
import '../../../../enums/happiness_index_mood_enum.dart';
import '../../../blocs/retrieve_mood_records/retrieve_mood_records_event.dart';
import '../../../blocs/retrieve_mood_records/retrieve_mood_records_state.dart';
import '../../../widgets/calendar/happiness_index_calendar_widget.dart';
import '../../../widgets/happiness_index_card_widget.dart';
import '../../../widgets/happiness_index_widget.dart';
import '../bloc/happiness_index_report_screen_bloc.dart';
import '../bloc/happiness_index_report_screen_state.dart';

class HappinessIndexReportCalendarWidget extends StatefulWidget {
  final String employeeId;

  const HappinessIndexReportCalendarWidget({
    super.key,
    required this.employeeId,
  });

  @override
  State<HappinessIndexReportCalendarWidget> createState() => _HappinessIndexReportCalendarWidgetState();
}

class _HappinessIndexReportCalendarWidgetState extends State<HappinessIndexReportCalendarWidget> {
  late DateTime dateSelectedCalendar;
  late String weekDayName;
  HappinessIndexMoodEnum? moodSelectedCalendar;
  late HappinessIndexReportScreenBloc _happinessIndexReportScreenBloc;

  @override
  void initState() {
    super.initState();
    dateSelectedCalendar = DateUtils.dateOnly(DateTime.now());
    _happinessIndexReportScreenBloc = Modular.get<HappinessIndexReportScreenBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_happinessIndexReportScreenBloc.retrieveMoodRecordsBloc.state is! LoadedRetrieveMoodRecordsState) {
        _happinessIndexReportScreenBloc.retrieveMoodRecordsBloc.add(
          GetRetrieveMoodRecordsEvent(
            language: LocaleHelper.languageAndCountryCode(
              locale: Localizations.localeOf(context),
            ),
            startDate: DateTime(dateSelectedCalendar.year, dateSelectedCalendar.month, 1),
            endDate: DateTime(dateSelectedCalendar.year, dateSelectedCalendar.month + 1, 0),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    weekDayName = DateTimeHelper.getNameWeek(
      appLocalizations: context.translate,
      weekDay: dateSelectedCalendar.weekday,
    );

    DateTimeHelper.formatToIso8601Date(
              dateTime: dateSelectedCalendar,
            ) ==
            DateTimeHelper.formatToIso8601Date(dateTime: DateTime.now())
        ? weekDayName = '$weekDayName (${context.translate.today})'
        : weekDayName;

    return BlocBuilder<HappinessIndexReportScreenBloc, HappinessIndexReportScreenState>(
      bloc: _happinessIndexReportScreenBloc,
      builder: (context, state) {
        if (state.retrieveMoodRecordsState is LoadingRetrieveMoodRecordsState) {
          return const WaapiLoadingWidget();
        }

        if (state.retrieveMoodRecordsState is ErrorRetrieveMoodRecordsState) {
          return ErrorStateWidget(
            title: context.translate.humorReportEmptyStateTitle,
            imagePath: AssetsPath.generalErrorState,
            subTitle: context.translate.humorReportEmptyStateSubtitle,
            onTapTryAgain: () {
              _happinessIndexReportScreenBloc.retrieveMoodRecordsBloc.add(
                GetRetrieveMoodRecordsEvent(
                  language: LocaleHelper.languageAndCountryCode(
                    locale: Localizations.localeOf(context),
                  ),
                  startDate: DateTime(dateSelectedCalendar.year, dateSelectedCalendar.month, 1),
                  endDate: DateTime(dateSelectedCalendar.year, dateSelectedCalendar.month + 1, 0),
                ),
              );
            },
          );
        }

        if (state.retrieveMoodRecordsState is LoadedRetrieveMoodRecordsState) {
          final moodDetails = state.retrieveMoodRecordsState.moods.firstWhereOrNull(
            (record) {
              return DateUtils.isSameDay(record.date, dateSelectedCalendar);
            },
          );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HappinessIndexCalendarWidget(
                  selectedDay: dateSelectedCalendar,
                  moods: state.retrieveMoodRecordsState.moods,
                  onSelectedDay: (newDate) {
                    if (newDate.month != dateSelectedCalendar.month) {
                      _happinessIndexReportScreenBloc.retrieveMoodRecordsBloc.add(
                        GetRetrieveMoodRecordsEvent(
                          language: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                          startDate: DateTime(newDate.year, newDate.month, 1),
                          endDate: DateTime(newDate.year, newDate.month + 1, 0),
                        ),
                      );
                    }

                    dateSelectedCalendar = newDate;
                    setState(() {});
                  },
                  onSelectedDayWithMood: (mood) {
                    moodSelectedCalendar = mood;
                    setState(() {});
                  },
                ),
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
                    children: [
                      SeniorText.h4(
                        DateTimeHelper.formatWithDefaultDatePattern(
                          dateTime: dateSelectedCalendar,
                          locale: LocaleHelper.languageAndCountryCode(
                            locale: Localizations.localeOf(context),
                          ),
                        ),
                        color: SeniorColors.grayscale90,
                      ),
                      SeniorText.label(
                        weekDayName,
                        color: SeniorColors.grayscale50,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.normal,
                      ),
                      if (moodDetails == null && !isToday())
                        Center(
                          child: SeniorText.label(
                            context.translate.noRecordsThisDay,
                            color: SeniorColors.grayscale50,
                          ),
                        ),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (moodDetails != null) {
                      return HappinessIndexCardWidget(
                        disabled: false,
                        happinessIndexMoodEntity: moodDetails,
                        onTap: () {
                          Modular.to.pushNamed(
                            HappinessIndexRoutes.moodDetailsScreenInitialRoute,
                            arguments: moodDetails,
                          );
                        },
                      );
                    }

                    if (moodDetails == null && isToday()) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: SeniorSpacing.normal,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SeniorText.label(context.translate.noRecordsToday),
                                SeniorText.cta(context.translate.howsYourMoodToday),
                                const SizedBox(
                                  height: SeniorSpacing.normal,
                                ),
                              ],
                            ),
                          ),
                          HappinessIndexWidget(
                            employeeId: widget.employeeId,
                            disabled: false,
                            onRefresh: () {
                              _happinessIndexReportScreenBloc.retrieveMoodRecordsBloc.add(
                                GetRetrieveMoodRecordsEvent(
                                  language: LocaleHelper.languageAndCountryCode(
                                    locale: Localizations.localeOf(context),
                                  ),
                                  startDate: DateTime(dateSelectedCalendar.year, dateSelectedCalendar.month, 1),
                                  endDate: DateTime(dateSelectedCalendar.year, dateSelectedCalendar.month + 1, 0),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: SeniorSpacing.normal,
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  bool isToday() {
    return DateUtils.isSameDay(dateSelectedCalendar, DateTime.now());
  }
}
