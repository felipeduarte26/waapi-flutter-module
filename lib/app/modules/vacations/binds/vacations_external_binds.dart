import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../external/datasources/cancel_vacation_approved_request_datasource_impl.dart';
import '../external/datasources/cancel_vacation_request_datasource_impl.dart';
import '../external/datasources/get_report_vacation_datasource_impl.dart';
import '../external/datasources/get_vacation_schedule_individual_datasource_impl.dart';
import '../external/datasources/get_vacation_view_staff_calendar_datasource_impl.dart';
import '../external/datasources/get_vacations_analytics_datasource_impl.dart';
import '../external/datasources/get_vacations_datasource_impl.dart';
import '../external/datasources/send_vacation_request_datasource_impl.dart';
import '../external/datasources/send_vacation_request_update_datasource_impl.dart';
import '../external/mappers/get_vacation_calendar_staff_view_model_mapper.dart';
import '../external/mappers/send_cancelation_approved_request_input_model_mapper.dart';
import '../external/mappers/send_vacation_request_input_model_mapper.dart';
import '../external/mappers/send_vacation_request_update_input_model_mapper.dart';
import '../external/mappers/vacation_employee_calendar_view_input_model_mapper.dart';
import '../external/mappers/vacations_analytics_model_mapper.dart';
import '../infra/datasources/cancel_vacation_approved_request_datasource.dart';
import '../infra/datasources/cancel_vacation_request_datasource.dart';
import '../infra/datasources/get_report_vacation_datasource.dart';
import '../infra/datasources/get_vacation_calendar_staff_view_datasource.dart';
import '../infra/datasources/get_vacation_schedule_individual_datasource.dart';
import '../infra/datasources/get_vacations_analytics_datasource.dart';
import '../infra/datasources/get_vacations_datasource.dart';
import '../infra/datasources/send_vacation_request_datasource.dart';
import '../infra/datasources/send_vacation_request_update_datasource.dart';

class VacationsExternalBinds {
  static List<Bind<Object>> binds = [
    // Datasources
    Bind.factory<GetVacationsDatasource>(
      (i) {
        return GetVacationsDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<GetVacationsAnalyticsDatasource>(
      (i) {
        return GetVacationsAnalyticsDatasourceImpl(
          restService: i.get(),
          vacationsAnalyticsModelMapper: i.get(),
        );
      },
      export: true,
    ),

    Bind.factory<SendVacationRequestDatasource>(
      (i) {
        return SendVacationRequestDatasourceImpl(
          restService: i.get(),
          sendVacationRequestInputModelMapper: i.get(),
        );
      },
    ),

    Bind.factory<SendVacationRequestUpdateDatasource>(
      (i) {
        return SendVacationRequestUpdateDatasourceImpl(
          restService: i.get(),
          sendVacationRequestUpdateInputModelMapper: i.get(),
        );
      },
    ),

    Bind.factory<CancelVacationRequestDatasource>(
      (i) {
        return CancelVacationRequestDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    Bind.factory<CancelVacationApprovedRequestDatasource>(
      (i) {
        return CancelVacationApprovedRequestDatasourceImpl(
          restService: i.get(),
          sendCancelationApprovedRequestInputModelMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetVacationCalendarStaffViewDatasource>(
      (i) {
        return GetVacationViewStaffCalendarDatasourceImpl(
          getVacationCalendarStaffViewMapper: i.get(),
          restService: i.get(),
          vacationEmployeeCalendarViewInputModelMapper: i.get(),
        );
      },
    ),

    Bind.factory<GetReportVacationDatasource>(
      (i) {
        return GetReportVacationDatasourceImpl(
          restService: i.get(),
          getStoredTokenUsecase: GetStoredTokenUsecase(),
          getStoredUserUsecase: GetStoredUserUsecase(),
          integrationUserRepositoryImpl: i.get(),
        );
      },
    ),

    Bind.factory<GetVacationScheduleIndividualDatasource>(
      (i) {
        return GetVacationScheduleIndividualDatasourceImpl(
          restService: i.get(),
        );
      },
    ),

    // Mappers
    Bind.factory<VacationsAnalyticsModelMapper>(
      (i) {
        return VacationsAnalyticsModelMapper();
      },
      export: true,
    ),

    Bind.factory(
      (i) {
        return SendVacationRequestInputModelMapper();
      },
    ),

    Bind.factory(
      (i) {
        return SendVacationRequestUpdateInputModelMapper();
      },
    ),

    Bind.factory(
      (i) {
        return GetVacationCalendarStaffViewModelMapper();
      },
    ),

    Bind.factory(
      (i) {
        return VacationEmployeeCalendarViewInputModelMapper();
      },
    ),
    Bind.factory(
      (i) {
        return SendCancelationApprovedRequestInputModelMapper();
      },
    ),
  ];
}
