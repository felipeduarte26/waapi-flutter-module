import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/entities/journey_entity.dart';
import '../../../../core/domain/enums/clocking_event_use_enum.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/infra/utils/extension/string_extension.dart';
import '../../../../core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import '../../../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../../../clocking_event/presenter/bloc/timer/timer_state.dart';

class DriversJourneyScreen extends StatefulWidget {
  final RegisterClockingEventBloc _registerClockingEventBloc;
  final TimerBloc _timerBloc;
  final WorkIndicatorCubit _workIndicatorCubit;
  final DriversJourneyBloc _driversJourneyBloc;
  final IShowBottomSheetUsecase _showBottomSheetUsecase;
  final IUtils _utils;
  final NavigatorService _navigatorService;
  final bool showNotificationButton;
  final ClockingEventBloc _clockingEventBloc;
  final ConfirmationSnackbarWidget _confirmationSnackbarWidget;
  final FacialRegistrationMessageWidget _facialRegistrationMessageWidget;

  const DriversJourneyScreen({
    super.key,
    required RegisterClockingEventBloc registerClockingEventBloc,
    required TimerBloc timerBloc,
    required WorkIndicatorCubit workIndicatorCubit,
    required DriversJourneyBloc driversJourneyBloc,
    required IShowBottomSheetUsecase showBottomSheetUsecase,
    required IUtils utils,
    required NavigatorService navigatorService,
    required ClockingEventBloc clockingEventBloc,
    required ConfirmationSnackbarWidget confirmationSnackbarWidget,
    required FacialRegistrationMessageWidget facialRegistrationMessageWidget,
    this.showNotificationButton = false,
  })  : _timerBloc = timerBloc,
        _workIndicatorCubit = workIndicatorCubit,
        _registerClockingEventBloc = registerClockingEventBloc,
        _driversJourneyBloc = driversJourneyBloc,
        _showBottomSheetUsecase = showBottomSheetUsecase,
        _utils = utils,
        _navigatorService = navigatorService,
        _clockingEventBloc = clockingEventBloc,
        _confirmationSnackbarWidget = confirmationSnackbarWidget,
        _facialRegistrationMessageWidget = facialRegistrationMessageWidget;

  @override
  State<DriversJourneyScreen> createState() => _DriversJourneyScreenState();
}

class _DriversJourneyScreenState extends State<DriversJourneyScreen> {
  @override
  void initState() {
    super.initState();

    widget._registerClockingEventBloc.setContext(context: context);
    widget._driversJourneyBloc.add(LoadJourneyEvent());
  }

  void onJourneyButtonClick(DriversJourneyEvent event) {
    widget._driversJourneyBloc.add(event);
  }

  void onStatusActionCardPressed(DriversJourneyEvent driversJourneyEvent) {
    var blocValue = widget._driversJourneyBloc;
    var eventCurrent = blocValue.currentEvent;

    widget._driversJourneyBloc.onSaveCurrentEvent({
      'current': driversJourneyEvent,
      'previous': eventCurrent == null ? blocValue.driverEventInExecution! : eventCurrent['current']!,
    });
    widget._driversJourneyBloc.add(driversJourneyEvent);
  }

  List<Widget> getButtons(blockButtons, DriversWorkStatusEnum status) {
    final buttons = [
      if (widget._driversJourneyBloc.showDrivingButton)
        StatusActionCardWidget(
          actionType: DriversWorkStatusActionEnum.driving,
          driversJourneyEvent: StartDrivingEvent(),
          onPressed: onStatusActionCardPressed,
          disabled: blockButtons || status == DriversWorkStatusEnum.driving,
        ),
      if (widget._driversJourneyBloc.showMandatoryBreakButton)
        StatusActionCardWidget(
          actionType: DriversWorkStatusActionEnum.mandatoryBreak,
          driversJourneyEvent: StartMandatoryBreakEvent(),
          onPressed: onStatusActionCardPressed,
          disabled: blockButtons || status == DriversWorkStatusEnum.mandatoryBreak,
        ),
      if (widget._driversJourneyBloc.showWaitingButton)
        StatusActionCardWidget(
          actionType: DriversWorkStatusActionEnum.waiting,
          driversJourneyEvent: StartWaitingBreakEvent(),
          onPressed: onStatusActionCardPressed,
          disabled: blockButtons || status == DriversWorkStatusEnum.waiting,
        ),
      StatusActionCardWidget(
        actionType: DriversWorkStatusActionEnum.foodTime,
        driversJourneyEvent: StartLunchEvent(),
        onPressed: onStatusActionCardPressed,
        disabled: blockButtons || status == DriversWorkStatusEnum.foodTime,
      ),
    ];

    return buttons;
  }

  String getWorkStatusLabel(DriversWorkStatusEnum status) {
    final collectorLocalizations = CollectorLocalizations.of(context);

    return switch (status) {
      DriversWorkStatusEnum.driving => collectorLocalizations.drive,
      DriversWorkStatusEnum.mandatoryBreak => collectorLocalizations.mandatoryBreak,
      DriversWorkStatusEnum.foodTime => collectorLocalizations.foodTime,
      DriversWorkStatusEnum.waiting => collectorLocalizations.waiting,
      _ => '',
    };
  }

  Timer timerToClosePopUp(BuildContext context) {
    return Timer(
      const Duration(
        seconds: 10,
      ),
      () {
        if (context.mounted) {
          Navigator.pop(context);
          widget._driversJourneyBloc.add(DoNothing());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final collectorLocalizations = CollectorLocalizations.of(context);
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return Scaffold(
      body: Stack(
        children: [
          BlocListener<RegisterClockingEventBloc, RegisterClockingState>(
            bloc: widget._registerClockingEventBloc,
            listener: (context, state) {
              if (state is SuccessRegisterState && state.clockingEvent.use == ClockingEventUseEnum.clockingEvent.codigo.toString()) {
                widget._facialRegistrationMessageWidget.show(clockingEventUse: state.clockingEvent.use);
                widget._confirmationSnackbarWidget.show(
                  clockingEvent: state.clockingEvent,
                  duration: const Duration(seconds: 3),
                );
              }
            },
            child: SeniorColorfulHeaderStructure(
              leading: IconButton(
                icon: Icon(
                  FontAwesomeIcons.angleLeft,
                  color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
                ),
                onPressed: () {
                  widget._clockingEventBloc.add(LoadClockingEventEvent());
                  widget._navigatorService.pop();
                },
              ),
              hasTopPadding: false,
              title: SeniorText.label(
                collectorLocalizations.driversJourney,
                color: SeniorColors.pureWhite,
                darkColor: SeniorColors.grayscale5,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.solidCircleQuestion,
                    size: SeniorIconSize.small,
                    color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
                  ),
                  onPressed: () async => await widget._showBottomSheetUsecase.call(
                    context: context,
                    content: [
                      const StatusExplanationWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: SeniorSpacing.normal,
                        ),
                        child: SeniorButton(
                          fullWidth: true,
                          outlined: true,
                          label: collectorLocalizations.close,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.showNotificationButton,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.solidBell,
                      size: SeniorIconSize.small,
                      color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
              body: BlocConsumer<DriversJourneyBloc, DriversJourneyState>(
                bloc: widget._driversJourneyBloc,
                listener: (context, state) async {
                  if (state is CallingModalToStartJourneyFromAction) {
                    final actionLabel = getWorkStatusLabel(
                      state.action.status,
                    ).toLowerCase();

                    await showDialog(
                      useRootNavigator: false,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            closable: true,
                            onClose: () {
                              widget._driversJourneyBloc.add(
                                DoNothing(),
                              );
                            },
                            title: collectorLocalizations.wantToStartJourney,
                            content: collectorLocalizations.startJourneyBeforeStartAction(
                              actionLabel,
                            ),
                            otherAction: SeniorModalAction(
                              label: collectorLocalizations.yes,
                              action: () {
                                var confirmStartJourneyBeforeAction = ConfirmStartJourneyBeforeAction(
                                  action: state.action,
                                );
                                widget._driversJourneyBloc.add(confirmStartJourneyBeforeAction);
                                Navigator.pop(context);
                              },
                            ),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.no,
                              action: () {
                                var startActionWithoutJourney = StartActionWithoutJourney(
                                  action: state.action,
                                );
                                widget._driversJourneyBloc.add(startActionWithoutJourney);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is JourneyStartedBeforeAction) {
                    await showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        final timer = timerToClosePopUp(context);
                        final actionLabel = getWorkStatusLabel(
                          state.action.status,
                        ).toLowerCase();

                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            title: collectorLocalizations.info,
                            content: collectorLocalizations
                                .journeyStartedBeforeAction(
                                  actionLabel,
                                )
                                .capitalize(),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.ok,
                              action: () {
                                timer.cancel();
                                Navigator.pop(context);
                                widget._driversJourneyBloc.add(DoNothing());
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is ActionStartedWithoutJourney) {
                    await showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        final timer = timerToClosePopUp(context);
                        final actionLabel = getWorkStatusLabel(
                          state.action.status,
                        ).toLowerCase();

                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            title: collectorLocalizations.info,
                            content: collectorLocalizations
                                .actionStartedWithoutJourney(
                                  actionLabel,
                                )
                                .capitalize(),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.ok,
                              action: () {
                                timer.cancel();
                                Navigator.pop(context);
                                widget._driversJourneyBloc.add(DoNothing());
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is CallingModalToClosePrevious) {
                    await showDialog(
                      useRootNavigator: false,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        final currentActionLabel = getWorkStatusLabel(
                          state.toClose!.status,
                        ).toLowerCase();
                        final nextActionLabel = getWorkStatusLabel(
                          state.actual!.status,
                        ).toLowerCase();

                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            closable: true,
                            onClose: () {
                              widget._driversJourneyBloc.add(
                                DoNothing(),
                              );
                            },
                            title: collectorLocalizations.continueRegistration,
                            content: collectorLocalizations.finishCurrentActionBeforeStartNextAction(
                              currentActionLabel,
                              nextActionLabel,
                            ),
                            otherAction: SeniorModalAction(
                              label: collectorLocalizations.yes,
                              action: () {
                                var confirmClosePreviousAction = ConfirmClosePreviousAction(
                                  [
                                    state.toClose!,
                                    state.actual!,
                                  ],
                                );
                                widget._driversJourneyBloc.add(confirmClosePreviousAction);
                                Navigator.pop(context);
                              },
                            ),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.no,
                              action: () {
                                var confirmClosePreviousAction = ConfirmClosePreviousAction(
                                  [state.actual!],
                                );
                                widget._driversJourneyBloc.add(confirmClosePreviousAction);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is NewActionStartedAndPreviousDoesNot) {
                    await showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        final timer = timerToClosePopUp(context);

                        final newActionLabel = getWorkStatusLabel(
                          state.newAction.status,
                        ).toLowerCase();
                        final previousActionLabel = getWorkStatusLabel(
                          state.previousAction.status,
                        ).toLowerCase();

                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            title: collectorLocalizations.info,
                            content: collectorLocalizations
                                .newActionStartedAndPreviousDoesNot(
                                  newActionLabel,
                                  previousActionLabel,
                                )
                                .capitalize(),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.ok,
                              action: () {
                                timer.cancel();
                                Navigator.pop(context);
                                widget._driversJourneyBloc.add(DoNothing());
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is PreviousActionFinishedAndNewStarted) {
                    await showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        final timer = timerToClosePopUp(context);

                        final previousActionLabel = getWorkStatusLabel(
                          state.previousAction.status,
                        ).toLowerCase();
                        final newActionLabel = getWorkStatusLabel(
                          state.newAction.status,
                        ).toLowerCase();

                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            title: collectorLocalizations.info,
                            content: collectorLocalizations
                                .previousActionFinishedAndNewStarted(
                                  previousActionLabel,
                                  newActionLabel,
                                )
                                .capitalize(),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.ok,
                              action: () {
                                timer.cancel();
                                Navigator.pop(context);
                                widget._driversJourneyBloc.add(DoNothing());
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is StartNewDriverJourney) {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => PopScope(
                        canPop: false,
                        child: SeniorModal(
                          title: collectorLocalizations.sureStartNewJourney,
                          content: collectorLocalizations.previousJourneyStillRunning,
                          otherAction: SeniorModalAction(
                            label: collectorLocalizations.yes,
                            action: () {
                              widget._driversJourneyBloc.add(
                                state.toExecute!,
                              );
                              Navigator.pop(context);
                            },
                          ),
                          defaultAction: SeniorModalAction(
                            label: collectorLocalizations.no,
                            action: () {
                              widget._driversJourneyBloc.add(DoNothing());
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    );
                    return;
                  }

                  if (state is CallingModalToCloseActionBeforeEndJourney) {
                    await showDialog(
                      useRootNavigator: false,
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        final actionLabel = getWorkStatusLabel(
                          state.action.status,
                        ).toLowerCase();

                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            closable: true,
                            onClose: () {
                              widget._driversJourneyBloc.add(
                                DoNothing(),
                              );
                            },
                            title: collectorLocalizations.continueRegistration,
                            content: collectorLocalizations.closeActionBeforeEndJourney(
                              actionLabel,
                            ),
                            otherAction: SeniorModalAction(
                              label: collectorLocalizations.yes,
                              action: () {
                                var confirmCloseActionBeforeEndJourney = ConfirmCloseActionBeforeEndJourney(
                                  action: state.action,
                                );
                                widget._driversJourneyBloc.add(confirmCloseActionBeforeEndJourney);
                                Navigator.pop(context);
                              },
                            ),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.no,
                              action: () {
                                var finishJourneyAndPreviousActionDoesNot = FinishJourneyAndPreviousActionDoesNot(
                                  action: state.action,
                                );
                                widget._driversJourneyBloc.add(finishJourneyAndPreviousActionDoesNot);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is PreviousActionClosedAndJourneyEnded) {
                    await showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        final timer = timerToClosePopUp(context);
                        final actionLabel = getWorkStatusLabel(
                          state.action.status,
                        ).toLowerCase();

                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            title: collectorLocalizations.info,
                            content: collectorLocalizations
                                .previousActionClosedAndJourneyEnded(
                                  actionLabel,
                                )
                                .capitalize(),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.ok,
                              action: () {
                                timer.cancel();
                                Navigator.pop(context);
                                widget._driversJourneyBloc.add(DoNothing());
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is JourneyFinishedAndPreviousActionDoesNot) {
                    await showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        final timer = timerToClosePopUp(context);
                        final actionLabel = getWorkStatusLabel(
                          state.action.status,
                        ).toLowerCase();

                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            title: collectorLocalizations.info,
                            content: collectorLocalizations
                                .journeyFinishedAndPreviousActionDoesNot(
                                  actionLabel,
                                )
                                .capitalize(),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.ok,
                              action: () {
                                timer.cancel();
                                Navigator.pop(context);
                                widget._driversJourneyBloc.add(DoNothing());
                              },
                            ),
                          ),
                        );
                      },
                    );
                    return;
                  }

                  if (state is CallingOvernight) {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return PopScope(
                          canPop: false,
                          child: SeniorModal(
                            closable: true,
                            onClose: () {
                              widget._driversJourneyBloc.add(
                                DoNothing(),
                              );
                            },
                            title: collectorLocalizations.wantRegisterOvernight,
                            content: collectorLocalizations.reportOvernightAfterJourney,
                            otherAction: SeniorModalAction(
                              label: collectorLocalizations.registerOvernight,
                              action: () {
                                widget._driversJourneyBloc.add(
                                  EndJourneyEvent(
                                    doClose: true,
                                    withOvernight: true,
                                  ),
                                );

                                Navigator.pop(context);
                              },
                            ),
                            defaultAction: SeniorModalAction(
                              label: collectorLocalizations.finishJourney,
                              action: () {
                                widget._driversJourneyBloc.add(
                                  EndJourneyEvent(
                                    doClose: true,
                                    withOvernight: false,
                                  ),
                                );

                                Navigator.pop(context);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  var totalBreaks = widget._driversJourneyBloc.totalBreaks;
                  var currentJourney = widget._driversJourneyBloc.currentJourney;
                  var blockButtons = false;
                  var totalTimeSinceLastJourneyUseCase = widget._driversJourneyBloc.totalTimeSinceLastJourneyUseCase;

                  var workStatus = JourneyInExecution().status;
                  DriversJourneyEvent eventForButton = StartJourneyEvent();
                  var dateTimeOfLastStatusStarted = DateTime.now();
                  var startClock = false;

                  if (state is InitialDriversJourneyState) {
                    return const LoadingWidget(
                      bottomLabel: '',
                    );
                  }

                  if (state is ErrorDriversJourneyState) {
                    return Padding(
                      padding: const EdgeInsets.all(
                        SeniorSpacing.small,
                      ).add(
                        const EdgeInsets.only(
                          top: SeniorSpacing.small,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            FontAwesomeIcons.triangleExclamation,
                            color: SeniorColors.manchesterColorOrange500,
                            size: SeniorIconSize.big,
                          ),
                          SeniorText.h4(
                            state.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SeniorText.label(
                            state.subtitle,
                          ),
                          const SizedBox(
                            height: SeniorSpacing.normal,
                          ),
                          SeniorButton(
                            fullWidth: true,
                            outlined: true,
                            label: collectorLocalizations.facialBackStart,
                            onPressed: () {
                              widget._navigatorService.navigate(
                                route: CollectorModuleService.homePath,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is RegisteringClockingEvent) {
                    blockButtons = true;
                    workStatus = DriversWorkStatusEnum.working;
                  }

                  if (state is NotStartedDriversJourneyState) {
                    workStatus = DriversWorkStatusEnum.notStarted;
                  }

                  if (state is StartedDriversJourneyState) {
                    workStatus = state.driversJourneyEvent?.status ?? JourneyInExecution().status;
                    eventForButton = state.driversJourneyEvent?.closedBy ?? StartJourneyEvent();
                    dateTimeOfLastStatusStarted = state.dateTimeOfLastStatusStarted;
                    startClock = true;
                  }

                  if (state is CallingModalToClosePrevious) {
                    workStatus = state.actual?.status ?? JourneyInExecution().status;
                    eventForButton = state.actual?.closedBy ?? StartJourneyEvent();
                  }

                  if (state is CallingOvernight) {
                    workStatus = state.actual?.status ?? JourneyInExecution().status;
                    eventForButton = state.actual?.closedBy ?? StartJourneyEvent();
                  }

                  return Stack(
                    children: [
                      SingleChildScrollView(
                        key: const Key('main_scrollable'),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: SeniorSpacing.small,
                            right: SeniorSpacing.small,
                            top: SeniorRadius.huge,
                          )

                              /// (SeniorButton height) + (10 of button bottom padding)
                              .add(
                                const EdgeInsets.only(
                                  bottom: 58,
                                ),
                              )

                              /// 10 of padding
                              .add(
                                const EdgeInsets.only(
                                  bottom: SeniorSpacing.small,
                                ),
                              ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClockWidget(
                                timerBloc: widget._timerBloc,
                                workIndicatorCubit: widget._workIndicatorCubit,
                                activeTimer: true,
                                showBottomSheetUsecase: widget._showBottomSheetUsecase,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isDark ? SeniorColors.grayscale70 : SeniorColors.grayscale10,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  children: [
                                    WorkStatusWidget(
                                      driversWorkStatus: workStatus,
                                    ),
                                    Visibility(
                                      visible: workStatus != DriversWorkStatusEnum.notStarted,
                                      child: BlocBuilder<TimerBloc, TimerState>(
                                        bloc: widget._timerBloc,
                                        builder: (context, state) {
                                          if (state is TimerClockState) {
                                            return JourneyTimerWidget(
                                              timer: startClock
                                                  ? state.dateTime.difference(
                                                      dateTimeOfLastStatusStarted,
                                                    )
                                                  : Duration.zero,
                                              driversWorkStatus: workStatus,
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: totalBreaks > 0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: SeniorSpacing.xxsmall,
                                        ),
                                        child: JourneyInfoWidget(
                                          title: collectorLocalizations.numberOfPauses,
                                          content: totalBreaks.toString(),
                                          onInfoButtonPressed: () {
                                            final collectorLocalizations = CollectorLocalizations.of(
                                              context,
                                            );

                                            widget._showBottomSheetUsecase(
                                              context: context,
                                              content: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: SeniorText.labelBold(
                                                    collectorLocalizations.breaks,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                SeniorText.body(
                                                  collectorLocalizations.breaksInfo,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                SeniorButton.ghost(
                                                  fullWidth: true,
                                                  label: collectorLocalizations.infoUnderstoodButton,
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: currentJourney != null,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: SeniorSpacing.xxsmall,
                                        ),
                                        child: JourneyInfoWidget(
                                          title: collectorLocalizations.journeyStart,
                                          content: DateFormat(
                                            widget._utils.getDateTimePattern(
                                              localeName: collectorLocalizations.localeName,
                                            ),
                                          ).format(
                                            currentJourney?.startDate ?? DateTime.now(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: currentJourney != null,
                                      child: BlocBuilder<TimerBloc, TimerState>(
                                        bloc: widget._timerBloc,
                                        builder: (context, state) {
                                          if (state is TimerClockState) {
                                            return JourneyInfoWidget(
                                              title: collectorLocalizations.totalWorked,
                                              content: widget._utils.getHourMinuteSecondFromDuration(
                                                widget._driversJourneyBloc.getTotalWorkedAtMoment(
                                                  state.dateTime,
                                                ),
                                              ),
                                              contentLightColor:
                                                  widget._driversJourneyBloc.isOddClockingEvents ? SeniorColors.manchesterColorRed400 : null,
                                              contentDarkColor:
                                                  widget._driversJourneyBloc.isOddClockingEvents ? SeniorColors.manchesterColorRed400 : null,
                                              onInfoButtonPressed: () {
                                                final collectorLocalizations = CollectorLocalizations.of(
                                                  context,
                                                );

                                                widget._showBottomSheetUsecase(
                                                  context: context,
                                                  content: [
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: SeniorText.labelBold(
                                                        collectorLocalizations.totalWorked,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    SeniorText.body(
                                                      collectorLocalizations.totalWorkedInfo,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    SeniorButton.ghost(
                                                      fullWidth: true,
                                                      label: collectorLocalizations.infoUnderstoodButton,
                                                      onPressed: () => Navigator.pop(
                                                        context,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                    Visibility(
                                      visible: isVisible(
                                        currentJourney: currentJourney,
                                        totalTimeSinceLastJourneyUseCase: totalTimeSinceLastJourneyUseCase,
                                      ),
                                      child: const SizedBox(
                                        height: 15,
                                      ),
                                    ),
                                    Visibility(
                                      visible: isVisible(
                                        currentJourney: currentJourney,
                                        totalTimeSinceLastJourneyUseCase: totalTimeSinceLastJourneyUseCase,
                                      ),
                                      child: const Divider(),
                                    ),
                                    Visibility(
                                      visible: isVisible(
                                        currentJourney: currentJourney,
                                        totalTimeSinceLastJourneyUseCase: totalTimeSinceLastJourneyUseCase,
                                      ),
                                      child: JourneyInfoWidget(
                                        title: collectorLocalizations.totalTimeSinceLastJourney,
                                        content: getContentTotalTimeSinceLastJourney(
                                          totalTimeSinceLastJourneyUseCase: totalTimeSinceLastJourneyUseCase,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    JourneyButtonWidget(
                                      disabled: false,
                                      driversWorkStatus: workStatus,
                                      eventToAdd: eventForButton,
                                      onPressed: onJourneyButtonClick,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              SeniorText.cta(
                                emphasis: true,
                                collectorLocalizations.actions,
                                darkColor: SeniorColors.pureWhite,
                                textProperties: const TextProperties(
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                height: SeniorSpacing.normal,
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: SeniorSpacing.small,
                                  mainAxisSpacing: SeniorSpacing.small,
                                  mainAxisExtent: 110,
                                ),
                                padding: EdgeInsets.zero,
                                itemCount: getButtons(blockButtons, workStatus).length,
                                itemBuilder: (context, index) => getButtons(blockButtons, workStatus)[index],
                              ),
                            ],
                          ),
                        ),
                      ),
                      state is RegisteringClockingEvent
                          ? Positioned.fill(
                              child: Container(
                                color: SeniorColors.pureBlack.withOpacity(0.8),
                                child: LoadingWidget(
                                  bottomLabel: collectorLocalizations.loading,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder<DriversJourneyBloc, DriversJourneyState>(
        bloc: widget._driversJourneyBloc,
        builder: (context, state) {
          if (state is StartedDriversJourneyState) {
            final isLoading = state.isLoading;

            return Padding(
              padding: const EdgeInsets.only(
                left: SeniorSpacing.small,
                right: SeniorSpacing.small,
                bottom: SeniorSpacing.small,
              ),
              child: SeniorButton(
                fullWidth: true,
                danger: true,
                disabled: isLoading,
                label: collectorLocalizations.finishJourney,
                onPressed: () {
                  widget._driversJourneyBloc.add(
                    EndJourneyEvent(),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  String getContentTotalTimeSinceLastJourney({
    Duration? totalTimeSinceLastJourneyUseCase,
  }) {
    var content = '';
    if (totalTimeSinceLastJourneyUseCase == null) {
      return '';
    }
    if (totalTimeSinceLastJourneyUseCase.inDays > 0) {
      content += '${totalTimeSinceLastJourneyUseCase.inDays}d ';
    }
    if (totalTimeSinceLastJourneyUseCase.inHours > 0) {
      content += '${totalTimeSinceLastJourneyUseCase.inHours % 24}h ';
    }
    if (totalTimeSinceLastJourneyUseCase.inMinutes > 0) {
      content += '${totalTimeSinceLastJourneyUseCase.inMinutes % 60}m ';
    }
    return content;
  }

  bool isVisible({
    JourneyEntity? currentJourney,
    Duration? totalTimeSinceLastJourneyUseCase,
  }) {
    return totalTimeSinceLastJourneyUseCase != null && currentJourney == null && totalTimeSinceLastJourneyUseCase.inMinutes > 0;
  }
}
