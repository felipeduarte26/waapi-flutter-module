import '../../../../../ponto_mobile_collector.dart';
import '../../external/mappers/employee_mapper.dart';
import '../input_model/employee_dto.dart';
import '../repositories/database/iemployee_platform_user_repository.dart';
import '../repositories/database/iplatform_user_repository.dart';

abstract class FindEmployeeIdByUsernameUsecase {
  Future<EmployeeDto?> call({
    required String username,
  });
}

class FindEmployeeIdByUsernameUsecaseImpl
    implements FindEmployeeIdByUsernameUsecase {
  late IEmployeeRepository _employeeRepository;
  late IPlatformUserRepository _platformUserRepository;
  late IEmployeePlatformUserRepository _employeePlatformUserRepository;

  FindEmployeeIdByUsernameUsecaseImpl({
    required IEmployeeRepository employeeRepository,
    required IPlatformUserRepository platformUserRepository,
    required IEmployeePlatformUserRepository employeePlatformUserRepository,
  }) {
    _employeeRepository = employeeRepository;
    _platformUserRepository = platformUserRepository;
    _employeePlatformUserRepository = employeePlatformUserRepository;
  }

  @override
  Future<EmployeeDto?> call({required String username}) async {
    var platformUser = await _platformUserRepository.findByUserName(username: username);
    if (platformUser == null) {
      return null;
    }
    var employeePlatformUsersTableData = await _employeePlatformUserRepository.findByPlatformUserId(platformUserId: platformUser.id!);
    var employeeId = employeePlatformUsersTableData?.employeeId;

    if (employeeId == null) {
      return null;
    }
    var entitiy = await _employeeRepository.findById(id: employeeId);
    return EmployeeMapper.fromEntityToDtoCollector(entitiy);
  }
}
