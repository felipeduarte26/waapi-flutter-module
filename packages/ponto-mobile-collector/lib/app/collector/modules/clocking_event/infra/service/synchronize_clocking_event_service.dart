import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:synchronized/synchronized.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/enums/network_status.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/domain/input_model/employee_dto.dart';
import '../../../../core/domain/input_model/synchronization_result.dart';
import '../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../core/external/mappers/clocking_event_mapper.dart';
import '../../../../core/external/mappers/employee_mapper.dart';
import '../../../../core/infra/repositories/database/logs_repository_db_impl.dart';
import '../../../../core/infra/utils/enum/execution_mode_enum.dart';
import '../../../../core/infra/utils/enum/synchronization_enum.dart';

class SynchronizeClockingEventService
    implements ISynchronizeClockingEventService {
  final clock.IImportService _importService;
  final IPlatformService _platformService;
  final IEnvironmentService _environmentService;
  final IClockingEventRepository _clockingEventRepository;
  final ISessionService _sessionService;
  final IUtils _utils;
  final clock.IInternalClockService _internalClockService;
  final IUploadPhotosService _uploadPhotosService;
  final IEmployeeRepository _employeeRepository;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final LogService _logService;
  final LogsRepositoryDbImpl _logsRepositoryDbImpl;
  final ClockingEventMapper _clockingEventMapper;

  SynchronizeClockingEventService(
    this._clockingEventRepository,
    this._environmentService,
    this._importService,
    this._platformService,
    this._sessionService,
    this._utils,
    this._internalClockService,
    this._uploadPhotosService,
    this._employeeRepository,
    this._getExecutionModeUsecase,
    this._logService,
    this._logsRepositoryDbImpl,
    this._clockingEventMapper,
  ) {
    controller = StreamController<SynchronizationResult>.broadcast();
    stream = controller.stream;
  }

  bool _synchronizationIsRunning = false;

  static late StreamController<SynchronizationResult> controller;

  static late Stream<SynchronizationResult> stream;

  @override
  bool get synchronizationIsRunning => _synchronizationIsRunning;

  Future<clock.ClockingEventsImportedDto> _sendToServer({
    required List<clock.ImportClockingEventRestDto> clockingEvents,
  }) async {
    _logService.saveLocalLog(exception: 'ClockingEventResponse', stackTrace: 'clockingEventImport requested', dateTimeOnDevice: DateTime.now());

    clock.ClockingEventResponse response =
        await _importService.importClockingEvent(
      clockingEvents: clockingEvents,
      clockingEventEnvironmentEnum:
          EnvironmentEnum.mapToClock(_environmentService.environment()),
    );

    return response.importResult;
  }

  Future<SynchronizationResult> _synchronizeSingle() async {
    log('Synchronizing in Individual Operation Mode');

    if (!_sessionService.hasEmployee()) {
      return _createSynchronizationResult(
        SynchronizationStatus.success,
        SynchronizationMessage.syncClockingEventSyncSuccess,
      );
    }

    /// Confirm you have an internet connection
    if ((await _platformService.connectivityStatus()) !=
        NetworkStatusEnum.active) {
      return _createSynchronizationResult(
        SynchronizationStatus.error,
        SynchronizationMessage.syncClockingEventSyncInternetUnavailable,
      );
    }

    int syncBatchSize = _environmentService.syncBatchSize();

    /// Get the first 50 non-synchronized records from the database
    var employeeId = _sessionService.getEmployeeId();

    List<clock.ImportClockingEventRestDto> clockingEvents =
        await _findAllUnsyncedByEmployeeId(syncBatchSize, employeeId);

    while (clockingEvents.isNotEmpty) {
      clock.ClockingEventsImportedDto? clockingEventsImportedDto;

      try {
        // Send records to server
        clockingEventsImportedDto =
            await _sendToServer(clockingEvents: clockingEvents);
      } catch (e) {
        return _createSynchronizationResult(
          SynchronizationStatus.warning,
          SynchronizationMessage.syncClockingEventSyncFailure,
        );
      }

      /// Confirm synchronization by updating the base
      if (clockingEventsImportedDto.clockingEventsImported != null &&
          clockingEventsImportedDto.clockingEventsImported!.isNotEmpty) {
        await _clockingEventRepository.confirmSynchronization(
          clockingEventsImportedId:
              clockingEventsImportedDto.clockingEventsImported!,
        );
      } else {
        _logService.saveLocalLog(exception: 'ClockingEventsImportedDto', stackTrace: 'ClockingEventsImportedDto is null or empty', dateTimeOnDevice: DateTime.now());
      }

      /// Get current user's photo directory
      Directory photoDirectory = await _utils.getPhotoDirectory(
        employeeId: employeeId,
      );

      /// Send all photos for this user to AWS S3
      await _uploadPhotosService.sendFromDirectory(
        directory: photoDirectory,
        employeeId: employeeId,
        operationMode: clock.OperationModeEnum.single,
      );

      /// Removes synced records older than 60 days
      await _clockingEventRepository.deleteRecordsOlderThen60Days(
        referenceDate: _internalClockService.getClockDateTime(),
      );

      /// Checks the base for more non-Soncrinized records
      clockingEvents =
          await _findAllUnsyncedByEmployeeId(syncBatchSize, employeeId);

      if (_environmentService.environment().name == EnvironmentEnum.test.name) {
        clockingEvents = [];
      }

      await _logsRepositoryDbImpl.deleteLogsOlderThen30Days(
        referenceDate: DateTime.now(),
      );
    }

    return _createSynchronizationResult(
      SynchronizationStatus.success,
      SynchronizationMessage.syncClockingEventSyncSuccess,
    );
  }

  Future<SynchronizationResult> _synchronizeMulti() async {
    log('Synchronizing in Multiple Operation Mode');

    /// Confirm you have an internet connection
    if ((await _platformService.connectivityStatus()) !=
        NetworkStatusEnum.active) {
      return _createSynchronizationResult(
        SynchronizationStatus.error,
        SynchronizationMessage.syncClockingEventSyncInternetUnavailable,
      );
    }

    //tamanho do lote por requisição
    int syncBatchSize = _environmentService.syncBatchSize();

    /// Get the first 50 non-synchronized records from the database
    List<clock.ImportClockingEventRestDto> clockingEvents =
        await findAllUnsynced(syncBatchSize);

    while (clockingEvents.isNotEmpty) {
      clock.ClockingEventsImportedDto? clockingEventsImportedDto;

      try {
        // Send records to server
        clockingEventsImportedDto =
            await _sendToServer(clockingEvents: clockingEvents);
      } catch (e) {
        return _createSynchronizationResult(
          SynchronizationStatus.warning,
          SynchronizationMessage.syncClockingEventSyncFailure,
        );
      }

      /// Confirm synchronization by updating the base
      if (clockingEventsImportedDto.clockingEventsImported != null &&
          clockingEventsImportedDto.clockingEventsImported!.isNotEmpty) {
        await _clockingEventRepository.confirmSynchronization(
          clockingEventsImportedId:
              clockingEventsImportedDto.clockingEventsImported!,
        );
      }

      List<clock.ImportClockingEventRestDto> listClockingEventsImported = clockingEvents
          .where((clockingEvent) => clockingEventsImportedDto?.clockingEventsImported?.contains(clockingEvent.appointmentId) ?? false)
          .toList();

      for (var clockingEventImported in listClockingEventsImported) {
        /// Get current user's photo directory
        Directory photoDirectory = await _utils.getPhotoDirectory(
          employeeId: clockingEventImported.employee.id,
        );

        /// Send all photos for this user to AWS S3
        await _uploadPhotosService.sendFromDirectory(
          directory: photoDirectory,
          employeeId: clockingEventImported.employee.id,
          operationMode: clock.OperationModeEnum.multi,
        );
      }

      /// Removes synced records older than 60 days
      await _clockingEventRepository.deleteRecordsOlderThen60Days(
        referenceDate: _internalClockService.getClockDateTime(),
      );

      /// Get the first 50 non-synchronized records from the database
      clockingEvents = await findAllUnsynced(syncBatchSize);

      if (_environmentService.environment().name == EnvironmentEnum.test.name) {
        clockingEvents = [];
      }

      await _logsRepositoryDbImpl.deleteLogsOlderThen30Days(
        referenceDate: DateTime.now(),
      );
    }

    return _createSynchronizationResult(
      SynchronizationStatus.success,
      SynchronizationMessage.syncClockingEventSyncSuccess,
    );
  }

  Future<List<clock.ImportClockingEventRestDto>> _findAllUnsyncedByEmployeeId(
    int syncBatchSize,
    String employeeId,
  ) async {
    List<clock.ImportClockingEventDto> clockingEventsDtoClock = [];
    List<ClockingEvent> entityList =
        await _clockingEventRepository.findAllUnsyncedByEmployeeId(
      limit: syncBatchSize,
      employeeId: employeeId,
    );

    List<ClockingEventDto> clockingEventListCollector = await _clockingEventMapper.fromEntityToDtoCollectorList(entityList);

    clockingEventsDtoClock = ClockingEventMapper.fromCollectorDtoToClockList(clockingEventListCollector);

    if (clockingEventsDtoClock.isNotEmpty) {
      Employee? entity = await _employeeRepository.findById(
        id: employeeId,
      );

      EmployeeDto? employeeDtoCollector =
          EmployeeMapper.fromEntityToDtoCollector(entity!);
          

      for (clock.ImportClockingEventDto clockEvent in clockingEventsDtoClock) {
        clockEvent.employeeDto =
            EmployeeMapper.fromCollectorDtoToClock(employeeDtoCollector);

        clockEvent.companyDto = clockEvent.employeeDto!.company;
      }
    }

    List<clock.ImportClockingEventRestDto> clockingEventsRestDto =
        clockingEventsDtoClock
            .map(
              clock.ImportClockingEventRestDtoConverter
                  .convertToImportClockingEventRestDto,
            )
            .toList();

    return clockingEventsRestDto;
  }

  Future<List<clock.ImportClockingEventRestDto>> findAllUnsynced(
    int syncBatchSize,
  ) async {
    List<clock.ImportClockingEventDto> clockingEventsDtoClock = [];
        List<ClockingEvent> entityList =
        await _clockingEventRepository.findAllUnsynced(
      limit: syncBatchSize,
    );

    clockingEventsDtoClock = ClockingEventMapper.fromCollectorEntityToClock(entityList);

    for (clock.ImportClockingEventDto clockEvent in clockingEventsDtoClock) {
      Employee? entity = await _employeeRepository.findById(
        id: clockEvent.employeeId,
      );
      EmployeeDto? employeeDtoCollector = EmployeeMapper.fromEntityToDtoCollector(entity!);

      clockEvent.employeeDto =
          EmployeeMapper.fromCollectorDtoToClock(employeeDtoCollector);

      clockEvent.companyDto = clockEvent.employeeDto!.company;
    }

    List<clock.ImportClockingEventRestDto> clockingEventsRestDto =
        clockingEventsDtoClock
            .map(
              clock.ImportClockingEventRestDtoConverter
                  .convertToImportClockingEventRestDto,
            )
            .toList();

    return clockingEventsRestDto;
  }

  Future<SynchronizationResult> _createSynchronizationResult(
    SynchronizationStatus status,
    SynchronizationMessage message,
  ) {
    var synchronizationResult = SynchronizationResult(
      status,
      message,
    );

    controller.sink.add(synchronizationResult);
    _synchronizationIsRunning = false;
    log(synchronizationResult.message.message);
    return Future.value(synchronizationResult);
  }

  @override
  Future<SynchronizationResult> startSynchronize() async {
    bool isOffline = !(await _platformService.hasConnectivity());
    if (isOffline) {
      return SynchronizationResult(
        SynchronizationStatus.error,
        SynchronizationMessage.syncClockingEventSyncInternetUnavailable,
      );
    }

    ExecutionModeEnum executionModeEnum = await _getExecutionModeUsecase();
    log(executionModeEnum.toString());

    final completer = Completer<SynchronizationResult>();
    StreamSubscription<SynchronizationResult>? subscription;
    subscription = stream.listen(
      (SynchronizationResult synchronizationResult) {
        completer.complete(synchronizationResult);

        if (subscription != null) {
          subscription.cancel();
        }
      },
      onError: (error) {
        _logService.saveLocalLog(exception: 'StreamSubscriptionSynchronizationResult', stackTrace: '$error', dateTimeOnDevice: DateTime.now());
        log(error);
      },
      cancelOnError: true,
    );

    // this object prevent concurrent access to data
    var lock = Lock();

    // Only this block can run (once) until done
    await lock.synchronized(() async {
      if (_synchronizationIsRunning) {
        log('synchronization is already running');
      } else {
        _synchronizationIsRunning = true;

        if (executionModeEnum.isIndividualOrDriver()) {
          return _synchronizeSingle();
        } else {
          return _synchronizeMulti();
        }
      }
    });

    return completer.future;
  }
}
