import '../../../../core/pagination/pagination_requirements.dart';
import '../models/birthday_employees_model.dart';

abstract class GetNext15DaysBirthdayEmployeesDatasource {
  Future<BirthdayEmployeesModel?> call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  });
}
