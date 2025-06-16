import '../../../../core/pagination/pagination_requirements.dart';
import '../repositories/get_payroll_repository.dart';
import '../types/financial_data_domain_types.dart';

abstract class GetPayrollUsecase {
  GetPayrollUsecaseCallback call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  });
}

class GetPayrollUsecaseImpl implements GetPayrollUsecase {
  final GetPayrollRepository _getPayrollRepository;

  GetPayrollUsecaseImpl({
    required GetPayrollRepository getPayrollRepository,
  }) : _getPayrollRepository = getPayrollRepository;

  @override
  GetPayrollUsecaseCallback call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  }) {
    return _getPayrollRepository.call(
      employeeId: employeeId,
      paginationRequirements: paginationRequirements,
    );
  }
}
