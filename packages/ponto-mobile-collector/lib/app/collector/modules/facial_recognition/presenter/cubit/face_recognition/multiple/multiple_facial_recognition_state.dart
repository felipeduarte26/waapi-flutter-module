import '../../../../../../core/presenter/widgets/collector_camera/camera_overlay_widget.dart';

abstract class MultipleFacialRecognitionState {
  final CameraOverlayState status;
  final String message;

  MultipleFacialRecognitionState({
    this.status = CameraOverlayState.initial,
    this.message = '',
  });
}

class MultiModeRecognitionIsStarting extends MultipleFacialRecognitionState {}

class MultiModeRecognitionOpened extends MultipleFacialRecognitionState {
  MultiModeRecognitionOpened({
    super.status = CameraOverlayState.ready,
    super.message = '',
  });
}

class MultiModeRecognitionReady extends MultipleFacialRecognitionState {
  MultiModeRecognitionReady({
    super.status = CameraOverlayState.initial,
    super.message = '',
  });
}

class MultiModeRecognitionInProgress extends MultipleFacialRecognitionState {
  MultiModeRecognitionInProgress({
    super.status = CameraOverlayState.processing,
    super.message = '',
  });
}

class MultiModeRecognitionSuccess extends MultipleFacialRecognitionState {
  MultiModeRecognitionSuccess({
    super.status = CameraOverlayState.success,
    super.message = '',
  });
}

class MultiModeNewMessageFailure extends MultipleFacialRecognitionState {
  MultiModeNewMessageFailure({
    super.status = CameraOverlayState.initial,
    super.message = '',
  });
}

class MultiModeChangeCameraInProgress extends MultipleFacialRecognitionState {
  MultiModeChangeCameraInProgress({
    super.status = CameraOverlayState.initial,
    super.message = '',
  });
}

class MultiModeChangeCameraSuccess extends MultipleFacialRecognitionState {
  MultiModeChangeCameraSuccess({
    super.status = CameraOverlayState.initial,
    super.message = '',
  });
}

class MultiModeRecognitionTimerRunOff extends MultipleFacialRecognitionState {
  MultiModeRecognitionTimerRunOff({
    super.status = CameraOverlayState.initial,
    super.message = '',
  });
}

class MultiModeFraudEvidenceStart extends MultipleFacialRecognitionState {
  MultiModeFraudEvidenceStart({
    super.status = CameraOverlayState.initial,
    super.message = '',
  });
}

class MultiModeFraudEvidenceOff extends MultipleFacialRecognitionState {
  MultiModeFraudEvidenceOff({
    super.status = CameraOverlayState.initial,
    super.message = '',
  });
}

class MultiModeLoadLocation extends MultipleFacialRecognitionState {}
