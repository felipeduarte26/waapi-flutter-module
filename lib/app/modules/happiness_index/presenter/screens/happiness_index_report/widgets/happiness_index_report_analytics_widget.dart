import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../domain/entities/happiness_index_group_entity.dart';
import '../../../../domain/entities/happiness_index_mood_entity.dart';
import '../../../../enums/happiness_index_mood_enum.dart';
import '../../../blocs/retrieve_mood_records/retrieve_mood_records_event.dart';
import '../../../blocs/retrieve_mood_records/retrieve_mood_records_state.dart';
import '../../../widgets/analytics/happiness_index_leading_reasons_widget.dart';
import '../../../widgets/analytics/happiness_index_swing_moods_chart_widget.dart';
import '../../../widgets/horizontal_chart/happiness_index_horizontal_chart_widget.dart';
import '../bloc/happiness_index_report_screen_bloc.dart';
import '../bloc/happiness_index_report_screen_state.dart';

class HappinessIndexReportAnalyticsWidget extends StatefulWidget {
  final String employeeId;

  const HappinessIndexReportAnalyticsWidget({
    Key? key,
    required this.employeeId,
  }) : super(key: key);

  @override
  State<HappinessIndexReportAnalyticsWidget> createState() => _HappinessIndexReportAnalyticsWidgetState();
}

class _HappinessIndexReportAnalyticsWidgetState extends State<HappinessIndexReportAnalyticsWidget> {
  bool showValues = false;
  DateTime dateSelectedCalendar = DateTime.now();
  late HappinessIndexReportScreenBloc _happinessIndexReportScreenBloc;

  @override
  void initState() {
    super.initState();

    _happinessIndexReportScreenBloc = Modular.get<HappinessIndexReportScreenBloc>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _happinessIndexReportScreenBloc.retrieveMoodRecordsBloc.add(
        GetRetrieveMoodRecordsEvent(
          language: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
          startDate: findFirstDateOfTheWeek(dateSelectedCalendar),
          endDate: findLastDateOfTheWeek(dateSelectedCalendar),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HappinessIndexReportScreenBloc, HappinessIndexReportScreenState>(
      bloc: _happinessIndexReportScreenBloc,
      builder: (context, state) {
        if (state.retrieveMoodRecordsState is LoadedRetrieveMoodRecordsState) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SeniorSpacing.normal,
                        right: SeniorSpacing.normal,
                        top: SeniorSpacing.xxsmall,
                      ),
                      child: SeniorText.cta(context.translate.weekAnalysis),
                    ),
                    SeniorCalendarHeader(
                      headerTitle: buildHeaderText(dateSelectedCalendar),
                      showHeader: true,
                      onLeftButtonPressed: () {
                        const lastWeek = -7;
                        setNewPeriod(days: lastWeek);
                      },
                      onRightButtonPressed: () {
                        const nextWeek = 7;
                        setNewPeriod(days: nextWeek);
                      },
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    HappinessIndexSwingMoodsChartWidget(
                      moods: state.retrieveMoodRecordsState.moods,
                      startDate: findFirstDateOfTheWeek(dateSelectedCalendar),
                      endDate: findLastDateOfTheWeek(dateSelectedCalendar),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: SeniorSpacing.small,
                        vertical: SeniorSpacing.small,
                      ),
                      width: double.infinity,
                      height: 1,
                      color: SeniorColors.grayscale30,
                    ),
                    if (state.retrieveMoodRecordsState.moods.isNotEmpty)
                      Column(
                        children: [
                          HappinessIndexHorizontalChartWidget(
                            moods: getMoods(
                              moods: state.retrieveMoodRecordsState.moods,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: SeniorSpacing.small,
                            ),
                            width: double.infinity,
                            height: 1,
                            color: SeniorColors.grayscale30,
                          ),
                          const SizedBox(
                            height: SeniorSpacing.xsmall,
                          ),
                        ],
                      ),
                    HappinessIndexLeadingReasonsWidget(
                      reasons: getLeadingReasons(
                        moods: state.retrieveMoodRecordsState.moods,
                      ),
                    ),
                    const SizedBox(
                      height: SeniorSpacing.normal,
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        if (state.retrieveMoodRecordsState is LoadingRetrieveMoodRecordsState) {
          return const WaapiLoadingWidget();
        }

        return const SizedBox.shrink();
      },
    );
  }

  String buildHeaderText(DateTime selectedDate) {
    final weekendDateFormat = DateFormat.yMd(
      LocaleHelper.languageAndCountryCode(
        locale: Localizations.localeOf(context),
      ),
    );

    return '${weekendDateFormat.format(findFirstDateOfTheWeek(selectedDate))} - ${weekendDateFormat.format(findLastDateOfTheWeek(selectedDate))}';
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

  void setNewPeriod({required int days}) {
    setState(() {
      dateSelectedCalendar = dateSelectedCalendar.add(Duration(days: days));
    });

    _happinessIndexReportScreenBloc.retrieveMoodRecordsBloc.add(
      GetRetrieveMoodRecordsEvent(
        language: LocaleHelper.languageAndCountryCode(
          locale: Localizations.localeOf(context),
        ),
        startDate: findFirstDateOfTheWeek(dateSelectedCalendar),
        endDate: findLastDateOfTheWeek(dateSelectedCalendar),
      ),
    );
  }

  List<HappinessIndexGroupEntity> getLeadingReasons({required List<HappinessIndexMoodEntity> moods}) {
    List<HappinessIndexGroupEntity> reasons = [];
    for (var mood in moods) {
      if (mood.happinessIndexGroups != null) {
        reasons.addAll(mood.happinessIndexGroups!);
      }
    }

    return reasons;
  }

  List<HappinessIndexMoodEnum> getMoods({required List<HappinessIndexMoodEntity> moods}) {
    List<HappinessIndexMoodEnum> chartMoods = [];
    for (var mood in moods) {
      chartMoods.add(mood.happinessIndexMood);
    }

    return chartMoods;
  }
}
