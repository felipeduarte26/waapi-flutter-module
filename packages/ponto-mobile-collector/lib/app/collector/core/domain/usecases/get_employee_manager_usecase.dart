import '../../../../../ponto_mobile_collector.dart';
import '../../external/mappers/employee_mapper.dart';
import '../input_model/employee_dto.dart';
import '../repositories/database/iemployee_platform_user_repository.dart';
import '../repositories/database/iplatform_user_repository.dart';

abstract class GetEmployeeManagerUsecase {
  Future<EmployeeDto?> call({required String username});
}

class GetEmployeeManagerUsecaseImpl implements GetEmployeeManagerUsecase {
  final IEmployeeRepository _employeeRepository;
  final IEmployeePlatformUserRepository _employeePlatformUserRepository;
  final IPlatformUserRepository _platformUserRepository;

  GetEmployeeManagerUsecaseImpl({
    required IEmployeeRepository employeeRepository,
    required IEmployeePlatformUserRepository employeePlatformUserRepository,
    required IPlatformUserRepository platformUserRepository,
  })  : _employeeRepository = employeeRepository,
        _employeePlatformUserRepository = employeePlatformUserRepository,
        _platformUserRepository = platformUserRepository;

  @override
  Future<EmployeeDto?> call({required String username}) async {
    var platformUserEmployeeDto = await _platformUserRepository.findByUserName(
      username: username,
    );

    if (platformUserEmployeeDto == null || platformUserEmployeeDto.id == null) {
      return null;
    }

    var employeePlatformUsersTableData =
        await _employeePlatformUserRepository.findByPlatformUserId(
      platformUserId: platformUserEmployeeDto.id!,
    );

    if (employeePlatformUsersTableData == null) {
      return null;
    }

    var entity = await _employeeRepository.findById(
      id: employeePlatformUsersTableData.employeeId,
    );
    return EmployeeMapper.fromEntityToDtoCollector(entity);
  }
}
