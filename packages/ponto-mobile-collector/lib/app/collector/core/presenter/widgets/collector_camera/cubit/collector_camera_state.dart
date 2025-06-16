abstract class CollectorCameraState {}

class InitializingCamera implements CollectorCameraState {}

class ReadyCamera implements CollectorCameraState {}

class ClosedCamera implements CollectorCameraState {}

class LightOn implements CollectorCameraState {}

class LightOff implements CollectorCameraState {}

class ChangingCamera implements CollectorCameraState {}

class CameraChanged implements CollectorCameraState {}

class CapturingImage implements CollectorCameraState {}

class CapturedImage implements CollectorCameraState {}
