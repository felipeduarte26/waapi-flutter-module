import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_download_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/face_recognition/face_recognition_download_service_impl.dart';

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

class MockISharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

void main() {
  Map<dynamic, dynamic> resultSuccessfully = {'status': 'success'};
  late FaceRecognitionDownloadService faceRecognitionDownloadService;
  late FlutterGryfoLib flutterGryfoLib;
  late ISharedPreferencesService sharedPreferencesService;

  setUp(() {
    flutterGryfoLib = MockFlutterGryfoLib();
    sharedPreferencesService = MockISharedPreferencesService();

    faceRecognitionDownloadService = FaceRecognitionDownloadServiceImpl(
      gryfoLib: flutterGryfoLib,
      sharedPreferencesService: sharedPreferencesService,
    );

    when(
      () => sharedPreferencesService.getDownloadAIFiles(),
    ).thenAnswer((_) async => false);

    when(
      () => flutterGryfoLib.downloadWeights(),
    ).thenAnswer((_) async => resultSuccessfully);

    when(
      () => sharedPreferencesService.setDownloadAIFiles(
        value: true,
      ),
    ).thenAnswer((_) async => {});
  });

  void mockVerifyNoMoreInteractions() {
    verifyNoMoreInteractions(sharedPreferencesService);
    verifyNoMoreInteractions(flutterGryfoLib);
  }

  group('MockFaceRecognitionTokenRepository', () {
    test('call authentication successfully test', () async {
      bool resultValue = await faceRecognitionDownloadService.downloadAIFiles();

      expect(resultValue, true);

      verify(
        () => sharedPreferencesService.getDownloadAIFiles(),
      ).called(1);
      verify(() => flutterGryfoLib.downloadWeights()).called(1);
      verify(
        () => sharedPreferencesService.setDownloadAIFiles(
          value: true,
        ),
      ).called(1);

      mockVerifyNoMoreInteractions();
    });

    test('return true when download has already been downloaded test',
        () async {
      when(
        () => sharedPreferencesService.getDownloadAIFiles(),
      ).thenAnswer((_) async => true);

      bool resultValue = await faceRecognitionDownloadService.downloadAIFiles();

      expect(resultValue, true);

      verify(
        () => sharedPreferencesService.getDownloadAIFiles(),
      ).called(1);

      mockVerifyNoMoreInteractions();
    });

    test('return false when gryfo authentication error test', () async {
      when(
        () => flutterGryfoLib.downloadWeights(),
      ).thenThrow(Exception());

      bool resultValue = await faceRecognitionDownloadService.downloadAIFiles();

      expect(resultValue, false);

      verify(
        () => sharedPreferencesService.getDownloadAIFiles(),
      ).called(1);
      verify(() => flutterGryfoLib.downloadWeights()).called(1);

      mockVerifyNoMoreInteractions();
    });
  });
}
