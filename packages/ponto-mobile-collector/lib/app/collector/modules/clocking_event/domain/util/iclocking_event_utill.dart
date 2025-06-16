import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';

abstract class IClockingEventUtil {
  clock.LocationDTO? convertToLocationDto({
    required StateLocationEntity location,
  });

  List<DateTime> getDateTimes(List<ClockingEvent> clockingEvents);
}
