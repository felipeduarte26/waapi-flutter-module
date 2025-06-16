
import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
abstract class IGetEmployeeUsecase {
  EmployeeDto? call();
}

class GetEmployeeUsecase implements IGetEmployeeUsecase {
  final ISessionService _sessionService;

  const GetEmployeeUsecase({
    required ISessionService sessionService,
  })  : _sessionService = sessionService;

  @override
  EmployeeDto? call() {
    if (_sessionService.hasEmployee()) {
      return _sessionService.getEmployee();
    } else {
      return null;
    }
  }
} 
