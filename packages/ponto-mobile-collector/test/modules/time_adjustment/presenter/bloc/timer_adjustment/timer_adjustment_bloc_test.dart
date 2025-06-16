import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/journey_time_details_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/find_employee_by_username_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/clocking_event_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/journey_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_company_dto_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_dto_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_receipt_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/util/iclocking_event_utill.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_driving_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_mandatory_break_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_meal_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_total_hours_in_journey_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_total_time_paused_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_waiting_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_clocking_event_by_manager_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_driver_journey_timeline_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_employees_by_manager_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/verify_user_logged_is_admin_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/verify_user_logged_is_manager_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/clock_company_dto_mock.dart';
import '../../../../../mocks/clocking_event_dto_mock.dart';
import '../../../../../mocks/clocking_event_mock.dart';
import '../../../../../mocks/clocking_event_receipt_model_mock.dart';
import '../../../../../mocks/configuration_entity_mock.dart';
import '../../../../../mocks/employee_dto_mock.dart';
import '../../../../../mocks/employee_entity_mock.dart';
import '../../../../../mocks/import_clocking_event_dto_mock.dart';
import '../../../../../mocks/journey_mock.dart';
import '../../../../../mocks/overnight_entity_mock.dart';

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockDayInfoService extends Mock implements IDayInfoService {}

class MockGetEmployeeUsecase extends Mock implements IGetEmployeeUsecase {}

class MockGetReceiptUsecase extends Mock implements IGetReceiptUsecase {}

class MockClockingEventUtil extends Mock implements IClockingEventUtil {}

class MockGetEmploeeDtoUsecase extends Mock implements IGetEmployeeDtoUsecase {}

class MockGetCompanyDtoUsecase extends Mock implements IGetCompanyDtoUsecase {}

class MockGetDrivingTimeUsecase extends Mock implements GetDrivingTimeUsecase {}

class MockGetWaitingTimeUsecase extends Mock implements GetWaitingTimeUsecase {}

class MockGetMealTimeUsecase extends Mock implements GetMealTimeUsecase {}

class MockGetTotalTimePausedUsecase extends Mock
    implements GetTotalTimePausedUsecase {}

class MockGetMandatoryBreakUsecase extends Mock
    implements GetMandatoryBreakUsecase {}

class MockGetTotalHoursInJourneyUsecase extends Mock
    implements GetTotalHoursInJourneyUsecase {}

class MockJourneyRepository extends Mock implements JourneyRepository {}

class MockGetDriverJourneyTimelineUsecase extends Mock
    implements GetDriverJourneyTimelineUsecase {}

class MockOvernightRepository extends Mock implements IOvernightRepository {}

class MockConfigurationRepository extends Mock
    implements ConfigurationRepository {}

class MockRegisterOvernightUsecase extends Mock
    implements RegisterOvernightUsecase {}

class MockVerifyUserLoggedIsManagerUsecase extends Mock
    implements VerifyUserLoggedIsManagerUsecase {}

class MockVerifyUserLoggedIsAdminUsecase extends Mock
    implements VerifyUserLoggedIsAdminUsecase {}

class MockFindEmployeeIdByUsernameUsecase extends Mock
    implements FindEmployeeIdByUsernameUsecase {}

class MockGetEmployeesByManagerUsecase extends Mock
    implements GetEmployeesByManagerUsecase {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockClockingEventMapper extends Mock implements ClockingEventMapper {}

class MockGetClockingEventByManagerUsecase extends Mock
    implements GetClockingEventByManagerUsecase {}

void main() {
  DateTime timeClock = DateTime.now();

  late IClockingEventRepository clockingEventRepository;
  late IGetEmployeeUsecase getEmployeeUsecase;
  late IDayInfoService dayInfoService;
  late IGetReceiptUsecase getReceiptUsecase;
  late IGetCompanyDtoUsecase getCompanyDtoUsecase;
  late IGetEmployeeDtoUsecase getEmployeeDtoUsecase;
  late TimerAdjustmentBloc timerAdjustmentBloc;
  late GetDrivingTimeUsecase getDrivingTimeUsecase;
  late GetWaitingTimeUsecase getWaitingTimeUsecase;
  late GetMealTimeUsecase getMealTimeUsecase;
  late GetMandatoryBreakUsecase getMandatoryBreakUsecase;
  late GetTotalHoursInJourneyUsecase getTotalHoursInJourneyUsecase;
  late GetTotalTimePausedUsecase getTotalTimePausedUsecase;
  late JourneyRepository journeyRepository;
  late GetDriverJourneyTimelineUsecase getDriverJourneyTimelineUsecase;
  late IOvernightRepository overnightRepository;
  late ConfigurationRepository configurationRepository;
  late RegisterOvernightUsecase registerOvernightUsecase;
  late VerifyUserLoggedIsManagerUsecase verifyUserLoggedIsManagerUsecase;
  late VerifyUserLoggedIsAdminUsecase verifyUserLoggedIsAdminUsecase;
  late FindEmployeeIdByUsernameUsecase findEmployeeIdByUsernameUsecase;
  late GetEmployeesByManagerUsecase getEmployeesByManagerUsecase;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late IEmployeeRepository employeeRepository;
  late GetClockingEventByManagerUsecase getClockingEventByManagerUsecase;
  late ClockingEventMapper clockingEventMapper;

  setUpAll(() {
    registerFallbackValue(clockingEventMock);
    registerFallbackValue(employeeDtoMock);
    registerFallbackValue(clockingEventDtoMock);
    registerFallbackValue(companyDtoMock);
    registerFallbackValue(employeeMockDto);
    registerFallbackValue(journeyMock);
    registerFallbackValue(overnightEntityMock);
    registerFallbackValue(configurationEntityMock);
    registerFallbackValue(clockingEventReceiptModelMock);
    registerFallbackValue(importClockingEventDtoMock);
  });

  setUp(() {
    clockingEventRepository = MockClockingEventRepository();
    getEmployeeUsecase = MockGetEmployeeUsecase();
    dayInfoService = MockDayInfoService();
    getReceiptUsecase = MockGetReceiptUsecase();
    getCompanyDtoUsecase = MockGetCompanyDtoUsecase();
    getEmployeeDtoUsecase = MockGetEmploeeDtoUsecase();
    getDrivingTimeUsecase = MockGetDrivingTimeUsecase();
    getWaitingTimeUsecase = MockGetWaitingTimeUsecase();
    getMealTimeUsecase = MockGetMealTimeUsecase();
    getMandatoryBreakUsecase = MockGetMandatoryBreakUsecase();
    getTotalHoursInJourneyUsecase = MockGetTotalHoursInJourneyUsecase();
    getTotalTimePausedUsecase = MockGetTotalTimePausedUsecase();
    journeyRepository = MockJourneyRepository();
    getDriverJourneyTimelineUsecase = MockGetDriverJourneyTimelineUsecase();
    overnightRepository = MockOvernightRepository();
    configurationRepository = MockConfigurationRepository();
    registerOvernightUsecase = MockRegisterOvernightUsecase();
    verifyUserLoggedIsManagerUsecase = MockVerifyUserLoggedIsManagerUsecase();
    verifyUserLoggedIsAdminUsecase = MockVerifyUserLoggedIsAdminUsecase();
    findEmployeeIdByUsernameUsecase = MockFindEmployeeIdByUsernameUsecase();
    getEmployeesByManagerUsecase = MockGetEmployeesByManagerUsecase();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    employeeRepository = MockEmployeeRepository();
    getClockingEventByManagerUsecase = MockGetClockingEventByManagerUsecase();
    clockingEventMapper = MockClockingEventMapper();

    timerAdjustmentBloc = TimerAdjustmentBloc(
      clockingEventRepository,
      dayInfoService,
      getEmployeeUsecase,
      getReceiptUsecase,
      getCompanyDtoUsecase,
      getEmployeeDtoUsecase,
      getDrivingTimeUsecase,
      getWaitingTimeUsecase,
      getMealTimeUsecase,
      getMandatoryBreakUsecase,
      getTotalHoursInJourneyUsecase,
      getTotalTimePausedUsecase,
      getDriverJourneyTimelineUsecase,
      journeyRepository,
      overnightRepository,
      configurationRepository,
      registerOvernightUsecase,
      verifyUserLoggedIsManagerUsecase,
      verifyUserLoggedIsAdminUsecase,
      findEmployeeIdByUsernameUsecase,
      getEmployeesByManagerUsecase,
      getExecutionModeUsecase,
      employeeRepository,
      getClockingEventByManagerUsecase,
      clockingEventMapper,
    );

    when(
      () => getEmployeeDtoUsecase.call(id: any(named: 'id')),
    ).thenAnswer((_) async => employeeMockDto);

    when(
      () => clockingEventRepository.findByDate(
        date: any(named: 'date'),
        employeeId: any(named: 'employeeId'),
      ),
    ).thenAnswer((_) async => [clockingEventMock]);

    when(
      () => dayInfoService.generate(
        clockingEvents: any(named: 'clockingEvents'),
        finalDate: any(named: 'finalDate'),
        initialDate: any(named: 'initialDate'),
      ),
    ).thenAnswer(
      (_) async => [
        DayInfoModel(
          isOdd: true,
          day: DateTime.now(),
          isSynchronized: true,
          isRemoteness: true,
          times: [],
          employee: employeeMockDto,
        ),
      ],
    );

    when(
      () => journeyRepository.findByDate(
        date: timeClock,
        employeeId: employeeMockDto.id,
      ),
    ).thenAnswer((_) async => [journeyMock]);
  });

  test('showDriverInfo', () async {
    when(() => getExecutionModeUsecase.call())
        .thenAnswer((_) async => ExecutionModeEnum.driver);

    timerAdjustmentBloc.executionModeEnum =
        await getExecutionModeUsecase.call();

    var showDriverInfo = timerAdjustmentBloc.showDriverInfo();
    expect(true, showDriverInfo);
  });

  blocTest(
    'ChangedSelectedEmployee test',
    setUp: () {
      when(
        () => clockingEventMapper.fromEntityToDtoCollectorList(any()),
      ).thenAnswer(
        (_) async => [
          clockingEventDtoMock,
        ],
      );

      when(
        () => clockingEventRepository.findByDate(
          date: any(named: 'date'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => [clockingEventMock]);

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).thenAnswer(
        (_) async => [
          DayInfoModel(
            isOdd: true,
            day: DateTime.now(),
            isSynchronized: true,
            isRemoteness: true,
            times: [],
            employee: employeeMockDto,
          ),
        ],
      );
    },
    build: () => timerAdjustmentBloc,
    act: (bloc) => bloc.add(ChangedSelectedEmployee('employeeId')),
    expect: () => [
      isA<LoadedTimerAdjustmentState>(),
    ],
  );

  blocTest<TimerAdjustmentBloc, TimerAdjustmentState>(
    'emits [LoadingTimerAdjustmentState, LoadedTimerAdjustmentState] when LoadDayTimerAdjustmentEvent is added',
    setUp: () {
      DateTime dateInitial = DateTime.parse('2023-05-12 10:37:21');
      DateTime dateFinal = DateTime.parse('2023-05-12 10:37:21');
      List<DayInfoModel> dayInfoList = [
        DayInfoModel(
          isOdd: true,
          day: dateFinal,
          isSynchronized: true,
          isRemoteness: true,
          times: [
            TimeInfoModel(
              clockingEventId: 'id1',
              dateTime: dateInitial,
              isBold: false,
              isPhoneOrigin: false,
              isPlatformOrigin: false,
              isManual: false,
              isRemoteness: false,
              isSynchronized: false,
              use: 2,
              isMealBreak: false,
            ),
          ],
          employee: employeeMockDto,
        ),
      ];

      when(
        () => clockingEventRepository.findByDate(
          date: any(named: 'date'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => [clockingEventMock]);

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).thenAnswer((_) async => dayInfoList);

      when(() => getExecutionModeUsecase.call())
          .thenAnswer((_) async => ExecutionModeEnum.driver);
    },
    build: () => timerAdjustmentBloc,
    act: (bloc) => bloc.add(
      LoadDayTimerAdjustmentEvent(
        selectedDay: DateTime.parse('2023-05-12 10:37:21'),
      ),
    ),
    expect: () => [
      isA<LoadingTimerAdjustmentState>(),
      isA<LoadedTimerAdjustmentState>(),
    ],
    verify: (_) {
      verify(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).called(1);

      verify(() => getExecutionModeUsecase.call()).called(1);
    },
  );

  blocTest<TimerAdjustmentBloc, TimerAdjustmentState>(
    'emits [LoadingTimerAdjustmentState, LoadedTimerAdjustmentState] when selectedDay is present',
    setUp: () {
      DateTime dateInitial = DateTime.parse('2023-05-12 10:37:21');
      DateTime dateFinal = DateTime.parse('2023-05-12 10:37:21');
      List<DayInfoModel> dayInfoList = [
        DayInfoModel(
          isOdd: true,
          day: dateFinal,
          isSynchronized: true,
          isRemoteness: true,
          times: [
            TimeInfoModel(
              clockingEventId: 'id1',
              dateTime: dateInitial,
              isBold: false,
              isPhoneOrigin: false,
              isPlatformOrigin: false,
              isManual: false,
              isRemoteness: false,
              isSynchronized: false,
              use: 2,
              isMealBreak: false,
            ),
          ],
          employee: employeeMockDto,
        ),
      ];

      when(
        () => clockingEventRepository.findByDate(
          date: any(named: 'date'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => [clockingEventMock]);

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).thenAnswer((_) async => dayInfoList);

      when(() => getExecutionModeUsecase.call())
          .thenAnswer((_) async => ExecutionModeEnum.driver);
    },
    build: () => timerAdjustmentBloc,
    act: (bloc) => bloc.add(
      LoadDayTimerAdjustmentEvent(
        selectedDay: DateTime.parse('2023-05-12 10:37:21'),
      ),
    ),
    expect: () => [
      isA<LoadingTimerAdjustmentState>(),
      isA<LoadedTimerAdjustmentState>(),
    ],
    verify: (_) {
      verify(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).called(1);

      verify(() => getExecutionModeUsecase.call()).called(1);
    },
  );
  blocTest<TimerAdjustmentBloc, TimerAdjustmentState>(
    'emits [ReceiptTimerAdjustmentState] when ShowReceiptTimerAdjustmentEvent is added',
    setUp: () {
      when(
        () => clockingEventMapper.fromEntityToDtoCollector(any()),
      ).thenAnswer((_) async => clockingEventDtoMock);

      when(
        () => clockingEventRepository.findById(
          clockingEventId: any(named: 'clockingEventId'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => clockingEventMock);

      when(
        () => getReceiptUsecase.call(
          clockingEvent: any(named: 'clockingEvent'),
          locale: any(named: 'locale'),
        ),
      ).thenReturn(clockingEventReceiptModelMock);

      when(
        () => getEmployeeUsecase.call(),
      ).thenReturn(employeeMockDto);

      when(
        () => getCompanyDtoUsecase.call(
          id: employeeMockDto.company!.id!,
        ),
      ).thenAnswer((_) async => companyDtoMock);

      when(
        () => getEmployeeDtoUsecase.call(
          id: clockingEventMock.employeeId,
        ),
      ).thenAnswer((_) async => employeeMockDto);
    },
    build: () => timerAdjustmentBloc,
    act: (bloc) => bloc.add(
      ShowReceiptTimerAdjustmentEvent(
        clockingEventId: 'clockingEventId',
        locale: 'pt',
      ),
    ),
    expect: () => [isA<ReceiptTimerAdjustmentState>()],
    verify: (_) {
      verify(
        () => clockingEventRepository.findById(
          clockingEventId: any(named: 'clockingEventId'),
          employeeId: any(named: 'employeeId'),
        ),
      ).called(1);

      verify(
        () => getReceiptUsecase.call(
          clockingEvent: any(named: 'clockingEvent'),
          locale: any(named: 'locale'),
        ),
      ).called(1);

      verify(() => getEmployeeUsecase.call()).called(1);

      verify(
        () => getCompanyDtoUsecase.call(
          id: employeeMockDto.company!.id!,
        ),
      ).called(1);

      verify(
        () => getEmployeeDtoUsecase.call(
          id: clockingEventMock.employeeId,
        ),
      ).called(1);

      verifyNoMoreInteractions(clockingEventRepository);
      verifyNoMoreInteractions(getEmployeeUsecase);
      verifyNoMoreInteractions(getReceiptUsecase);
      verifyNoMoreInteractions(getCompanyDtoUsecase);
      verifyNoMoreInteractions(getEmployeeDtoUsecase);
    },
  );

  blocTest(
    'emits [AddOvernightSuccessState] when AddOvernightEvent is added',
    setUp: () {
      when(
        () => registerOvernightUsecase.call(
          dateTimeEvent: any(named: 'dateTimeEvent'),
          manual: any(named: 'manual'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => overnightEntityMock);
    },
    build: () => timerAdjustmentBloc,
    act: (bloc) => bloc.add(AddOvernightEvent()),
    expect: () => [isA<AddOvernightSuccessState>()],
    verify: (_) {
      verify(() => getEmployeeUsecase.call()).called(1);

      verifyNoMoreInteractions(getEmployeeUsecase);
    },
  );

  blocTest(
    'emits [AddOvernightErrorState] when AddOvernightEvent is added',
    setUp: () {
      when(
        () => registerOvernightUsecase.call(
          dateTimeEvent: any(named: 'dateTimeEvent'),
          manual: any(named: 'manual'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenThrow(Exception());
    },
    build: () => timerAdjustmentBloc,
    act: (bloc) => bloc.add(AddOvernightEvent()),
    expect: () => [isA<AddOvernightErrorState>()],
    verify: (_) {
      verify(() => getEmployeeUsecase.call()).called(1);

      verifyNoMoreInteractions(getEmployeeUsecase);
    },
  );

  blocTest(
    'description is admin',
    setUp: () {
      DateTime dateInitial = DateTime.parse('2023-05-12 10:37:21');
      DateTime dateFinal = DateTime.parse('2023-05-12 10:37:21');
      List<DayInfoModel> dayInfoList = [];

      when(() => getEmployeeDtoUsecase.call(id: 'employeeId'))
          .thenAnswer((_) async => employeeMockDto);

      dayInfoList.add(
        DayInfoModel(
          isOdd: true,
          day: dateFinal,
          isSynchronized: true,
          isRemoteness: true,
          times: [
            TimeInfoModel(
              clockingEventId: 'id1',
              dateTime: dateInitial,
              isBold: false,
              isPhoneOrigin: false,
              isPlatformOrigin: false,
              isManual: false,
              isRemoteness: false,
              isSynchronized: false,
              use: 2,
              isMealBreak: false,
            ),
          ],
          employee: employeeMockDto,
        ),
      );
      when(
        () => verifyUserLoggedIsAdminUsecase.call(username: 'username'),
      ).thenAnswer((_) async => true);
      when(
        () => verifyUserLoggedIsManagerUsecase.call(username: 'username'),
      ).thenAnswer((_) async => false);

      when(
        () => clockingEventRepository.findFirstByDate(
          date: any(named: 'date'),
        ),
      ).thenAnswer((_) async => [clockingEventMock]);
      when(
        () => clockingEventMapper.fromEntityToDtoCollectorList(any()),
      ).thenAnswer(
        (_) async => [
          clockingEventDtoMock,
        ],
      );

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).thenAnswer((_) async => dayInfoList);
    },
    build: () {
      timerAdjustmentBloc.isMultipleView = true;
      timerAdjustmentBloc.username = 'username';
      return timerAdjustmentBloc;
    },
    act: (bloc) {
      bloc.add(LoadDayTimerAdjustmentEvent(selectedDay: DateTime(2023, 10, 1)));
    },
    expect: () => [
      isA<LoadingTimerAdjustmentState>(),
      isA<LoadedTimerAdjustmentState>(),
    ],
  );

  blocTest(
    'description is manager',
    setUp: () {
      DateTime dateInitial = DateTime.parse('2023-05-12 10:37:21');
      DateTime dateFinal = DateTime.parse('2023-05-12 10:37:21');
      List<DayInfoModel> dayInfoList = [];

      when(() => getEmployeeDtoUsecase.call(id: 'employeeId'))
          .thenAnswer((_) async => employeeMockDto);

      dayInfoList.add(
        DayInfoModel(
          isOdd: true,
          day: dateFinal,
          isSynchronized: true,
          isRemoteness: true,
          times: [
            TimeInfoModel(
              clockingEventId: 'id1',
              dateTime: dateInitial,
              isBold: false,
              isPhoneOrigin: false,
              isPlatformOrigin: false,
              isManual: false,
              isRemoteness: false,
              isSynchronized: false,
              use: 2,
              isMealBreak: false,
            ),
          ],
          employee: employeeMockDto,
        ),
      );
      when(
        () => verifyUserLoggedIsAdminUsecase.call(username: 'username'),
      ).thenAnswer((_) async => false);
      when(
        () => verifyUserLoggedIsManagerUsecase.call(username: 'username'),
      ).thenAnswer((_) async => true);
      when(
        () => findEmployeeIdByUsernameUsecase.call(username: 'username'),
      ).thenAnswer((_) async => Future.value(employeeMockDto));
      when(
        () => getEmployeesByManagerUsecase.call(
          username: 'username',
        ),
      ).thenAnswer((_) async => [employeeEntityMock]);
      final clockingEvent = ClockingEvent(
        dateEvent: '2023 10 1',
        timeEvent: '12:00:00',
        timeZone: 'UTC',
        cpf: '12345678900',
        employeeId: 'employeeId',
        companyIdentifier: 'EX123',
        signature: 'signature',
        use: '2',
        isMealBreak: false,
        locationStatus: null,
        appVersion: '',
        platform: '',
        id: '',
        signatureVersion: 1,
        employeeName: '',
        companyName: '',
      );

      when(
        () => clockingEventRepository.findByDate(
          date: any(named: 'date'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => [clockingEvent]);

      when(
        () => clockingEventMapper.fromEntityToDtoCollectorList(any()),
      ).thenAnswer(
        (_) async => [
          clockingEventDtoMock,
        ],
      );

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).thenAnswer((_) async => dayInfoList);
    },
    build: () {
      timerAdjustmentBloc.isMultipleView = true;
      timerAdjustmentBloc.username = 'username';
      timerAdjustmentBloc.employeeId = 'employeeId';
      return timerAdjustmentBloc;
    },
    act: (bloc) {
      bloc.add(LoadDayTimerAdjustmentEvent(selectedDay: DateTime(2023, 10, 1)));
    },
    expect: () => [
      isA<LoadingTimerAdjustmentState>(),
      isA<LoadedTimerAdjustmentState>(),
    ],
  );

  blocTest(
    'description is not admin or manager',
    setUp: () {
      DateTime dateInitial = DateTime.parse('2023-05-12 10:37:21');
      DateTime dateFinal = DateTime.parse('2023-05-12 10:37:21');
      List<DayInfoModel> dayInfoList = [];

      when(() => getEmployeeDtoUsecase.call(id: 'employeeId'))
          .thenAnswer((_) async => employeeMockDto);

      dayInfoList.add(
        DayInfoModel(
          isOdd: true,
          day: dateFinal,
          isSynchronized: true,
          isRemoteness: true,
          times: [
            TimeInfoModel(
              clockingEventId: 'id1',
              dateTime: dateInitial,
              isBold: false,
              isPhoneOrigin: false,
              isPlatformOrigin: false,
              isManual: false,
              isRemoteness: false,
              isSynchronized: false,
              use: 2,
              isMealBreak: false,
            ),
          ],
          employee: employeeMockDto,
        ),
      );
      when(
        () => verifyUserLoggedIsAdminUsecase.call(username: 'username'),
      ).thenAnswer((_) async => false);
      when(
        () => verifyUserLoggedIsManagerUsecase.call(username: 'username'),
      ).thenAnswer((_) async => false);
      when(
        () => findEmployeeIdByUsernameUsecase.call(username: 'username'),
      ).thenAnswer((_) async => employeeMockDto);

      when(
        () => clockingEventRepository.findByDate(
          date: any(named: 'date'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => [clockingEventMock]);

      when(
        () => clockingEventMapper.fromEntityToDtoCollectorList(any()),
      ).thenAnswer(
        (_) async => [
          clockingEventDtoMock,
        ],
      );

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).thenAnswer((_) async => dayInfoList);
    },
    build: () {
      timerAdjustmentBloc.isMultipleView = true;
      timerAdjustmentBloc.username = 'username';
      return timerAdjustmentBloc;
    },
    act: (bloc) {
      bloc.add(LoadDayTimerAdjustmentEvent(selectedDay: DateTime(2023, 10, 1)));
    },
    expect: () => [
      isA<LoadingTimerAdjustmentState>(),
      isA<LoadedTimerAdjustmentState>(),
    ],
  );

  test('should return correct journey time details', () async {
    final clockingEvents = <ClockingEventDto>[];

    final drivingTime = DateTime(2022, 1, 1, 8, 0);
    final waitingTime = DateTime(2022, 1, 1, 9, 0);
    final mealBreakTime = DateTime(2022, 1, 1, 12, 0);
    final mandatoryBreakTime = DateTime(2022, 1, 1, 15, 0);
    final totalWorkingTime = DateTime(2022, 1, 1, 18, 0);
    final totalBreakTime = DateTime(2022, 1, 1, 19, 0);

    when(() => getDrivingTimeUsecase.call(clockingEvents: clockingEvents))
        .thenAnswer((_) async => drivingTime);
    when(() => getWaitingTimeUsecase.call(clockingEvents: clockingEvents))
        .thenAnswer((_) async => waitingTime);
    when(() => getMealTimeUsecase.call(clockingEvents: clockingEvents))
        .thenAnswer((_) async => mealBreakTime);
    when(() => getMandatoryBreakUsecase.call(clockingEvents: clockingEvents))
        .thenAnswer((_) async => mandatoryBreakTime);
    when(
      () => getTotalHoursInJourneyUsecase.call(clockingEvents: clockingEvents),
    ).thenAnswer((_) async => totalWorkingTime);
    when(() => getTotalTimePausedUsecase.call(clockingEvents: clockingEvents))
        .thenAnswer((_) async => totalBreakTime);

    final result =
        await timerAdjustmentBloc.calculateJourneyTimes(clockingEvents);

    expect(result, isA<List<JourneyTimeDetailsDto>>());
  });

  blocTest(
    'employee is null',
    setUp: () {
      final dateInitial = DateTime.parse('2023-05-12 10:37:21');
      final dateFinal = DateTime.parse('2023-05-12 10:37:21');
      final dayInfoList = [
        DayInfoModel(
          isOdd: true,
          day: dateFinal,
          isSynchronized: true,
          isRemoteness: true,
          times: [
            TimeInfoModel(
              clockingEventId: 'id1',
              dateTime: dateInitial,
              isBold: false,
              isPhoneOrigin: false,
              isPlatformOrigin: false,
              isManual: false,
              isRemoteness: false,
              isSynchronized: false,
              use: 2,
              isMealBreak: false,
            ),
          ],
          employee: employeeMockDto,
        ),
      ];

      when(
        () => getEmployeeUsecase.call(),
      ).thenReturn(null);

      when(() => getExecutionModeUsecase.call())
          .thenAnswer((_) async => ExecutionModeEnum.individual);

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).thenAnswer((_) async => dayInfoList);
    },
    build: () {
      return timerAdjustmentBloc;
    },
    act: (bloc) {
      bloc.add(LoadDayTimerAdjustmentEvent(selectedDay: DateTime(2023, 10, 1)));
    },
    expect: () => [
      isA<LoadingTimerAdjustmentState>(),
      isA<LoadedTimerAdjustmentState>(),
    ],
  );

  blocTest(
    'execution mode is individual',
    setUp: () {
      final dateInitial = DateTime.parse('2023-05-12 10:37:21');
      final dateFinal = DateTime.parse('2023-05-12 10:37:21');
      final dayInfoList = [
        DayInfoModel(
          isOdd: true,
          day: dateFinal,
          isSynchronized: true,
          isRemoteness: true,
          times: [
            TimeInfoModel(
              clockingEventId: 'id1',
              dateTime: dateInitial,
              isBold: false,
              isPhoneOrigin: false,
              isPlatformOrigin: false,
              isManual: false,
              isRemoteness: false,
              isSynchronized: false,
              use: 2,
              isMealBreak: false,
            ),
          ],
          employee: employeeMockDto,
        ),
      ];

      when(() => getExecutionModeUsecase.call())
          .thenAnswer((_) async => ExecutionModeEnum.individual);

      when(
        () => clockingEventRepository.findByDate(
          date: any(named: 'date'),
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => [clockingEventMock]);

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
        ),
      ).thenAnswer((_) async => dayInfoList);
    },
    build: () {
      return timerAdjustmentBloc;
    },
    act: (bloc) {
      bloc.add(LoadDayTimerAdjustmentEvent(selectedDay: DateTime(2023, 10, 1)));
    },
    expect: () => [
      isA<LoadingTimerAdjustmentState>(),
      isA<LoadedTimerAdjustmentState>(),
    ],
  );

  test('should set selectedEmployee to first employee when list is not empty',
      () async {
    final dateInitial = DateTime.parse('2023-05-12 10:37:21');
    final dateFinal = DateTime.parse('2023-05-12 10:37:21');
    final dayInfoList = [
      DayInfoModel(
        isOdd: true,
        day: dateFinal,
        isSynchronized: true,
        isRemoteness: true,
        times: [
          TimeInfoModel(
            clockingEventId: 'id1',
            dateTime: dateInitial,
            isBold: false,
            isPhoneOrigin: false,
            isPlatformOrigin: false,
            isManual: false,
            isRemoteness: false,
            isSynchronized: false,
            use: 2,
            isMealBreak: false,
          ),
        ],
        employee: employeeMockDto,
      ),
    ];
    when(() => getExecutionModeUsecase.call())
        .thenAnswer((_) async => ExecutionModeEnum.multiple);
    when(
      () => clockingEventRepository.findByDate(
        date: any(named: 'date'),
        employeeId: any(named: 'employeeId'),
      ),
    ).thenAnswer((_) async => [clockingEventMock]);
    when(
      () => dayInfoService.generate(
        clockingEvents: any(named: 'clockingEvents'),
        finalDate: any(named: 'finalDate'),
        initialDate: any(named: 'initialDate'),
      ),
    ).thenAnswer((_) async => dayInfoList);

    const username = 'manager_username';
    final employeeList = [employeeMockDto];
    when(() => getEmployeesByManagerUsecase.call(username: username))
        .thenAnswer((_) async => [employeeEntityMock]);
    timerAdjustmentBloc.selectedEmployee = employeeList.first;
    timerAdjustmentBloc
        .add(LoadDayTimerAdjustmentEvent(selectedDay: DateTime(2023, 5, 12)));

    expect(timerAdjustmentBloc.selectedEmployee, employeeList.first);
  });
  test('should set selectedEmployee to null when list is empty', () async {
    final dateInitial = DateTime.parse('2023-05-12 10:37:21');
    final dateFinal = DateTime.parse('2023-05-12 10:37:21');
    final dayInfoList = [
      DayInfoModel(
        isOdd: true,
        day: dateFinal,
        isSynchronized: true,
        isRemoteness: true,
        times: [
          TimeInfoModel(
            clockingEventId: 'id1',
            dateTime: dateInitial,
            isBold: false,
            isPhoneOrigin: false,
            isPlatformOrigin: false,
            isManual: false,
            isRemoteness: false,
            isSynchronized: false,
            use: 2,
            isMealBreak: false,
          ),
        ],
        employee: employeeMockDto,
      ),
    ];
    when(() => getExecutionModeUsecase.call())
        .thenAnswer((_) async => ExecutionModeEnum.multiple);
    when(
      () => clockingEventRepository.findByDate(
        date: any(named: 'date'),
        employeeId: any(named: 'employeeId'),
      ),
    ).thenAnswer((_) async => [clockingEventMock]);
    when(
      () => dayInfoService.generate(
        clockingEvents: any(named: 'clockingEvents'),
        finalDate: any(named: 'finalDate'),
        initialDate: any(named: 'initialDate'),
      ),
    ).thenAnswer((_) async => dayInfoList);
    const username = 'manager_username';
    final employeeList = <Employee>[];
    when(() => getEmployeesByManagerUsecase.call(username: username))
        .thenAnswer((_) async => employeeList);

    timerAdjustmentBloc
        .add(LoadDayTimerAdjustmentEvent(selectedDay: DateTime(2023, 10, 1)));

    expect(timerAdjustmentBloc.selectedEmployee, isNull);
  });
}
