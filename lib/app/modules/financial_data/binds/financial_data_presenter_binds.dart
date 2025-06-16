import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/bloc/earnings_report_bloc/earnings_report_bloc.dart';
import '../presenter/bloc/payroll_bloc/payroll_bloc.dart';
import '../presenter/screens/payroll_screen/bloc/payroll_screen_bloc.dart';

class FinancialDataPresenterBinds {
  static List<Bind<Object>> binds = [
    Bind.factory<EarningsReportBloc>(
      (i) {
        return EarningsReportBloc(
          getEarningsReportsUsecase: i.get(),
        );
      },
      export: true,
    ),
    Bind.lazySingleton<PayrollBloc>((i) {
      return PayrollBloc(
        getPayrollUsecase: i.get(),
      );
    }),
    Bind.lazySingleton<PayrollScreenBloc>(
      (i) {
        return PayrollScreenBloc(
          payrollBloc: i.get(),
          contractEmployeeBloc: i.get(),
          personalizationBloc: i.get(),
          profileBloc: i.get(),
        );
      },
      export: true,
    ),
  ];
}
