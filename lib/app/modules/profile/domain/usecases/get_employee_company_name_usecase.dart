import '../repositories/get_employee_company_name_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetEmployeeCompanyNameUsecase {
  GetEmployeeCompanyNameUsecaseCallback call({
    required String employeeId,
  });
}

class GetEmployeeCompanyNameUsecaseImpl implements GetEmployeeCompanyNameUsecase {
  final GetEmployeeCompanyNameRepository _getEmployeeCompanyNameRepository;

  const GetEmployeeCompanyNameUsecaseImpl({
    required GetEmployeeCompanyNameRepository getEmployeeCompanyNameRepository,
  }) : _getEmployeeCompanyNameRepository = getEmployeeCompanyNameRepository;

  @override
  GetEmployeeCompanyNameUsecaseCallback call({
    required String employeeId,
  }) {
    return _getEmployeeCompanyNameRepository.call(
      employeeId: employeeId,
    );
  }
}
