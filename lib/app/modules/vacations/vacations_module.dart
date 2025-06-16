import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'binds/vacations_domain_binds.dart';
import 'binds/vacations_external_binds.dart';
import 'binds/vacations_infra_binds.dart';
import 'binds/vacations_presenter_binds.dart';
import 'presenter/screens/opened_period_details_screen/opened_period_details_screen.dart';
import 'presenter/screens/paid_period_details_screen/paid_period_details_screen.dart';
import 'presenter/screens/report_link_pdf_view_screen/report_view_pdf_screen.dart';
import 'presenter/screens/vacation_request_details_screen/vacation_request_details_screen.dart';
import 'presenter/screens/vacation_request_screen/vacation_request_screen.dart';
import 'presenter/screens/vacations_screen/vacations_screen.dart';

class VacationsModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...VacationsDomainBinds.binds,
      ...VacationsInfraBinds.binds,
      ...VacationsExternalBinds.binds,
      ...VacationsPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        VacationsRoutes.vacationsScreenRoute,
        child: (_, args) {
          return VacationsScreen(
            employeeId: args.data['employeeId'],
          );
        },
      ),
      ChildRoute(
        VacationsRoutes.paidPeriodDetailsScreenRoute,
        child: (_, args) {
          return PaidPeriodDetailsScreen(
            vacationPeriodId: args.data['vacationPeriodId'],
            employeeId: args.data['employeeId'],
          );
        },
      ),
      ChildRoute(
        VacationsRoutes.openedPeriodDetailsScreenRoute,
        child: (_, args) {
          return OpenedPeriodDetailsScreen(
            vacationPeriodId: args.data['vacationPeriodId'],
            employeeId: args.data['employeeId'],
          );
        },
      ),
      ChildRoute(
        VacationsRoutes.requestVacationScreenRoute,
        child: (_, args) {
          return VacationRequestScreen(
            employeeId: args.data['employeeId'],
            isRequestVacationUpdate: args.data['isRequestVacationUpdate'] ?? false,
            vacationDetailEntity: args.data['vacationDetailEntity'],
            vacationPeriodId: args.data['vacationPeriodId'],
            id: args.data['id'],
          );
        },
      ),
      ChildRoute(
        VacationsRoutes.requestVacationDetailsScreenRoute,
        child: (_, args) {
          return VacationRequestDetailsScreen(
            vacationDetail: args.data['vacationDetails'],
            employeeId: args.data['employeeId'],
            vacationPeriodId: args.data['vacationPeriodId'],
          );
        },
      ),
      ChildRoute(
        VacationsRoutes.reportPdfViewScreenRoute,
        child: (_, args) {
          return ReportViewPdfScreen(
            filePath: args.data['filePath'],
            title: args.data['title'],
          );
        },
      ),
    ];
  }
}
