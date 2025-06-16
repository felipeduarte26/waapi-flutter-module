import '../../../../../ponto_mobile_collector.dart';
import '../entities/status_face_employee.dart';
import '../repositories/face_recognition_register_face_repository.dart';

abstract class IRegisterFaceEmployeeUsecase {
  Future<StatusFaceEmployee?> call(
    String imageBase64,
    String? employeeSelected,
  );
}

class RegisterFaceEmployeeUsecase implements IRegisterFaceEmployeeUsecase {
  final FaceRecognitionRegisterFaceRepository
      _faceRecognitionRegisterFaceRepository;
  final ISessionService _sessionService;
  final IEmployeeRepository _employeeRepository;

  const RegisterFaceEmployeeUsecase({
    required FaceRecognitionRegisterFaceRepository
        faceRecognitionRegisterFaceRepository,
    required ISessionService sessionService,
    required IEmployeeRepository employeeRepository,
  })  : _faceRecognitionRegisterFaceRepository =
            faceRecognitionRegisterFaceRepository,
        _sessionService = sessionService,
        _employeeRepository = employeeRepository;

  @override
  Future<StatusFaceEmployee?> call(
    String imageBase64,
    String? employeeSelected,
  ) async {
    String employeeId;

    if (employeeSelected != null) {
      employeeId = employeeSelected;
    } else {
      employeeId = _sessionService.getEmployeeId();
    }

    StatusFaceEmployee? gryfoFaceEmployee =
        await _faceRecognitionRegisterFaceRepository.call(
      imageBase64: imageBase64,
      employeeIdSelected: employeeSelected,
    );

    if (employeeSelected == null) {
      if (gryfoFaceEmployee != null && gryfoFaceEmployee.success!) {
        var employeeIdNoDash = employeeId.replaceAll('-', '');
        _sessionService.setFaceRegistered(id: employeeIdNoDash);
        _employeeRepository.updateFaceRegisteredByEmployeeId(
          employeeId: employeeId,
        );
      }
    }

    return gryfoFaceEmployee;
  }
}
