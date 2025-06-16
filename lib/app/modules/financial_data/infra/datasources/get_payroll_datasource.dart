import '../../../../core/pagination/pagination_requirements.dart';
import '../models/payroll_model.dart';

abstract class GetPayrollDatasource {
  Future<List<PayrollModel>> call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  });
}
