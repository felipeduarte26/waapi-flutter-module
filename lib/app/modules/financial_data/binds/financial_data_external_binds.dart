import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../external/datasources/get_earnings_report_datasource_impl.dart';
import '../external/datasources/get_historical_jobposition_datasource_impl.dart';
import '../external/datasources/get_payroll_datasource_impl.dart';
import '../external/mappers/historical_job_position_model_mapper.dart';
import '../external/mappers/payroll_model_mapper.dart';
import '../infra/datasources/get_earnings_report_datasource.dart';
import '../infra/datasources/get_historical_jobposition_datasource.dart';
import '../infra/datasources/get_payroll_datasource.dart';

class FinancialDataExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.factory<GetPayrollDatasource>(
      (i) {
        return GetPayrollDatasourceImpl(
          restService: i.get(),
          payrollMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetEarningsReportDatasource>(
      (i) {
        return GetEarningsReportDatasourceImpl(
          restService: i.get(),
          getStoredTokenUsecase: GetStoredTokenUsecase(),
          getStoredUserUsecase: GetStoredUserUsecase(),
          integrationUserRepositoryImpl: i.get(),
        );
      },
    ),

    Bind.factory<GetHistoricalJobpositionDataSource>(
      (i) {
        return GetHistoricalJobpositionDatasourceImpl(
          restService: i.get(),
          historicalJobPositionModelMapper: i.get(),
        );
      },
    ),

    // Mappers
    Bind.factory<PayrollModelMapper>(
      (i) {
        return PayrollModelMapper();
      },
      export: true,
    ),

    Bind.factory<HistoricalJobPositionModelMapper>(
      (i) {
        return HistoricalJobPositionModelMapper();
      },
      export: true,
    ),
  ];
}
