import 'package:bloc_test/bloc_test.dart';
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/find_employee_by_username_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/clocking_event_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/ordering_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_clocking_event_by_manager_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/verify_user_logged_is_admin_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/verify_user_logged_is_manager_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/clocking_event_dto_mock.dart';
import '../../../../../mocks/employee_dto_mock.dart';
import '../../../../../mocks/overnight_entity_mock.dart';

class MockInternalClockService extends Mock implements clock.IInternalClockService {}

class MockUtils extends Mock implements IUtils {}

class MockClockingEventMapper extends Mock implements ClockingEventMapper {}

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockEmployeeUsecase extends Mock implements IGetEmployeeUsecase {}

class MockIDayInfoService extends Mock implements IDayInfoService {}

class MockOvernightRepository extends Mock implements IOvernightRepository {}

class MockVerifyUserLoggedIsManagerUsecase extends Mock
    implements VerifyUserLoggedIsManagerUsecase {}

class MockVerifyUserLoggedIsAdminUsecase extends Mock
    implements VerifyUserLoggedIsAdminUsecase {}

class MockFindEmployeeIdByUsernameUsecase extends Mock
    implements FindEmployeeIdByUsernameUsecase {}

class MockGetClockingEventByManagerUsecase extends Mock
    implements GetClockingEventByManagerUsecase {}

void main() {
  DateTime dateInicial = DateTime.parse('2023-05-12 10:37:21');
  DateTime dateFinal = DateTime.parse('2023-05-12 10:37:21');
  DateTime clockTime = DateTime.parse('2023-05-12 10:37:21');
  DateTime firstDayOfTheMonth = DateTime.parse('2023-05-01 10:37:21');
  DateTime lastDayOfTheMonth = DateTime.parse('2023-05-12 10:37:21');

  late clock.IInternalClockService internalClockService;
  late IUtils utils;
  late IClockingEventRepository clockingEventRepository;
  late IGetEmployeeUsecase getEmployeeUseCase;
  late IDayInfoService dayInfoService;
  late IOvernightRepository overnightRepository;
  late VerifyUserLoggedIsManagerUsecase verifyUserLoggedIsManagerUsecase;
  late VerifyUserLoggedIsAdminUsecase verifyUserLoggedIsAdminUsecase;
  late FindEmployeeIdByUsernameUsecase findEmployeeIdByUsernameUsecase;
  late GetClockingEventByManagerUsecase getClockingEventByManagerUsecase;
  late ClockingEventMapper clockingEventMapper;

  late PeriodBloc periodBloc;

  List<ClockingEventDto> clockList = [
    ClockingEventDto(
      clockingEventId: 'clockingEventId',
      dateEvent: '2023-05-12',
      timeEvent: '11:36',
      timeZone: '-0300',
      companyIdentifier: '000000000000000',
      cpf: '00000000000',
      appVersion: '2.1.0',
      platform: 'android',
      employeeDto: employeeMockDto,
      use: '1',
      signature: 'signature',
      signatureVersion: 2,
    ),
  ];

    List<ClockingEvent> clockListEntity = [
    ClockingEvent(
      id: 'clockingEventId',
      dateEvent: '2023-05-12',
      timeEvent: '11:36',
      timeZone: '-0300',
      companyIdentifier: '000000000000000',
      cpf: '00000000000',
      appVersion: '2.1.0',
      platform: 'android',
      employeeId: '123',
      use: '1',
      signature: 'signature',
      signatureVersion: 2,
      employeeName: '',
      companyName: '',
    ),
  ];


  DayInfoModel dayInfoModel = DayInfoModel(
    isOdd: true,
    day: dateFinal,
    isSynchronized: true,
    isRemoteness: true,
    times: [
      TimeInfoModel(
        clockingEventId: 'id1',
        dateTime: dateInicial,
        isBold: false,
        isPhoneOrigin: false,
        isPlatformOrigin: false,
        isManual: false,
        isRemoteness: false,
        isSynchronized: false,
        use: 1,
        isMealBreak: false,
      ),
    ],
    employee: employeeMockDto,
  );

  setUp(
    () {
      internalClockService = MockInternalClockService();
      utils = MockUtils();
      clockingEventRepository = MockClockingEventRepository();
      getEmployeeUseCase = MockEmployeeUsecase();
      dayInfoService = MockIDayInfoService();
      overnightRepository = MockOvernightRepository();
      verifyUserLoggedIsManagerUsecase = MockVerifyUserLoggedIsManagerUsecase();
      verifyUserLoggedIsAdminUsecase = MockVerifyUserLoggedIsAdminUsecase();
      findEmployeeIdByUsernameUsecase = MockFindEmployeeIdByUsernameUsecase();
      getClockingEventByManagerUsecase = MockGetClockingEventByManagerUsecase();
      clockingEventMapper = MockClockingEventMapper();

      periodBloc = PeriodBloc(
        internalClockService,
        utils,
        clockingEventRepository,
        getEmployeeUseCase,
        dayInfoService,
        overnightRepository,
        verifyUserLoggedIsManagerUsecase,
        verifyUserLoggedIsAdminUsecase,
        findEmployeeIdByUsernameUsecase,
        getClockingEventByManagerUsecase,
        clockingEventMapper,
      );

      when(
        () => getEmployeeUseCase.call(),
      ).thenReturn(employeeMockDto);

      when(
        () => internalClockService.getClockDateTime(),
      ).thenReturn(clockTime);

      when(
        () => utils.firstDayOfWeek(any()),
      ).thenReturn(dateInicial);

      when(
        () => utils.firstDayOfTheMonth(any()),
      ).thenReturn(firstDayOfTheMonth);

      when(
        () => utils.lastDayOfTheMonth(any()),
      ).thenReturn(lastDayOfTheMonth);

      when(
        () => clockingEventRepository.findByEmployeeAndPeriod(
          initDate: any(named: 'initDate'),
          endDate: any(named: 'endDate'),
          employeeId: any(named: 'employeeId'),
          orderingMode: OrderingModeEnum.desc,
        ),
      ).thenAnswer(
        (invocation) => Future.value(clockListEntity),
      );

      when(
        () => dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
          overnights: any(named: 'overnights'),
        ),
      ).thenAnswer(
        (invocation) => Future.value([dayInfoModel]),
      );

      when(
        () => overnightRepository.findByEmployee(
          employeeId: any(named: 'employeeId'),
        ),
      ).thenAnswer((_) async => [overnightEntityMock]);

      when(() => clockingEventMapper.fromEntityToDtoCollectorList(any(),))
          .thenAnswer(
      (_) async => [clockingEventDtoMock], // Retorna uma lista válida
    );
    },
  );

  group('PeriodBlocTest Single or Driver User', () {
    blocTest(
      'LoadPeriodEvent Test',
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(LoadPeriodEvent()),
      expect: () {
        return [
          isA<LoadingDayInfoState>(),
          isA<LoadedDayInfoState>(),
        ];
      },
      verify: (_) {
        verify(
          () => internalClockService.getClockDateTime(),
        ).called(2);

        verify(
          () => utils.firstDayOfTheMonth(any()),
        ).called(1);

        verify(
          () => utils.lastDayOfTheMonth(any()),
        ).called(1);

        verify(() => getEmployeeUseCase.call()).called(1);

        verifyNever(
          () => verifyUserLoggedIsAdminUsecase.call(
            username: any(named: 'username'),
          ),
        );
        verifyNever(
          () => verifyUserLoggedIsManagerUsecase.call(
            username: any(named: 'username'),
          ),
        );

        verifyNever(
          () => getClockingEventByManagerUsecase.call(
            appointments: any(named: 'appointments'),
            username: any(named: 'username'),
          ),
        );

        verifyNever(
          () => findEmployeeIdByUsernameUsecase.call(
            username: any(named: 'username'),
          ),
        );
      },
    );
    blocTest(
      'LoadPeriodEvent isPeriodSelected Test',
      setUp: () {
        periodBloc.isPeriodSelected = true;
        periodBloc.initialDateFilter = firstDayOfTheMonth;
        periodBloc.finalDateFilter =
            lastDayOfTheMonth.subtract(const Duration(days: 10));
      },
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(LoadPeriodEvent()),
      expect: () {
        return [
          isA<LoadingDayInfoState>(),
          isA<LoadedDayInfoState>(),
        ];
      },
      verify: (_) {
        verify(() => getEmployeeUseCase.call()).called(1);


        verifyNever(
          () => internalClockService.getClockDateTime(),
        );

        verifyNever(
          () => utils.firstDayOfTheMonth(any()),
        );

        verifyNever(
          () => utils.lastDayOfTheMonth(any()),
        );

        verifyNever(
          () => verifyUserLoggedIsAdminUsecase.call(
            username: any(named: 'username'),
          ),
        );

        verifyNever(
          () => verifyUserLoggedIsManagerUsecase.call(
            username: any(named: 'username'),
          ),
        );

        verifyNever(
          () => getClockingEventByManagerUsecase.call(
            appointments: any(named: 'appointments'),
            username: any(named: 'username'),
          ),
        );

        verifyNever(
          () => findEmployeeIdByUsernameUsecase.call(
            username: any(named: 'username'),
          ),
        );
      },
    );

    blocTest(
      'RefreshPeriodEvent Test',
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(RefreshPeriodEvent()),
      expect: () {
        return [
          isA<LoadedDayInfoState>(),
        ];
      },
    );

    blocTest(
      'BackWeekPeriodEvent Test',
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(BackWeekPeriodEvent()),
      expect: () {
        return [
          isA<LoadedDayInfoState>(),
        ];
      },
    );

    blocTest(
      'AheadWeekPeriodEvent Test',
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(AheadWeekPeriodEvent()),
      expect: () {
        return [
          isA<LoadedDayInfoState>(),
        ];
      },
    );

    blocTest(
      'FilterPeriodEvent Test',
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(
        FilterPeriodEvent(
          initDate: firstDayOfTheMonth,
          endDate: lastDayOfTheMonth.subtract(const Duration(days: 10)),
          isPeriodSelected: true,
        ),
      ),
      expect: () {
        return [
          isA<LoadingDayInfoState>(),
          isA<LoadedDayInfoState>(),
        ];
      },
      verify: (_) {

        verify(
          () => 
          dayInfoService.generate(
          clockingEvents: any(named: 'clockingEvents'),
          finalDate: any(named: 'finalDate'),
          initialDate: any(named: 'initialDate'),
          overnights: any(named: 'overnights'),
        ),
        ).called(1);
      },
    );
  });

  group('PeriodBlocTest Multi Users', () {
    blocTest(
      'LoadPeriodEvent admin Test',
      setUp: () {
        periodBloc.username = 'username';

        when(() => getEmployeeUseCase.call()).thenReturn(null);

        when(() => verifyUserLoggedIsAdminUsecase.call(username: 'username'))
            .thenAnswer((_) async => true);

        when(() => verifyUserLoggedIsManagerUsecase.call(username: 'username'))
            .thenAnswer((_) async => false);

        when(
          () => clockingEventRepository.findByPeriod(
            initDate: firstDayOfTheMonth,
            endDate: lastDayOfTheMonth,
            orderingMode: OrderingModeEnum.desc,
          ),
        ).thenAnswer((_) async => clockListEntity);
      },
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(LoadPeriodEvent()),
      expect: () {
        return [
          isA<LoadingDayInfoState>(),
          isA<LoadedDayInfoState>(),
        ];
      },
      verify: (_) {
        verify(
          () => verifyUserLoggedIsAdminUsecase.call(username: 'username'),
        ).called(1);

        verify(
          () => verifyUserLoggedIsManagerUsecase.call(username: 'username'),
        ).called(1);

        verify(
          () => clockingEventRepository.findByPeriod(
            initDate: firstDayOfTheMonth,
            endDate: lastDayOfTheMonth,
            orderingMode: OrderingModeEnum.desc,
          ),
        ).called(1);

        verifyNever(
          () => getClockingEventByManagerUsecase.call(
            appointments: any(named: 'appointments'),
            username: any(named: 'username'),
          ),
        );

        verifyNever(
          () => findEmployeeIdByUsernameUsecase.call(
            username: any(named: 'username'),
          ),
        );

        verifyNever(
          () => clockingEventRepository.findByEmployeeAndPeriod(
            initDate: any(named: 'initDate'),
            endDate: any(named: 'endDate'),
            employeeId: any(named: 'employeeId'),
            orderingMode: OrderingModeEnum.desc,
          ),
        );
      },
    );

    blocTest(
      'LoadPeriodEvent manager Test',
      setUp: () {
        periodBloc.username = 'username';

        when(() => getEmployeeUseCase.call()).thenReturn(null);

        when(() => verifyUserLoggedIsAdminUsecase.call(username: 'username'))
            .thenAnswer((_) async => false);

        when(() => verifyUserLoggedIsManagerUsecase.call(username: 'username'))
            .thenAnswer((_) async => true);

        when(
          () => clockingEventRepository.findByPeriod(
            initDate: firstDayOfTheMonth,
            endDate: lastDayOfTheMonth,
            orderingMode: OrderingModeEnum.desc,
          ),
        ).thenAnswer((_) async => clockListEntity);

        when(
          () => getClockingEventByManagerUsecase.call(
            appointments: any(named: 'appointments'),
            username: 'username',
          ),
        ).thenAnswer((_) async => clockList);
      },
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(LoadPeriodEvent()),
      expect: () {
        return [
          isA<LoadingDayInfoState>(),
          isA<LoadedDayInfoState>(),
        ];
      },
      verify: (_) {
        verify(
          () => verifyUserLoggedIsAdminUsecase.call(username: 'username'),
        ).called(1);

        verify(
          () => verifyUserLoggedIsManagerUsecase.call(username: 'username'),
        ).called(1);

        verify(
          () => clockingEventRepository.findByPeriod(
            initDate: firstDayOfTheMonth,
            endDate: lastDayOfTheMonth,
            orderingMode: OrderingModeEnum.desc,
          ),
        ).called(1);

        verifyNever(
          () => findEmployeeIdByUsernameUsecase.call(
            username: any(named: 'username'),
          ),
        );

        verifyNever(
          () => clockingEventRepository.findByEmployeeAndPeriod(
            initDate: any(named: 'initDate'),
            endDate: any(named: 'endDate'),
            employeeId: any(named: 'employeeId'),
            orderingMode: OrderingModeEnum.desc,
          ),
        );
      },
    );

    blocTest(
      'LoadPeriodEvent employee Test',
      setUp: () {
        periodBloc.username = 'username';

        when(() => getEmployeeUseCase.call()).thenReturn(null);

        when(() => verifyUserLoggedIsAdminUsecase.call(username: 'username'))
            .thenAnswer((_) async => false);

        when(() => verifyUserLoggedIsManagerUsecase.call(username: 'username'))
            .thenAnswer((_) async => false);

        when(() => findEmployeeIdByUsernameUsecase.call(username: 'username'))
            .thenAnswer((_) async => employeeMockDto);

        when(
          () => clockingEventRepository.findByEmployeeAndPeriod(
            initDate: firstDayOfTheMonth,
            endDate: lastDayOfTheMonth,
            employeeId: employeeDtoMock.id,
            orderingMode: OrderingModeEnum.desc,
          ),
        ).thenAnswer((_) async => clockListEntity);
      },
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(LoadPeriodEvent()),
      expect: () {
        return [
          isA<LoadingDayInfoState>(),
          isA<LoadedDayInfoState>(),
        ];
      },
      verify: (_) {
        verify(
          () => verifyUserLoggedIsAdminUsecase.call(username: 'username'),
        ).called(1);

        verify(
          () => verifyUserLoggedIsManagerUsecase.call(username: 'username'),
        ).called(1);

        verify(
          () => findEmployeeIdByUsernameUsecase.call(username: 'username'),
        ).called(1);

        verify(
          () => clockingEventRepository.findByEmployeeAndPeriod(
            initDate: firstDayOfTheMonth,
            endDate: lastDayOfTheMonth,
            employeeId: employeeDtoMock.id,
            orderingMode: OrderingModeEnum.desc,
          ),
        ).called(1);

        verifyNever(
          () => clockingEventRepository.findByPeriod(
            initDate: any(named: 'initDate'),
            endDate: any(named: 'endDate'),
            orderingMode: OrderingModeEnum.desc,
          ),
        );

        verifyNever(
          () => getClockingEventByManagerUsecase.call(
            appointments: any(named: 'appointments'),
            username: any(named: 'username'),
          ),
        );
      },
    );

    blocTest(
      'FilterEmployeeEvent',
      setUp: () {
        periodBloc.username = 'username';
        periodBloc.initialDateFilter = firstDayOfTheMonth;
        periodBloc.finalDateFilter = lastDayOfTheMonth;

        when(() => getEmployeeUseCase.call()).thenReturn(null);

        when(() => verifyUserLoggedIsAdminUsecase.call(username: 'username'))
            .thenAnswer((_) async => true);

        when(() => verifyUserLoggedIsManagerUsecase.call(username: 'username'))
            .thenAnswer((_) async => false);

        when(
              () => clockingEventRepository.findByPeriod(
            initDate: firstDayOfTheMonth,
            endDate: lastDayOfTheMonth,
            orderingMode: OrderingModeEnum.desc,
          ),
        ).thenAnswer((_) async => clockListEntity);
      },
      build: () {
        return periodBloc;
      },
      act: (PeriodBloc bloc) => bloc.add(
        FilterEmployeeEvent(
          employeesIds: ['id'],
          isEmployeesSelected: true,
        ),
      ),
      expect: () {
        return [
          isA<LoadingDayInfoState>(),
          isA<LoadedDayInfoState>(),
        ];
      },
      verify: (_) {
        verify(
          () => clockingEventRepository.findByPeriod(
            initDate: firstDayOfTheMonth,
            endDate: lastDayOfTheMonth,
            orderingMode: OrderingModeEnum.desc,
          ),
        ).called(1);

        verify(
          () => dayInfoService.generate(
            clockingEvents: [],
            finalDate: lastDayOfTheMonth,
            initialDate: firstDayOfTheMonth,
            overnights: [],
          ),
        ).called(1);
      },
    );
  });
}
