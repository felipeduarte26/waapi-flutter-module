import '../../../../core/pagination/pagination_requirements.dart';
import '../types/corporate_mural_domain_types.dart';

abstract class GetNext15DaysBirthdayEmployeesRepository {
  GetNext15DaysBirthdayEmployeesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required DateTime currentDate,
    required String employeeId,
  });
}
