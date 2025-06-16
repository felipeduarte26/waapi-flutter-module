import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/infra/utils/workday_indicator.dart';
import '../../domain/usecase/show_bottom_sheet_usecase.dart';

class TodaysWorkday extends StatelessWidget {
  final WorkdayIndicators workdayIndicators;
  final bool expanded;
  final Function? onExpandedPressed;
  final IShowBottomSheetUsecase showBottomSheetUsecase;

  const TodaysWorkday({
    super.key,
    required this.workdayIndicators,
    this.expanded = true,
    this.onExpandedPressed,
    required this.showBottomSheetUsecase,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    final theme = Provider.of<ThemeRepository>(context).theme;

    return SeniorCard(
      onTap: () => {
        onExpandedPressed?.call(),
      },
      style: SeniorCardStyle(
        backgroundColor: isDark ? theme.cardTheme!.style!.backgroundColor : SeniorColors.grayscale7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildHeader(context),
          if (expanded && workdayIndicators.clockingEvents.isEmpty)
            Padding(
              padding: const EdgeInsets.all(SeniorSpacing.small),
              child: SvgPicture.asset(
                'packages/ponto_mobile_collector/assets/icons/empty_2.svg',
                height: 76,
              ),
            ),
          if (workdayIndicators.clockingEvents.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: SeniorSpacing.xsmall),
              child: SeniorText.body(
                CollectorLocalizations.of(context).noClockingEvents,
                color: SeniorColors.neutralColor600,
              ),
            ),
          if (expanded && workdayIndicators.clockingEvents.isEmpty)
            SeniorText.small(
              CollectorLocalizations.of(context).whenRegistered,
              color: SeniorColors.neutralColor600,
            ),
          if (expanded && workdayIndicators.clockingEvents.isNotEmpty) buildClockingEventList(context),
          if (!expanded && workdayIndicators.clockingEvents.isNotEmpty) buildLastClockingEvent(context),
          if (expanded && workdayIndicators.clockingEvents.isNotEmpty) _buildInidicators(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              FontAwesomeIcons.solidCalendarCheck,
              color:
                  themeRepository.isCustomTheme() ? themeRepository.theme.primaryColor : SeniorColors.primaryColor400,
              size: SeniorIconSize.small,
            ),
            const SizedBox(width: SeniorSpacing.small),
            SeniorText.labelBold(
              CollectorLocalizations.of(context).todaysClockinEvents,
            ),
          ],
        ),
        Icon(
          expanded ? FontAwesomeIcons.angleUp : FontAwesomeIcons.angleDown,
          color: SeniorColors.neutralColor500,
          size: SeniorIconSize.small,
        ),
      ],
    );
  }

  Widget buildClockingEventList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.xsmall),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: workdayIndicators.clockingEvents.length,
      itemBuilder: (context, index) => buildClockingEventRow(index, context),
    );
  }

  Widget buildLastClockingEvent(BuildContext context) {
    int index = workdayIndicators.clockingEvents.lastIndexWhere(
      (e) => workdayIndicators.clockingEvents.indexOf(e) % 2 == 0,
    );
    String label = index == workdayIndicators.clockingEvents.length - 1
        ? CollectorLocalizations.of(context).lastClockingevent
        : CollectorLocalizations.of(context).lastClockingevents;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(SeniorSpacing.xsmall),
          child: SeniorText.small(label),
        ),
        buildClockingEventRow(index, context),
      ],
    );
  }

  Widget buildClockingEventRow(int index, BuildContext context) {
    if (index % 2 == 0) {
      final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

      return IgnorePointer(
        ignoring: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SeniorBadge.icon(
              icon: FontAwesomeIcons.solidCircleRight,
              iconColor: SeniorColors.primaryColor500,
              backgroundColor: isDark ? SeniorColors.grayscale70 : SeniorColors.secondaryColor100,
              fontColor: isDark ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
              label: TimeOfDay.fromDateTime(
                workdayIndicators.clockingEvents[index],
              ).format(context),
              shape: SeniorBadgeShape.pill,
            ),
            if (index + 1 < workdayIndicators.clockingEvents.length)
              const Padding(
                padding: EdgeInsets.all(5.33),
                child: Icon(
                  FontAwesomeIcons.leftRight,
                  color: SeniorColors.neutralColor500,
                  size: SeniorIconSize.xsmall,
                ),
              ),
            if (index + 1 < workdayIndicators.clockingEvents.length)
              SeniorBadge.icon(
                icon: FontAwesomeIcons.solidCircleLeft,
                iconColor: SeniorColors.manchesterColorRed500,
                backgroundColor: isDark ? SeniorColors.grayscale70 : SeniorColors.secondaryColor100,
                fontColor: isDark ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                label: TimeOfDay.fromDateTime(
                  workdayIndicators.clockingEvents[index + 1],
                ).format(context),
                shape: SeniorBadgeShape.pill,
              ),
          ],
        ),
      );
    }
    if (index + 1 < workdayIndicators.clockingEvents.length) {
      return _buildDivider(index, context);
    }
    return const SizedBox.shrink();
  }

  Widget _buildDivider(int i, BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    final theme = Provider.of<ThemeRepository>(context).theme;

    return Stack(
      alignment: Alignment.center,
      children: [
        Divider(
          height: 5,
          thickness: 1,
          color: isDark ? SeniorColors.grayscale70 : SeniorColors.grayscale10,
          endIndent: 0,
          indent: 0,
        ),
        Container(
          color: isDark ? theme.cardTheme!.style!.backgroundColor : SeniorColors.pureWhite,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: SeniorText.small(
            CollectorLocalizations.of(context).breakTime.replaceFirst(
                  '%t',
                  WorkdayIndicators.durationInterval(
                    workdayIndicators.clockingEvents[i],
                    workdayIndicators.clockingEvents[i + 1],
                  ),
                ),
            color: SeniorColors.grayscale70,
            darkColor: SeniorColors.grayscale60,
          ),
        ),
      ],
    );
  }

  Widget _buildInidicators(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SeniorText.small(
                  CollectorLocalizations.of(context).hoursWorked,
                  color: SeniorColors.grayscale70,
                  darkColor: SeniorColors.grayscale60,
                ),
                IconButton(
                  constraints: const BoxConstraints(maxHeight: 25),
                  alignment: Alignment.center,
                  onPressed: () {
                    showBottomSheetUsecase.call(
                      context: context,
                      content: [const HoursWorkedInfoWidget()],
                    );
                  },
                  icon: Icon(
                    color: isDark ? SeniorColors.secondaryColor600 : SeniorColors.pureBlack,
                    FontAwesomeIcons.circleInfo,
                    size: SeniorIconSize.xsmall,
                  ),
                ),
              ],
            ),
            SeniorText.small(
              WorkdayIndicators.formatDuration(
                workdayIndicators.workedHours(completeNow: true),
              ),
              color: SeniorColors.grayscale90,
              darkColor: SeniorColors.grayscale30,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SeniorText.small(
              CollectorLocalizations.of(context).breaks,
              color: SeniorColors.grayscale70,
              darkColor: SeniorColors.grayscale60,
            ),
            SeniorText.small(
              WorkdayIndicators.formatDuration(
                workdayIndicators.breaks,
              ),
              color: SeniorColors.grayscale90,
              darkColor: SeniorColors.grayscale30,
            ),
          ],
        ),
      ],
    );
  }
}

class HoursWorkedInfoWidget extends StatelessWidget {
  const HoursWorkedInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var localizations = CollectorLocalizations.of(context);

    return Column(
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SeniorText.labelBold(
                localizations.hoursWorked,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SeniorSpacing.normal,
        ),
        SeniorText.small(
          localizations.hoursWorkedTodayInfo,
          textProperties: const TextProperties(
            softWrap: true,
          ),
          color: SeniorColors.neutralColor500,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SeniorSpacing.normal),
          child: SeniorButton.ghost(
            label: localizations.infoUnderstoodButton,
            fullWidth: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
