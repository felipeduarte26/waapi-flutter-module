import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/components/senior_text/utils/typographies.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/enums/clocking_event_use_enum.dart';
import '../../../../core/domain/input_model/grouped_date_dto.dart';
import '../../../../core/domain/input_model/journey_time_details_dto.dart';
import '../../../../core/domain/input_model/synchronization_result.dart';
import '../../../../core/domain/input_model/timeline_item_dto.dart';
import '../../../../core/infra/utils/enum/drivers_work_status_enum.dart';
import '../../../../core/infra/utils/enum/synchronization_enum.dart';
import '../../../../core/infra/utils/enum/type_journey_time_enum.dart';
import '../../../../core/infra/utils/extension/string_extension.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../../../../core/infra/utils/workday_indicator.dart';
import '../../../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../../../clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_bloc.dart';
import '../../../clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_event.dart';
import '../../../clocking_event/presenter/bloc/synchronize_clocking_event/synchronize_clocking_event_state.dart';
import '../../domain/model/day_info_model.dart';
import '../../domain/model/time_info_model.dart';
import '../bloc/timer_adjustment/timer_adjustment_bloc.dart';
import '../bloc/timer_adjustment/timer_adjustment_event.dart';
import 'clocking_event_status_widget.dart';
import 'drivers_journey_timeline_widget.dart';

class TimeAdjustmentWidget extends StatefulWidget {
  final TimerAdjustmentBloc _timerAdjustmentBloc;
  final IUtils _utils;
  final IShowBottomSheetUsecase _showBottomSheetUsecase;

  final DayInfoModel dayInfoModel;
  final bool isCollapsed;
  final bool showEmployeeName;
  final SynchronizeClockingEventBloc _synchronizeClockingEventBloc;
  final bool _isDriversJourneyHistory;
  final int? journeyNumber;
  final List<JourneyTimeDetailsDto>? journeyTimeDetailsList;
  final List<TimelineItemDto>? timelineItems;
  final DateTime? totalBreakTime;

  const TimeAdjustmentWidget(
    this._timerAdjustmentBloc,
    this._synchronizeClockingEventBloc,
    this._utils,
    this._showBottomSheetUsecase, {
    super.key,
    required this.isCollapsed,
    this.showEmployeeName = false,
    required this.dayInfoModel,
    bool isDriversJourneyHistory = false,
    this.journeyNumber,
    this.journeyTimeDetailsList,
    this.timelineItems,
    this.totalBreakTime,
  }) : _isDriversJourneyHistory = isDriversJourneyHistory;

  @override
  State<TimeAdjustmentWidget> createState() => _TimeAdjustmentWidgetState();
}

class _TimeAdjustmentWidgetState extends State<TimeAdjustmentWidget>
    with SingleTickerProviderStateMixin {
  late WorkdayIndicators _workdayIndicators;
  final ScrollController _controller = ScrollController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    if (widget._synchronizeClockingEventBloc.state
        is SyncClockingEventSyncInProgress) {
      _startAnimationSynchronization();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _workdayIndicators =
        WorkdayIndicators(clockingEvents: widget.dayInfoModel.getDateTimes());
    if (_workdayIndicators.clockingEvents.isNotEmpty &&
        !widget.isCollapsed &&
        !widget._isDriversJourneyHistory) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) {
          var jump = _controller.position.maxScrollExtent;
          if (jump > 0.0) {
            _controller.jumpTo(jump);
          }
        },
      );
    }

    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDark = themeRepository.isDarkTheme();
    final theme = themeRepository.theme;
    bool isOvernight() {
      return widget.dayInfoModel.isOvernight ?? false;
    }

    return Opacity(
      opacity: (widget.dayInfoModel.times.isEmpty) ? 0.64 : 1.00,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SeniorSpacing.normal,
        ),
        child: !widget.isCollapsed &&
                widget._isDriversJourneyHistory &&
                isOvernight()
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      key: const Key('daily cards'),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: (widget.dayInfoModel.getDateTimes().last.day -
                              widget.dayInfoModel.getDateTimes().first.day) +
                          1,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 15,
                      ),
                      itemBuilder: (context, index) => SeniorElevatedElement(
                        elevation: SeniorElevations.dp01,
                        borderRadius: 6,
                        child: Container(
                          color: isDark
                              ? theme.cardTheme!.style!.backgroundColor
                              : SeniorColors.grayscale0,
                          child: Column(
                            children: [
                              buildDaySelectHeader(context),
                              buildClockingEventsRow(
                                context,
                                isCollapsed: widget.isCollapsed,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SeniorElevatedElement(
                      elevation: SeniorElevations.dp01,
                      borderRadius: 6,
                      child: Container(
                        color: isDark
                            ? theme.cardTheme!.style!.backgroundColor
                            : SeniorColors.grayscale0,
                        child: Column(
                          children: [
                            buildTotalClockingEvents(context),
                            if (widget.dayInfoModel.times.isNotEmpty)
                              buildMoreDetailsButton(context),
                            buildNotificationArea(context),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildOvernightEditor(context),
                  ],
                ),
              )
            : Column(
                children: [
                  SeniorElevatedElement(
                    elevation: SeniorElevations.dp01,
                    borderRadius: 6,
                    child: Container(
                      color: isDark
                          ? theme.cardTheme!.style!.backgroundColor
                          : SeniorColors.grayscale0,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildDaySelectHeader(context),
                            Padding(
                              padding: EdgeInsets.only(
                                left: widget.isCollapsed
                                    ? SeniorSpacing.big + SeniorSpacing.xxsmall
                                    : 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.isCollapsed &&
                                      widget.showEmployeeName &&
                                      widget.dayInfoModel.employee != null) ...[
                                    SeniorText.small(
                                      CollectorLocalizations.of(context)
                                          .cardReceiptEmployeeName,
                                      color: SeniorColors.neutralColor500,
                                      darkColor: SeniorColors.neutralColor400,
                                    ),
                                    SeniorText.small(
                                      widget.dayInfoModel.employee?.name ?? '',
                                      textProperties: const TextProperties(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SeniorSpacing.xxsmall,
                                    ),
                                  ],
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildClockingEventsRow(
                                          context,
                                          isCollapsed: widget.isCollapsed,
                                        ),
                                      ),
                                      if (widget.isCollapsed)
                                        buildStatusClockingEvent(context),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (!widget.isCollapsed) ...[
                              buildTotalClockingEvents(context),
                              if (widget._isDriversJourneyHistory &&
                                  widget.dayInfoModel.times.isNotEmpty)
                                buildMoreDetailsButton(context),
                              buildNotificationArea(context),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildStatusClockingEvent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: SeniorSpacing.xxsmall,
        right: SeniorSpacing.xsmall,
      ),
      child: Row(
        children: [
          widget.dayInfoModel.times.isNotEmpty
              ? ClockingEventStatusWidget(
                  isOdd: widget.dayInfoModel.isOdd,
                  isRemoteness: widget.dayInfoModel.isRemoteness,
                  isSynchronized: widget.dayInfoModel.isSynchronized,
                  isOvernight: widget.dayInfoModel.isOvernight ?? false,
                )
              : ClockingEventStatusWidget(
                  isOdd: false,
                  isRemoteness: false,
                  isSynchronized: true,
                  isOvernight: widget.dayInfoModel.isOvernight ?? false,
                ),
        ],
      ),
    );
  }

  Widget buildDaySelectHeader(
    BuildContext context, {
    bool isOvernight = false,
  }) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDark = themeRepository.isDarkTheme();
    final isCustom = themeRepository.isCustomTheme();

    return Padding(
      padding: const EdgeInsets.only(
        left: SeniorSpacing.small,
        right: SeniorSpacing.small,
        top: SeniorSpacing.small,
        bottom: SeniorSpacing.xxsmall,
      ),
      child: widget.isCollapsed
          ? Row(
              children: [
                Icon(
                  isOvernight
                      ? FontAwesomeIcons.solidMoon
                      : FontAwesomeIcons.calendarDay,
                  color: isCustom
                      ? themeRepository.theme.primaryColor
                      : SeniorColors.primaryColor400,
                  size: SeniorIconSize.small,
                ),
                const SizedBox(
                  width: SeniorSpacing.xsmall,
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SeniorText.labelBold(
                        DateFormat(
                          DateFormat.YEAR_NUM_MONTH_DAY,
                          CollectorLocalizations.of(context).localeName,
                        ).format(widget.dayInfoModel.day),
                        color: SeniorColors.neutralColor800,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(SeniorSpacing.xsmall),
                        child: Icon(
                          FontAwesomeIcons.solidCircle,
                          color: SeniorColors.secondaryColor600,
                          size: 4,
                        ),
                      ),
                      Expanded(
                        child: SeniorText.small(
                          DateFormat.EEEE(
                            CollectorLocalizations.of(context).localeName,
                          ).format(widget.dayInfoModel.day).capitalize(),
                          textProperties: const TextProperties(
                            overflow: TextOverflow.ellipsis,
                          ),
                          color: SeniorColors.neutralColor700,
                        ),
                      ),
                      if (isOvernight)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SeniorSpacing.normal,
                          ),
                          child: SeniorBadge(
                            backgroundColor: isDark
                                ? SeniorColors.secondaryColor
                                : SeniorColors.grayscale20,
                            fontColor: isDark
                                ? SeniorColors.pureWhite
                                : SeniorColors.pureBlack,
                            label: CollectorLocalizations.of(context).overnight,
                          ),
                        ),
                    ],
                  ),
                ),
                if (isOvernight)
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      FontAwesomeIcons.pen,
                      color: SeniorColors.secondaryColor600,
                      size: SeniorIconSize.small,
                    ),
                  ),
              ],
            )
          : InformationDaysJourney(
              dayInfoModel: widget.dayInfoModel,
              journeyNumber: widget.journeyNumber ?? 0,
            ),
    );
  }

  Widget buildClockingEventsRow(
    BuildContext context, {
    required bool isCollapsed,
  }) {
    if (isCollapsed) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SeniorText.small(
                CollectorLocalizations.of(context).clockingEvents,
                color: SeniorColors.neutralColor500,
                darkColor: SeniorColors.neutralColor400,
              ),
              if (widget.dayInfoModel.times.isNotEmpty)
                SeniorText.smallBold(
                  ' (${widget.dayInfoModel.times.length})',
                  color: SeniorColors.neutralColor500,
                  darkColor: SeniorColors.neutralColor400,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.xsmall,
            ),
            child: widget.dayInfoModel.times.isEmpty
                ? SeniorText.small(
                    CollectorLocalizations.of(context).withoutClockingEvents,
                    color: SeniorColors.neutralColor500,
                    darkColor: SeniorColors.neutralColor400,
                  )
                : Text.rich(
                    TextSpan(
                      children: List.generate(
                        widget.dayInfoModel.times.length,
                        (index) {
                          final timeInfoModel =
                              widget.dayInfoModel.times[index];

                          final hasSeparator =
                              index < (widget.dayInfoModel.times.length - 1);
                          var separator = '|';

                          if (hasSeparator) {
                            final dateTimes =
                                widget.dayInfoModel.getDateTimes();
                            final nextDatetime = dateTimes[index + 1];
                            final currentDatetime = dateTimes[index];

                            if (currentDatetime.day < nextDatetime.day) {
                              separator = '•';
                            }
                          }

                          final formatedTime = DateFormat(
                            DateFormat.HOUR_MINUTE,
                            CollectorLocalizations.of(context).localeName,
                          ).format(
                            timeInfoModel.dateTime,
                          );

                          return TextSpan(
                            children: [
                              TextSpan(
                                text: formatedTime,
                                style: TextStyle(
                                  fontWeight: timeInfoModel.isBold
                                      ? FontWeight.bold
                                      : null,
                                ),
                              ),
                              if (hasSeparator)
                                TextSpan(
                                  text: separator,
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    style: getTextStyle(
                      Typographies.small,
                      false,
                    ).copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          ),
        ],
      );
    }

    List<GroupedDateDto> groupedDatesList =
        _groupDateTimesByDay(widget.dayInfoModel.getDateTimes());
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          shrinkWrap: true,
          itemCount: groupedDatesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                left: SeniorSpacing.small,
                right: SeniorSpacing.small,
                top: SeniorSpacing.small,
                bottom: SeniorSpacing.xxsmall,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.calendarDay,
                        color: SeniorColors.primaryColor400,
                        size: SeniorIconSize.small,
                      ),
                      const SizedBox(
                        width: SeniorSpacing.small,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SeniorText.labelBold(
                            DateFormat(
                              DateFormat.YEAR_NUM_MONTH_DAY,
                              CollectorLocalizations.of(context).localeName,
                            ).format(groupedDatesList[index].data),
                            color: SeniorColors.neutralColor800,
                          ),
                          const SizedBox(
                            width: SeniorSpacing.xsmall,
                          ),
                          SeniorText.small(
                            DateFormat.EEEE(
                              CollectorLocalizations.of(context).localeName,
                            ).format(groupedDatesList[index].data).capitalize(),
                            textProperties: const TextProperties(
                              overflow: TextOverflow.ellipsis,
                            ),
                            color: SeniorColors.neutralColor700,
                          ),
                        ],
                      ),
                    ],
                  ),
                  LimitedBox(
                    maxHeight: 125,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: groupedDatesList[index].dateTimes.length,
                      itemBuilder: (context, i) {
                        return clockingEventRow(
                          i,
                          groupedDatesList[index].dateTimes[i],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget clockingEventRow(int index, DateTime clockingEventTime) {
    TimeInfoModel timeInfoModel = widget.dayInfoModel.times[index];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.xxxsmall,
      ),
      child: Row(
        key: const Key('clockingRow'),
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: SeniorSpacing.normal,
          ),
          SizedBox(
            width: SeniorSpacing.normal,
            child: SeniorText.smallBold(
              key: const Key('Index'),
              (index + 1).toString(),
              color: SeniorColors.neutralColor400,
            ),
          ),
          const SizedBox(
            width: SeniorSpacing.small,
          ),
          timeInfoModel.isBold
              ? SeniorText.labelBold(
                  key: const Key('Hour'),
                  _getFormattedTime(
                    clockingEventTime,
                  ),
                  color: SeniorColors.neutralColor800,
                )
              : SeniorText.label(
                  key: const Key('Hour'),
                  _getFormattedTime(
                    clockingEventTime,
                  ),
                  color: SeniorColors.neutralColor800,
                ),
          const SizedBox(
            width: SeniorSpacing.xxsmall,
          ),
          const Padding(
            padding: EdgeInsets.all(
              SeniorSpacing.xxsmall,
            ),
            child: Icon(
              FontAwesomeIcons.mobileScreenButton,
              color: SeniorColors.neutralColor600,
              size: 14,
            ),
          ),
          if (widget._isDriversJourneyHistory)
            Padding(
              padding: const EdgeInsets.only(
                left: SeniorSpacing.xsmall,
              ),
              child: Icon(
                _getWorkStatusFromTimeInfoModel(timeInfoModel).icon,
                color: SeniorColors.neutralColor600,
                size: 14,
              ),
            ),
          if (timeInfoModel.isManual)
            const Padding(
              padding: EdgeInsets.only(
                left: SeniorSpacing.xsmall,
              ),
              child: Icon(
                FontAwesomeIcons.squarePen,
                color: SeniorColors.neutralColor600,
                size: 14,
              ),
            ),
          if (!timeInfoModel.isSynchronized)
            const Padding(
              padding: EdgeInsets.only(
                left: SeniorSpacing.xsmall,
              ),
              child: Icon(
                FontAwesomeIcons.rotate,
                color: SeniorColors.neutralColor600,
                size: 14,
              ),
            ),
          const Spacer(),
          if (timeInfoModel.isManual)
            const Padding(
              padding: EdgeInsets.only(
                right: SeniorSpacing.xmedium,
              ),
              child: Icon(
                FontAwesomeIcons.pen,
                color: SeniorColors.neutralColor600,
                size: 14,
              ),
            ),
          if (!timeInfoModel.isManual)
            Padding(
              padding: const EdgeInsets.only(
                right: SeniorSpacing.xmedium,
              ),
              child: InkWell(
                onTap: () async {
                  widget._timerAdjustmentBloc.add(
                    ShowReceiptTimerAdjustmentEvent(
                      clockingEventId: timeInfoModel.clockingEventId,
                      locale: CollectorLocalizations.of(context).localeName,
                    ),
                  );
                },
                child: const Icon(
                  FontAwesomeIcons.receipt,
                  color: SeniorColors.neutralColor600,
                  size: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getFormattedTime(DateTime date) {
    return widget._utils.formatTime(
      dateTime: date,
      locale: CollectorLocalizations.of(context).localeName,
    );
  }

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SeniorSnackBar.success(
        message: message,
      ),
    );
  }

  void _showWarningSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SeniorSnackBar.warning(
        message: message,
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SeniorSnackBar.error(
        message: message,
      ),
    );
  }

  void _startAnimationSynchronization() {
    _animationController.repeat(period: const Duration(seconds: 1));
  }

  void _stopAnimationSynchronization() {
    _animationController.stop();
  }

  String _getMessageFromSynchronizationResult(
    SynchronizationMessage syncMessage,
  ) {
    String msg;

    switch (syncMessage) {
      case SynchronizationMessage.syncClockingEventSyncSuccess:
        msg = CollectorLocalizations.of(context).syncClockingEventSyncSuccess;
        break;
      case SynchronizationMessage.syncClockingEventSyncInternetUnavailable:
        msg = CollectorLocalizations.of(context)
            .syncClockingEventSyncInternetUnavailable;
        break;
      case SynchronizationMessage.syncClockingEventSyncFailure:
        msg = CollectorLocalizations.of(context).syncClockingEventSyncFailure;
        break;
      default:
        throw Exception(
          'SynchronizationMessage not handled: $syncMessage.',
        );
    }

    return msg;
  }

  void showSynchronizationResultMessage(
    SynchronizationResult synchronizationResult,
  ) {
    if (synchronizationResult.status == SynchronizationStatus.success) {
      _showSuccessSnackbar(
        context,
        _getMessageFromSynchronizationResult(synchronizationResult.message),
      );
    } else if (synchronizationResult.status == SynchronizationStatus.warning) {
      _showWarningSnackbar(
        context,
        _getMessageFromSynchronizationResult(synchronizationResult.message),
      );
    } else if (synchronizationResult.status == SynchronizationStatus.error) {
      _showErrorSnackbar(
        context,
        _getMessageFromSynchronizationResult(synchronizationResult.message),
      );
    }
  }

  void listenerSynchronizeClockingEventBloc(context, state) {
    if (state is SyncClockingEventInitial) {
      log('## SyncClockingEventInitial emited. ##');
    } else if (state is SyncClockingEventSyncInProgress) {
      _startAnimationSynchronization();
    } else if (state is SyncClockingEventSyncSuccess ||
        state is SyncClockingEventSyncFailure) {
      _stopAnimationSynchronization();
      showSynchronizationResultMessage(state.synchronizationResult);
    }
  }

  Widget buildNotificationArea(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return BlocListener<SynchronizeClockingEventBloc, SyncClockingEventState>(
      bloc: widget._synchronizeClockingEventBloc,
      listener: listenerSynchronizeClockingEventBloc,
      child: Semantics(
        label: 'botao-sincronizar-marcacoes',
        child: InkWell(
          key: const Key('botao-sincronizar-marcacoes'),
          onTap: () {
            widget._synchronizeClockingEventBloc
                .add(SyncClockingEventStarted());
          },
          child: Container(
            color: isDark
                ? SeniorColors.manchesterColorBlue800
                : SeniorColors.manchesterColorBlue100,
            height: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(SeniorSpacing.xxxsmall),
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0)
                        .animate(_animationController),
                    child: Icon(
                      FontAwesomeIcons.arrowsRotate,
                      color: isDark
                          ? SeniorColors.manchesterColorBlue500
                          : SeniorColors.manchesterColorBlue600,
                      size: 13.33,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTotalClockingEvents(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    JourneyTimeDetailsDto? totalWorkingTime;

    if (widget.journeyTimeDetailsList != null) {
      totalWorkingTime = widget._utils.getFirstEventByType(
        type: TypeJourneyTimeEnum.working,
        journeyTimeDetailsList: widget.journeyTimeDetailsList!,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(SeniorSpacing.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: SeniorSpacing.xxsmall),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SeniorText.small(
                      CollectorLocalizations.of(context).hoursWorked,
                      color: SeniorColors.neutralColor700,
                    ),
                    if (widget._isDriversJourneyHistory)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: GestureDetector(
                          onTap: () async =>
                              await widget._showBottomSheetUsecase.call(
                            context: context,
                            content: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SeniorText.labelBold(
                                  CollectorLocalizations.of(context)
                                      .hoursWorked,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SeniorText.body(
                                CollectorLocalizations.of(context)
                                    .hoursWorkedInfo,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SeniorButton.ghost(
                                fullWidth: true,
                                label: CollectorLocalizations.of(context)
                                    .infoUnderstoodButton,
                                onPressed: () => Navigator.pop(context),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                          child: Icon(
                            FontAwesomeIcons.circleInfo,
                            color: isDark ? SeniorColors.pureWhite : null,
                            size: SeniorIconSize.xsmall,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: SeniorSpacing.xxsmall),
                Row(
                  children: [
                    SeniorText.small(
                      CollectorLocalizations.of(context).timeInBreaks,
                      color: SeniorColors.neutralColor700,
                    ),
                    if (widget._isDriversJourneyHistory)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: GestureDetector(
                          onTap: () async =>
                              await widget._showBottomSheetUsecase.call(
                            context: context,
                            content: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SeniorText.labelBold(
                                  CollectorLocalizations.of(context).breaks,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SeniorText.body(
                                CollectorLocalizations.of(context).breaksInfo,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SeniorButton.ghost(
                                fullWidth: true,
                                label: CollectorLocalizations.of(context)
                                    .infoUnderstoodButton,
                                onPressed: () => Navigator.pop(context),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                          child: Icon(
                            FontAwesomeIcons.circleInfo,
                            color: isDark ? SeniorColors.pureWhite : null,
                            size: SeniorIconSize.xsmall,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SeniorText.smallBold(
                totalWorkingTime != null
                    ? '${totalWorkingTime.time.hour.toString().padLeft(2, '0')}:${totalWorkingTime.time.minute.toString().padLeft(2, '0')}'
                    : '00:00',
                color: SeniorColors.neutralColor800,
              ),
              const SizedBox(height: SeniorSpacing.xxsmall),
              SeniorText.smallBold(
                widget.totalBreakTime != null
                    ? '${widget.totalBreakTime!.hour.toString().padLeft(2, '0')}:${widget.totalBreakTime!.minute.toString().padLeft(2, '0')}'
                    : '00:00',
                color: SeniorColors.neutralColor800,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMoreDetailsButton(BuildContext context) {
    return SeniorButton.ghost(
      fullWidth: true,
      label: CollectorLocalizations.of(context).moreDetails,
      onPressed: () async => await widget._showBottomSheetUsecase.call(
        context: context,
        content: [
          DriversJourneyTimelineWidget(
            utils: widget._utils,
            showBottomSheetUsecase: widget._showBottomSheetUsecase,
            timelineItems: widget.timelineItems!,
            journeyTimeDetailsList: widget.journeyTimeDetailsList!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: SeniorButton(
              fullWidth: true,
              outlined: true,
              label: CollectorLocalizations.of(context).close,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
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
}

class InformationDaysJourney extends StatelessWidget {
  final DayInfoModel dayInfoModel;
  final int journeyNumber;

  const InformationDaysJourney({
    super.key,
    required this.dayInfoModel,
    required this.journeyNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: journeyNumber > 0,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.truck,
                    color: SeniorColors.primaryColor400,
                    size: SeniorIconSize.small,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.small,
                  ),
                  SeniorText.labelBold(
                    '${CollectorLocalizations.of(context).journey} $journeyNumber',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<GroupedDateDto> _groupDateTimesByDay(List<DateTime> dateTimes) {
  Map<DateTime, List<DateTime>> grouped = {};

  for (DateTime dt in dateTimes) {
    DateTime normalizedDate = DateTime(dt.year, dt.month, dt.day);

    if (!grouped.containsKey(normalizedDate)) {
      grouped[normalizedDate] = [];
    }

    grouped[normalizedDate]!.add(dt);
  }

  List<GroupedDateDto> groupedList = grouped.entries.map((entry) {
    return GroupedDateDto(data: entry.key, dateTimes: entry.value);
  }).toList();

  return groupedList;
}

DriversWorkStatusEnum _getWorkStatusFromTimeInfoModel(
  TimeInfoModel timeInfoModel,
) {
  final use = timeInfoModel.use;
  final isMealBreak = timeInfoModel.isMealBreak;

  if (use == ClockingEventUseEnum.driving.codigo) {
    return DriversWorkStatusEnum.driving;
  }

  if (use == ClockingEventUseEnum.clockingEvent.codigo) {
    if (isMealBreak) {
      return DriversWorkStatusEnum.foodTime;
    } else {
      return DriversWorkStatusEnum.notStarted;
    }
  }

  if (use == ClockingEventUseEnum.waiting.codigo) {
    return DriversWorkStatusEnum.waiting;
  }

  if (use == ClockingEventUseEnum.mandatoryBreak.codigo) {
    return DriversWorkStatusEnum.mandatoryBreak;
  }

  if (use == ClockingEventUseEnum.paidBreak.codigo) {
    return DriversWorkStatusEnum.paidBreak;
  }

  return DriversWorkStatusEnum.notStarted;
}
