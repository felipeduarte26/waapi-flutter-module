import '../../entities/clocking_event_use.dart';
import '../../enums/clocking_event_use_type.dart';

abstract class ClockingEventUseRepository {
  Future<bool> exist({
    required String employeeId,
    required String clockingType,
  });

  Future<int> insert({
    required ClockingEventUse clocking,
    required String employeeId,
  });

  Future<bool> update({
    required ClockingEventUse clocking,
    required String employeeId,
  });

  Future<bool> save({
    required ClockingEventUse clocking,
    required String employeeId,
  });

  Future<List<ClockingEventUse>> findAllByEmployeeId({
    required String employeeId,
  });

  Future<ClockingEventUse?> findByEmployeeIdAndClockingEventUseType({
    required String employeeId,
    required ClockingEventUseType clockingEventUseType,
  });

  Future<int> deleteByEmployeeId({
    required String employeeId,
  });

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });
}
