import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';
import '../../../../core/domain/input_model/clocking_event_register_type.dart';

abstract class IEmployeeHasRecentClockingEventUsecase {
  Future<bool> call({
    String? employeeId,
    required ClockingEventRegisterType clockingEventRegisterType,
  });
}

class EmployeeHasRecentClockingEventUsecase
    implements IEmployeeHasRecentClockingEventUsecase {
  final IClockingEventRepository _clockingEventRepository;
  final clock.IInternalClockService _internalClockService;
  final ISessionService _sessionService;

  const EmployeeHasRecentClockingEventUsecase({
    required IClockingEventRepository clockingEventRepository,
    required clock.IInternalClockService internalClockService,
    required ISessionService sessionService,
  })  : _clockingEventRepository = clockingEventRepository,
        _internalClockService = internalClockService,
        _sessionService = sessionService;

  @override
  Future<bool> call({
    String? employeeId,
    required ClockingEventRegisterType clockingEventRegisterType,
  }) async {
    employeeId ??= _sessionService.getEmployeeId();

    final lastClockingEvent =
        await _clockingEventRepository.findLastClockingEventByEmployeeId(
      employeeId: employeeId,
    );

    var hasRecentClockingEvent = false;

    if (lastClockingEvent == null) {
      return hasRecentClockingEvent;
    }

    if (clockingEventRegisterType is! ClockingEventRegisterTypeDriver) {
      hasRecentClockingEvent = _internalClockService
              .getClockDateTime()
              .difference(lastClockingEvent.getDateTimeEvent())
              .inMinutes <
          2;
    }

    return hasRecentClockingEvent;
  }
}
