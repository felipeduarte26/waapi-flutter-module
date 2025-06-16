import 'package:bloc/bloc.dart';

import '../../../../../../../ponto_mobile_collector.dart';
import '../../../../../core/domain/entities/journey_entity.dart';
import '../../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../../core/domain/input_model/clocking_event_journey_dto.dart';
import '../../../../../core/domain/input_model/company_dto.dart';
import '../../../../../core/domain/input_model/employee_dto.dart';
import '../../../../../core/domain/input_model/journey_time_details_dto.dart';
import '../../../../../core/domain/input_model/timeline_item_dto.dart';
import '../../../../../core/domain/usecases/find_employee_by_username_usecase.dart';
import '../../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../../core/external/mappers/clocking_event_mapper.dart';
import '../../../../../core/external/mappers/employee_mapper.dart';
import '../../../../../core/infra/repositories/database/journey_repository.dart';
import '../../../../../core/infra/utils/enum/execution_mode_enum.dart';
import '../../../../../core/infra/utils/enum/type_journey_time_enum.dart';
import '../../../../clocking_event/domain/usecase/get_company_dto_usecase.dart';
import '../../../../clocking_event/domain/usecase/get_employee_dto_usecase.dart';
import '../../../../clocking_event/domain/usecase/get_employee_usecase.dart';
import '../../../../clocking_event/domain/usecase/get_receipt_usecase.dart';
import '../../../../drivers_journey/domain/usecases/get_driving_time_usecase.dart';
import '../../../../drivers_journey/domain/usecases/get_mandatory_break_usecase.dart';
import '../../../../drivers_journey/domain/usecases/get_meal_time_usecase.dart';
import '../../../../drivers_journey/domain/usecases/get_total_hours_in_journey_usecase.dart';
import '../../../../drivers_journey/domain/usecases/get_total_time_paused_usecase.dart';
import '../../../../drivers_journey/domain/usecases/get_waiting_time_usecase.dart';
import '../../../domain/usecases/get_clocking_event_by_manager_usecase.dart';
import '../../../domain/usecases/get_driver_journey_timeline_usecase.dart';
import '../../../domain/usecases/get_employees_by_manager_usecase.dart';
import '../../../domain/usecases/verify_user_logged_is_admin_usecase.dart';
import '../../../domain/usecases/verify_user_logged_is_manager_usecase.dart';

class TimerAdjustmentBloc
    extends Bloc<TimerAdjustmentEvent, TimerAdjustmentState> {
  final IClockingEventRepository _clockingEventRepository;
  final IGetEmployeeUsecase _getEmployeeUsecase;
  final IDayInfoService _dayInfoService;
  final IGetReceiptUsecase _getReceiptUsecase;
  final IGetEmployeeDtoUsecase _employeeDtoUsecase;
  final IGetCompanyDtoUsecase _companyDtoUsecase;
  final GetDrivingTimeUsecase _getDrivingTimeUsecase;
  final GetWaitingTimeUsecase _getWaitingTimeUsecase;
  final GetMealTimeUsecase _getMealTimeUsecase;
  final GetMandatoryBreakUsecase _getMandatoryBreakUsecase;
  final GetTotalHoursInJourneyUsecase _getTotalHoursInJourneyUsecase;
  final GetTotalTimePausedUsecase _getTotalTimePausedUsecase;
  final GetDriverJourneyTimelineUsecase _getDriverJourneyTimelineUsecase;
  final JourneyRepository _journeyRepository;
  final IOvernightRepository _overnightRepository;
  final ConfigurationRepository _configurationRepository;
  final RegisterOvernightUsecase _registerOvernightUsecase;
  final VerifyUserLoggedIsManagerUsecase _verifyUserLoggedIsManagerUsecase;
  final VerifyUserLoggedIsAdminUsecase _verifyUserLoggedIsAdminUsecase;
  final FindEmployeeIdByUsernameUsecase _findEmployeeIdByUsernameUsecase;
  final GetEmployeesByManagerUsecase _getEmployeesByManagerUsecase;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final IEmployeeRepository _employeeRepository;
  final GetClockingEventByManagerUsecase _getClockingEventByManagerUsecase;
  final ClockingEventMapper _clockingEventMapper;

  DateTime? selectedDay;
  DateTime day = DateTime.now();
  late DayInfoModel dayInfoModel;
  bool showAddOvernightButton = false;
  bool hasOvernight = false;
  bool controlOvernight = false;
  EmployeeDto? selectedEmployee;
  ExecutionModeEnum? executionModeEnum;
  bool? isDriversJourneyHistory;
  List<JourneyTimeDetailsDto> journeyTimeDetailsList = [];
  List<JourneyEntity> journeys = [];
  List<ClockingeventJourney> clockingEventsJourneyList = [];
  DateTime totalWorkingTime = DateTime(0);
  DateTime totalBreakTime = DateTime(0);
  List<TimelineItemDto> timelineItems = [];
  bool? isMultipleView;
  bool canChangeEmployee = true;
  String? username;
  String? employeeId;

  Future<List<JourneyTimeDetailsDto>> calculateJourneyTimes(
    List<ClockingEventDto> clockingEvents,
  ) async {
    DateTime drivingTime = await _getDrivingTimeUsecase.call(
      clockingEvents: clockingEvents,
    );

    DateTime waitingTime = await _getWaitingTimeUsecase.call(
      clockingEvents: clockingEvents,
    );

    DateTime mealBreakTime = await _getMealTimeUsecase.call(
      clockingEvents: clockingEvents,
    );

    DateTime mandatoryBreaTime = await _getMandatoryBreakUsecase.call(
      clockingEvents: clockingEvents,
    );

    totalWorkingTime = await _getTotalHoursInJourneyUsecase.call(
      clockingEvents: clockingEvents,
    );

    totalBreakTime = await _getTotalTimePausedUsecase.call(
      clockingEvents: clockingEvents,
    );

    journeyTimeDetailsList.add(
      JourneyTimeDetailsDto(
        time: drivingTime,
        use: TypeJourneyTimeEnum.driving,
      ),
    );

    journeyTimeDetailsList.add(
      JourneyTimeDetailsDto(
        time: waitingTime,
        use: TypeJourneyTimeEnum.waiting,
      ),
    );
    journeyTimeDetailsList.add(
      JourneyTimeDetailsDto(
        time: mealBreakTime,
        use: TypeJourneyTimeEnum.mealBreak,
      ),
    );

    journeyTimeDetailsList.add(
      JourneyTimeDetailsDto(
        time: mandatoryBreaTime,
        use: TypeJourneyTimeEnum.mandatoryBreak,
      ),
    );

    journeyTimeDetailsList.add(
      JourneyTimeDetailsDto(
        time: totalWorkingTime,
        use: TypeJourneyTimeEnum.working,
      ),
    );
    return journeyTimeDetailsList;
  }

  TimerAdjustmentBloc(
    this._clockingEventRepository,
    this._dayInfoService,
    this._getEmployeeUsecase,
    this._getReceiptUsecase,
    this._companyDtoUsecase,
    this._employeeDtoUsecase,
    this._getDrivingTimeUsecase,
    this._getWaitingTimeUsecase,
    this._getMealTimeUsecase,
    this._getMandatoryBreakUsecase,
    this._getTotalHoursInJourneyUsecase,
    this._getTotalTimePausedUsecase,
    this._getDriverJourneyTimelineUsecase,
    this._journeyRepository,
    this._overnightRepository,
    this._configurationRepository,
    this._registerOvernightUsecase,
    this._verifyUserLoggedIsManagerUsecase,
    this._verifyUserLoggedIsAdminUsecase,
    this._findEmployeeIdByUsernameUsecase,
    this._getEmployeesByManagerUsecase,
    this._getExecutionModeUsecase,
    this._employeeRepository,
    this._getClockingEventByManagerUsecase,
    this._clockingEventMapper,
  ) : super(InitialTimerAdjustmentState()) {
    on<ChangedSelectedEmployee>((event, emit) async {
      List<ClockingEventDto> clockingEvents = [];
      var employeeDto = await _employeeDtoUsecase.call(id: event.employeeId);
      if (employeeDto != null) {
        List<ClockingEvent> entitiyList =
            await _clockingEventRepository.findByDate(
          date: day,
          employeeId: employeeDto.id,
        );
        clockingEvents = await _clockingEventMapper
            .fromEntityToDtoCollectorList(entitiyList);
        selectedEmployee = employeeDto;
        employeeId = employeeDto.id;
        emit(await completeLoading(clockingEvents));
      }
    });

    on<LoadDayTimerAdjustmentEvent>(
      (event, emit) async {
        day = event.selectedDay;

        if (selectedDay != null) {
          day = selectedDay!;
          selectedDay = null;
        }

        List<ClockingEventDto> findAllByJourneyId = [];
        List<ClockingEventDto> clockingEvents = [];

        emit(LoadingTimerAdjustmentState());
        if (isMultipleView ?? false) {
          if (employeeId != null) {
            List<ClockingEvent> entityList =
                await _clockingEventRepository.findByDate(
              date: day,
              employeeId: employeeId!,
            );
            clockingEvents =
                await _clockingEventMapper.fromEntityToDtoCollectorList(
              entityList,
            );
            selectedEmployee = await _employeeDtoUsecase.call(id: employeeId!);
          } else if (username != null && username!.isNotEmpty) {
            employeeId = null;
            var admin =
                await _verifyUserLoggedIsAdminUsecase.call(username: username!);
            var manager = await _verifyUserLoggedIsManagerUsecase.call(
              username: username!,
            );

            if (admin || manager) {
              List<ClockingEvent> entityList =
                  await _clockingEventRepository.findFirstByDate(date: day);
              clockingEvents =
                  await _clockingEventMapper.fromEntityToDtoCollectorList(
                entityList,
              );
            }

            if (!admin && manager) {
              clockingEvents = await _getClockingEventByManagerUsecase.call(
                appointments: clockingEvents,
                username: username!,
              );
            }

            if (!admin && !manager) {
              canChangeEmployee = false;
              var employeeDto = await _findEmployeeIdByUsernameUsecase.call(
                username: username!,
              );
              if (employeeDto != null) {
                List<ClockingEvent> entityList =
                    await _clockingEventRepository.findByDate(
                  date: day,
                  employeeId: employeeDto.id,
                );
                clockingEvents =
                    await _clockingEventMapper.fromEntityToDtoCollectorList(
                  entityList,
                );
                selectedEmployee = employeeDto;
              }
            }

            if (clockingEvents.isNotEmpty) {
              selectedEmployee = await _employeeDtoUsecase.call(
                id: clockingEvents.first.employeeDto!.id,
              );
            }

            if (clockingEvents.isEmpty && admin) {
              var findFirst = await _employeeRepository.findFirst();
              selectedEmployee =
                  EmployeeMapper.fromEntityToDtoCollector(findFirst);
            }

            if (clockingEvents.isEmpty && manager) {
              List<Employee>? listEntity =
                  await _getEmployeesByManagerUsecase.call(username: username!);
              List<EmployeeDto>? list =
                  EmployeeMapper.fromEntityToDtoCollectorList(
                listEntity,
              );

              if(list != null && list.isNotEmpty) {
                selectedEmployee = list.first;
              }
            }
          }

          var timerAdjustmentState = await completeLoading(clockingEvents);
          emit(timerAdjustmentState);
          return;
        }

        EmployeeDto? employeeDto = _getEmployeeUsecase.call();

        executionModeEnum = await _getExecutionModeUsecase.call();

        if (employeeDto != null) {
          if (executionModeEnum?.isDriver() ?? false) {
            clockingEventsJourneyList.clear();

            await checkOvernight(employeeDto);

            journeys = await _journeyRepository.findByDate(
              date: day,
              employeeId: employeeDto.id,
            );

            for (var e in journeys) {
              List<JourneyTimeDetailsDto> journeyTimeList = [];
              List<ClockingEvent> entitiyList =
                  await _clockingEventRepository.findAllByJourneyId(
                journeyId: e.id,
              );
              if (entitiyList.isEmpty) {
                return;
              }
              findAllByJourneyId =
                  await _clockingEventMapper.fromEntityToDtoCollectorList(
                entitiyList,
              );

              clockingEvents.addAll(findAllByJourneyId);

              List<JourneyTimeDetailsDto> result =
                  await calculateJourneyTimes(findAllByJourneyId);

              journeyTimeList.addAll(result);

              result.clear();

              List<DayInfoModel> dayInfoModelList =
                  await _dayInfoService.generate(
                clockingEvents: findAllByJourneyId,
                initialDate: day,
                finalDate: day,
                journeyId: e.id,
              );

              DayInfoModel dayInfoModelOfJourney = dayInfoModelList.first;
              bool isJourneyFinished = e.endDate != null;
              timelineItems = _getDriverJourneyTimelineUsecase.call(
                clockingEvents: dayInfoModelOfJourney.times,
                isJourneyFinished: isJourneyFinished,
              );

              clockingEventsJourneyList.add(
                ClockingeventJourney(
                  dayInfoModeltList: dayInfoModelList,
                  journey: e,
                  journeyTimeDetailsDto: journeyTimeList,
                  totalBreakTime: totalBreakTime,
                  timelineItems: timelineItems,
                ),
              );

              totalBreakTime = DateTime(0);
            }
            emit(await completeLoading(clockingEvents));
            return;
          }

          List<ClockingEvent> entityList =
              await _clockingEventRepository.findByDate(
            date: day,
            employeeId: employeeDto.id,
          );

          clockingEvents =
              await _clockingEventMapper.fromEntityToDtoCollectorList(
            entityList,
          );
        }

        emit(await completeLoading(clockingEvents));
      },
    );

    on<ShowReceiptTimerAdjustmentEvent>(
      (event, emit) async {
        EmployeeDto? employeeDto = _getEmployeeUsecase.call();

        if (employeeDto != null) {
          ClockingEvent? entity = await _clockingEventRepository.findById(
            clockingEventId: event.clockingEventId,
            employeeId: employeeDto.id,
          );
          ClockingEventDto? dto;
          if (entity != null) {
            dto = await _clockingEventMapper.fromEntityToDtoCollector(
              entity,
            );
          }

          CompanyDto? companyDto;

          if (dto != null) {
            companyDto = await _companyDtoUsecase.call(
              id: employeeDto.company.id!,
            );

            employeeDto = await _employeeDtoUsecase.call(
              id: dto.employeeDto!.id,
            );

            dto.employeeDto = employeeDto;
            dto.companyDto = companyDto;
            ClockingEventReceiptModel model = _getReceiptUsecase.call(
              clockingEvent: ClockingEventMapper.fromDtoToEntityCollector(
                dto,
              )!,
              locale: event.locale,
            );

            ReceiptTimerAdjustmentState newState = ReceiptTimerAdjustmentState(
              receiptModel: model,
            );

            emit(newState);
          }
        }
      },
    );

    on<AddOvernightEvent>((event, emit) async {
      try {
        EmployeeDto? employeeDto = _getEmployeeUsecase.call();
        await _registerOvernightUsecase.call(
          dateTimeEvent: day,
          manual: true,
          employeeId: employeeDto?.id ?? '',
        );
        hasOvernight = true;
        showAddOvernightButton = !hasOvernight && controlOvernight;
        emit(
          AddOvernightSuccessState(
            showAddOvernightButton: showAddOvernightButton,
          ),
        );
      } catch (e) {
        emit(AddOvernightErrorState());
      }
    });
  }

  bool showDriverInfo() {
    return executionModeEnum?.isDriver() ?? false;
  }

  Future<TimerAdjustmentState> completeLoading(
    List<ClockingEventDto> clockingEvents,
  ) async {
    List<DayInfoModel> dayInfoList = await _dayInfoService.generate(
      clockingEvents: clockingEvents,
      initialDate: day,
      finalDate: day,
    );

    dayInfoModel = dayInfoList.first;

    return LoadedTimerAdjustmentState(
      dayInfoModel: dayInfoList.first,
      showAddOvernightButton: showAddOvernightButton,
    );
  }

  Future<void> checkOvernight(EmployeeDto? employeeDto) async {
    var findByDate = await _overnightRepository.findByEmployee(
      employeeId: employeeDto?.id ?? '',
    );

    hasOvernight = findByDate.any((element) => element.date.day == day.day);

    var loginConfigurationDTO = await _configurationRepository.findByEmployeeId(
      employeeId: employeeDto?.id ?? '',
    );

    var controlOvernight = loginConfigurationDTO?.controlOvernight;
    controlOvernight = (executionModeEnum?.isDriver() ?? false) &&
        (loginConfigurationDTO?.controlOvernight ?? false);
    showAddOvernightButton = !hasOvernight && controlOvernight;
  }
}
