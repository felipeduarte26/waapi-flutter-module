import 'package:json_annotation/json_annotation.dart';

import '../../exception/service_exception.dart';

enum InsightOutOfBoundType {
  @JsonValue('ALL_CLOCKING_EVENTS')
  allClockingEvents('ALL_CLOCKING_EVENTS'),

  @JsonValue('MOBILE_ONLY')
  mobileOnly('MOBILE_ONLY'),

  @JsonValue('DO_NOT_SEND')
  doNotSend('DO_NOT_SEND');

  final String value;

  const InsightOutOfBoundType(this.value);

  static InsightOutOfBoundType build(String value) {
    if (value == InsightOutOfBoundType.allClockingEvents.value) {
      return InsightOutOfBoundType.allClockingEvents;
    }

    if (value == InsightOutOfBoundType.mobileOnly.value) {
      return InsightOutOfBoundType.mobileOnly;
    }

    if (value == InsightOutOfBoundType.doNotSend.value) {
      return InsightOutOfBoundType.doNotSend;
    }

    throw ServiceException(message: 'InsightOutOfBoundType not found');
  }
}
