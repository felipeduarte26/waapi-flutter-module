import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum ClockingEventOriginEnum {
  @JsonValue('MOBILE')
  mobile('Mobile'),

  @JsonValue('WEB')
  web('WEB'),

  @JsonValue('CLIENT')
  client('Client');

  final String value;
  const ClockingEventOriginEnum(this.value);

  static ClockingEventOriginEnum build(String value) {
    if (value == ClockingEventOriginEnum.mobile.value) {
      return ClockingEventOriginEnum.mobile;
    }

    if (value == ClockingEventOriginEnum.web.value) {
      return ClockingEventOriginEnum.web;
    }

    if (value == ClockingEventOriginEnum.client.value) {
      return ClockingEventOriginEnum.client;
    }

    throw ClockingEventException('ClockingEventOriginEnum not found.');
  }
}
