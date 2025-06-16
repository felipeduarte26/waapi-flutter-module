import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';


abstract class IRegisterClockingEventService {
  Future<clock.ImportClockingEventDto> register({
    required ClockingEventRegisterEntity clockingEventRegisterEntity,
  });
}
