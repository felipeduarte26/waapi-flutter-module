import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/external/mappers/employee_mapper.dart';

abstract class IGetEmployeeDtoUsecase {
  Future<EmployeeDto?> call({required String id});
}

class GetEmployeeDtoUsecase implements IGetEmployeeDtoUsecase {
  final IEmployeeRepository _employeeRepository;

  const GetEmployeeDtoUsecase({
    required IEmployeeRepository employeeRepository,
  }) : _employeeRepository = employeeRepository;

  @override
  Future<EmployeeDto?> call({required String id}) async {
    var entity = await _employeeRepository.findById(id: id);
    return EmployeeMapper.fromEntityToDtoCollector(entity);
  }
}
