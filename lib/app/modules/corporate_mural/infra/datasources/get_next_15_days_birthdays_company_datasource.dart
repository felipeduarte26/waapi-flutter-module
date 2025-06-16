import '../../../../core/pagination/pagination_requirements.dart';
import '../models/employees_by_year_hire_model.dart';

abstract class GetNext15DaysBirthdaysCompanyDatasource {
  Future<List<EmployeesByYearHireModel>> call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  });
}
