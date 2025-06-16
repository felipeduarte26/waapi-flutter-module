import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/device_info_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/adapters/device_adapter.dart';

void main() {
  group('DeviceAdapter', () {
    test('toDeviceInfoAuth should map DeviceInfoDto to auth.DeviceInfo correctly', () {
      // Arrange
      final deviceInfoDto = DeviceInfo(
        id: '123',
        identifier: 'device-identifier',
        model: 'device-model',
        name: 'device-name',
      );

      // Act
      final authDeviceInfo = DeviceAdapter.toDeviceInfoAuth(deviceInfoDto);

      // Assert
      expect(authDeviceInfo.id, equals(deviceInfoDto.id));
      expect(authDeviceInfo.identifier, equals(deviceInfoDto.identifier));
      expect(authDeviceInfo.model, equals(deviceInfoDto.model));
      expect(authDeviceInfo.name, equals(deviceInfoDto.name));
    });
  });
}