
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/infra/utils/iutils.dart';

/// Returns the total time of a pair of point events.
/// Taking into account only hours and minutes.
DateTime calculateTotaltimeClockingEventPair({
  required List<ClockingEventDto> clockingEvents,
  required int typeUse,
  required IUtils utils,
}) {
  try {
    List<ClockingEventDto> typeClockingEvents =
        clockingEvents.where((element) => element.use == typeUse.toString()).toList();

    if (typeClockingEvents.isEmpty || typeClockingEvents.length < 2) {
      return DateTime(0);
    }

    final int totalTimeInSeconds = calculateTotalTimeInSeconds(
      typeClockingEventList: typeClockingEvents,
      utils: utils,
    );

    int hours = totalTimeInSeconds ~/ 3600;
    int minutes = (totalTimeInSeconds.remainder(3600)) ~/ 60;
    int seconds = totalTimeInSeconds.remainder(60);

    return DateTime(0, 0, 0, hours, minutes, seconds);
  } catch (e) {
    return DateTime(0);
  }
}

/// Calculate the total time in minutes of a pair of point events.
int calculateTotalTimeInMinutes({
  required List<ClockingEventDto> typeClockingEventList,
  required IUtils utils,
}) {
  int timeMinutes = 0;

  for (int index = 0; index < typeClockingEventList.length; index++) {
    if (utils.isEven(index) == false && index > 0) {
      int difference = utils.calculateDifferenceInMinutes(
        typeClockingEventList[index].timeEvent,
        typeClockingEventList[index - 1].timeEvent,
      );
      timeMinutes += difference;
    }
  }

  return timeMinutes;
}

/// Calculate the total time in seconds of a pair of point events.
int calculateTotalTimeInSeconds({
  required List<ClockingEventDto> typeClockingEventList,
  required IUtils utils,
}) {
  int timeSeconds = 0;

  for (int index = 0; index < typeClockingEventList.length; index++) {
    if (utils.isEven(index) == false && index > 0) {
      int difference = utils.calculateDifferenceInSeconds(
        typeClockingEventList[index].timeEvent,
        typeClockingEventList[index - 1].timeEvent,
      );
      timeSeconds += difference;
    }
  }

  return timeSeconds;
}
