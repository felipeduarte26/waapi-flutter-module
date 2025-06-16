import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/components/components.dart';
import 'package:senior_design_system/repositories/theme_repository.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/infra/utils/extension/string_extension.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../../../clocking_event/domain/usecase/get_clock_time_usecase.dart';
import '../../../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../../../clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import '../../../clocking_event/presenter/widgets/clocking_event_receipt/clocking_event_receipt_widget.dart';
import '../../../routes/collector_routes.dart';
import '../../../routes/time_adjustment_multi_routes.dart';
import '../bloc/timer_adjustment/timer_adjustment_bloc.dart';
import '../bloc/timer_adjustment/timer_adjustment_event.dart';
import '../bloc/timer_adjustment/timer_adjustment_state.dart';
import '../widgets/clocking_event_info_widget.dart';
import '../widgets/selected_employee_widget.dart';
import '../widgets/timer_adjustment_widget.dart';

class TimeAdjustmentClockingEventsScreen extends StatefulWidget {
  final TimerAdjustmentBloc _timerAdjustmentBloc;
  final IGetClockDateTimeUsecase _getClockDateTimeUsecase;
  final SynchronizeClockingEventBloc _synchronizeClockingEventBloc;
  final IUtils _utils;
  final IShowBottomSheetUsecase _showBottomSheetUsecase;
  final NavigatorService _navigatorService;
  final String username;
  final bool isMulti;
  final bool isManagerOrAdmin;

  const TimeAdjustmentClockingEventsScreen(
    this._timerAdjustmentBloc,
    this._getClockDateTimeUsecase,
    this._synchronizeClockingEventBloc,
    this._utils,
    this._showBottomSheetUsecase,
    this._navigatorService,
    this.username, {
    this.isMulti = false,
    this.isManagerOrAdmin = false,
    super.key,
  });

  @override
  State<TimeAdjustmentClockingEventsScreen> createState() =>
      _TimeAdjustmentClockingEventsScreenState();
}

class _TimeAdjustmentClockingEventsScreenState
    extends State<TimeAdjustmentClockingEventsScreen> {
  var calendarFormat = SeniorCalendarFormat.week;
  late DateTime lastDay;
  late DateTime firstDay;

  @override
  void initState() {
    super.initState();
    widget._timerAdjustmentBloc.isMultipleView = widget.isMulti;
    widget._timerAdjustmentBloc.username = widget.username;
    loadClockingEvents();
  }

  Widget buildOvernightEditor(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDark = themeRepository.isDarkTheme();
    final theme = themeRepository.theme;

    return SeniorElevatedElement(
      elevation: SeniorElevations.dp01,
      borderRadius: 6,
      child: Container(
        color: isDark
            ? theme.cardTheme!.style!.backgroundColor
            : SeniorColors.grayscale0,
        padding: const EdgeInsets.only(
          bottom: SeniorSpacing.small - SeniorSpacing.xxsmall,
        ),
        child: buildDaySelectHeader(
          context,
          isOvernight: true,
        ),
      ),
    );
  }

  void loadClockingEvents() async {
   // if(widget._timerAdjustmentBloc.employeeId == null){
    widget._timerAdjustmentBloc.add(
      LoadDayTimerAdjustmentEvent(
        selectedDay: widget._getClockDateTimeUsecase.call(),
      ),
    );
    //}
  }

  Widget buildDaySelectHeader(
    BuildContext context, {
    bool isOvernight = false,
  }) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    DateTime day = widget._timerAdjustmentBloc.day;

    return Padding(
      padding: const EdgeInsets.only(
        left: SeniorSpacing.small,
        right: SeniorSpacing.small,
        top: SeniorSpacing.small,
        bottom: SeniorSpacing.xxsmall,
      ),
      child: Row(
        children: [
          Icon(
            isOvernight
                ? FontAwesomeIcons.solidMoon
                : FontAwesomeIcons.calendarDay,
            color: SeniorColors.primaryColor400,
            size: SeniorIconSize.medium,
          ),
          const SizedBox(
            width: SeniorSpacing.xsmall,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.labelBold(
                DateFormat(
                  DateFormat.YEAR_NUM_MONTH_DAY,
                  CollectorLocalizations.of(context).localeName,
                ).format(day),
                color: SeniorColors.neutralColor800,
              ),
              SeniorText.small(
                DateFormat.EEEE(
                  CollectorLocalizations.of(context).localeName,
                ).format(day).capitalize(),
                textProperties: const TextProperties(
                  overflow: TextOverflow.ellipsis,
                ),
                color: SeniorColors.neutralColor700,
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SeniorSpacing.normal,
            ),
            child: SeniorBadge(
              backgroundColor: isDark
                  ? SeniorColors.secondaryColor
                  : SeniorColors.grayscale20,
              fontColor:
                  isDark ? SeniorColors.pureWhite : SeniorColors.pureBlack,
              label: CollectorLocalizations.of(context).overnight,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerAdjustmentBloc, TimerAdjustmentState>(
      bloc: widget._timerAdjustmentBloc,
      listener: (context, state) {
        if (state is ReceiptTimerAdjustmentState) {
          widget._showBottomSheetUsecase.call(
            context: context,
            content: [
              ClockingEventReceiptWidget(receipt: state.receiptModel),
            ],
          );
        }
        if (state is AddOvernightSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.success(
              message:
                  CollectorLocalizations.of(context).overnightAddedSuccessfully,
            ),
          );
        }

        if (state is AddOvernightErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.success(
              message: CollectorLocalizations.of(context).overnightAddedError,
            ),
          );
        }
      },
      builder: (context, state) {
        bool showAddOvernightButton = false;
        if (state is LoadedTimerAdjustmentState) {
          showAddOvernightButton = state.showAddOvernightButton;
        } else if (state is AddOvernightSuccessState) {
          showAddOvernightButton = state.showAddOvernightButton;
        }
        if (state is LoadingTimerAdjustmentState ||
            state is InitialTimerAdjustmentState) {
          return LoadingWidget(
            bottomLabel: CollectorLocalizations.of(context).loading,
          );
        }

        lastDay = widget._getClockDateTimeUsecase.call();
        firstDay = lastDay.subtract(
          const Duration(
            days: 60,
          ),
        );

        return ListView(
          children: [
            SeniorCalendar(
              locale: Localizations.localeOf(context).languageCode,
              inactiveYesterdays: false,
              margin: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              firstDay: firstDay,
              lastDay: lastDay,
              selectedDay: widget._timerAdjustmentBloc.day,
              onDaySelected: (newDate) {
                widget._timerAdjustmentBloc.add(
                  LoadDayTimerAdjustmentEvent(
                    selectedDay: newDate,
                  ),
                );
              },
              calendarFormat: calendarFormat,
              onChangeFormat: (format) {
                setState(
                  () {
                    calendarFormat = format;
                  },
                );
              },
            ),
            if (widget.isManagerOrAdmin &&
                widget._timerAdjustmentBloc.selectedEmployee != null) ...[
              SelectedEmployeeWidget(
                name: widget._timerAdjustmentBloc.selectedEmployee?.name ?? '',
                canChange: widget._timerAdjustmentBloc.canChangeEmployee,
                onTap: () {
                  widget._navigatorService.pushNamed(
                    route:
                        '/${PontoMobileCollectorRoutes.module}/${TimeAdjustmentMultiRoutes.selectEmployeeFull}',
                    arguments: widget.username,
                  );
                },
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SeniorSpacing.normal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.calendarDays,
                        size: SeniorIconSize.small,
                        color: SeniorColors.secondaryColor600,
                      ),
                      const SizedBox(
                        width: SeniorSpacing.xsmall,
                      ),
                      Expanded(
                        child: SeniorText.labelBold(
                          CollectorLocalizations.of(context).clockingsOfTheDay,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var showDriverInfo =
                              widget._timerAdjustmentBloc.showDriverInfo();
                          widget._showBottomSheetUsecase.call(
                            context: context,
                            content: [
                              ClockingEventInfoWidget(
                                showSynced: !showDriverInfo,
                                showMobile: !showDriverInfo,
                                showPlatform: !showDriverInfo,
                                showOdd: !showDriverInfo,
                                driver: showDriverInfo,                                
                              ),
                            ],
                          );
                        },
                        child: const Icon(
                          FontAwesomeIcons.solidCircleQuestion,
                          size: SeniorIconSize.small,
                          color: SeniorColors.secondaryColor600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SeniorSpacing.xsmall,
                  ),
                  SeniorText.small(
                    CollectorLocalizations.of(context).lastUpdate(
                      DateFormat(
                        DateFormat.YEAR_NUM_MONTH_DAY,
                        CollectorLocalizations.of(context).localeName,
                      ).format(
                        widget._getClockDateTimeUsecase.call(),
                      ),
                      DateFormat(
                        DateFormat.HOUR_MINUTE,
                        CollectorLocalizations.of(context).localeName,
                      ).format(
                        widget._getClockDateTimeUsecase.call(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget._timerAdjustmentBloc.clockingEventsJourneyList.isNotEmpty
                ? ListView.builder(
                    itemCount: widget
                        ._timerAdjustmentBloc.clockingEventsJourneyList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final clkJourney = widget._timerAdjustmentBloc
                          .clockingEventsJourneyList[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: SeniorSpacing.xmedium,
                          top: SeniorSpacing.normal,
                        ),
                        child: TimeAdjustmentWidget(
                          widget._timerAdjustmentBloc,
                          widget._synchronizeClockingEventBloc,
                          widget._utils,
                          widget._showBottomSheetUsecase,
                          dayInfoModel: clkJourney.dayInfoModeltList.first,
                          isCollapsed: false,
                          showEmployeeName: true,
                          isDriversJourneyHistory: widget
                                  ._timerAdjustmentBloc.executionModeEnum
                                  ?.isDriver() ??
                              false,
                          journeyNumber: index + 1,
                          journeyTimeDetailsList:
                              clkJourney.journeyTimeDetailsDto,
                          timelineItems: clkJourney.timelineItems,
                          totalBreakTime: clkJourney.totalBreakTime,
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: SeniorSpacing.xmedium,
                      top: SeniorSpacing.normal,
                    ),
                    child: TimeAdjustmentWidget(
                      widget._timerAdjustmentBloc,
                      widget._synchronizeClockingEventBloc,
                      widget._utils,
                      widget._showBottomSheetUsecase,
                      dayInfoModel: widget._timerAdjustmentBloc.dayInfoModel,
                      isCollapsed: false,
                      showEmployeeName: true,
                      isDriversJourneyHistory: widget
                              ._timerAdjustmentBloc.executionModeEnum
                              ?.isDriver() ??
                          false,
                    ),
                  ),
            Visibility(
              visible: widget._timerAdjustmentBloc.hasOvernight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: buildOvernightEditor(context),
              ),
            ),
            Visibility(
              visible: showAddOvernightButton,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SeniorSpacing.normal,
                ),
                child: SeniorButton(
                  fullWidth: true,
                  outlined: true,
                  icon: FontAwesomeIcons.plus,
                  label: CollectorLocalizations.of(context).addOvernightButton,
                  onPressed: () {
                    widget._timerAdjustmentBloc.add(
                      AddOvernightEvent(),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: SeniorSpacing.normal,
            ),
          ],
        );
      },
    );
  }
}
