// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/domain/enums/camera_type.dart';
import '../../../../core/domain/services/face_recognition/face_recognition_settings_service.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../../../../core/presenter/cubit/work_indicator/work_indicator_cubit.dart';
import '../../../../core/presenter/widgets/collector_camera/camera_overlay_widget.dart';
import '../../../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../../../clocking_event/presenter/bloc/register_clocking_event/register_clocking_event_bloc.dart';
import '../../../clocking_event/presenter/bloc/register_clocking_event/register_clocking_event_state.dart';
import '../../../clocking_event/presenter/bloc/timer/timer_bloc.dart';
import '../../../clocking_event/presenter/widgets/clock/clock_widget.dart';
import '../../../clocking_event/presenter/widgets/confirmation_snackbar_widget.dart';
import '../../../clocking_event/presenter/widgets/day_mensage_widget.dart';
import '../cubit/face_recognition/multiple/multiple_facial_recognition_cubit.dart';
import '../cubit/face_recognition/multiple/multiple_facial_recognition_state.dart';

class MultipleFacialRecognitionScreen extends StatefulWidget {
  final IUtils _utils;
  final WorkIndicatorCubit _workIndicatorCubit;
  final MultipleFacialRecognitionCubit _multiFacialRecognitionCubit;
  final FlutterGryfoLib _flutterGryfoLib;
  final Widget? fragmentTest;

  final TimerBloc _timerBloc;
  final RegisterClockingEventBloc _registerClockingEventBloc;
  final IShowBottomSheetUsecase showBottomSheetUsecase;
  final ConfirmationSnackbarWidget _confirmationSnackbarWidget;
  final FaceRecognitionSettingsService _faceRecognitionSettingsService;

  const MultipleFacialRecognitionScreen({
    required IUtils utils,
    required WorkIndicatorCubit workIndicatorCubit,
    required MultipleFacialRecognitionCubit multipleFacialRecognitionCubit,
    required RegisterClockingEventBloc registerClockingEventBloc,
    required TimerBloc timerBloc,
    required FlutterGryfoLib flutterGryfoLib,
    required ConfirmationSnackbarWidget confirmationSnackbarWidget,
    required FaceRecognitionSettingsService faceRecognitionSettingsService,
    required this.showBottomSheetUsecase,
    this.fragmentTest,
    super.key,
  })  : _utils = utils,
        _workIndicatorCubit = workIndicatorCubit,
        _multiFacialRecognitionCubit = multipleFacialRecognitionCubit,
        _registerClockingEventBloc = registerClockingEventBloc,
        _flutterGryfoLib = flutterGryfoLib,
        _timerBloc = timerBloc,
        _confirmationSnackbarWidget = confirmationSnackbarWidget,
        _faceRecognitionSettingsService = faceRecognitionSettingsService;

  @override
  MultipleFacialRecognitionScreenState createState() =>
      MultipleFacialRecognitionScreenState();
}

class MultipleFacialRecognitionScreenState
    extends State<MultipleFacialRecognitionScreen> {
  late Widget fragmentContainer;

  bool enableSquare = true;
  bool alertFraud = false;

  @override
  void initState() {
    fragmentContainer = widget._flutterGryfoLib.createFragmentContainer(
      backgroundColor: SeniorColors.grayscale90,
      hideDefaultOverlay: true,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Durations.short4, () async {
        await widget._faceRecognitionSettingsService.setSettings();
        widget._multiFacialRecognitionCubit.openRecognize(
          messages: {
            'facialRegistrationCompleted':
                CollectorLocalizations.of(context).facialRegistrationCompleted,
            'facialCaceledRegistration':
                CollectorLocalizations.of(context).facialCaceledRegistration,
            'facialRegistering':
                CollectorLocalizations.of(context).facialRegistering,
            'facialCollaboratorNotFound':
                CollectorLocalizations.of(context).facialCollaboratorNotFound,
          },
        );
      });
    });
  }

  @override
  void dispose() {
    widget._multiFacialRecognitionCubit.timer?.cancel();

    SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget._utils.isTablet(context)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    widget._registerClockingEventBloc.setContext(context: context);
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (widget._multiFacialRecognitionCubit.state
            is! MultiModeRecognitionInProgress) {
          closeRecognition();
        }
      },
      child: Scaffold(
        body: BlocConsumer<MultipleFacialRecognitionCubit,
            MultipleFacialRecognitionState>(
          bloc: widget._multiFacialRecognitionCubit,
          listener: (context, state) async {
            if (state
                case MultiModeRecognitionOpened() ||
                    MultiModeChangeCameraSuccess()) {
              widget._multiFacialRecognitionCubit.startRecognition();
            }

            if (state is MultiModeChangeCameraInProgress) {
              enableSquare = false;
            }

            if (state is MultiModeChangeCameraSuccess) {
              enableSquare = true;
            }

            if (state is MultiModeRecognitionTimerRunOff) {
              await closeRecognition();
            }
            if (state is MultiModeFraudEvidenceStart) {
              alertFraud = true;
            }
            if (state is MultiModeFraudEvidenceOff) {
              alertFraud = false;
            }
          },
          builder: (context, state) => Stack(
            children: [
              SeniorColorfulHeaderStructure(
                title: SeniorText.label(
                  CollectorLocalizations.of(context)
                      .facialFacialRecognitionMultiMode,
                  color: SeniorColors.pureWhite,
                  darkColor: SeniorColors.grayscale5,
                ),
                leading: IconButton(
                  key: const Key('closeMultipleFacialRecognition'),
                  icon: Icon(
                    FontAwesomeIcons.angleLeft,
                    color: isDark
                        ? SeniorColors.grayscale5
                        : SeniorColors.pureWhite,
                  ),
                  iconSize: SeniorSpacing.small,
                  onPressed: () => closeRecognition(),
                ),
                body: Column(
                  children: [
                    BlocListener<RegisterClockingEventBloc,
                        RegisterClockingState>(
                      bloc: widget._registerClockingEventBloc,
                      listener: (context, state) {
                        if (state is SuccessRegisterState) {
                          log('##INFO## show confirmation snackbar ${DateTime.now()}');

                          widget._confirmationSnackbarWidget.show(
                            clockingEvent: state.clockingEvent,
                            hideActionButton: true,
                          );
                        }
                      },
                      child: const SizedBox(),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: DayMessageWidget(
                        day: widget._timerBloc.lastDateTime,
                      ),
                    ),
                    ClockWidget(
                      workIndicatorCubit: widget._workIndicatorCubit,
                      showBottomSheetUsecase: widget.showBottomSheetUsecase,
                      timerBloc: widget._timerBloc,
                      activeTimer: true,
                      showFaceRecognitionSync: false,
                    ),
                    const SizedBox(height: SeniorSpacing.normal),
                    Expanded(
                      child: CameraOverlayWidget(
                        enableCaptureButton: false,
                        enableShadow: false,
                        enableToggleFlash: widget
                                ._multiFacialRecognitionCubit.selectedCamera ==
                            0,
                        onToggleFlash: () =>
                            widget._flutterGryfoLib.toggleLight(),
                        onToggleCamera: () => widget
                            ._multiFacialRecognitionCubit
                            .changeCameraDefault(),
                        enableSquare: enableSquare,
                        uiState: state.status,
                        customMessage: state.message,
                        isFraudAlert: alertFraud,
                        cameraType: CameraType.facialRecognition,
                        timerBlockFraudEvidence:
                            widget._multiFacialRecognitionCubit.timerDuration,
                        child: widget.fragmentTest ?? fragmentContainer,
                      ),
                    ),
                  ],
                ),
              ),
              if (state is MultiModeRecognitionIsStarting ||
                  state is MultiModeLoadLocation)
                Container(
                  color: isDark
                      ? SeniorColors.grayscale90
                      : SeniorColors.pureWhite,
                  alignment: Alignment.center,
                  child: SeniorText.label(
                    CollectorLocalizations.of(context).loading,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> closeRecognition() async {
    await widget._multiFacialRecognitionCubit.finalize();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
