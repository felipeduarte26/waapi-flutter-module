import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum DeveloperModeEnum {
  @JsonValue('ACTIVE')
  active('Active'),

  @JsonValue('INACTIVE')
  inactive('Inactive'),

  @JsonValue('UNDEFINED')
  undefined('Undefined');

  final String value;
  const DeveloperModeEnum(this.value);

  static DeveloperModeEnum build(String value) {
    if (value == DeveloperModeEnum.active.value) {
      return DeveloperModeEnum.active;
    }

    if (value == DeveloperModeEnum.inactive.value) {
      return DeveloperModeEnum.inactive;
    }

    if (value == DeveloperModeEnum.undefined.value) {
      return DeveloperModeEnum.undefined;
    }

    throw ClockingEventException('DeveloperModeEnum not found.');
  }
}
