import '../../domain/entities/status_face_employee.dart';
import '../../domain/repositories/face_recognition_register_face_repository.dart';
import '../datasources/face_recognition_register_face_datasource.dart';

class FaceRecognitionRegisterFaceRepositoryImpl
    implements FaceRecognitionRegisterFaceRepository {
  final FaceRecognitionRegisterFaceDatasource
      _faceRecognitionRegisterFaceDatasource;
  FaceRecognitionRegisterFaceRepositoryImpl({
    required FaceRecognitionRegisterFaceDatasource
        faceRecognitionRegisterFaceDatasource,
  }) : _faceRecognitionRegisterFaceDatasource =
            faceRecognitionRegisterFaceDatasource;

  @override
  Future<StatusFaceEmployee?> call({
    required String imageBase64,
    String? employeeIdSelected,
  }) {
    return _faceRecognitionRegisterFaceDatasource.call(
      imageBase64: imageBase64,
      employeeIdSelected: employeeIdSelected,
    );
  }
}
