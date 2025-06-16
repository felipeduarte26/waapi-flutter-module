import '../repositories/get_contract_employee_repository.dart';
import '../types/profile_domain_types.dart';

abstract class GetContractEmployeeUsecase {
  GetContractEmployeeUsecaseCallback call({
    required String employeeId,
  });
}

class GetContractEmployeeUsecaseImpl implements GetContractEmployeeUsecase {
  final GetContractEmployeeRepository _getContractEmployeeRepository;

  const GetContractEmployeeUsecaseImpl({
    required GetContractEmployeeRepository getContractEmployeeRepository,
  }) : _getContractEmployeeRepository = getContractEmployeeRepository;

  @override
  GetContractEmployeeUsecaseCallback call({
    required String employeeId,
  }) {
    return _getContractEmployeeRepository.call(
      employeeId: employeeId,
    );
  }
}
