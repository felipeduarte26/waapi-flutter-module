import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum ReminderType {
  @JsonValue('INTRAJOURNEY')
  intrajourney('INTRAJOURNEY'),
  @JsonValue('INTERJOURNEY')
  interjourney('INTERJOURNEY');

  final String value;

  const ReminderType(this.value);

    static ReminderType build(String value) {
    if (value == ReminderType.intrajourney.value) {
      return ReminderType.intrajourney;
    }

    if (value == ReminderType.interjourney.value) {
      return ReminderType.interjourney;
    }

    throw ClockingEventException('ReminderType not found');
  }
}
