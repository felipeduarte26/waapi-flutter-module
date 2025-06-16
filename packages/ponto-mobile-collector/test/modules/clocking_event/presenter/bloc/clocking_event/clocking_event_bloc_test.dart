import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/clocking_event_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_company_dto_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_dto_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/util/iclocking_event_utill.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/clock_company_dto_mock.dart';
import '../../../../../mocks/clocking_event_dto_mock.dart';
import '../../../../../mocks/clocking_event_mock.dart';
import '../../../../../mocks/employee_dto_mock.dart';

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockGetEmploeeDtoUsecase extends Mock implements IGetEmployeeDtoUsecase {}

class MockGetCompanyDtoUsecase extends Mock implements IGetCompanyDtoUsecase {}

class MockGetEmploeeUsecase extends Mock implements IGetEmployeeUsecase {}

class MockClockingEventUtil extends Mock implements IClockingEventUtil {}

class MockClockingEventMapper extends Mock implements ClockingEventMapper {}

class MockGetClockDateTimeUsecase extends Mock
    implements IGetClockDateTimeUsecase {}

class MockSessionService extends Mock implements ISessionService {}

class MockUtils extends Mock implements IUtils {}

class FakeBuildContext extends Fake implements BuildContext {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

void main() {
  late IClockingEventRepository clockingEventRepository;
  late IGetCompanyDtoUsecase getCompanyDtoUsecase;
  late IGetEmployeeDtoUsecase getEmployeeDtoUsecase;
  late IGetEmployeeUsecase getEmployeeUsecase;
  late IClockingEventUtil clockingEventUtil;
  late ClockingEventBloc clockingEventBloc;
  late IGetClockDateTimeUsecase getClockDateTimeUsecase;
  late ISessionService sessionService;
  late IUtils utils;
  late BuildContext mockContext;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late ClockingEventMapper clockingEventMapper;
  DateTime today = DateTime.now();

  setUp(
    () {
      clockingEventRepository = MockClockingEventRepository();
      getCompanyDtoUsecase = MockGetCompanyDtoUsecase();
      getEmployeeDtoUsecase = MockGetEmploeeDtoUsecase();
      clockingEventUtil = MockClockingEventUtil();
      getEmployeeUsecase = MockGetEmploeeUsecase();
      getClockDateTimeUsecase = MockGetClockDateTimeUsecase();
      sessionService = MockSessionService();
      utils = MockUtils();
      mockContext = FakeBuildContext();
      getExecutionModeUsecase = MockGetExecutionModeUsecase();
      clockingEventMapper = MockClockingEventMapper();

      when(() => getClockDateTimeUsecase.call()).thenReturn(today);

      when(() => sessionService.getEmployee()).thenReturn(employeeMockDto);
      when(() => sessionService.hasEmployee()).thenReturn(true);
      when(() => sessionService.checkDeviceStatus())
          .thenReturn(DeviceAuthorizationStatusEnum.deviceActivationIsPending);
      when(() => sessionService.getExecutionMode())
          .thenReturn(ExecutionModeEnum.individual);
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer((_) async => ExecutionModeEnum.individual);

      clockingEventBloc = ClockingEventBloc(
        getClockDateTimeUsecase,
        clockingEventRepository,
        getEmployeeUsecase,
        getCompanyDtoUsecase,
        getEmployeeDtoUsecase,
        sessionService,
        utils,
        getExecutionModeUsecase,
        clockingEventMapper,
      );
    },
  );

  group(
    'ClockingEventBloc',
    () {
      blocTest(
        'on LoadClockingEventEvent test',
        setUp: () {
          registerFallbackValue(DateTime.now());

          when(() => clockingEventMapper.fromEntityToDtoCollectorList([clockingEventMock]),)
              .thenAnswer((_) async => [clockingEventDtoMock]);

          when(() => getEmployeeUsecase.call()).thenReturn(employeeMockDto);

          when(
            () => getCompanyDtoUsecase.call(
              id: any(named: 'id'),
            ),
          ).thenAnswer((_) async => companyDtoMock);

          when(() => getEmployeeDtoUsecase.call(id: any(named: 'id')))
              .thenAnswer((_) async => employeeMockDto);

          when(
            () => clockingEventRepository.findByDate(
              date: any(named: 'date'),
              employeeId: any(named: 'employeeId'),
              filterByUse: any(named: 'filterByUse'),
            ),
          ).thenAnswer((_) async => [clockingEventMock]);

        },
        build: () => clockingEventBloc,
        act: (bloc) => bloc.add(LoadClockingEventEvent()),
        expect: () => [
          isA<LoadingClockingEventState>(),
          isA<ReadyContentClockingEventState>(),
        ],
        verify: (bloc) {
          verify(() => getEmployeeUsecase.call()).called(1);

          verify(
            () => getCompanyDtoUsecase.call(
              id: any(named: 'id'),
            ),
          ).called(1);

          verify(() => getEmployeeDtoUsecase.call(id: any(named: 'id')))
              .called(1);

          verify(
            () => clockingEventRepository.findByDate(
              date: any(named: 'date'),
              employeeId: any(named: 'employeeId'),
              filterByUse: any(named: 'filterByUse'),
            ),
          ).called(1);

          verifyNoMoreInteractions(
            getEmployeeUsecase,
          );

          verifyNoMoreInteractions(
            getCompanyDtoUsecase,
          );

          verifyNoMoreInteractions(
            getEmployeeDtoUsecase,
          );

          verifyNoMoreInteractions(
            clockingEventUtil,
          );
        },
      );

      blocTest(
        'on ChangeExpandedTodaysClockingEventEvent test',
        build: () => clockingEventBloc,
        act: (bloc) => bloc.add(
          ChangeExpandedTodaysClockingEventEvent(),
        ),
        expect: () => [
          isA<ChangeTodayClockingEventState>(),
        ],
      );

      blocTest(
        'on UpdateClockTimeEvent test',
        build: () => clockingEventBloc,
        act: (bloc) => bloc.add(
          BusyClockingEvent(),
        ),
        expect: () => [
          isA<LoadingClockingEventState>(),
        ],
        verify: (bloc) {
          verifyZeroInteractions(clockingEventRepository);
        },
      );

      blocTest(
        'on ShowPreloadedDataEvent test',
        build: () => clockingEventBloc,
        act: (bloc) => bloc.add(
          ShowPreloadedDataEvent(),
        ),
        expect: () => [
          isA<ReadyContentClockingEventState>(),
        ],
        verify: (bloc) {
          verifyZeroInteractions(clockingEventRepository);
        },
      );

      test('should return session employee name test', () {
        expect(clockingEventBloc.getEmployeeName(), employeeDtoMock.name);
      });

      test('should retur true when call hasEmployee test', () {
        expect(clockingEventBloc.hasEmployee(), true);
      });

      test('get device status message on single mode test', () {
        when(
          () => utils.getDeviceStatusMessage(
            mockContext,
            DeviceAuthorizationStatusEnum.deviceActivationIsPending,
          ),
        ).thenReturn('message');
        expect(clockingEventBloc.deviceStatus(mockContext), 'message');
      });
    },
  );
}
