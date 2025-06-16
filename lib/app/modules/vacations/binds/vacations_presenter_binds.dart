import 'package:flutter_modular/flutter_modular.dart';

import '../presenter/blocs/report_vacation_bloc/report_vacation_bloc.dart';
import '../presenter/blocs/vacation_analytics/vacations_analytics_bloc.dart';
import '../presenter/blocs/vacation_calendar_bloc/vacation_calendar_staff_view_bloc.dart';
import '../presenter/blocs/vacation_request/vacation_request_bloc.dart';
import '../presenter/blocs/vacation_schedule_individual_bloc/vacation_schedule_individual_bloc.dart';
import '../presenter/blocs/vacations_bloc/vacations_bloc.dart';
import '../presenter/screens/vacation_request_screen/bloc/vacation_request_screen_bloc.dart';
import '../presenter/screens/vacations_screen/bloc/vacations_screen_bloc.dart';

class VacationsPresenterBinds {
  static List<Bind<Object>> binds = [
    // Blocs
    Bind.singleton<VacationsBloc>(
      (i) {
        return VacationsBloc(
          getVacationsUsecase: i.get(),
        );
      },
    ),

    Bind.singleton<VacationsScreenBloc>(
      (i) {
        return VacationsScreenBloc(
          vacationsBloc: i.get(),
          authorizationBloc: i.get(),
        );
      },
    ),

    Bind.singleton<VacationsAnalyticsBloc>(
      (i) {
        return VacationsAnalyticsBloc(
          getVacationsAnalyticsUsecase: i.get(),
        );
      },
      export: true,
    ),

    Bind.singleton<VacationRequestBloc>(
      (i) {
        return VacationRequestBloc(
          sendVacationRequestUsecase: i.get(),
          sendVacationRequestUpdateUseCase: i.get(),
          cancelVacationRequestUsecase: i.get(),
          
        );
      },
    ),

    Bind.singleton<VacationRequestScreenBloc>(
      (i) {
        return VacationRequestScreenBloc(
          vacationRequestBloc: i.get(),
          vacationsBloc: i.get(),
          authorizationBloc: i.get(),
        );
      },
    ),

    Bind.lazySingleton<VacationCalendarStaffViewBloc>(
      (i) {
        return VacationCalendarStaffViewBloc(
          getVacationEmployeeCalendarViewUsercase: i.get(),
        );
      },
    ),

    Bind.factory<VacationScheduleIndividualBloc>(
      (i) {
        return VacationScheduleIndividualBloc(
          getVacationScheduleIndividualUsecase: i.get(),
        );
      },
    ),

    Bind.factory<ReportVacationBloc>(
      (i) {
        return ReportVacationBloc(
          getReportVacationUsecase: i.get(),
        );
      },
    ),
  ];
}
