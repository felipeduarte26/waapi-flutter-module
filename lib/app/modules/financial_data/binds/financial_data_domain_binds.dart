import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/get_earnings_reports_usecase.dart';
import '../domain/usecases/get_payroll_usecase.dart';

class FinancialDataDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.factory<GetPayrollUsecase>((i) {
      return GetPayrollUsecaseImpl(
        getPayrollRepository: i.get(),
      );
    }),

    Bind.factory<GetEarningsReportsUsecase>((i) {
      return GetEarningsReportsUsecaseImpl(
        getG5ConnectorUsecase: i.get(),
        getEarningsReportsRepository: i.get(),
      );
    }),
  ];
}
