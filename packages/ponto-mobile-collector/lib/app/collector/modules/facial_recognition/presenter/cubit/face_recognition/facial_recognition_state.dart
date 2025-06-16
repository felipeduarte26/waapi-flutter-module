abstract class FacialRecognitionState {}

class RecognitionInitializationInProgress implements FacialRecognitionState {}

class RecognitionInitializationSuccess implements FacialRecognitionState {}

class RecognitionSuccess implements FacialRecognitionState {}

class RecognitionFailure implements FacialRecognitionState {}

class NewMessageFailure implements FacialRecognitionState {}

class NewMessageSuccess implements FacialRecognitionState {}

class ChangeCameraInProgress implements FacialRecognitionState {}

class ChangeCameraSuccess implements FacialRecognitionState {}

class CloseRecognitionSuccess implements FacialRecognitionState {}

class FraudEvidenceStart implements FacialRecognitionState {}

class FraudEvidenceOff implements FacialRecognitionState {}
