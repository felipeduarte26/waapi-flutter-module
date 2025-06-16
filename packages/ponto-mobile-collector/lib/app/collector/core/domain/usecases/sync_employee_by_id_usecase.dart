import '../../external/mappers/configuration_mapper.dart';
import '../../external/mappers/employee_mapper.dart';
import '../entities/employee.dart';
import '../entities/multi_employee_sync.dart';
import '../entities/page_entity.dart';
import '../entities/page_response_entity.dart';
import '../enums/work_indicator_type.dart';
import '../repositories/database/iconfiguration_repository.dart';
import '../repositories/database/iemployee_repository.dart';
import '../services/iemployee_sync_service.dart';
import '../services/work_indicator_service.dart';

/// Synchronizes all employee information with the id entered in the parameter.
abstract class SyncEmployeeByIdUsecase {
  Future<MultiEmployeeSync?> call({required String? employeeId});
}

class SyncEmployeeByIdUsecaseImpl implements SyncEmployeeByIdUsecase {
  final IEmployeeSyncService _employeeSyncService;
  final WorkIndicatorService _workIndicatorService;
  final IEmployeeRepository _employeeRepository;
  final IConfigurationRepository _configurationRepository;
  final syncEmployeeById = WorkIndicatorType.syncEmployeeById;

  SyncEmployeeByIdUsecaseImpl({
    required IEmployeeSyncService employeeSyncService,
    required WorkIndicatorService workIndicatorService,
    required IEmployeeRepository employeeRepository,
    required IConfigurationRepository configurationRepository,
  })  : _employeeSyncService = employeeSyncService,
        _workIndicatorService = workIndicatorService,
        _employeeRepository = employeeRepository,
        _configurationRepository = configurationRepository;

  @override
  Future<MultiEmployeeSync?> call({
    required String? employeeId,
  }) async {
    try {
      _workIndicatorService.addWorkIndicator(
        workIndicatorType: syncEmployeeById,
      );

      PageResponseEntity<MultiEmployeeSync> response =
          await _employeeSyncService.getEmployees(
        pageEntity: PageEntity(
          page: 0,
          pageSize: 1,
        ),
        employeeIdFilter: employeeId,
      );

      if (response.content.isNotEmpty) {
        Employee? employeeEntity =
            EmployeeMapper.fromDtoToEntityCollector(
          response.content[0].employee,
        );
        if (employeeEntity != null) {
          await _employeeRepository.save(employee: employeeEntity);
        }

        await _configurationRepository.save(
          config: ConfigurationMapper.fromDtoToEntityCollector(
              response.content[0].configuration,),
          employeeId: response.content[0].employee.id,
        );

        _workIndicatorService.removeWorkIndicator(
          workIndicatorType: syncEmployeeById,
        );

        return response.content[0];
      } else {
        _workIndicatorService.removeWorkIndicator(
          workIndicatorType: syncEmployeeById,
        );

        return null;
      }
    } catch (e) {
      _workIndicatorService.removeWorkIndicator(
        workIndicatorType: syncEmployeeById,
      );

      rethrow;
    }
  }
}
