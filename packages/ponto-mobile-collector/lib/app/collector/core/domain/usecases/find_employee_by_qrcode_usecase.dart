import '../../external/mappers/employee_mapper.dart';
import '../input_model/employee_dto.dart';
import '../repositories/database/iemployee_repository.dart';

abstract class FindEmployeeIdByQrCodeUsecase {

  Future<EmployeeDto?> call({
    required String qrcode,
  });
}

class FindEmployeeIdByQrCodeUsecaseImpl
    implements FindEmployeeIdByQrCodeUsecase {
  final IEmployeeRepository _employeeRepository;

  FindEmployeeIdByQrCodeUsecaseImpl({
    required IEmployeeRepository employeeRepository,
  }) : _employeeRepository = employeeRepository;

  @override
  Future<EmployeeDto?> call({required String qrcode}) async {
    var entity = await _employeeRepository.findByEmployeeCodeAndEnable(employeeCode: qrcode);
    return EmployeeMapper.fromEntityToDtoCollector(entity);
  }
}
