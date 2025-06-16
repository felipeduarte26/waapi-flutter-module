import 'package:bloc_test/bloc_test.dart';
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/clocking_event_use.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/journey_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/clocking_event_use_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_total_time_since_last_journey_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../../mocks/clocking_event_mock.dart';
import '../../../../../../../mocks/journey_mock.dart';
import '../../../../../../../mocks/state_location_entity_mock.dart';

class MockRegisterClockingEventBloc extends MockBloc<RegisterClockingEventEvent, RegisterClockingState> implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

class MockSessionService extends Mock implements ISessionService {}

class MockJourneyRepository extends Mock implements IJourneyRepository {}

class MockClockingEventRepository extends Mock implements IClockingEventRepository {}

class MockRegisterJourneyUsecase extends Mock implements IRegisterJourneyUsecase {}

class MockRegisterOvernightUsecase extends Mock implements IRegisterOvernightUsecase {}

class MockGetTotalTimeSinceLastJourneyUseCase extends Mock implements GetTotalTimeSinceLastJourneyUseCase {}

class MockFinishJourneyUsecase extends Mock implements IFinishJourneyUsecase {}

class MockClockingEventUseRepository extends Mock implements ClockingEventUseRepository {}

class MockInternalClockService extends Mock implements clock.IInternalClockService {}

class MockConfigurationRepository extends Mock implements IConfigurationRepository {}

class MockPlatformService extends Mock implements IPlatformService {}

class MockJourneyEntity extends Mock implements JourneyEntity {
  @override
  final String id = 'journeyId';

  @override
  final DateTime startDate;

  MockJourneyEntity({
    DateTime? startDate,
  }) : startDate = startDate ?? DateTime(2000, 1, 1, 8);
}

class MockClockingEvent extends Mock implements ClockingEvent {
  @override
  final bool isMealBreak;

  final DateTime dateTimeEvent;

  MockClockingEvent({
    DateTime? dateTimeEvent,
    this.isMealBreak = false,
  }) : dateTimeEvent = dateTimeEvent ?? DateTime(2000, 1, 1, 8);

  @override
  DateTime getDateTimeEvent() {
    return dateTimeEvent;
  }
}

void main() {
  late DriversJourneyBloc driversJourneyBloc;
  late RegisterClockingEventBloc mockRegisterClockingEventBloc;
  late ISessionService mockSessionService;
  late IJourneyRepository mockJourneyRepository;
  late IClockingEventRepository mockClockingEventRepository;
  late IUtils mockUtils;
  late IRegisterJourneyUsecase mockRegisterJourneyUsecase;
  late IRegisterOvernightUsecase mockRegisterOvernightUsecase;
  late IFinishJourneyUsecase mockFinishJourneyUsecase;
  late ClockingEventUseRepository mockClockingEventUseRepository;
  late clock.IInternalClockService mockInternalClockService;
  late IConfigurationRepository mockConfigurationRepository;
  late IPlatformService mockPlatformService;
  late GetTotalTimeSinceLastJourneyUseCase mockGetTotalTimeSinceLastJourneyUseCase;

  void prepareMocks({bool overnight = true}) {
    var configuration = Configuration(
      onlyOnline: false,
      operationMode: OperationModeType.driver,
      takePhoto: false,
      timezone: '-03:00',
      overnight: overnight,
    );
    when(
      () => mockConfigurationRepository.findByEmployeeId(
        employeeId: any(
          named: 'employeeId',
        ),
      ),
    ).thenAnswer(
      (_) async => configuration,
    );

    when(
      () => mockGetTotalTimeSinceLastJourneyUseCase.call(),
    ).thenAnswer(
      (_) async => const Duration(hours: 5, minutes: 30),
    );

    when(
      () => mockClockingEventUseRepository.findAllByEmployeeId(
        employeeId: any(named: 'employeeId'),
      ),
    ).thenAnswer(
      (invocation) async => List.of([
        const ClockingEventUse(
          code: '2',
          employeeId: 'employeeId',
          clockingEventUseType: ClockingEventUseType.clockingEvent,
          description: '',
        ),
        const ClockingEventUse(
          code: '29',
          employeeId: 'employeeId',
          clockingEventUseType: ClockingEventUseType.driving,
          description: '',
        ),
        const ClockingEventUse(
          code: '28',
          employeeId: 'employeeId',
          clockingEventUseType: ClockingEventUseType.mandatoryBreak,
          description: '',
        ),
      ]),
    );

    var clockingEventMock = ClockingEvent(
      dateEvent: '2023-10-01',
      timeEvent: '12:00:00',
      timeZone: 'UTC',
      cpf: '12345678900',
      employeeName: 'John Doe',
      companyName: 'Example Company',
      companyIdentifier: 'EX123',
      signature: 'signature',
      use: 'use',
      journeyEventName: 'StartJourneyEvent',
      isMealBreak: false,
      location: null,
      locationStatus: null,
      id: '',
      signatureVersion: 1,
      employeeId: '',
    );

    when(
      () => mockClockingEventRepository.findAllClockingEventByJourneyId(
        journeyId: any(named: 'journeyId'),
      ),
    ).thenAnswer((_) async => List.of([clockingEventMock]));

    var journeyEntity = JourneyEntity(
      employeeId: 'employeeId',
      id: '',
      startDate: DateTime.now(),
      journeyNumber: 1,
    );

    when(
      () => mockJourneyRepository.findCurrentJourneyByEmployeeId(
        employeeId: any(named: 'employeeId'),
      ),
    ).thenAnswer((invocation) async => journeyEntity);
  }

  setUp(
    () {
      mockRegisterClockingEventBloc = MockRegisterClockingEventBloc();
      mockSessionService = MockSessionService();
      mockJourneyRepository = MockJourneyRepository();
      mockClockingEventRepository = MockClockingEventRepository();
      mockUtils = Utils();
      mockRegisterJourneyUsecase = MockRegisterJourneyUsecase();
      mockRegisterOvernightUsecase = MockRegisterOvernightUsecase();
      mockFinishJourneyUsecase = MockFinishJourneyUsecase();
      mockClockingEventUseRepository = MockClockingEventUseRepository();
      mockInternalClockService = MockInternalClockService();
      mockConfigurationRepository = MockConfigurationRepository();
      mockPlatformService = MockPlatformService();
      mockGetTotalTimeSinceLastJourneyUseCase = MockGetTotalTimeSinceLastJourneyUseCase();

      when(
        () => mockPlatformService.getLocation(),
      ).thenAnswer((_) async => stateLocationEntityMock);

      driversJourneyBloc = DriversJourneyBloc(
        mockRegisterClockingEventBloc,
        mockSessionService,
        mockJourneyRepository,
        mockClockingEventRepository,
        mockUtils,
        mockRegisterJourneyUsecase,
        mockRegisterOvernightUsecase,
        mockFinishJourneyUsecase,
        mockClockingEventUseRepository,
        mockInternalClockService,
        mockConfigurationRepository,
        mockPlatformService,
        mockGetTotalTimeSinceLastJourneyUseCase,
      );

      when(
        () => mockSessionService.getEmployeeId(),
      ).thenReturn(
        'employeeId',
      );
    },
  );

  tearDown(
    () {
      driversJourneyBloc.close();
    },
  );

  group(
    'DriversJourneyBloc',
    () {
      test(
        'initial state is InitialDriversJourneyState',
        () {
          expect(
            driversJourneyBloc.state,
            isA<InitialDriversJourneyState>(),
          );
        },
      );

      blocTest<DriversJourneyBloc, DriversJourneyState>(
        'emits [LoadingDriversJourneyState, NotStartedDriversJourneyState] when LoadJourneyEvent is added and no current journey exists',
        build: () {
          const configuration = Configuration(
            onlyOnline: true,
            operationMode: OperationModeType.single,
            takePhoto: true,
            timezone: '-03:00',
          );

          when(
            () => mockConfigurationRepository.findByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => configuration,
          );

          when(
            () => mockGetTotalTimeSinceLastJourneyUseCase.call(),
          ).thenAnswer(
            (_) async => const Duration(hours: 5, minutes: 30),
          );

          when(
            () => mockClockingEventUseRepository.findAllByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => [],
          );

          when(
            () => mockJourneyRepository.findCurrentJourneyByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => null,
          );

          return driversJourneyBloc;
        },
        act: (bloc) => bloc.add(LoadJourneyEvent()),
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<NotStartedDriversJourneyState>(),
        ],
      );

      blocTest<DriversJourneyBloc, DriversJourneyState>(
        'emits [LoadingDriversJourneyState, StartedDriversJourneyState] when LoadJourneyEvent is added and current journey exists',
        build: () {
          const configuration = Configuration(
            onlyOnline: true,
            operationMode: OperationModeType.single,
            takePhoto: true,
            timezone: '-03:00',
          );

          final clockingEventUseDTOs = [
            const ClockingEventUse(
              code: '2',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.clockingEvent,
              description: '',
            ),
            const ClockingEventUse(
              code: '18',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.paidBreak,
              description: '',
            ),
            const ClockingEventUse(
              code: '22',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.mandatoryBreak,
              description: '',
            ),
            const ClockingEventUse(
              code: '23',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.driving,
              description: '',
            ),
            const ClockingEventUse(
              code: '21',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.waiting,
              description: '',
            ),
          ];

          when(
            () => mockGetTotalTimeSinceLastJourneyUseCase.call(),
          ).thenAnswer(
            (_) async => const Duration(hours: 5, minutes: 30),
          );
          when(
            () => mockConfigurationRepository.findByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => configuration,
          );

          when(
            () => mockClockingEventUseRepository.findAllByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => clockingEventUseDTOs,
          );

          when(
            () => mockJourneyRepository.findCurrentJourneyByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => null,
          );

          return driversJourneyBloc;
        },
        act: (bloc) => bloc.add(LoadJourneyEvent()),
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<NotStartedDriversJourneyState>(),
        ],
      );

      blocTest<DriversJourneyBloc, DriversJourneyState>(
        'emits [RegisteringClockingEvent, StartedDriversJourneyState] when StartJourneyEvent is added',
        build: () {
          const configuration = Configuration(
            onlyOnline: true,
            operationMode: OperationModeType.single,
            takePhoto: true,
            timezone: '-03:00',
          );

          final clockingEventUseDTOs = [
            const ClockingEventUse(
              code: '2',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.clockingEvent,
              description: '',
            ),
            const ClockingEventUse(
              code: '18',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.paidBreak,
              description: '',
            ),
            const ClockingEventUse(
              code: '22',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.mandatoryBreak,
              description: '',
            ),
            const ClockingEventUse(
              code: '23',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.driving,
              description: '',
            ),
            const ClockingEventUse(
              code: '21',
              employeeId: 'employeeId',
              clockingEventUseType: ClockingEventUseType.waiting,
              description: '',
            ),
          ];

          final journeyEntity = JourneyEntity(
            id: 'journeyId',
            employeeId: 'employeeId',
            startDate: DateTime.now(),
          );

          when(
            () => mockGetTotalTimeSinceLastJourneyUseCase.call(),
          ).thenAnswer(
            (_) async => const Duration(hours: 5, minutes: 30),
          );
          when(
            () => mockInternalClockService.getClockDateTime(),
          ).thenReturn(
            DateTime.now(),
          );

          when(
            () => mockConfigurationRepository.findByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => configuration,
          );

          when(
            () => mockClockingEventUseRepository.findAllByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => clockingEventUseDTOs,
          );

          when(
            () => mockJourneyRepository.findCurrentJourneyByEmployeeId(
              employeeId: any(
                named: 'employeeId',
              ),
            ),
          ).thenAnswer(
            (_) async => null,
          );

          when(
            () => mockRegisterJourneyUsecase.call(
              dateTimeEvent: any(
                named: 'dateTimeEvent',
              ),
            ),
          ).thenAnswer(
            (_) async => journeyEntity,
          );

          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await Future.delayed(Duration.zero);

          bloc.add(StartJourneyEvent(force: true));
          await Future.delayed(Duration.zero);
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<NotStartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
        ],
      );

      blocTest<DriversJourneyBloc, DriversJourneyState>(
        'emits [LoadingDriversJourneyState, StartedDriversJourneyState] when LoadJourneyEvent is added and current journey exists',
        build: () {
          prepareMocks();

          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
        },
        expect: () {
          return [
            isA<LoadingDriversJourneyState>(),
            isA<StartedDriversJourneyState>(),
          ];
        },
      );
    },
  );

  group(
    'Handling Events',
    () {
      blocTest(
        'Handling doNothing',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(
            LoadJourneyEvent(),
          );
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(DoNothing());
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
        ],
      );

      blocTest(
        'Handling CallingModalToStartJourneyFromAction',
        build: () => driversJourneyBloc,
        act: (bloc) => bloc.add(StartDrivingEvent()),
        expect: () => [
          isA<CallingModalToStartJourneyFromAction>(),
        ],
      );

      blocTest(
        'Handling ConfirmClosePreviousAction',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(
            LoadJourneyEvent(),
          );
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            ConfirmClosePreviousAction([
              StopDrivingEvent(),
              StartMandatoryBreakEvent(),
            ]),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
        ],
      );

      blocTest(
        'handling new StartJourneyEvent with journey already started ',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(StartJourneyEvent());
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<StartNewDriverJourney>(),
        ],
      );

      blocTest(
        'handling CallingModalToClosePrevious',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(StartDrivingEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<RegisteringClockingEvent>(),
              ],
            ),
          );
          bloc.add(StartMandatoryBreakEvent());
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
          isA<CallingModalToClosePrevious>(),
        ],
      );

      blocTest(
        'handling EmitNewActionStartedAndPreviousDoesNot',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.onSaveCurrentEvent({
            'previous': StartDrivingEvent(), // ou qualquer outro evento válido
          });
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            EmitNewActionStartedAndPreviousDoesNot(
              newAction: StartMandatoryBreakEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<NewActionStartedAndPreviousDoesNot>(),
        ],
      );

      blocTest(
        'handling EmitPreviousActionFinishedAndNewStarted',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.onSaveCurrentEvent({
            'previous': StartDrivingEvent(), // ou qualquer outro evento válido
          });
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            EmitPreviousActionFinishedAndNewStarted(
              newAction: StartMandatoryBreakEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<PreviousActionFinishedAndNewStarted>(),
        ],
      );

      blocTest(
        'handling ConfirmStartJourneyBeforeAction',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            ConfirmStartJourneyBeforeAction(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
        ],
      );

      blocTest(
        'handling StartActionWithoutJourney',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            StartActionWithoutJourney(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
        ],
      );

      blocTest(
        'handling EmitJourneyStartedBeforeAction',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            EmitJourneyStartedBeforeAction(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<JourneyStartedBeforeAction>(),
        ],
      );

      blocTest(
        'handling EmitActionStartedWithoutJourney',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            EmitActionStartedWithoutJourney(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<ActionStartedWithoutJourney>(),
        ],
      );

      blocTest(
        'handling ConfirmCloseActionBeforeEndJourney with overnight',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            ConfirmCloseActionBeforeEndJourney(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
          isA<CallingOvernight>(),
        ],
      );

      blocTest(
        'handling FinishJourneyAndPreviousActionDoesNot with overnight',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            FinishJourneyAndPreviousActionDoesNot(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
          isA<CallingOvernight>(),
        ],
      );

      blocTest(
        'handling ConfirmCloseActionBeforeEndJourney with no overnight',
        build: () {
          prepareMocks(
            overnight: false,
          );
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            ConfirmCloseActionBeforeEndJourney(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
        ],
      );

      blocTest(
        'handling FinishJourneyAndPreviousActionDoesNot with no overnight',
        build: () {
          prepareMocks(
            overnight: false,
          );
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            FinishJourneyAndPreviousActionDoesNot(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
        ],
      );

      blocTest(
        'handling EmitPreviousActionClosedAndJourneyEnded',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            EmitPreviousActionClosedAndJourneyEnded(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<PreviousActionClosedAndJourneyEnded>(),
        ],
      );

      blocTest(
        'handling EmitJourneyFinishedAndPreviousActionDoesNot',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(
            EmitJourneyFinishedAndPreviousActionDoesNot(
              action: StartDrivingEvent(),
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<JourneyFinishedAndPreviousActionDoesNot>(),
        ],
      );

      blocTest(
        'CallingModalToCloseActionBeforeEndJourney',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(StartDrivingEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<RegisteringClockingEvent>(),
              ],
            ),
          );
          bloc.add(EndJourneyEvent());
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
          isA<CallingModalToCloseActionBeforeEndJourney>(),
        ],
      );

      blocTest(
        'CallingOvernight',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(StartDrivingEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<RegisteringClockingEvent>(),
              ],
            ),
          );
          bloc.driverEventInExecution = StartJourneyEvent();
          bloc.add(EndJourneyEvent());
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
          isA<CallingOvernight>(),
        ],
      );

      blocTest(
        'EndJourneyEvent with pendingClockingEvents empty',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(StartDrivingEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<RegisteringClockingEvent>(),
              ],
            ),
          );
          bloc.driverEventInExecution = StartJourneyEvent();
          bloc.add(
            EndJourneyEvent(
              doClose: true,
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
        ],
      );

      blocTest(
        'EndJourneyEvent with pendingClockingEvents not empty',
        build: () {
          prepareMocks();
          return driversJourneyBloc;
        },
        act: (bloc) async {
          bloc.add(LoadJourneyEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<LoadingDriversJourneyState>(),
                isA<StartedDriversJourneyState>(),
              ],
            ),
          );
          bloc.add(StartDrivingEvent());
          await expectLater(
            bloc.stream,
            emitsInOrder(
              [
                isA<RegisteringClockingEvent>(),
              ],
            ),
          );
          bloc.driverEventInExecution = StartJourneyEvent();
          bloc.pendingClockingEvents.add(StartDrivingEvent());
          bloc.add(
            EndJourneyEvent(
              doClose: true,
            ),
          );
        },
        expect: () => [
          isA<LoadingDriversJourneyState>(),
          isA<StartedDriversJourneyState>(),
          isA<RegisteringClockingEvent>(),
        ],
      );
    },
  );

  group('ClassFactory', () {
    test('should create an instance of StartJourneyEvent', () {
      final instance = ClassFactory.createInstance('StartJourneyEvent');

      expect(instance, isA<StartJourneyEvent>());
    });

    test('should create an instance of StartDrivingEvent', () {
      final instance = ClassFactory.createInstance('StartDrivingEvent');

      expect(instance, isA<StartDrivingEvent>());
    });

    test('should create an instance of StopDrivingEvent', () {
      final instance = ClassFactory.createInstance('StopDrivingEvent');

      expect(instance, isA<StopDrivingEvent>());
    });

    test('should create an instance of StartMandatoryBreakEvent', () {
      final instance = ClassFactory.createInstance('StartMandatoryBreakEvent');

      expect(instance, isA<StartMandatoryBreakEvent>());
    });

    test('should create an instance of EndMandatoryBreakEvent', () {
      final instance = ClassFactory.createInstance('EndMandatoryBreakEvent');

      expect(instance, isA<EndMandatoryBreakEvent>());
    });

    test('should create an instance of StartLunchEvent', () {
      final instance = ClassFactory.createInstance('StartLunchEvent');

      expect(instance, isA<StartLunchEvent>());
    });

    test('should create an instance of EndLunchEvent', () {
      final instance = ClassFactory.createInstance('EndLunchEvent');

      expect(instance, isA<EndLunchEvent>());
    });

    test('should create an instance of StartWaitingBreakEvent', () {
      final instance = ClassFactory.createInstance('StartWaitingBreakEvent');

      expect(instance, isA<StartWaitingBreakEvent>());
    });

    test('should create an instance of EndWaitingBreakEvent', () {
      final instance = ClassFactory.createInstance('EndWaitingBreakEvent');

      expect(instance, isA<EndWaitingBreakEvent>());
    });

    test('should throw an exception when class is not found', () {
      expect(
        () => ClassFactory.createInstance('NonExistentClass'),
        throwsException,
      );
    });
  });

  group('getClockingEventUseByCode', () {
    final clockingEventUseDTOs = [
      ClockingEventUse(
        code: '2',
        employeeId: 'employeeId',
        clockingEventUseType: ClockingEventUseType.clockingEvent,
        description: ClockingEventUseType.clockingEvent.value,
      ),
      const ClockingEventUse(
        code: '18',
        employeeId: 'employeeId',
        clockingEventUseType: ClockingEventUseType.paidBreak,
        description: '',
      ),
      const ClockingEventUse(
        code: '22',
        employeeId: 'employeeId',
        clockingEventUseType: ClockingEventUseType.mandatoryBreak,
        description: '',
      ),
      const ClockingEventUse(
        code: '23',
        employeeId: 'employeeId',
        clockingEventUseType: ClockingEventUseType.driving,
        description: '',
      ),
      const ClockingEventUse(
        code: '21',
        employeeId: 'employeeId',
        clockingEventUseType: ClockingEventUseType.waiting,
        description: '',
      ),
    ];
    ClockingEventUse? getClockingEventUseByCode(String code) {
      if (clockingEventUseDTOs.isEmpty) {
        return null;
      }
      return clockingEventUseDTOs.firstWhere(
        (element) => element.code == code,
      );
    }

    test('should return ClockingEventUseDTO when code matches', () {
      final result = getClockingEventUseByCode('2');

      expect(result, isNotNull);
      expect(result!.code, '2');
      expect(
        result.description,
        ClockingEventUseType.clockingEvent.value,
      );
    });

    test('should return null when _clockingEventUses is empty', () {
      // Arrange
      clockingEventUseDTOs.clear();

      final result = getClockingEventUseByCode('001');

      expect(result, isNull);
    });
  });

  group('calculateActualJourney', () {
    test('should return NotStartedDriversJourneyState when currentJourney is null', () async {
      final result = await driversJourneyBloc.calculateActualJourney(null);

      expect(result, isA<NotStartedDriversJourneyState>());
    });

    test('should return NotStartedDriversJourneyState when findAllByJourneyId is empty', () async {
      when(
        () => mockClockingEventRepository.findAllClockingEventByJourneyId(
          journeyId: journeyMock.id,
        ),
      ).thenAnswer((_) async => []);

      final result = await driversJourneyBloc.calculateActualJourney(journeyMock);

      expect(result, isA<NotStartedDriversJourneyState>());
    });

    test('should return StartedDriversJourneyState with correct data', () async {
      when(
        () => mockClockingEventRepository.findAllClockingEventByJourneyId(
          journeyId: journeyMock.id,
        ),
      ).thenAnswer((_) async => [clockingEventMock]);

      final result = await driversJourneyBloc.calculateActualJourney(journeyMock);

      expect(result, isA<StartedDriversJourneyState>());
      final state = result as StartedDriversJourneyState;
      expect(state.journeyStartedDateTime, journeyMock.startDate);
      final f = DateFormat('yyyy-MM-dd');
      expect(
        f.format(state.dateTimeOfLastStatusStarted),
        clockingEventMock.dateEvent,
      );
      expect(state, isA<StartedDriversJourneyState>());
    });

    test('should handle exception and return StartedDriversJourneyState with JourneyInExecution', () async {
      when(
        () => mockClockingEventRepository.findAllClockingEventByJourneyId(
          journeyId: journeyMock.id,
        ),
      ).thenAnswer((_) async => [clockingEventMock]);

      final result = await driversJourneyBloc.calculateActualJourney(journeyMock);

      expect(result, isA<StartedDriversJourneyState>());
      final state = result as StartedDriversJourneyState;
      expect(state.journeyStartedDateTime, journeyMock.startDate);
      final f = DateFormat('yyyy-MM-dd');
      expect(
        f.format(state.dateTimeOfLastStatusStarted),
        clockingEventMock.dateEvent,
      );
      expect(state.driversJourneyEvent, isA<JourneyInExecution>());
    });
  });

  group(
    'calculate total worked functions',
    () {
      test(
        'getTotalWorkedAtMoment should return Duration.zero when currentJourney is null',
        () {
          driversJourneyBloc.currentJourney = null;

          final result = driversJourneyBloc.getTotalWorkedAtMoment(DateTime(0));

          expect(result, Duration.zero);
        },
      );

      test(
        'getTotalWorkedAtMoment should return Duration.zero when whenWorkStarted is null',
        () {
          driversJourneyBloc.currentJourney = MockJourneyEntity();
          driversJourneyBloc.whenWorkStarted = null;

          final result = driversJourneyBloc.getTotalWorkedAtMoment(DateTime(0));

          expect(result, Duration.zero);
        },
      );

      test(
        'getTotalWorkedAtMoment should return totalWorked when driverEventInExecution is StartLunchEvent',
        () {
          driversJourneyBloc.currentJourney = MockJourneyEntity();
          driversJourneyBloc.whenWorkStarted = DateTime(2000, 1, 1, 8);
          driversJourneyBloc.driverEventInExecution = StartLunchEvent();
          driversJourneyBloc.totalWorked = const Duration(hours: 1);

          final result = driversJourneyBloc.getTotalWorkedAtMoment(
            DateTime(2000, 1, 1, 10),
          );

          expect(result, const Duration(hours: 1));
        },
      );

      test(
        'getTotalWorkedAtMoment should return totalWorked when driverEventInExecution is StartMandatoryBreakEvent',
        () {
          driversJourneyBloc.currentJourney = MockJourneyEntity();
          driversJourneyBloc.whenWorkStarted = DateTime(2000, 1, 1, 8);
          driversJourneyBloc.driverEventInExecution = StartMandatoryBreakEvent();
          driversJourneyBloc.totalWorked = const Duration(hours: 1);

          final result = driversJourneyBloc.getTotalWorkedAtMoment(
            DateTime(2000, 1, 1, 10),
          );

          expect(result, const Duration(hours: 1));
        },
      );

      test(
        'getTotalWorkedAtMoment should return differences between whenWorkStarted and moment',
        () {
          driversJourneyBloc.currentJourney = MockJourneyEntity();
          driversJourneyBloc.whenWorkStarted = DateTime(2000, 1, 1, 8);
          driversJourneyBloc.differenceBetweenWhenWorkStartedAndWhenJourneyStarted = Duration.zero;
          driversJourneyBloc.totalMealBreakDuration = const Duration(minutes: 30);
          driversJourneyBloc.totalMandatoryBreakDuration = const Duration(
            minutes: 30,
          );

          final result = driversJourneyBloc.getTotalWorkedAtMoment(
            DateTime(2000, 1, 1, 10),
          );

          expect(result, const Duration(hours: 1));
        },
      );
    },
  );

  group(
    'calculateTotalWorked',
    () {
      test(
        'should return 0 when journey is null',
        () async {
          driversJourneyBloc.currentJourney = null;

          await driversJourneyBloc.calculateTotalWorked();

          final result = driversJourneyBloc.getTotalWorkedAtMoment(
            DateTime(0),
          );

          expect(result, Duration.zero);
        },
      );

      test(
        'should return 0 when clockingEvents is empty',
        () async {
          when(
            () => mockClockingEventRepository.findAllClockingEventByJourneyId(
              journeyId: any(named: 'journeyId'),
            ),
          ).thenAnswer(
            (_) async => [],
          );

          driversJourneyBloc.currentJourney = MockJourneyEntity();

          await driversJourneyBloc.calculateTotalWorked();

          final result = driversJourneyBloc.getTotalWorkedAtMoment(
            DateTime(0),
          );

          expect(result, Duration.zero);
        },
      );

      test(
        'should return 8 hours and 30 minutes',
        () async {
          when(
            () => mockClockingEventRepository.findAllClockingEventByJourneyId(
              journeyId: any(named: 'journeyId'),
            ),
          ).thenAnswer(
            (_) async => [
              /// Início da jornada
              MockClockingEvent(),

              /// Início da direção
              MockClockingEvent(
                dateTimeEvent: DateTime(2000, 1, 1, 10),
              ),

              /// Fim da direção
              MockClockingEvent(
                dateTimeEvent: DateTime(2000, 1, 1, 12),
              ),

              /// Início do almoço
              MockClockingEvent(
                dateTimeEvent: DateTime(2000, 1, 1, 12),
                isMealBreak: true,
              ),

              /// Fim do almoço
              MockClockingEvent(
                dateTimeEvent: DateTime(2000, 1, 1, 13, 30),
                isMealBreak: true,
              ),
            ],
          );

          driversJourneyBloc.currentJourney = MockJourneyEntity();

          await driversJourneyBloc.calculateTotalWorked();

          final result = driversJourneyBloc.getTotalWorkedAtMoment(
            DateTime(2000, 1, 1, 18),
          );

          expect(
            result,
            const Duration(hours: 8, minutes: 30),
          );
        },
      );
    },
  );
}
