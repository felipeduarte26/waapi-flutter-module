import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/network_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/synchronization_result.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/clocking_event_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/logs_repository_db_impl.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/clocking_event_dto_mock.dart';
import '../../../../mocks/clocking_event_mock.dart';
import '../../../../mocks/employee_entity_mock.dart';

class MockPlatformService extends Mock implements IPlatformService {}

class SessionServiceMock extends Mock implements ISessionService {}

class MockEnvironmentService extends Mock implements IEnvironmentService {}

class MockClockingEventRepository extends Mock
    implements IClockingEventRepository {}

class MockImportService extends Mock implements clock.IImportService {}

class MockUploadPhotosService extends Mock implements IUploadPhotosService {}

class MockInternalClockService extends Mock
    implements clock.IInternalClockService {}

class MockUtils extends Mock implements IUtils {}

class MockEmployeeRepository extends Mock implements IEmployeeRepository {}

class MockLogService extends Mock implements LogService {}

class MockClockingEventMapper extends Mock implements ClockingEventMapper {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockClockingEventRepositoryDbImpl extends Mock
    implements LogsRepositoryDbImpl {}

class FakeImportClockingEventDto extends Fake
    implements clock.ImportClockingEventDto {}

void main() {
  late IPlatformService platformService;
  late ISessionService sessionService;
  late IEnvironmentService environmentService;
  late IClockingEventRepository clockingEventRepository;
  late IUploadPhotosService uploadPhotosService;
  late clock.IImportService importService;
  late clock.IInternalClockService internalClockService;
  late IUtils utils;
  late IEmployeeRepository employeeRepository;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late LogService logService;
  late LogsRepositoryDbImpl logsRepositoryDbImpl;
  late ClockingEventMapper clockingEventMapper;

  setUp(() {
    platformService = MockPlatformService();
    sessionService = SessionServiceMock();
    environmentService = MockEnvironmentService();
    clockingEventRepository = MockClockingEventRepository();
    uploadPhotosService = MockUploadPhotosService();
    importService = MockImportService();
    internalClockService = MockInternalClockService();
    utils = MockUtils();
    employeeRepository = MockEmployeeRepository();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    logService = MockLogService();
    logsRepositoryDbImpl = MockClockingEventRepositoryDbImpl();
    clockingEventMapper = MockClockingEventMapper();

    when(
      () => sessionService.hasEmployee(),
    ).thenReturn(true);

    when(
      () => environmentService.environment(),
    ).thenReturn(EnvironmentEnum.dev);

    when(
      () => platformService.hasConnectivity(),
    ).thenAnswer((_) async => true);

    // Configuração do MockClockingEventMapper
    when(
      () => clockingEventMapper.fromEntityToDtoCollectorList(any()),
    ).thenAnswer(
      (_) async => [clockingEventDtoMock], // Retorna uma lista válida
    );
  });

  group('Single Operation Mode', () {
    test(
      'SynchronizeClockingEventService no connection Test',
      () async {
        when(
          () => platformService.connectivityStatus(),
        ).thenAnswer(
          (invocation) => Future.value(NetworkStatusEnum.inactive),
        );

        when(
          () => getExecutionModeUsecase(),
        ).thenAnswer(
          (invocation) => Future.value(ExecutionModeEnum.individual),
        );

        SynchronizeClockingEventService service =
            SynchronizeClockingEventService(
          clockingEventRepository,
          environmentService,
          importService,
          platformService,
          sessionService,
          utils,
          internalClockService,
          uploadPhotosService,
          employeeRepository,
          getExecutionModeUsecase,
          logService,
          logsRepositoryDbImpl,
          clockingEventMapper,
        );

        expect(service.synchronizationIsRunning, false);
        await service.startSynchronize();
        expect(service.synchronizationIsRunning, false);

        verify(() => platformService.connectivityStatus());
        verify(() => platformService.hasConnectivity());
        verifyNoMoreInteractions(platformService);
      },
    );

    test(
      'SynchronizeClockingEventService succes Test',
      () async {
        DateTime dateTime = DateTime.now();
        String employeeId = '05678575-9c60-4265-87b1-f616092380d8';

        List<String> clockingEventsImportedId = [
          '4a52d593-d16f-4444-974b-34883dc5e0d9',
        ];

        clock.ClockingEventsImportedDto clockingEventsImportedDto =
            clock.ClockingEventsImportedDto(
          clockingEventsImported: clockingEventsImportedId,
          importErros: [],
        );

        clock.ClockingEventResponse response = clock.ClockingEventResponse(
          importResult: clockingEventsImportedDto,
        );

        Directory photoDirectory = Directory('directory');

        when(
          () => getExecutionModeUsecase(),
        ).thenAnswer(
          (invocation) => Future.value(ExecutionModeEnum.individual),
        );

        when(
          () => platformService.connectivityStatus(),
        ).thenAnswer(
          (invocation) => Future.value(NetworkStatusEnum.active),
        );

        when(
          () => environmentService.syncBatchSize(),
        ).thenReturn(10);

        when(
          () => sessionService.getEmployeeId(),
        ).thenReturn(
          employeeId,
        );

        when(
          () => clockingEventRepository.findAllUnsyncedByEmployeeId(
            employeeId: any(named: 'employeeId'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer(
          (invocation) => Future.value([clockingEventMock]),
        );

        when(
          () => importService.importClockingEvent(
            clockingEvents: any(named: 'clockingEvents'),
            clockingEventEnvironmentEnum:
                clock.ClockingEventEnvironmentEnum.dev,
          ),
        ).thenAnswer(
          (invocation) => Future.value(response),
        );

        when(
          () => clockingEventRepository.confirmSynchronization(
            clockingEventsImportedId: clockingEventsImportedId,
          ),
        ).thenAnswer(
          (invocation) => Future.value(),
        );

        when(
          () => utils.getPhotoDirectory(employeeId: any(named: 'employeeId')),
        ).thenAnswer(
          (invocation) => Future.value(photoDirectory),
        );

        when(
          () => uploadPhotosService.sendFromDirectory(
            directory: photoDirectory,
            employeeId: employeeId,
            operationMode: clock.OperationModeEnum.single,
          ),
        ).thenAnswer(
          (invocation) => Future.value(),
        );

        when(
          () => internalClockService.getClockDateTime(),
        ).thenReturn(dateTime);

        when(
          () => clockingEventRepository.deleteRecordsOlderThen60Days(
            referenceDate: dateTime,
          ),
        ).thenAnswer(
          (invocation) => Future.value(0),
        );

        when(
          () => environmentService.environment(),
        ).thenReturn(
          EnvironmentEnum.test,
        );

        when(() => logsRepositoryDbImpl.deleteLogsOlderThen30Days(
                referenceDate: any(named: 'referenceDate'),),)
            .thenAnswer((invocation) => Future.value(0));

        when(
          () => employeeRepository.getAll(),
        ).thenAnswer((invocation) => Future.value([employeeEntityMock]));

        when(
          () => employeeRepository.findById(id: any(named: 'id')),
        ).thenAnswer((invocation) => Future.value(employeeEntityMock));

        SynchronizeClockingEventService service =
            SynchronizeClockingEventService(
          clockingEventRepository,
          environmentService,
          importService,
          platformService,
          sessionService,
          utils,
          internalClockService,
          uploadPhotosService,
          employeeRepository,
          getExecutionModeUsecase,
          logService,
          logsRepositoryDbImpl,
          clockingEventMapper,
        );

        await service.startSynchronize();

        expect(service.synchronizationIsRunning, false);

        verify(
          () => platformService.connectivityStatus(),
        ).called(1);

        verify(
          () => environmentService.syncBatchSize(),
        ).called(1);

        verify(
          () => sessionService.getEmployeeId(),
        ).called(1);

        verify(
          () => sessionService.hasEmployee(),
        ).called(1);

        verify(
          () => clockingEventRepository.findAllUnsyncedByEmployeeId(
            employeeId: any(named: 'employeeId'),
            limit: any(named: 'limit'),
          ),
        ).called(2);

        verify(
          () => importService.importClockingEvent(
            clockingEvents: any(named: 'clockingEvents'),
            clockingEventEnvironmentEnum:
                clock.ClockingEventEnvironmentEnum.dev,
          ),
        ).called(1);

        verify(
          () => clockingEventRepository.confirmSynchronization(
            clockingEventsImportedId: clockingEventsImportedId,
          ),
        ).called(1);

        verify(
          () => utils.getPhotoDirectory(employeeId: any(named: 'employeeId')),
        ).called(1);

        verify(
          () => uploadPhotosService.sendFromDirectory(
            directory: photoDirectory,
            employeeId: employeeId,
            operationMode: clock.OperationModeEnum.single,
          ),
        ).called(1);

        verify(
          () => internalClockService.getClockDateTime(),
        ).called(1);

        verify(
          () => clockingEventRepository.deleteRecordsOlderThen60Days(
            referenceDate: dateTime,
          ),
        ).called(1);

        verify(
          () => environmentService.environment(),
        ).called(2);

        verify(() => logsRepositoryDbImpl.deleteLogsOlderThen30Days(
            referenceDate: any(named: 'referenceDate'),),).called(1);

        verify(() => platformService.hasConnectivity());

        verifyNoMoreInteractions(platformService);
        verifyNoMoreInteractions(sessionService);
        verifyNoMoreInteractions(environmentService);
        verifyNoMoreInteractions(clockingEventRepository);
        verifyNoMoreInteractions(importService);
        verifyNoMoreInteractions(internalClockService);
        verifyNoMoreInteractions(uploadPhotosService);
        verifyNoMoreInteractions(utils);
      },
    );

    test(
      'failure on synchronization due unavailable internet connection',
      () async {
        String employeeId = '05678575-9c60-4265-87b1-f616092380d8';

        when(
          () => getExecutionModeUsecase(),
        ).thenAnswer(
          (invocation) => Future.value(ExecutionModeEnum.individual),
        );

        when(
          () => platformService.connectivityStatus(),
        ).thenAnswer(
          (invocation) => Future.value(NetworkStatusEnum.active),
        );

        when(
          () => environmentService.syncBatchSize(),
        ).thenReturn(10);

        when(
          () => sessionService.getEmployeeId(),
        ).thenReturn(
          employeeId,
        );

        when(
          () => clockingEventRepository.findAllUnsyncedByEmployeeId(
            employeeId: any(named: 'employeeId'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer(
          (invocation) => Future.value([clockingEventMock]),
        );

        when(
          () => importService.importClockingEvent(
            clockingEvents: any(named: 'clockingEvents'),
            clockingEventEnvironmentEnum:
                clock.ClockingEventEnvironmentEnum.dev,
          ),
        ).thenThrow(Exception('generic failure'));

        when(
          () => employeeRepository.findById(id: any(named: 'id')),
        ).thenAnswer((invocation) => Future.value(employeeEntityMock));

        SynchronizeClockingEventService service =
            SynchronizeClockingEventService(
          clockingEventRepository,
          environmentService,
          importService,
          platformService,
          sessionService,
          utils,
          internalClockService,
          uploadPhotosService,
          employeeRepository,
          getExecutionModeUsecase,
          logService,
          logsRepositoryDbImpl,
          clockingEventMapper,
        );

        SynchronizationResult synchronizationResult =
            await service.startSynchronize();

        expect(synchronizationResult.status, SynchronizationStatus.warning);
        expect(
          synchronizationResult.message,
          SynchronizationMessage.syncClockingEventSyncFailure,
        );
      },
    );
  });

  group('Multiple Operation Mode', () {
    test(
      'SynchronizeClockingEventService no connection Test',
      () async {
        when(
          () => platformService.connectivityStatus(),
        ).thenAnswer(
          (invocation) => Future.value(NetworkStatusEnum.inactive),
        );

        when(
          () => getExecutionModeUsecase(),
        ).thenAnswer(
          (invocation) => Future.value(ExecutionModeEnum.multiple),
        );

        SynchronizeClockingEventService service =
            SynchronizeClockingEventService(
          clockingEventRepository,
          environmentService,
          importService,
          platformService,
          sessionService,
          utils,
          internalClockService,
          uploadPhotosService,
          employeeRepository,
          getExecutionModeUsecase,
          logService,
          logsRepositoryDbImpl,
          clockingEventMapper,
        );

        expect(service.synchronizationIsRunning, false);
        await service.startSynchronize();
        expect(service.synchronizationIsRunning, false);

        verify(() => platformService.connectivityStatus());
        verify(() => platformService.hasConnectivity());
        verifyNoMoreInteractions(platformService);
      },
    );

    test(
  'SynchronizeClockingEventService succes Test',
  () async {
    DateTime dateTime = DateTime.now();
    String employeeId = '05678575-9c60-4265-87b1-f616092380d8';

    List<String> clockingEventsImportedId = [
      '4a52d593-d16f-4444-974b-34883dc5e0d9',
    ];

    clock.ClockingEventsImportedDto clockingEventsImportedDto =
        clock.ClockingEventsImportedDto(
      clockingEventsImported: clockingEventsImportedId,
      importErros: [],
    );

    clock.ClockingEventResponse response = clock.ClockingEventResponse(
      importResult: clockingEventsImportedDto,
    );

    Directory photoDirectory = Directory('directory');

    when(
      () => getExecutionModeUsecase(),
    ).thenAnswer(
      (invocation) => Future.value(ExecutionModeEnum.individual),
    );

    when(
      () => platformService.connectivityStatus(),
    ).thenAnswer(
      (invocation) => Future.value(NetworkStatusEnum.active),
    );

    when(
      () => environmentService.syncBatchSize(),
    ).thenReturn(10);

    when(
      () => sessionService.getEmployeeId(),
    ).thenReturn(
      employeeId,
    );

    when(
      () => clockingEventRepository.findAllUnsyncedByEmployeeId(
        employeeId: any(named: 'employeeId'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer(
      (invocation) => Future.value([clockingEventMock]),
    );

    when(
      () => clockingEventMapper.fromEntityToDtoCollectorList(any()),
    ).thenAnswer(
      (_) async => [clockingEventDtoMock],
    );

    when(
      () => importService.importClockingEvent(
        clockingEvents: any(named: 'clockingEvents'),
        clockingEventEnvironmentEnum:
            clock.ClockingEventEnvironmentEnum.dev,
      ),
    ).thenAnswer(
      (invocation) => Future.value(response),
    );

    when(
      () => clockingEventRepository.confirmSynchronization(
        clockingEventsImportedId: clockingEventsImportedId,
      ),
    ).thenAnswer(
      (invocation) => Future.value(),
    );

    when(
      () => utils.getPhotoDirectory(employeeId: any(named: 'employeeId')),
    ).thenAnswer(
      (invocation) => Future.value(photoDirectory),
    );

    when(
      () => uploadPhotosService.sendFromDirectory(
        directory: photoDirectory,
        employeeId: employeeId,
        operationMode: clock.OperationModeEnum.single,
      ),
    ).thenAnswer(
      (invocation) => Future.value(),
    );

    when(
      () => internalClockService.getClockDateTime(),
    ).thenReturn(dateTime);

    when(
      () => clockingEventRepository.deleteRecordsOlderThen60Days(
        referenceDate: dateTime,
      ),
    ).thenAnswer(
      (invocation) => Future.value(0),
    );

    when(
      () => environmentService.environment(),
    ).thenReturn(
      EnvironmentEnum.test,
    );

    when(() => logsRepositoryDbImpl.deleteLogsOlderThen30Days(
            referenceDate: any(named: 'referenceDate'),),)
        .thenAnswer((invocation) => Future.value(0));

    when(
      () => employeeRepository.getAll(),
    ).thenAnswer((invocation) => Future.value([employeeEntityMock]));

    when(
      () => employeeRepository.findById(id: any(named: 'id')),
    ).thenAnswer((invocation) => Future.value(employeeEntityMock));

    SynchronizeClockingEventService service =
        SynchronizeClockingEventService(
      clockingEventRepository,
      environmentService,
      importService,
      platformService,
      sessionService,
      utils,
      internalClockService,
      uploadPhotosService,
      employeeRepository,
      getExecutionModeUsecase,
      logService,
      logsRepositoryDbImpl,
      clockingEventMapper,
    );

    await service.startSynchronize();

    expect(service.synchronizationIsRunning, false);

    verify(
      () => platformService.connectivityStatus(),
    ).called(1);

    verify(
      () => environmentService.syncBatchSize(),
    ).called(1);

    verify(
      () => sessionService.getEmployeeId(),
    ).called(1);

    verify(
      () => sessionService.hasEmployee(),
    ).called(1);

    verify(
      () => clockingEventRepository.findAllUnsyncedByEmployeeId(
        employeeId: any(named: 'employeeId'),
        limit: any(named: 'limit'),
      ),
    ).called(2);

    verify(
      () => importService.importClockingEvent(
        clockingEvents: any(named: 'clockingEvents'),
        clockingEventEnvironmentEnum:
            clock.ClockingEventEnvironmentEnum.dev,
      ),
    ).called(1);

    verify(
      () => clockingEventRepository.confirmSynchronization(
        clockingEventsImportedId: clockingEventsImportedId,
      ),
    ).called(1);

    verify(
      () => utils.getPhotoDirectory(employeeId: any(named: 'employeeId')),
    ).called(1);

    verify(
      () => uploadPhotosService.sendFromDirectory(
        directory: photoDirectory,
        employeeId: employeeId,
        operationMode: clock.OperationModeEnum.single,
      ),
    ).called(1);

    verify(
      () => internalClockService.getClockDateTime(),
    ).called(1);

    verify(
      () => clockingEventRepository.deleteRecordsOlderThen60Days(
        referenceDate: dateTime,
      ),
    ).called(1);

    verify(
      () => environmentService.environment(),
    ).called(2);

    verify(() => logsRepositoryDbImpl.deleteLogsOlderThen30Days(
        referenceDate: any(named: 'referenceDate'),),).called(1);

    verify(() => platformService.hasConnectivity());

    verifyNoMoreInteractions(platformService);
    verifyNoMoreInteractions(sessionService);
    verifyNoMoreInteractions(environmentService);
    verifyNoMoreInteractions(clockingEventRepository);
    verifyNoMoreInteractions(importService);
    verifyNoMoreInteractions(internalClockService);
    verifyNoMoreInteractions(uploadPhotosService);
    verifyNoMoreInteractions(utils);
  },
);

    test(
      'failure on synchronization due unavailable internet connection',
      () async {
        // DateTime dateTime = DateTime.now();
        String employeeId = '05678575-9c60-4265-87b1-f616092380d8';

        when(
          () => getExecutionModeUsecase(),
        ).thenAnswer(
          (invocation) => Future.value(ExecutionModeEnum.multiple),
        );

        when(
          () => platformService.connectivityStatus(),
        ).thenAnswer(
          (invocation) => Future.value(NetworkStatusEnum.active),
        );

        when(
          () => environmentService.syncBatchSize(),
        ).thenReturn(10);

        when(
          () => sessionService.getEmployeeId(),
        ).thenReturn(
          employeeId,
        );

        when(
          () => clockingEventRepository.findAllUnsynced(
            limit: any(named: 'limit'),
          ),
        ).thenAnswer(
          (invocation) => Future.value([clockingEventMock]),
        );

        when(
          () => importService.importClockingEvent(
            clockingEvents: any(named: 'clockingEvents'),
            clockingEventEnvironmentEnum:
                clock.ClockingEventEnvironmentEnum.dev,
          ),
        ).thenThrow(Exception('generic failure'));

        when(
          () => employeeRepository.findById(id: any(named: 'id')),
        ).thenAnswer((invocation) => Future.value(employeeEntityMock));

        SynchronizeClockingEventService service =
            SynchronizeClockingEventService(
          clockingEventRepository,
          environmentService,
          importService,
          platformService,
          sessionService,
          utils,
          internalClockService,
          uploadPhotosService,
          employeeRepository,
          getExecutionModeUsecase,
          logService,
          logsRepositoryDbImpl,
          clockingEventMapper,
        );

        SynchronizationResult synchronizationResult =
            await service.startSynchronize();

        expect(synchronizationResult.status, SynchronizationStatus.warning);
        expect(
          synchronizationResult.message,
          SynchronizationMessage.syncClockingEventSyncFailure,
        );
      },
    );

    test('no internet connection test', () async {
      when(
        () => platformService.hasConnectivity(),
      ).thenAnswer((_) async => false);

      SynchronizeClockingEventService service = SynchronizeClockingEventService(
        clockingEventRepository,
        environmentService,
        importService,
        platformService,
        sessionService,
        utils,
        internalClockService,
        uploadPhotosService,
        employeeRepository,
        getExecutionModeUsecase,
        logService,
        logsRepositoryDbImpl,
        clockingEventMapper,
      );

      SynchronizationResult synchronizationResult =
          await service.startSynchronize();

      expect(
        synchronizationResult.message,
        SynchronizationMessage.syncClockingEventSyncInternetUnavailable,
      );
      expect(synchronizationResult.status, SynchronizationStatus.error);

      verify(() => platformService.hasConnectivity());
    });
  });
}
