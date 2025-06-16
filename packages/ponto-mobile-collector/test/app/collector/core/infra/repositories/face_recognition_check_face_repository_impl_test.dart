import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_check_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/face_recognition_check_face_repository_impl.dart';

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

void main() {
  String tEmployeeId = 'tEmployeeId';
  Map<dynamic, dynamic> employeesMapFalse = {'status': 'erro'};
  Map<dynamic, dynamic> employeesMapTrue = {'external_ids': '["$tEmployeeId"]'};
  late FaceRecognitionCheckFaceRepository faceRecognitionCheckFaceRepository;
  late FlutterGryfoLib flutterGryfoLib;

  setUp(() {
    flutterGryfoLib = MockFlutterGryfoLib();
    faceRecognitionCheckFaceRepository = FaceRecognitionCheckFaceRepositoryImpl(
      gryfoLib: flutterGryfoLib,
    );

    when(
      () => flutterGryfoLib.getRegistered(),
    ).thenAnswer((_) async => employeesMapTrue);
  });

  group('FaceRecognitionRegisterCompanyRepositoryImpl', () {
    test('returns true when the employee is found test', () async {
      bool result = await faceRecognitionCheckFaceRepository.call(
        employeeId: tEmployeeId,
      );

      expect(result, true);
      verify(() => flutterGryfoLib.getRegistered()).called(1);
    });

    test('returns false when the employee not found test', () async {
      when(
        () => flutterGryfoLib.getRegistered(),
      ).thenAnswer((_) async => employeesMapFalse);

      bool result = await faceRecognitionCheckFaceRepository.call(
        employeeId: tEmployeeId,
      );

      expect(result, false);
      verify(() => flutterGryfoLib.getRegistered()).called(1);
    });
  });
}
