import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../../external/drift/collector_database.dart';
import '../../../infra/utils/enum/ordering_mode_enum.dart';
import '../../entities/clocking_event.dart';

abstract class IClockingEventRepository {
  Future<bool> exist({
    required String clockingEventId,
  });

  Future<int> insert({
    required clock.ImportClockingEventDto clockingEvent,
    String? journeyId,
    required bool isMealBreak,
  });

  Future<bool> update({
    required clock.ImportClockingEventDto clockingEvent,
    String? journeyId,
    required bool isMealBreak,
  });

  Future<List<ClockingEvent>> getAll();

  Future<bool> save({
    required clock.ImportClockingEventDto clockingEvent,
    String? journeyId,
    String? journeyEventName,
    required bool isMealBreak,
  });

  Future<ClockingEvent?> findById({
    required String clockingEventId,
    required String employeeId,
  });

  /// Fetch all records not synchronized with the server, filtered by employee.
  Future<List<ClockingEvent>> findAllUnsyncedByEmployeeId({
    required String employeeId,
    int limit,
  });

  /// Fetch all records not synchronized with the server.
  Future<List<ClockingEvent>> findAllUnsynced({
    int? limit = 100,
  });

  /// Confirms the success of the synchronization in the local base, as well as saves the remote id of the record.
  Future<void> confirmSynchronization({
    required List<String> clockingEventsImportedId,
  });

  /// Delete records older than 60 days from the reference date.
  Future<int> deleteRecordsOlderThen60Days({
    required DateTime referenceDate,
  });

  ClockingEventTableData convertToTable({
    required clock.ImportClockingEventDto dto,
  });

  Future<ClockingEvent> convertToEntity({
    required ClockingEventTableData tableData,
  });

  Future<List<ClockingEvent>> findByDate({
    required DateTime date,
    required String employeeId,
    auth.ClockingEventUseType? filterByUse,
  });

  Future<List<ClockingEvent>> findFirstByDate({
    required DateTime date,
  });

  Future<List<ClockingEvent>> findByEmployeeAndPeriod({
    required DateTime initDate,
    required DateTime endDate,
    required String employeeId,
    OrderingModeEnum orderingMode,
  });

  Future<List<ClockingEvent>> findByPeriod({
    required DateTime initDate,
    required DateTime endDate,
    OrderingModeEnum orderingMode,
  });

  Future<List<ClockingEvent>>  convertToClockingEventList({
    required List<ClockingEventTableData> data,
  });

  Future<ClockingEvent?> findLastClockingEventByEmployeeId({
    required String employeeId,
  });

  Future<List<ClockingEvent>> findByEmployeesInAndPeriod({
    required DateTime initDate,
    required DateTime endDate,
    required List<String> employeesIds,
    required OrderingModeEnum orderingMode,
  });

  Future<List<ClockingEvent>> findAllByJourneyId({
    required String journeyId,
  });

  Future<List<ClockingEvent>> findAllClockingEventByJourneyId({
    required String journeyId,
  });

  Future<void> deleteAllSynced();

  Future<List<ClockingEvent>> findAll();
  Future<List<ClockingEventTableData>> deleteByEmployeeIds({
    required List<String> employeeIds,
  });
}
