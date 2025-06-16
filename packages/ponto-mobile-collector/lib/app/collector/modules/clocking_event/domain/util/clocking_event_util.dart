import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;

import '../../../../../../ponto_mobile_collector.dart';
import 'iclocking_event_utill.dart';

class ClockingEventUtil implements IClockingEventUtil {
  @override
  clock.LocationDTO? convertToLocationDto({
    required StateLocationEntity location,
  }) {
    if (!location.success) {
      return null;
    }

    clock.LocationDTO locationDto = clock.LocationDTO(
      latitude: location.latitude!,
      longitude: location.longitude!,
      dateAndTime: DateTime.now(),
    );

    return locationDto;
  }

 

  @override
  List<DateTime> getDateTimes(List<ClockingEvent> clockingEvents) {
    List<DateTime> times = [];

    for (ClockingEvent event in clockingEvents) {
      times.add(event.getDateTimeEvent());
    }

    return times;
  }
}
