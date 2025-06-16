import '../../../domain/enums/face_registration_status_enum.dart';

abstract class FaceRegistrationState {}

class FaceRegistrationInitial implements FaceRegistrationState {}

class FaceRegistrationCheckingInformationInProgress
    implements FaceRegistrationState {}

class FaceRegistrationOffline implements FaceRegistrationState {}

class PersonExistsOnFacialRecognitionPlatform
    implements FaceRegistrationState {}

class PersonNotExistsOnFacialRecognitionPlatform
    implements FaceRegistrationState {}

class FaceCaptureInProgress implements FaceRegistrationState {}

class FaceRegistrationInProgress implements FaceRegistrationState {}

class FaceRegistrationSuccess implements FaceRegistrationState {}

class FaceRegistrationFailure implements FaceRegistrationState {
  final FaceRegistrationStatusEnum faceRegistrationStatusEnum;
  FaceRegistrationFailure(this.faceRegistrationStatusEnum);
}

class FaceRegistrationAlert implements FaceRegistrationState {
  final FaceRegistrationStatusEnum faceRegistrationStatusEnum;

  FaceRegistrationAlert(this.faceRegistrationStatusEnum);
}

class FaceRegistrationNoPermission implements FaceRegistrationState {}
