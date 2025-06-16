
import '../../exception/service_exception.dart';

enum ClockingEventUseType {
  clockingEvent('CLOCKING_EVENT'),
  paidBreak('PAID_BREAK'),
  mandatoryBreak('MANDATORY_BREAK'),
  driving('DRIVING'),
  waiting('WAITING');

  final String value;

  const ClockingEventUseType(this.value);

  static ClockingEventUseType build(String value) {
    if (value == ClockingEventUseType.clockingEvent.value) {
      return ClockingEventUseType.clockingEvent;
    }

    if (value == ClockingEventUseType.paidBreak.value) {
      return ClockingEventUseType.paidBreak;
    }

    if (value == ClockingEventUseType.mandatoryBreak.value) {
      return ClockingEventUseType.mandatoryBreak;
    }

    if (value == ClockingEventUseType.driving.value) {
      return ClockingEventUseType.driving;
    }

    if (value == ClockingEventUseType.waiting.value) {
      return ClockingEventUseType.waiting;
    }

    throw ServiceException(message: 'ClockingEventUse type not found');
  }
}
