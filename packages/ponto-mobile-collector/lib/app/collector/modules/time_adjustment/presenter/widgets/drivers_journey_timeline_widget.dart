import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/journey_time_details_dto.dart';
import '../../../../core/domain/input_model/timeline_item_dto.dart';
import '../../../../core/infra/utils/enum/type_journey_time_enum.dart';
import '../../../../core/infra/utils/extension/string_extension.dart';
import '../../../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';

class DriversJourneyTimelineWidget extends StatelessWidget {
  final IUtils _utils;
  final IShowBottomSheetUsecase _showBottomSheetUsecase;
  final List<TimelineItemDto> timelineItems;
  final List<JourneyTimeDetailsDto> journeyTimeDetailsList;

  const DriversJourneyTimelineWidget({
    super.key,
    required IUtils utils,
    required IShowBottomSheetUsecase showBottomSheetUsecase,
    required this.timelineItems,
    required this.journeyTimeDetailsList,
  })  : _utils = utils,
        _showBottomSheetUsecase = showBottomSheetUsecase;

  Widget _card(
    BuildContext context, {
    required DriversWorkStatusEnum driversWorkStatus,
    int? totalHours,
    int? totalMinutes,
  }) {
    assert(
      (totalHours == null && totalMinutes == null) ||
          (totalHours != null && totalMinutes != null),
    );

    final collectorLocalizations = CollectorLocalizations.of(context);

    final themeRepository = Provider.of<ThemeRepository>(context);
    final (
      theme,
      isDark,
    ) = (
      themeRepository.theme,
      themeRepository.isDarkTheme(),
    );

    DriversWorkStatusActionEnum? driversWorkStatusAction;

    try {
      driversWorkStatusAction = DriversWorkStatusActionEnum.values.byName(
        driversWorkStatus.name,
      );
    } catch (_) {}

    final (
      icon,
      iconColor,
    ) = (
      driversWorkStatus.icon,
      driversWorkStatusAction?.iconColor ??
          (isDark ? SeniorColors.primaryColor400 : SeniorColors.primaryColor),
    );

    final status = switch (driversWorkStatus) {
      DriversWorkStatusEnum.working => collectorLocalizations.working,
      DriversWorkStatusEnum.driving => collectorLocalizations.drive,
      DriversWorkStatusEnum.mandatoryBreak =>
        collectorLocalizations.mandatoryBreak,
      DriversWorkStatusEnum.foodTime => collectorLocalizations.foodTime,
      DriversWorkStatusEnum.waiting => collectorLocalizations.waiting,
      _ => '',
    };

    final (
      hours,
      minutes,
    ) = (
      totalHours?.toString().padLeft(2, '0') ?? '--',
      totalMinutes?.toString().padLeft(2, '0') ?? '--',
    );

    return SeniorElevatedElement(
      elevation: SeniorElevations.dp01,
      borderRadius: 6,
      child: GestureDetector(
        onTap: () async => await _showBottomSheetUsecase.call(
          context: context,
          content: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: iconColor,
                      size: SeniorIconSize.small,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: SeniorText.labelBold(
                        status,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                SeniorText.small(
                  switch (driversWorkStatus) {
                    DriversWorkStatusEnum.working =>
                      collectorLocalizations.workingStatusDescription,
                    DriversWorkStatusEnum.foodTime =>
                      collectorLocalizations.foodTimeStatusDescriptionModal,
                    DriversWorkStatusEnum.driving =>
                      collectorLocalizations.drivingStatusDescription,
                    DriversWorkStatusEnum.mandatoryBreak =>
                      collectorLocalizations.mandatoryBreakStatusDescription,
                    DriversWorkStatusEnum.waiting =>
                      collectorLocalizations.waitingStatusDescription,
                    _ => '',
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: SeniorSpacing.normal,
                  ),
                  child: SeniorButton.ghost(
                    label:
                        CollectorLocalizations.of(context).infoUnderstoodButton,
                    fullWidth: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // _rateInformationWidget(context),
              ],
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? theme.cardTheme!.style!.backgroundColor
                : SeniorColors.grayscale0,
            border: Border(
              left: BorderSide(
                color: iconColor,
                width: 5,
              ),
            ),
          ),
          constraints: const BoxConstraints(
            minHeight: 75,
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: SeniorIconSize.small,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeniorText.small(
                      status,
                    ),
                    SeniorText.cta(
                      '$hours:$minutes',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildPrefix({
    required CollectorLocalizations collectorLocalizations,
    bool? isBeginning,
  }) {
    if (isBeginning != null) {
      return isBeginning
          ? collectorLocalizations.startOf
          : collectorLocalizations.endOf;
    }
    return '';
  }

  String _buildDescription({
    required CollectorLocalizations collectorLocalizations,
    bool? isBeginning,
    DateTime? startDateTime,
    DateTime? endDateTime,
    required String totalHours,
    required String totalMinutes,
  }) {
    final String localeName = collectorLocalizations.localeName;
    if (isBeginning != null) {
      if (isBeginning) {
        if (startDateTime != null) {
          return _utils.formatTime(
            dateTime: startDateTime,
            locale: localeName,
          );
        }
      } else {
        if (startDateTime != null && endDateTime != null) {
          final startTime = _utils.formatTime(
            dateTime: startDateTime,
            locale: localeName,
          );
          final endTime = _utils.formatTime(
            dateTime: endDateTime,
            locale: localeName,
          );
          return collectorLocalizations.betweenTimes(
            startTime,
            endTime,
            '${totalHours != '00' && totalHours != '0' ? totalHours + collectorLocalizations.abbreviatedHour : ''} ${totalMinutes != '00' ? totalMinutes + collectorLocalizations.minutes : ''}',
          );
        }
      }
    } else {
      return _formatDuration(
        collectorLocalizations: collectorLocalizations,
        startDateTime: startDateTime,
        endDateTime: endDateTime,
        localeName: localeName,
      );
    }
    return '';
  }

  String _formatDuration({
    required CollectorLocalizations collectorLocalizations,
    required String localeName,
    DateTime? startDateTime,
    DateTime? endDateTime,
  }) {
    if (startDateTime != null && endDateTime != null) {
      final startTime = _utils.formatTime(
        dateTime: startDateTime,
        locale: localeName,
      );
      final endTime = _utils.formatTime(
        dateTime: endDateTime,
        locale: localeName,
      );

      final differenceInMinutes = _utils.calculateDifferenceInMinutes(
        endTime,
        startTime,
      );

      int hours = differenceInMinutes ~/ 60;
      int minutes = differenceInMinutes % 60;
      String totalHours = hours.toString();
      String totalMinutes = minutes.toString();

      return collectorLocalizations.betweenTimes(
        startTime,
        endTime,
        '${totalHours != '00' && totalHours != '0' ? totalHours + collectorLocalizations.abbreviatedHour : ''} ${totalMinutes != '00' && totalMinutes != '0' ? totalMinutes + collectorLocalizations.minutes : ''}',
      );
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    final JourneyTimeDetailsDto? drivingTime = _utils.getFirstEventByType(
      type: TypeJourneyTimeEnum.driving,
      journeyTimeDetailsList: journeyTimeDetailsList,
    );

    final JourneyTimeDetailsDto? waitingTime = _utils.getFirstEventByType(
      type: TypeJourneyTimeEnum.waiting,
      journeyTimeDetailsList: journeyTimeDetailsList,
    );

    final JourneyTimeDetailsDto? mealBreakTime = _utils.getFirstEventByType(
      type: TypeJourneyTimeEnum.mealBreak,
      journeyTimeDetailsList: journeyTimeDetailsList,
    );

    final JourneyTimeDetailsDto? mandatoryBreakTime =
        _utils.getFirstEventByType(
      type: TypeJourneyTimeEnum.mandatoryBreak,
      journeyTimeDetailsList: journeyTimeDetailsList,
    );

    final JourneyTimeDetailsDto? totalWorkingTime = _utils.getFirstEventByType(
      type: TypeJourneyTimeEnum.working,
      journeyTimeDetailsList: journeyTimeDetailsList,
    );

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.xsmall),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: timelineItems.length,
            itemBuilder: (context, index) {
              final bool? isBeginning = timelineItems[index].isBeginning;
              DateTime? startDateTime = timelineItems[index].startDate;
              DateTime? endDateTime = timelineItems[index].endDate;
              int totalHours =
                  totalWorkingTime != null ? totalWorkingTime.time.hour : 00;
              int totalMinutes =
                  totalWorkingTime != null ? totalWorkingTime.time.minute : 00;

              final TypeJourneyTimeEnum typeJourneyTimeEnum =
                  TypeJourneyTimeEnum.values.byName(
                timelineItems[index].typeJourneyTimeEnum!.name,
              );

              final (
                prefix,
                description,
              ) = (
                _buildPrefix(
                  collectorLocalizations: collectorLocalizations,
                  isBeginning: isBeginning,
                ),
                _buildDescription(
                  collectorLocalizations: collectorLocalizations,
                  isBeginning: isBeginning,
                  totalHours: totalHours.toString(),
                  totalMinutes: totalMinutes.toString(),
                  startDateTime: startDateTime,
                  endDateTime: endDateTime,
                ),
              );
              final IconData icon = typeJourneyTimeEnum.icon(context);
              final String status = typeJourneyTimeEnum.status(context);

              String timelineLabel =
                  upperCaseFirstLetter(word: '$prefix$status');

              return Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox.square(
                      dimension: 35,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          color: isDark
                              ? SeniorColors.grayscale30
                              : SeniorColors.grayscale50,
                        ),
                        child: Icon(
                          icon,
                          size: SeniorIconSize.small,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SeniorText.body(
                            timelineLabel,
                            darkColor: SeniorColors.grayscale30,
                          ),
                          SeniorText.small(
                            description,
                            darkColor: SeniorColors.grayscale50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => Container(
              alignment: Alignment.centerLeft,
              height: 45,
              child: VerticalDivider(
                indent: 5,
                endIndent: 5,
                color: isDark
                    ? SeniorColors.grayscale30
                    : SeniorColors.grayscale50,
                thickness: 2,
                width: 35,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.solidClock,
              color:
                  isDark ? SeniorColors.grayscale30 : SeniorColors.grayscale50,
              size: SeniorIconSize.small,
            ),
            const SizedBox(
              width: 10,
            ),
            SeniorText.labelBold(
              collectorLocalizations.totalsOfTheDay,
              darkColor: SeniorColors.pureWhite,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _card(
                    context,
                    driversWorkStatus: DriversWorkStatusEnum.working,
                    totalHours: totalWorkingTime != null
                        ? totalWorkingTime.time.hour
                        : 00,
                    totalMinutes: totalWorkingTime != null
                        ? totalWorkingTime.time.minute
                        : 00,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _card(
                    context,
                    driversWorkStatus: DriversWorkStatusEnum.driving,
                    totalHours:
                        drivingTime != null ? drivingTime.time.hour : 00,
                    totalMinutes:
                        drivingTime != null ? drivingTime.time.minute : 00,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _card(
                    context,
                    driversWorkStatus: DriversWorkStatusEnum.waiting,
                    totalHours:
                        waitingTime != null ? waitingTime.time.hour : 00,
                    totalMinutes:
                        waitingTime != null ? waitingTime.time.minute : 00,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  _card(
                    context,
                    driversWorkStatus: DriversWorkStatusEnum.foodTime,
                    totalHours:
                        mealBreakTime != null ? mealBreakTime.time.hour : 00,
                    totalMinutes:
                        mealBreakTime != null ? mealBreakTime.time.minute : 00,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _card(
                    context,
                    driversWorkStatus: DriversWorkStatusEnum.mandatoryBreak,
                    totalHours: mandatoryBreakTime != null
                        ? mandatoryBreakTime.time.hour
                        : 00,
                    totalMinutes: mandatoryBreakTime != null
                        ? mandatoryBreakTime.time.minute
                        : 00,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
