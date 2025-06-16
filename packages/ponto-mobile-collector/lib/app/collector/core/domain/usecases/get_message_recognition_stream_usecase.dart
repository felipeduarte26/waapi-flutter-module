import '../entities/facial_recognition_message.dart';
import '../services/face_recognition/i_face_recognition_sdk_authentication_service.dart';

abstract class IGetMessageRecognitionStreamUsecase {
  Stream<FacialRecognitionMessage> call();
}

class GetMessageRecognitionStreamUsecase
    implements IGetMessageRecognitionStreamUsecase {
  final IFaceRecognitionSdkAuthenticationService
      _faceRecognitionSdkAuthenticationService;

  const GetMessageRecognitionStreamUsecase({
    required IFaceRecognitionSdkAuthenticationService
        faceRecognitionSdkAuthenticationService,
  }) : _faceRecognitionSdkAuthenticationService =
            faceRecognitionSdkAuthenticationService;

  @override
  Stream<FacialRecognitionMessage> call() {
    return _faceRecognitionSdkAuthenticationService
        .getFacialRecognitionMessageStream();
  }
}
