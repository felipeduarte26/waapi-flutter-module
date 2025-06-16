class WorkdayIndicators {
  List<DateTime> clockingEvents;

  WorkdayIndicators({this.clockingEvents = const []}) {
    clockingEvents.sort(
      (a, b) => a.compareTo(b),
    );
  }

  int getLengthToCalc() {
    if (clockingEvents.isNotEmpty && clockingEvents.length.isOdd) {
      return clockingEvents.length - 1;
    } else {
      return clockingEvents.length;
    }
  }

  Duration get breaks {
    Duration duration = Duration.zero;

    int length = getLengthToCalc();

    for (var i = 0; i < length; i++) {
      if (i % 2 == 1) {
        if (i + 1 < clockingEvents.length) {
          List<DateTime> clockingEventsBreaks = resetSeconds(clockingEvents[i], clockingEvents[i + 1]);
          duration += clockingEventsBreaks[1].difference(clockingEventsBreaks[0]);
        }
      }
    }

    return duration;
  }

  Duration workedHours({bool completeNow = false}) {
    Duration duration = Duration.zero;
    int length = getLengthToCalc();
    for (var i = 0; i < length; i++) {
      if (i % 2 == 0) {
        DateTime t1 = clockingEvents[i];
        DateTime t2 = clockingEvents[i + 1];
        DateTime time1 =
            DateTime(t1.year, t1.month, t1.day, t1.hour, t1.minute, 0);
        DateTime time2 =
            DateTime(t2.year, t2.month, t2.day, t2.hour, t2.minute, 0);

        if (i + 1 < clockingEvents.length) {
          duration += time2.difference(time1);
        } else if (completeNow) {
          duration += DateTime.now().difference(time1);
        }
      }
    }
    return duration;
  }

  static String formatDuration(Duration duration) {
    int hours;
    int minutes;

    hours = duration.inHours;

    minutes = duration.inMinutes % 60;

    final String formatedHours = hours == 0 ? '' : ' ${hours}h';

    final String formatedMinutes =
        minutes != 0 || hours == 0 ? ' ${minutes}min' : '';

    return formatedHours + formatedMinutes;
  }

  static String durationInterval(DateTime exitClock, DateTime startClock) {
    List<DateTime> clockingEvents = resetSeconds(exitClock, startClock);
    return formatDuration(clockingEvents[1].difference(clockingEvents[0]));
  }

  static List<DateTime> resetSeconds(DateTime exitClock, DateTime startClock) {
    List<DateTime> listClockEvents = [];

    DateTime clockOut = DateTime(
      exitClock.year,
      exitClock.month,
      exitClock.day,
      exitClock.hour,
      exitClock.minute,
      0,
    );

    DateTime clockIn = DateTime(
      startClock.year,
      startClock.month,
      startClock.day,
      startClock.hour,
      startClock.minute,
      0,
    );

    listClockEvents.add(clockOut);
    listClockEvents.add(clockIn);
    
    return listClockEvents;
  }
}
