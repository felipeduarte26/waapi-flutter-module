import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/enums/facial_recognition_status_enum.dart';
import '../../../../core/domain/services/face_recognition/face_recognition_settings_service.dart';
import '../cubit/face_recognition/facial_recognition_cubit.dart';
import '../cubit/face_recognition/facial_recognition_state.dart';

class FacialRecognitionScreen extends StatefulWidget {
  final FlutterGryfoLib _flutterGryfoLib;
  final FacialRecognitionCubit _facialRecognitionCubit;
  final int delay;
  final Widget? fragmentTest;
  final FaceRecognitionSettingsService _faceRecognitionSettingsService;
  final IUtils _utils;

  const FacialRecognitionScreen({
    required FlutterGryfoLib flutterGryfoLib,
    required FacialRecognitionCubit facialRecognitionCubit,
    required FaceRecognitionSettingsService faceRecognitionSettingsService,
    this.fragmentTest,
    this.delay = 500,
    required IUtils utils,
    super.key,
  })  : _flutterGryfoLib = flutterGryfoLib,
        _facialRecognitionCubit = facialRecognitionCubit,
        _faceRecognitionSettingsService = faceRecognitionSettingsService,
        _utils = utils;

  @override
  FacialRecognitionScreenState createState() => FacialRecognitionScreenState();
}

class FacialRecognitionScreenState extends State<FacialRecognitionScreen> {
  late Widget fragmentContainer;
  bool enableSquare = true;
  bool recognitionSuccess = false;
  bool alertFraud = false;

  CameraOverlayState cameraOverlayState = CameraOverlayState.processing;

  @override
  void initState() {
    fragmentContainer = widget._flutterGryfoLib.createFragmentContainer(
      backgroundColor: SeniorColors.grayscale90,
      hideDefaultOverlay: true,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget._faceRecognitionSettingsService.setSettings();
      widget._facialRecognitionCubit.openRecognize();
    });
    super.initState();
  }

  @override
  void dispose() {
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

    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        } else {
          if (widget._facialRecognitionCubit.status ==
              FacialRecognitionStatusEnum.successfullyRecognized) {
            widget._facialRecognitionCubit.finalize();
          } else {
            showConfirmationDialog();
          }
        }
      },
      child: Scaffold(
        body: SeniorColorfulHeaderStructure(
          hasTopPadding: false,
          hideLeading: true,
          title: SeniorText.label(
            CollectorLocalizations.of(context).facialFacialRecognition,
            color: SeniorColors.pureWhite,
            darkColor: SeniorColors.grayscale5,
          ),
          actions: [
            IconButton(
              onPressed: () => showConfirmationDialog(),
              icon: Icon(
                FontAwesomeIcons.xmark,
                size: SeniorIconSize.small,
                color:
                    isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
              ),
            ),
          ],
          body: BlocConsumer<FacialRecognitionCubit, FacialRecognitionState>(
            bloc: widget._facialRecognitionCubit,
            listener: (context, state) {
              if (state is RecognitionInitializationSuccess) {
                widget._facialRecognitionCubit.startRecognition();
              }

              if (state is ChangeCameraInProgress) {
                enableSquare = false;
              }

              if (state is ChangeCameraSuccess) {
                enableSquare = true;
              }

              if (state is CloseRecognitionSuccess) {
                Navigator.pop(
                  context,
                  widget._facialRecognitionCubit.status,
                );
              }
              if (state is FraudEvidenceStart) {
                alertFraud = true;
              }
              if (state is FraudEvidenceOff) {
                alertFraud = false;
              }
            },
            builder: (context, state) {
              setCameraOverlayState(state);
              return SizedBox.expand(
                child: CameraOverlayWidget(
                  enableCaptureButton: false,
                  enableToggleFlash:
                      widget._facialRecognitionCubit.selectedCamera == 0,
                  onToggleFlash: () => widget._flutterGryfoLib.toggleLight(),
                  onToggleCamera: () =>
                      widget._facialRecognitionCubit.changeCameraDefault(),
                  enableSquare: enableSquare,
                  uiState: cameraOverlayState,
                  enableShadow: false,
                  customMessage: widget._facialRecognitionCubit.getMessage(),
                  isFraudAlert: alertFraud,
                  cameraType: CameraType.facialRecognition,
                  timerBlockFraudEvidence:
                      widget._facialRecognitionCubit.timerDuration,
                  child: widget.fragmentTest ?? fragmentContainer,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void setCameraOverlayState(FacialRecognitionState state) {
    log('##INFO## state: $state');
    switch (state) {
      case NewMessageFailure():
        cameraOverlayState = CameraOverlayState.error;
        break;
      case RecognitionSuccess():
        cameraOverlayState = CameraOverlayState.success;
        break;
      case RecognitionInitializationSuccess():
        cameraOverlayState = CameraOverlayState.ready;
        break;
      default:
        cameraOverlayState = CameraOverlayState.initial;
    }
  }

  Future<bool> showConfirmationDialog() async {
    SeniorModal modal = SeniorModal(
      content: CollectorLocalizations.of(context).facialModalAlertContent,
      otherAction: SeniorModalAction(
        label: CollectorLocalizations.of(context).facialModalAlertBackButton,
        action: () {
          Navigator.pop(
            context,
          );
        },
      ),
      defaultAction: SeniorModalAction(
        label: CollectorLocalizations.of(context).facialModalAlertProceedButton,
        action: () {
          widget._facialRecognitionCubit.status =
              FacialRecognitionStatusEnum.cancelled;
          widget._facialRecognitionCubit.finalize();
          Navigator.pop(
            context,
          );
        },
      ),
      title: CollectorLocalizations.of(context).facialModalAlertTitle,
    );

    showDialog(
      context: context,
      builder: (context) {
        return modal;
      },
    );
    return true;
  }
}
