import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/entities/payroll_entity.dart';
import '../../domain/failures/financial_data_failure.dart';
import '../../domain/repositories/get_payroll_repository.dart';
import '../../domain/types/financial_data_domain_types.dart';
import '../adapters/payroll_entity_adapter.dart';
import '../datasources/get_historical_jobposition_datasource.dart';
import '../datasources/get_payroll_datasource.dart';

class GetPayrollRepositoryImpl implements GetPayrollRepository {
  final GetPayrollDatasource _getPayrollDatasource;
  final GetHistoricalJobpositionDataSource _getHistoricalJobpositionDataSource;
  final PayrollEntityAdapter _payrollEntityAdapter;
 

  GetPayrollRepositoryImpl({
    required GetPayrollDatasource getPayrollDatasource,
    required PayrollEntityAdapter payrollEntityAdapter,
    
    required GetHistoricalJobpositionDataSource getHistoricalJobpositionDataSource,
  })  : _getPayrollDatasource = getPayrollDatasource,
        _payrollEntityAdapter = payrollEntityAdapter,
        
        _getHistoricalJobpositionDataSource = getHistoricalJobpositionDataSource;

  @override
  GetPayrollUsecaseCallback call({
    required String employeeId,
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final historicalJobpositionList = await _getHistoricalJobpositionDataSource.call(
        employeeId: employeeId,
      );

      final payrollModel = await _getPayrollDatasource.call(
        employeeId: employeeId,
        paginationRequirements: paginationRequirements,
      );

      Set<PayrollEntity>? payrollEntitList = {};

      for (var payroll in payrollModel) {
        payrollEntitList.add(
          _payrollEntityAdapter.fromModel(
            payrollModel: payroll,
            historicalJobPositionModel: historicalJobpositionList,
          ),
        );
      }

      return right(payrollEntitList);
    } catch (error) {


      return left(
        FinancialDataDatasourceFailure(
          message: error.toString(),
        ),
      );
    }
  }
}
