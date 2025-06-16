import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_employee_company_name_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/get_employee_company_name_datasource.dart';

class GetEmployeeCompanyNameRepositoryImpl implements GetEmployeeCompanyNameRepository {
  final GetEmployeeCompanyNameDatasource _getEmployeeCompanyNameDatasource;

  const GetEmployeeCompanyNameRepositoryImpl({
    required GetEmployeeCompanyNameDatasource getEmployeeCompanyNameDatasource,
  }) : _getEmployeeCompanyNameDatasource = getEmployeeCompanyNameDatasource;

  @override
  GetEmployeeCompanyNameUsecaseCallback call({
    required String employeeId,
  }) async {
    try {
      final companyName = await _getEmployeeCompanyNameDatasource.call(
        employeeId: employeeId,
      );

      return right(companyName);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
