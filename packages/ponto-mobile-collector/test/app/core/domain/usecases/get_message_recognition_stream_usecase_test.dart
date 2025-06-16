import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/facial_recognition_message.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_message_recognition_stream_usecase.dart';

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

void main() {
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  late IGetMessageRecognitionStreamUsecase getMessageRecognitionStremUsecase;
  final StreamController<FacialRecognitionMessage> broadcastStream =
      StreamController<FacialRecognitionMessage>.broadcast();

  setUp(() {
    faceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();
    getMessageRecognitionStremUsecase = GetMessageRecognitionStreamUsecase(
      faceRecognitionSdkAuthenticationService:
          faceRecognitionSdkAuthenticationService,
    );
  });

  group('IGetMessageRecognitionStremUsecase', () {
    test('call success test', () async {
      when(
        () => faceRecognitionSdkAuthenticationService
            .getFacialRecognitionMessageStream(),
      ).thenAnswer((_) => broadcastStream.stream);

      expect(getMessageRecognitionStremUsecase.call(), broadcastStream.stream);

      verify(
        () => faceRecognitionSdkAuthenticationService
            .getFacialRecognitionMessageStream(),
      ).called(1);
    });
  });
}
