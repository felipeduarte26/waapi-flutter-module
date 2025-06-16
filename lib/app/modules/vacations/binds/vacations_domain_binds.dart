import 'package:flutter_modular/flutter_modular.dart';

import '../domain/usecases/cancel_vacation_request_usecase.dart';
import '../domain/usecases/get_report_vacation_usecase.dart';
import '../domain/usecases/get_vacation_calendar_staff_view_usercase.dart';
import '../domain/usecases/get_vacation_schedule_individual_usecase.dart';
import '../domain/usecases/get_vacations_analytics_usecase.dart';
import '../domain/usecases/get_vacations_usecase.dart';
import '../domain/usecases/send_vacation_request_update_usecase.dart';
import '../domain/usecases/send_vacation_request_usecase.dart';

class VacationsDomainBinds {
  static List<Bind<Object>> binds = [
    // Usecases
    Bind.factory<GetVacationsUsecase>(
      (i) {
        return GetVacationsUsecaseImpl(
          getVacationsRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetVacationsAnalyticsUsecase>(
      (i) {
        return GetVacationsAnalyticsUsecaseImpl(
          getVacationsAnalyticsRepository: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SendVacationRequestUsecase>(
      (i) {
        return SendVacationRequestUsecaseImpl(
          sendVacationRequestRepository: i.get(),
        );
      },
    ),

    Bind.factory<SendVacationRequestUpdateUseCase>(
      (i) {
        return SendVacationRequestUpdateUsecaseImpl(
          sendVacationRequestUpdateRepository: i.get(),
        );
      },
    ),

    Bind.factory<CancelVacationRequestUsecase>(
      (i) {
        return CancelVacationRequestUsecaseImpl(
          cancelVacationRequestRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetVacationCalendarStaffViewUsercase>(
      (i) {
        return GetVacationCalendarStaffViewUsercaseImpl(
          getVacationEmployeeCalendarViewRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetVacationScheduleIndividualUsecase>(
      (i) {
        return GetVacationScheduleIndividualUsecaseImpl(
          getVacationScheduleIndividualRepository: i.get(),
        );
      },
    ),

    Bind.factory<GetReportVacationUsecase>(
      (i) {
        return GetReportVacationUsecaseImpl(
          getReportVacationRepository: i.get(),
        );
      },
    ),
  ];
}
