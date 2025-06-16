import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_settings_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/face_recognition/face_recognition_settings_service_impl.dart';

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

class MockISharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

void main() {
  Map<String, Object> settings = {'prop': 'value'};
  Map<dynamic, dynamic> resultSuccessfully = {'status': 'success'};
  Map<dynamic, dynamic> resultError = {'status': 'error'};
  late FaceRecognitionSettingsService faceRecognitionSettingsService;
  late FlutterGryfoLib flutterGryfoLib;
  late ISharedPreferencesService sharedPreferencesService;

  setUp(() {
    flutterGryfoLib = MockFlutterGryfoLib();
    sharedPreferencesService = MockISharedPreferencesService();

    faceRecognitionSettingsService = FaceRecognitionSettingsServiceImpl(
      gryfoLib: flutterGryfoLib,
      sharedPreferencesService: sharedPreferencesService,
    );

    registerFallbackValue(settings);

    when(
      () => flutterGryfoLib.setSettings(any()),
    ).thenAnswer((_) async => resultSuccessfully);

    when(
      () => sharedPreferencesService.getCameraDefault(),
    ).thenAnswer((_) async => 0);
  });

  void mockVerifyNoMoreInteractions() {
    verifyNoMoreInteractions(sharedPreferencesService);
    verifyNoMoreInteractions(flutterGryfoLib);
  }

  group('FaceRecognitionSettingsServiceImpl', () {
    test('return true when setSettings called successfully test', () async {
      bool resultValue = await faceRecognitionSettingsService.setSettings();

      expect(resultValue, true);

      verify(() => sharedPreferencesService.getCameraDefault()).called(1);
      verify(() => flutterGryfoLib.setSettings(any())).called(1);

      mockVerifyNoMoreInteractions();
    });

    test('return false when setSettings error test', () async {
      when(
        () => flutterGryfoLib.setSettings(any()),
      ).thenAnswer((_) async => resultError);
      bool resultValue = await faceRecognitionSettingsService.setSettings();

      expect(resultValue, false);

      verify(() => sharedPreferencesService.getCameraDefault()).called(1);
      verify(() => flutterGryfoLib.setSettings(any())).called(1);

      mockVerifyNoMoreInteractions();
    });

    test('return false when setSettings throws test', () async {
      when(
        () => flutterGryfoLib.setSettings(any()),
      ).thenThrow(Exception());
      bool resultValue = await faceRecognitionSettingsService.setSettings();

      expect(resultValue, false);

      verify(() => sharedPreferencesService.getCameraDefault()).called(1);
      verify(() => flutterGryfoLib.setSettings(any())).called(1);

      mockVerifyNoMoreInteractions();
    });
  });
}
