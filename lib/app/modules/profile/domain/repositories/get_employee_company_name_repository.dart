import '../types/profile_domain_types.dart';

abstract class GetEmployeeCompanyNameRepository {
  GetEmployeeCompanyNameUsecaseCallback call({
    required String employeeId,
  });
}
