
import '../../../../../ponto_mobile_collector.dart';
import '../input_model/employee_dto.dart';

abstract class GetSessionEmployeeUsecase {
  EmployeeDto? call();
}

class GetSessionEmployeeUsecaseImpl implements GetSessionEmployeeUsecase {
  final ISessionService _sessionService;

  const GetSessionEmployeeUsecaseImpl({
    required ISessionService sessionService,
  }) : _sessionService = sessionService;

  @override
  EmployeeDto? call() {
    if (_sessionService.hasEmployee()) {
      return _sessionService.getEmployee();
    }

    return null;
  }
}
