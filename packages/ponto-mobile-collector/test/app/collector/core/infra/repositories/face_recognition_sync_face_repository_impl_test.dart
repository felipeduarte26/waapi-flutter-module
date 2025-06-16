import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_sync_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/face_recognition_sync_face_repository_impl.dart';

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

class MockLogService extends Mock implements LogService {}

void main() {
  List<String> tEmployeesId = ['tEmployeeId'];
  Map<dynamic, dynamic> responseSuccess = {'status': 'success'};
  Map<dynamic, dynamic> responseError = {'status': 'error'};
  late FaceRecognitionSyncFaceRepository faceRecognitionSyncFaceRepository;
  late FlutterGryfoLib flutterGryfoLib;
  late LogService logService;

  setUp(() {
    flutterGryfoLib = MockFlutterGryfoLib();
    logService = MockLogService();

    faceRecognitionSyncFaceRepository = FaceRecognitionSyncFaceRepositoryImpl(
      gryfoLib: flutterGryfoLib,
      logService: logService,
    );

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    when(
      () => flutterGryfoLib.synchronizeExternalIds(tEmployeesId),
    ).thenAnswer((_) async => responseSuccess);
  });

  group('FaceRecognitionRegisterCompanyRepositoryImpl', () {
    test('returns true when the employee is found test', () async {
      bool result = await faceRecognitionSyncFaceRepository.call(
        employeesId: tEmployeesId,
      );

      expect(result, true);
      verify(() => flutterGryfoLib.synchronizeExternalIds(tEmployeesId))
          .called(1);
    });

    test('returns false when the employee not found test', () async {
      when(
        () => flutterGryfoLib.synchronizeExternalIds(tEmployeesId),
      ).thenAnswer((_) async => responseError);

      bool result = await faceRecognitionSyncFaceRepository.call(
        employeesId: tEmployeesId,
      );

      expect(result, false);
      verify(() => flutterGryfoLib.synchronizeExternalIds(tEmployeesId))
          .called(1);
    });
  });
}
