import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../core/external/mappers/clocking_event_mapper.dart';
import '../../../../core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import '../../domain/usecase/get_lifecycle_stream_usecase.dart';
import '../../domain/usecase/show_bottom_sheet_usecase.dart';
import '../../domain/util/iclocking_event_utill.dart';
import '../bloc/timer/timer_state.dart';
import 'clocking_event_not_available_widget.dart';
import 'driver_register_button_widget.dart';

class ClockingEventWidget extends StatefulWidget {
  final TimerBloc _timerBloc;
  final RegisterClockingEventBloc _registerClockingEventBloc;
  final ClockingEventBloc _clockingEventBloc;
  final int _secondsToPressButton;
  final IShowBottomSheetUsecase _showBottomSheetUsecase;
  final IClockingEventUtil _clockingEventUtil;
  final Widget Function(String message, String description)? _errorBuilder;
  final ConfirmationSnackbarWidget _confirmationSnackbarWidget;
  final FacialRegistrationMessageWidget _facialRegistrationMessageWidget;
  final WorkIndicatorCubit _workIndicatorCubit;
  final NavigatorService _navigatorService;
  final IPlatformService _platformService;
  final IGetLifecycleStreamUsecase _getLifecycleStreamUsecase;

  const ClockingEventWidget({
    required TimerBloc timerBloc,
    required RegisterClockingEventBloc registerClockingEventBloc,
    required ClockingEventBloc clockingEventBloc,
    required IShowBottomSheetUsecase showBottomSheetUsecase,
    required IClockingEventUtil clockingEventUtil,
    required ConfirmationSnackbarWidget confirmationSnackbarWidget,
    required FacialRegistrationMessageWidget facialRegistrationMessageWidget,
    required WorkIndicatorCubit workIndicatorCubit,
    required NavigatorService navigatorService,
    required IPlatformService platformService,
    required IGetLifecycleStreamUsecase getLifecycleStreamUsecase,
    Widget Function(String message, String description)? errorBuilder,
    int secondsToPressButton = 1,
    super.key,
  })  : _timerBloc = timerBloc,
        _registerClockingEventBloc = registerClockingEventBloc,
        _clockingEventBloc = clockingEventBloc,
        _showBottomSheetUsecase = showBottomSheetUsecase,
        _clockingEventUtil = clockingEventUtil,
        _errorBuilder = errorBuilder,
        _secondsToPressButton = secondsToPressButton,
        _confirmationSnackbarWidget = confirmationSnackbarWidget,
        _facialRegistrationMessageWidget = facialRegistrationMessageWidget,
        _workIndicatorCubit = workIndicatorCubit,
        _navigatorService = navigatorService,
        _platformService = platformService,
        _getLifecycleStreamUsecase = getLifecycleStreamUsecase;

  @override
  State<ClockingEventWidget> createState() => _ClockingEventWidgetState();
}

class _ClockingEventWidgetState extends State<ClockingEventWidget>
    with WidgetsBindingObserver {
  StateLocationEntity? stateLocationEntity;
  late StreamSubscription<AppLifecycleState> _lifecycleSubscription;

  @override
  void initState() {
    _lifecycleSubscription = widget._getLifecycleStreamUsecase.call().listen((event) {
      if (event == AppLifecycleState.resumed) {
        _getContextOnLoad();
      }
    });

    _getContextOnLoad();
    super.initState();
  }

   @override
  void dispose() {
    _lifecycleSubscription.cancel();
    super.dispose();
  }

  void _getContextOnLoad() async {
    widget._clockingEventBloc.add(ClockingEventLoadingLocationEvent());
    stateLocationEntity = await widget._platformService.getLocation(requestLocation: false);

    widget._registerClockingEventBloc.setContext(context: context);
    widget._clockingEventBloc.add(LoadClockingEventEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClockingEventBloc, ClockingEventBaseState>(
      bloc: widget._clockingEventBloc,
      builder: (context, state) {
        String? errorMessage = widget._clockingEventBloc.deviceStatus(context);
        if (errorMessage != null) {
          if (widget._errorBuilder != null) {
            return widget._errorBuilder!(
              errorMessage,
              CollectorLocalizations.of(context).contactRh,
            );
          }

          return PontoStateCardWidget(
            disabled: false,
            iconData: Icons.error,
            message: CollectorLocalizations.of(context).alert,
            showButton: true,
            textButton: 'Saiba mais',
            onTap: () {
              launchUrl(Uri.parse('https://documentacao.senior.com.br'));
            },
            descriptionMessage: errorMessage,
          );
        }

        // Validation if screen information (Clocking Event or time clock) is being updated
        if (state is LoadingClockingEventState ||
            state is InitialClockingEventState || 
            state is ClockingEventLoadingLocationState) {
          return LoadingWidget(
            bottomLabel: CollectorLocalizations.of(context).loading,
          );
        }

        return Column(
          children: [
            // User message and name
            Padding(
              padding: const EdgeInsets.all(SeniorSpacing.normal),
              child: Column(
                children: [
                  ClockWidget(
                    timerBloc: widget._timerBloc,
                    workIndicatorCubit: widget._workIndicatorCubit,
                    activeTimer: true,
                    showBottomSheetUsecase: widget._showBottomSheetUsecase,
                  ),
                  widget._clockingEventBloc.hasEmployee()
                      ? const SizedBox()
                      : const SizedBox(height: SeniorSpacing.small),
                  widget._clockingEventBloc.hasEmployee()
                      ? const SizedBox()
                      : ClockingEventNotAvailableWidget(
                          title: CollectorLocalizations.of(context)
                              .clockingEventNotAvailable,
                          description: CollectorLocalizations.of(context)
                              .descriptionClockingEventNotAvailable,
                          icon: const Icon(
                            FontAwesomeIcons.triangleExclamation,
                            color: SeniorColors.primaryColor500,
                            size: SeniorIconSize.medium,
                          ),
                          disabled: false,
                        ),
                ],
              ),
            ),
            // Register Button
            widget._clockingEventBloc.hasEmployee()
                ? BlocConsumer<RegisterClockingEventBloc,
                    RegisterClockingState>(
                    bloc: widget._registerClockingEventBloc,
                    listener: (context, state) {
                      if (state is SuccessRegisterState &&
                          widget._clockingEventBloc.executionModeEnum
                              .isIndividual()) {
                        widget._clockingEventBloc.add(LoadClockingEventEvent());
                        widget._facialRegistrationMessageWidget
                            .show(clockingEventUse: state.clockingEvent.use);
                        widget._confirmationSnackbarWidget.show(
                          clockingEvent: state.clockingEvent,
                        );
                      }
                    },
                    builder: (context, state) {
                      return BlocBuilder<TimerBloc, TimerState>(
                        bloc: widget._timerBloc,
                        buildWhen: (previous, current) {
                          if ((current is TimerUpdatingState &&
                                  previous is! TimerUpdatingState) ||
                              (current is TimerClockState &&
                                  previous is! TimerClockState)) {
                            return true;
                          }

                          return false;
                        },
                        builder: (context, timerState) {
                          return timerState is TimerUpdatingState 
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SeniorSpacing.xsmall,
                                    vertical: SeniorSpacing.xsmall,
                                  ),
                                  child: SeniorLoading(),
                                )
                              : Column(
                                  children: [
                                    if (widget
                                        ._clockingEventBloc.executionModeEnum
                                        .isIndividual())
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: SeniorSpacing.xsmall,
                                        ),
                                        child: SeniorLinearLongPressButton(
                                          busy: widget
                                              ._registerClockingEventBloc
                                              .isRegistering,
                                          fullLength: true,
                                          busyMessage:
                                              CollectorLocalizations.of(
                                            context,
                                          ).clockingEventCapturingTime,
                                          icon:
                                              Icons.access_time_filled_rounded,
                                          duration:
                                              widget._secondsToPressButton,
                                          label: CollectorLocalizations.of(
                                            context,
                                          ).clockingEventCaptureTime,
                                          onSubmit: () {
                                            widget._registerClockingEventBloc
                                                .add(
                                              NewRegisterEvent(
                                                clockingEventRegisterType:
                                                    ClockingEventRegisterTypeSession(),
                                                stateLocationEntity:
                                                    stateLocationEntity,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    if (widget
                                        ._clockingEventBloc.executionModeEnum
                                        .isDriver())
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: SeniorSpacing.medium,
                                          vertical: SeniorSpacing.small,
                                        ),
                                        child: DriverRegisterButtonWidget(
                                          navigatorService:
                                              widget._navigatorService,
                                              clockingEventBloc: widget._clockingEventBloc,
                                        ),
                                      ),
                                  ],
                                );
                        },
                      );
                    },
                  )
                : const SizedBox(),
            // Message info
            !widget._clockingEventBloc.executionModeEnum.isDriver() &&
                    widget._clockingEventBloc.hasEmployee()
                ? SeniorText.small(
                    CollectorLocalizations.of(context)
                        .clockingEventKeepButtonPressedToRegister,
                    color: SeniorColors.neutralColor700,
                  )
                : const SizedBox(),
            widget._clockingEventBloc.hasEmployee()
                ? const SizedBox(height: SeniorSpacing.xsmall)
                : const SizedBox(),
            // List of Clocking Events
            widget._clockingEventBloc.hasEmployee()
                ? Padding(
                    padding: const EdgeInsets.all(SeniorSpacing.normal),
                    child:
                        BlocBuilder<ClockingEventBloc, ClockingEventBaseState>(
                      bloc: widget._clockingEventBloc,
                      builder: (context, state) {
                        return TodaysWorkday(
                          workdayIndicators: WorkdayIndicators(
                            clockingEvents:
                                widget._clockingEventUtil.getDateTimes(
                              ClockingEventMapper.fromDtoToEntityCollectorList(widget._clockingEventBloc.clockingEvents)!,
                            ),
                          ),
                          expanded:
                              widget._clockingEventBloc.expandTodaysWorkday,
                          onExpandedPressed: () {
                            widget._clockingEventBloc.add(
                              ChangeExpandedTodaysClockingEventEvent(),
                            );
                          },
                          showBottomSheetUsecase:
                              widget._showBottomSheetUsecase,
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
