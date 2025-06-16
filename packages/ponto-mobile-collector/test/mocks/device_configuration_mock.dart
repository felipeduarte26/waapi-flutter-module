import 'package:ponto_mobile_collector/app/collector/core/domain/entities/device_configuration.dart';

DeviceConfiguration deviceConfigurationMock = DeviceConfiguration(
  id: 'testId',
  allowChangeTime: true,
  enableFacial: true,
  enableNfc: true,
  enableQrCode: true,
  enableUserPassword: true,
  lastSync: DateTime.parse('2024-06-21'),
  lastUpdate: DateTime.parse('2024-06-21'),
  timeZone: '-03:00',
);
