import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/face_recognition_synchronization_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/face_recognition/face_recognition_synchronization_service_impl.dart';

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

void main() {
  String tEmployeeId = '8cdf9cd0b8e84341935e9beced9f74d3';
  Map<dynamic, dynamic> responseError = {
    'status': 'error',
    'persons': tEmployeeId,
  };

  Map<dynamic, dynamic> responsePerson = {
    'status': 'success',
    'persons': tEmployeeId,
  };

  late FaceRecognitionSynchronizationService
      faceRecognitionSynchronizationService;
  late FlutterGryfoLib flutterGryfoLib;

  setUp(() {
    flutterGryfoLib = MockFlutterGryfoLib();

    faceRecognitionSynchronizationService =
        FaceRecognitionSynchronizationServiceImpl(
      gryfoLib: flutterGryfoLib,
    );

    when(
      () => flutterGryfoLib.synchronizeExternalIds([tEmployeeId]),
    ).thenAnswer((_) async => responsePerson);
  });

  void mockVerifyNoMoreInteractions() {
    verifyNoMoreInteractions(flutterGryfoLib);
  }

  group('FaceRecognitionSynchronizationServiceImpl', () {
    test('return true when syncFaceEmployee called successfully test',
        () async {
      bool resultValue = await faceRecognitionSynchronizationService
          .syncFaceEmployee(tEmployeeId);

      expect(resultValue, true);

      verify(() => flutterGryfoLib.synchronizeExternalIds([tEmployeeId]))
          .called(1);

      mockVerifyNoMoreInteractions();
    });

    test('return false when syncFaceEmployee error test', () async {
      when(
        () => flutterGryfoLib.synchronizeExternalIds([tEmployeeId]),
      ).thenAnswer((_) async => responseError);

      bool resultValue = await faceRecognitionSynchronizationService
          .syncFaceEmployee(tEmployeeId);

      expect(resultValue, false);

      verify(() => flutterGryfoLib.synchronizeExternalIds([tEmployeeId]))
          .called(1);

      mockVerifyNoMoreInteractions();
    });
  });
}
