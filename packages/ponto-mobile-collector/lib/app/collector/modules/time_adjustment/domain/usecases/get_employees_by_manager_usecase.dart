import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/repositories/database/imanager_repository.dart';
import '../../../../core/domain/repositories/database/iplatform_user_repository.dart';

abstract class GetEmployeesByManagerUsecase {
  Future<List<Employee>?> call(
      {required String username,
      List<String>? employeeIdsFromClockingEventList,});
}

class GetEmployeesByManagerUsecaseImpl implements GetEmployeesByManagerUsecase {
  final IPlatformUserRepository _platformUserRepository;
  final IManagerRepository _managerRepository;
  final IEmployeeRepository _employeeRepository;
  List<EmployeeDto?> employeesByManagerWithAppointments = [];

  GetEmployeesByManagerUsecaseImpl({
    required IManagerRepository managerRepository,
    required IEmployeeRepository employeeRepository,
    required IPlatformUserRepository platformUserRepository,
  })  : _managerRepository = managerRepository,
        _employeeRepository = employeeRepository,
        _platformUserRepository = platformUserRepository;

  @override
  Future<List<Employee>?> call(
      {required String username,
      List<String>? employeeIdsFromClockingEventList,}) async {
    List<Employee>? employeesByManager = [];
    List<Employee> filteredEmployees = [];

    var platformUserEmployeeDto = await _platformUserRepository.findByUserName(
      username: username,
    );

    if (platformUserEmployeeDto == null || platformUserEmployeeDto.id == null) {
      return employeesByManager;
    }

    var managerEmployeeDto = await _managerRepository.findByPlatformUserId(
      platformUserId: platformUserEmployeeDto.id!,
    );

    if (managerEmployeeDto == null || managerEmployeeDto.id == null) {
      return employeesByManager;
    }

    employeesByManager = await _employeeRepository.findEmployeesByManager(
      managerId: managerEmployeeDto.id!,
    );

    if (employeeIdsFromClockingEventList != null) {
      filteredEmployees = employeesByManager.where((employee) {
        return employeeIdsFromClockingEventList.contains(employee.id);
      }).toList();
    }
    
    return filteredEmployees;
  }
}
