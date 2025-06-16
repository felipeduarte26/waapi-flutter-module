import 'package:json_annotation/json_annotation.dart';

import '../../exception/clocking_event_exception.dart';

enum GPSoperationModeEnum {
  @JsonValue('ACTIVE')
  active('Active'),

  @JsonValue('INACTIVE')
  inactive('Inactive'),

  @JsonValue('PRECISION')
  precision('Pecision');

  final String value;
  const GPSoperationModeEnum(this.value);

  static GPSoperationModeEnum build(String value) {
    if (value == GPSoperationModeEnum.active.value) {
      return GPSoperationModeEnum.active;
    }

    if (value == GPSoperationModeEnum.inactive.value) {
      return GPSoperationModeEnum.inactive;
    }

    if (value == GPSoperationModeEnum.precision.value) {
      return GPSoperationModeEnum.precision;
    }

    throw ClockingEventException('GPSoperationModeEnum not found.');
  }
}
