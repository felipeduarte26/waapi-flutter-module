import '../entities/status_face_employee.dart';

abstract class FaceRecognitionRegisterFaceRepository {
  Future<StatusFaceEmployee?> call({
    required String imageBase64,
    String? employeeIdSelected,
  });
}
