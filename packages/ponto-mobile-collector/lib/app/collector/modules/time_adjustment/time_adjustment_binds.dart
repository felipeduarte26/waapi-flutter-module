import 'package:flutter_modular/flutter_modular.dart';

import '../../core/domain/services/bottom_sheet_service/ibottom_sheet_service.dart';
import '../../core/infra/services/bottom_sheet_service/bottom_sheet_service.dart';
import '../clocking_event/domain/service/iregister_clocking_event_service.dart';
import '../clocking_event/domain/usecase/get_company_dto_usecase.dart';
import '../clocking_event/domain/usecase/get_employee_dto_usecase.dart';
import '../clocking_event/domain/usecase/get_employee_usecase.dart';
import '../clocking_event/domain/usecase/get_receipt_usecase.dart';
import '../clocking_event/domain/usecase/show_bottom_sheet_usecase.dart';
import '../clocking_event/domain/util/clocking_event_util.dart';
import '../clocking_event/domain/util/iclocking_event_utill.dart';
import '../clocking_event/infra/service/register_clocking_event_service.dart';
import '../drivers_journey/domain/usecases/get_driving_time_usecase.dart';
import '../drivers_journey/domain/usecases/get_mandatory_break_usecase.dart';
import '../drivers_journey/domain/usecases/get_meal_time_usecase.dart';
import '../drivers_journey/domain/usecases/get_total_hours_in_journey_usecase.dart';
import '../drivers_journey/domain/usecases/get_total_time_paused_usecase.dart';
import '../drivers_journey/domain/usecases/get_waiting_time_usecase.dart';
import '../facial_recognition/domain/usecases/get_employees_to_facial_registration_usecase.dart';
import 'domain/service/iday_info_service.dart';
import 'domain/service/populate_list_events_service.dart';
import 'domain/service/timeline_service.dart';
import 'domain/usecases/get_clocking_event_by_manager_usecase.dart';
import 'domain/usecases/get_driver_journey_timeline_usecase.dart';
import 'domain/usecases/verify_user_logged_is_admin_usecase.dart';
import 'domain/usecases/verify_user_logged_is_manager_usecase.dart';
import 'infra/service/day_info_service.dart';
import 'infra/service/populate_list_events_service_impl.dart';
import 'infra/service/timeline_service_impl.dart';
import 'presenter/bloc/filter_employee_select/filter_employee_select_bloc.dart';
import 'presenter/bloc/period/period_bloc.dart';
import 'presenter/bloc/tab_action/tab_action_bloc.dart';
import 'presenter/bloc/time_adjustment_select_employee_bloc/time_adjustment_select_employee_bloc.dart';
import 'presenter/bloc/timer_adjustment/timer_adjustment_bloc.dart';

class TimeAdjustmentBinds extends Module {
  @override
  List<Bind> get binds => [
        // Service
        Bind.lazySingleton<IDayInfoService>(
          (i) => DayInfoService(employeeRepository: i()),
          export: true,
        ),

        Bind.lazySingleton<IRegisterClockingEventService>(
          (i) => RegisterClockingEventService(
            clockingEventRepository: i(),
            createClockingEventService: i(),
            environmentService: i(),
            internalClockService: i(),
            platformService: i(),
            synchronizeClockingEventService: i(),
            utils: i(),
            configurationRepository: i(),
            getAccessTokenUsecase: i(),
            clockingEventUseRepository: i(),
            logService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IBottomSheetService>(
          (i) => BottomSheetService(),
          export: true,
        ),

        Bind.lazySingleton<PopulateListEventsService>(
          (i) => PopulateListEventsServiceImpl(),
          export: true,
        ),

        Bind.lazySingleton<TimelineService>(
          (i) => TimelineServiceImpl(
            utils: i(),
            populateListEventsService: i(),
          ),
          export: true,
        ),

        // USECASE

        Bind.lazySingleton<IShowBottomSheetUsecase>(
          (i) => ShowBottomSheetUsecase(bottomSheetService: i()),
          export: true,
        ),

        Bind.lazySingleton<IGetReceiptUsecase>(
          (i) => GetReceiptUsecase(utils: i()),
          export: true,
        ),

        Bind.lazySingleton<IGetEmployeeUsecase>(
          (i) => GetEmployeeUsecase(sessionService: i(),),
          export: true,
        ),

        Bind.lazySingleton<GetDriverJourneyTimelineUsecase>(
          (i) => GetDriverJourneyTimelineUsecaseImpl(
            timelineService: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<IClockingEventUtil>(
          (i) => ClockingEventUtil(),
          export: true,
        ),

        Bind.lazySingleton<IGetEmployeeDtoUsecase>(
          (i) => GetEmployeeDtoUsecase(employeeRepository: i()),
          export: true,
        ),

        Bind.lazySingleton<IGetCompanyDtoUsecase>(
          (i) => GetCompanyDtoUsecase(companyRepository: i()),
          export: true,
        ),

        // BLOCs
        Bind.lazySingleton<TabActionBloc>(
          (i) => TabActionBloc(),
          export: true,
        ),
        Bind.lazySingleton<GetDrivingTimeUsecase>(
          (i) => GetDrivingTimeUsecaseImpl(utils: i()),
          export: true,
        ),
        Bind.lazySingleton<GetWaitingTimeUsecase>(
          (i) => GetWaitingTimeUsecaseImpl(utils: i()),
          export: true,
        ),
        Bind.lazySingleton<GetMealTimeUsecase>(
          (i) => GetMealTimeUsecaseImpl(utils: i()),
          export: true,
        ),
        Bind.lazySingleton<GetMandatoryBreakUsecase>(
          (i) => GetMandatoryBreakUsecaseImpl(utils: i()),
          export: true,
        ),

        Bind.lazySingleton<GetTotalHoursInJourneyUsecase>(
          (i) => GetTotalHoursInJourneyUsecaseImpl(
            getMealTimeUsecase: i(),
            getMandatoryBreakUsecase: i(),
            utils: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<GetTotalTimePausedUsecase>(
          (i) => GetTotalTimePausedUsecaseImpl(
            getMandatoryBreakUsecase: i(),
            getMealTimeUsecase: i(),
            utils: i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<TimerAdjustmentBloc>(
          (i) => TimerAdjustmentBloc(
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
          ),
          export: true,
        ),

        Bind.lazySingleton<PeriodBloc>(
          (i) => PeriodBloc(
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
            i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<GetEmployeesToFacialRegistrationUsecase>(
          (i) => GetEmployeesToFacialRegistrationUsecaseImpl(
            getEmployeesToFacialRegistrationRepository: i(),
            getAccessTokenUsecase: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<FilterEmployeeSelectBloc>(
          (i) => FilterEmployeeSelectBloc(
            getCompletedAppointmentsUsecase: i(),
          ),
          export: true,
          onDispose: (cubit) => cubit.close(),
        ),
        Bind.lazySingleton<VerifyUserLoggedIsManagerUsecase>(
          (i) => VerifyUserLoggedIsManagerUsecaseImpl(
            sharedPreferencesService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<VerifyUserLoggedIsAdminUsecase>(
          (i) => VerifyUserLoggedIsAdminUsecaseImpl(
            sharedPreferencesService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<VerifyUserLoggedIsAdminUsecase>(
          (i) => VerifyUserLoggedIsAdminUsecaseImpl(
            sharedPreferencesService: i(),
          ),
          export: true,
        ),
        Bind.lazySingleton<FilterEmployeeSelectBloc>(
          (i) => FilterEmployeeSelectBloc(
            getCompletedAppointmentsUsecase: i(),
          ),
          export: true,
          onDispose: (cubit) => cubit.close(),
        ),
        Bind.lazySingleton<TimeAdjustmentSelectEmployeeBloc>(
          (i) => TimeAdjustmentSelectEmployeeBloc(
            getCompletedAppointmentsUsecase: i(),
          ),
          export: true,
          onDispose: (cubit) => cubit.close(),
        ),
        Bind.lazySingleton<GetClockingEventByManagerUsecase>(
          (i) => GetClockingEventByManagerUsecaseImpl(
            getEmployeeManagerUsecase: i(),
            getEmployeesByManagerUsecase: i(),
          ),
          export: true,
        ),
      ];
}
