
import '../../../../core/pagination/pagination_requirements.dart';
import '../types/financial_data_domain_types.dart';

abstract class GetPayrollRepository {
  GetPayrollUsecaseCallback call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  });
}
