import 'package:flutter_modular/flutter_modular.dart';

import '../domain/repositories/cancel_vacation_request_repository.dart';
import '../domain/repositories/get_report_vacation_repository.dart';
import '../domain/repositories/get_vacation_calendar_staff_view_repository.dart';
import '../domain/repositories/get_vacation_schedule_individual_repository.dart';
import '../domain/repositories/get_vacations_analytics_repository.dart';
import '../domain/repositories/get_vacations_repository.dart';
import '../domain/repositories/send_vacation_request_repository.dart';
import '../domain/repositories/send_vacation_request_update_repository.dart';
import '../infra/adapters/vacation_calendar_staff_view_entity_adapter.dart';
import '../infra/adapters/vacations_analytics_entity_adapter.dart';
import '../infra/repositories/cancel_vacation_request_repository_impl.dart';
import '../infra/repositories/get_report_vacation_repository_impl.dart';
import '../infra/repositories/get_vacation_calendar_staff_view_repository_impl.dart';
import '../infra/repositories/get_vacation_schedule_individual_repository_impl.dart';
import '../infra/repositories/get_vacations_analytics_repository_impl.dart';
import '../infra/repositories/get_vacations_repository_impl.dart';
import '../infra/repositories/send_vacation_request_repository_impl.dart';
import '../infra/repositories/send_vacation_request_update_repository_impl.dart';

class VacationsInfraBinds {
  static List<Bind<Object>> binds = [
    // Repositories
    Bind.factory<GetVacationsRepository>(
      (i) {
        return GetVacationsRepositoryImpl(
          getVacationsDatasource: i.get(),
          
        );
      },
    ),

    Bind.factory<GetVacationsAnalyticsRepository>(
      (i) {
        return GetVacationsAnalyticsRepositoryImpl(
          
          getVacationsAnalyticsDatasource: i.get(),
          vacationsAnalyticsEntityAdapter: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SendVacationRequestRepository>(
      (i) {
        return SendVacationRequestRepositoryImpl(
          
          sendVacationRequestDatasource: i.get(),
          
        );
      },
    ),

    Bind.factory<SendVacationRequestUpdateRepository>(
      (i) {
        return SendVacationRequestUpdateRepositoryImpl(
          
          sendVacationRequestUpdateDatasource: i.get(),
          
        );
      },
    ),

    Bind.factory<CancelVacationRequestRepository>(
      (i) {
        return CancelVacationRequestRepositoryImpl(
          
          cancelVacationRequestDatasource: i.get(),
          
          cancelVacationApprovedRequestDatasource: i.get(),
        );
      },
    ),

    Bind.factory<GetReportVacationRepository>(
      (i) {
        return GetReportVacationRepositoryImpl(
          
          getReportVacationDatasource: i.get(),
        );
      },
    ),

    Bind.factory<GetVacationCalendarStaffViewRepository>(
      (i) {
        return GetVacationCalendarStaffViewRepositoryImpl(
          
          getVacationEmployeeCalendarViewDatasource: i.get(),
          vacationEmployeeCalendarViewEntityAdapter: i.get(),
        );
      },
    ),

    Bind.factory<GetVacationScheduleIndividualRepository>(
      (i) {
        return GetVacationScheduleIndividualRepositoryImpl(
          
          getVacationScheduleIndividualDatasource: i.get(),
        );
      },
    ),

    // Adapters
    Bind.factory<VacationsAnalyticsEntityAdapter>(
      (i) {
        return VacationsAnalyticsEntityAdapter();
      },
      export: true,
    ),

    Bind.factory<VacationCalendarStaffViewEntityAdapter>(
      (i) {
        return VacationCalendarStaffViewEntityAdapter();
      },
      export: true,
    ),
  ];
}
