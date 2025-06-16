import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum NetworkStatusEnum {
  @JsonValue('ACTIVE')
  active('Active'),

  @JsonValue('INACTIVE')
  inactive('Inactive'),

  @JsonValue('UNDEFINED')
  undefined('Undefined');

  final String value;
  const NetworkStatusEnum(
    this.value,
  );

  static NetworkStatusEnum build(String value) {
    if (value == NetworkStatusEnum.active.value) {
      return NetworkStatusEnum.active;
    }

    if (value == NetworkStatusEnum.inactive.value) {
      return NetworkStatusEnum.inactive;
    }

    if (value == NetworkStatusEnum.undefined.value) {
      return NetworkStatusEnum.undefined;
    }

    throw ClockingEventException('NetworkStatusEnum not found.');
  }
}
