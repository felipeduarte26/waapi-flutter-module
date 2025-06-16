
import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;

import '../../domain/input_model/device_info_dto.dart';

class DeviceAdapter {

  static auth.DeviceInfo toDeviceInfoAuth(DeviceInfo deviceInfoDto) {
    return auth.DeviceInfo(
      id: deviceInfoDto.id,
      identifier: deviceInfoDto.identifier,
      model: deviceInfoDto.model,
      name: deviceInfoDto.name,
    );
  }
}
