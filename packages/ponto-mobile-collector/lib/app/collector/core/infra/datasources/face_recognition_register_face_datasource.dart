import '../../domain/entities/status_face_employee.dart';

abstract class FaceRecognitionRegisterFaceDatasource {
  Future<StatusFaceEmployee?> call({
    required String imageBase64,
    String? employeeIdSelected,
  });
}
