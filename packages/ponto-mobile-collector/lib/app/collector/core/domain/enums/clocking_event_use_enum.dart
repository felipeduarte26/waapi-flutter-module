import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum ClockingEventUseEnum {
  @JsonValue('CLOCKING_EVENT')
  clockingEvent('Clocking Event', 2),

  @JsonValue('PAID_BREAK')
  paidBreak('Paid Break', 18),

  @JsonValue('MANDATORY_BREAK')
  mandatoryBreak('Mandatory Break', 22),

  @JsonValue('DRIVING')
  driving('Driving', 23),

  @JsonValue('WAITING')
  waiting('Waiting', 21);

  final String value;
  final int codigo;

  const ClockingEventUseEnum(
    this.value,
    this.codigo,
  );

  static ClockingEventUseEnum build(int codigo) {
    if (codigo == ClockingEventUseEnum.clockingEvent.codigo) {
      return ClockingEventUseEnum.clockingEvent;
    } else if (codigo == ClockingEventUseEnum.paidBreak.codigo) {
      return ClockingEventUseEnum.paidBreak;
    } else if (codigo == ClockingEventUseEnum.mandatoryBreak.codigo) {
      return ClockingEventUseEnum.mandatoryBreak;
    } else if (codigo == ClockingEventUseEnum.driving.codigo) {
      return ClockingEventUseEnum.driving;
    } else if (codigo == ClockingEventUseEnum.waiting.codigo) {
      return ClockingEventUseEnum.waiting;
    }

    throw ClockingEventException('ClockingEventUseEnum not found.');
  }
}
