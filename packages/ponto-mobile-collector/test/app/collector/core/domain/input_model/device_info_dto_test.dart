import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/device_info_dto.dart';

void main() {
  group('DeviceInfo', () {
    test('should create a DeviceInfo instance with all fields', () {
      final deviceInfo = DeviceInfo(
        id: '123',
        identifier: 'device-001',
        name: 'Device Name',
        model: 'Model X',
        status: StatusDevice.authorized,
      );

      expect(deviceInfo.id, '123');
      expect(deviceInfo.identifier, 'device-001');
      expect(deviceInfo.name, 'Device Name');
      expect(deviceInfo.model, 'Model X');
      expect(deviceInfo.status, StatusDevice.authorized);
    });

    test('should convert DeviceInfo to JSON', () {
      final deviceInfo = DeviceInfo(
        id: '123',
        identifier: 'device-001',
        name: 'Device Name',
        model: 'Model X',
        status: StatusDevice.authorized,
      );

      final json = deviceInfo.toJson();

      expect(json['id'], '123');
      expect(json['identifier'], 'device-001');
      expect(json['name'], 'Device Name');
      expect(json['model'], 'Model X');
      expect(json['status'], 'AUTHORIZED');
    });

    test('should create DeviceInfo from JSON', () {
      final json = {
        'id': '123',
        'identifier': 'device-001',
        'name': 'Device Name',
        'model': 'Model X',
        'status': 'AUTHORIZED',
      };

      final deviceInfo = DeviceInfo.fromJson(json);

      expect(deviceInfo.id, '123');
      expect(deviceInfo.identifier, 'device-001');
      expect(deviceInfo.name, 'Device Name');
      expect(deviceInfo.model, 'Model X');
      expect(deviceInfo.status, StatusDevice.authorized);
    });

    test('should handle null fields in JSON', () {
      final json = {
        'identifier': 'device-001',
        'name': 'Device Name',
        'model': 'Model X',
      };

      final deviceInfo = DeviceInfo.fromJson(json);

      expect(deviceInfo.id, isNull);
      expect(deviceInfo.identifier, 'device-001');
      expect(deviceInfo.name, 'Device Name');
      expect(deviceInfo.model, 'Model X');
      expect(deviceInfo.status, isNull);
    });
  });
}
