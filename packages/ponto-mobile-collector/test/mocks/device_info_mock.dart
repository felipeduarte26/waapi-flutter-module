import 'package:mobile_authentication/mobile_authentication_service.dart' as auth;
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/device_info_dto.dart';

auth.DeviceInfo deviceInfoMock = auth.DeviceInfo(
  identifier: 'identifier',
  model: 'model',
  name: 'name',
  id: 'id',
  status: auth.StatusDevice.authorized,
);

DeviceInfo deviceMockInfo = DeviceInfo(
  identifier: 'identifier',
  model: 'model',
  name: 'name',
  id: 'id',
  status: StatusDevice.authorized,
);
