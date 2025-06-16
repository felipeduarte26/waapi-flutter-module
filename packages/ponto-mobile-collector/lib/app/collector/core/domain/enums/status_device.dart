import 'package:json_annotation/json_annotation.dart';

import '../../exception/service_exception.dart';

enum StatusDevice {
  @JsonValue('PENDING')
  pending('PENDING'),

  @JsonValue('REJECTED')
  rejected('REJECTED'),

  @JsonValue('AUTHORIZED')
  authorized('AUTHORIZED'),

  @JsonValue('AUTHORIZED_BY_EMPLOYEE')
  authorizedByEmployee('AUTHORIZED_BY_EMPLOYEE');

  final String value;

  const StatusDevice(this.value);

  static StatusDevice build(String value) {
    if (value == StatusDevice.authorized.value) {
      return StatusDevice.authorized;
    }

    if (value == StatusDevice.authorizedByEmployee.value) {
      return StatusDevice.authorizedByEmployee;
    }

    if (value == StatusDevice.pending.value) {
      return StatusDevice.pending;
    }

    if (value == StatusDevice.rejected.value) {
      return StatusDevice.rejected;
    }

    throw ServiceException(message: 'StatusDevice not found');
  }
}
