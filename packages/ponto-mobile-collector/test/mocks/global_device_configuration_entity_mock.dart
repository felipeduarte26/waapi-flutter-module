import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_device_configuration_entity.dart';

import 'device_configuration_mock.dart';
import 'device_entity_mock.dart';
import 'global_configuration_entity_mock.dart';

GlobalDeviceConfigurationEntity globalDeviceConfigurationEntityMock =
    GlobalDeviceConfigurationEntity(
  deviceConfiguration: deviceConfigurationMock,
  globalConfigurationEntity: globalConfigurationEntityMock,
  hlbDateTime: '2024-06-07',
  device: deviceEntityMock,
);
