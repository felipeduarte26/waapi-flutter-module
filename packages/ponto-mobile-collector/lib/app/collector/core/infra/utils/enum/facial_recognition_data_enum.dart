import '../../../domain/entities/facial_recognition_message.dart';

enum FacialRecognitionCodesEnum {
  successfullyAuthenticated(100, 'authenticate'),
  successfullyDownloadedAiFiles(100, 'downloadWeights');

  final int code;
  final String method;

  const FacialRecognitionCodesEnum(this.code, this.method);

  bool hasMatch(FacialRecognitionMessage message) =>
      message.code == code && message.method == method;
}
