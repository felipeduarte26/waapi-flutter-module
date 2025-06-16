import '../../../../core/domain/entities/configuration.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/repositories/database/iconfiguration_repository.dart';
import '../../../../core/domain/usecases/get_session_employee_usecase.dart';

abstract class IGetUserFaceRecognitionUsecase {
  Future<bool> call();
}

class GetUserFaceRecognitionUsecase implements IGetUserFaceRecognitionUsecase {
  final GetSessionEmployeeUsecase _getSessionEmployeeUsecase;
  final IConfigurationRepository _configurationRepository;

  const GetUserFaceRecognitionUsecase({
    required GetSessionEmployeeUsecase getSessionEmployeeUsecase,
    required IConfigurationRepository configurationRepository,
  })  : _getSessionEmployeeUsecase = getSessionEmployeeUsecase,
        _configurationRepository = configurationRepository;

  @override
  Future<bool> call() async {

    EmployeeDto? employee = _getSessionEmployeeUsecase.call();
    if (employee != null) {
      Configuration? employeeEntity =
          await _configurationRepository.findByEmployeeId(
        employeeId: employee.id,
      );
      return employeeEntity != null &&
          employeeEntity.faceRecognition != null &&
          employeeEntity.faceRecognition!;
    }

    return false;
  }
}
