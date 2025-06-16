abstract class VacationsRoutes {
  // Module route name
  static const String vacationsModuleRoute = '/vacations';

  // Vacations screen routes name
  static const String vacationsScreenRoute = '/';
  static const String vacationsScreenInitialRoute = '$vacationsModuleRoute$vacationsScreenRoute';

  // Opened vacations screen routes name
  static const String openedPeriodDetailsScreenRoute = '/opened_period_details';
  static const String openedPeriodDetailsScreenInitialRoute = '$vacationsModuleRoute$openedPeriodDetailsScreenRoute';

  // Paid vacations screen routes name
  static const String paidPeriodDetailsScreenRoute = '/paid_period_details';
  static const String paidPeriodDetailsScreenInitialRoute = '$vacationsModuleRoute$paidPeriodDetailsScreenRoute';

  // Request vacations screen routes name
  static const String requestVacationScreenRoute = '/request_vacation';
  static const String requestVacationScreenInitialRoute = '$vacationsModuleRoute$requestVacationScreenRoute';

  static const String requestVacationDetailsScreenRoute = '/request_vacation_details';
  static const String requestVacationDetailsScreenInitialRoute =
      '$vacationsModuleRoute$requestVacationDetailsScreenRoute';

  static const String reportPdfViewScreenRoute = '/report_view_pdf';
  static const String reportPdfViewScreenRouteInitialRoute = '$vacationsModuleRoute$reportPdfViewScreenRoute';
}
