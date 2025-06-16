import '../types/profile_domain_types.dart';

abstract class GetContractEmployeeRepository {
  GetContractEmployeeUsecaseCallback call({
    required String employeeId,
  });
}
