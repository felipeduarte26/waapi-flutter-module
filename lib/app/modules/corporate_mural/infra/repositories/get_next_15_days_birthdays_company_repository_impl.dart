import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/corporate_mural_failure.dart';
import '../../domain/repositories/get_next_15_days_birthdays_company_repository.dart';
import '../../domain/types/corporate_mural_domain_types.dart';
import '../adapters/employees_by_year_hire_entity_adapter.dart';
import '../datasources/get_next_15_days_birthdays_company_datasource.dart';

class GetNext15DaysBirthdaysCompanyRepositoryImpl implements GetNext15DaysBirthdaysCompanyRepository {
  final GetNext15DaysBirthdaysCompanyDatasource _getNext15DaysBirthdaysCompanyDatasource;
  final EmployeesByYearHireEntityAdapter _employeesByYearHireEntityAdapter;

  const GetNext15DaysBirthdaysCompanyRepositoryImpl({
    required GetNext15DaysBirthdaysCompanyDatasource getNext15DaysBirthdaysCompanyDatasource,
    required EmployeesByYearHireEntityAdapter employeesByYearHireEntityAdapter,
  })  : _getNext15DaysBirthdaysCompanyDatasource = getNext15DaysBirthdaysCompanyDatasource,
        _employeesByYearHireEntityAdapter = employeesByYearHireEntityAdapter;

  @override
  GetNext15DaysBirthdaysCompanyUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  }) async {
    try {
      final employeesByYearHireList = await _getNext15DaysBirthdaysCompanyDatasource.call(
        paginationRequirements: paginationRequirements,
        currentDate: currentDate,
        employeeId: employeeId,
      );

      final employeesByYearHireEntityList = employeesByYearHireList.map((employeesByYearHireModel) {
        return _employeesByYearHireEntityAdapter.fromModel(
          employeesByYearHireModel: employeesByYearHireModel,
        );
      }).toList();

      return right(employeesByYearHireEntityList);
    } catch (error) {
      return left(const CorporateMuralDatasourceFailure());
    }
  }
}
