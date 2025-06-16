import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/get_earnings_reports_repository.dart';
import '../domain/repositories/get_payroll_repository.dart';
import '../infra/adapters/historical_job_position_entity_adapter.dart';
import '../infra/adapters/payroll_entity_adapter.dart';
import '../infra/repositories/get_earnings_reports_repository_impl.dart';
import '../infra/repositories/get_payroll_repository_impl.dart';

class FinancialDataInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.factory<GetPayrollRepository>(
      (i) {
        return GetPayrollRepositoryImpl(
          
          getPayrollDatasource: i.get(),
          payrollEntityAdapter: i.get(),
          getHistoricalJobpositionDataSource: i.get(),
        );
      },
    ),

    Bind.factory<GetEarningsReportsRepository>(
      (i) {
        return GetEarningsReportsRepositoryImpl(
          
          getEarningsReportsDatasource: i.get(),
        );
      },
    ),

    // Adapters
    Bind.factory<PayrollEntityAdapter>(
      (i) {
        return PayrollEntityAdapter();
      },
      export: true,
    ),

    // Adapters
    Bind.factory<HistoricalJobPositionEntityAdapter>(
      (i) {
        return HistoricalJobPositionEntityAdapter();
      },
      export: true,
    ),
  ];
}
