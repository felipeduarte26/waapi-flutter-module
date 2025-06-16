import '../../../../core/types/either.dart';
import '../entities/payroll_entity.dart';
import '../failures/financial_data_failure.dart';

typedef GetPayrollUsecaseCallback = Future<Either<FinancialDataFailure, Set<PayrollEntity>>>;
typedef GetEarningsReportsUsecaseCallback = Future<Either<FinancialDataFailure, List<int>>>;
