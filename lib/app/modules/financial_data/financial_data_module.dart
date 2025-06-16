import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import '../g5/g5_module.dart';
import 'binds/financial_data_domain_binds.dart';
import 'binds/financial_data_external_binds.dart';
import 'binds/financial_data_infra_binds.dart';
import 'binds/financial_data_presenter_binds.dart';
import 'presenter/screens/payroll_screen/payroll_screen.dart';

class FinancialDataModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...FinancialDataDomainBinds.binds,
      ...FinancialDataExternalBinds.binds,
      ...FinancialDataInfraBinds.binds,
      ...FinancialDataPresenterBinds.binds,
    ];
  }

  @override
  List<Module> get imports {
    return [
      ...super.imports,
      G5Module(),
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        FinancialDataRoutes.payrollScreenRoute,
        child: (_, args) {
          return PayrollScreen(
            employeeId: args.data['employeeId'],
          );
        },
      ),
    ];
  }
}
