import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/status_face_employee.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/face_recognition_register_face_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/datasources/face_recognition_register_face_datasource.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/face_recognition_register_face_repository_impl.dart';

class MockFaceRecognitionRegisterFaceDatasource extends Mock
    implements FaceRecognitionRegisterFaceDatasource {}

void main() {
  String tImageBase64 = 'tImageBase64';
  String tEmployeeIdSelected = 'tEmployeeIdSelected';
  StatusFaceEmployee statusFaceEmployee = const StatusFaceEmployee();
  late FaceRecognitionRegisterFaceRepository
      faceRecognitionRegisterFaceRepository;
  late FaceRecognitionRegisterFaceDatasource
      faceRecognitionRegisterFaceDatasource;

  setUp(() {
    faceRecognitionRegisterFaceDatasource =
        MockFaceRecognitionRegisterFaceDatasource();

    faceRecognitionRegisterFaceRepository =
        FaceRecognitionRegisterFaceRepositoryImpl(
      faceRecognitionRegisterFaceDatasource:
          faceRecognitionRegisterFaceDatasource,
    );

    when(
      () => faceRecognitionRegisterFaceDatasource.call(
        imageBase64: tImageBase64,
        employeeIdSelected: tEmployeeIdSelected,
      ),
    ).thenAnswer((_) async => statusFaceEmployee);
  });

  group('FaceRecognitionRegisterFaceRepositoryImpl', () {
    test('call register face successfully test', () async {
      StatusFaceEmployee? resultValue =
          await faceRecognitionRegisterFaceRepository.call(
        imageBase64: tImageBase64,
        employeeIdSelected: tEmployeeIdSelected,
      );

      expect(resultValue, statusFaceEmployee);

      verify(
        () => faceRecognitionRegisterFaceDatasource.call(
          imageBase64: tImageBase64,
          employeeIdSelected: tEmployeeIdSelected,
        ),
      ).called(1);

      verifyNoMoreInteractions(faceRecognitionRegisterFaceDatasource);
    });
  });
}
