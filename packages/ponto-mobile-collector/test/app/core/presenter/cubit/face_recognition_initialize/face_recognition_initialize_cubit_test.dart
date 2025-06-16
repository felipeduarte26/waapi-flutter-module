import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/widgets/face_recognition_initialize/cubit/face_recognition_initialize_cubit.dart';

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

void main() {
  late FaceRecognitionInitializeCubit faceRecognitionInitializeCubit;
  late IFaceRecognitionSdkAuthenticationService
      faceRecognitionSdkAuthenticationService;
  late StreamController<bool> streamController;

  setUp(() {
    faceRecognitionSdkAuthenticationService =
        MockFaceRecognitionSdkAuthenticationService();
    streamController = StreamController<bool>();

    when(
      () =>
          faceRecognitionSdkAuthenticationService.getInitializationIsRunning(),
    ).thenReturn(true);

    when(
      () => faceRecognitionSdkAuthenticationService.getInitializeStream(),
    ).thenAnswer((_) => streamController.stream);

    faceRecognitionInitializeCubit = FaceRecognitionInitializeCubit(
      faceRecognitionSdkAuthenticationService:
          faceRecognitionSdkAuthenticationService,
    );
  });

  group('FaceRecognitionInitializeCubit', () {
    test(
        'emits [RecognitionInitializationSuccess],'
        ' when recognitionService emit true test', () async {
      streamController.add(true);
      await Future.delayed(const Duration(milliseconds: 50));
      faceRecognitionInitializeCubit.close();
      expect(
        faceRecognitionInitializeCubit.state,
        isA<FaceRecognitionInitializeIsRunning>(),
      );
    });

    test(
        'emits [FaceRecognitionInitializeIsFinished],'
        ' when recognitionService emit false test', () async {
      streamController.add(false);
      await Future.delayed(const Duration(milliseconds: 50));
      faceRecognitionInitializeCubit.close();
      expect(
        faceRecognitionInitializeCubit.state,
        isA<FaceRecognitionInitializeIsFinished>(),
      );
    });
  });
}
