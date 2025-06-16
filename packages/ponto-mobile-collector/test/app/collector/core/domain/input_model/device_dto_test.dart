import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/developer_mode.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/gps_operation_mode.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/device_dto.dart';

void main() {
  group('DeviceDto', () {
    test('should serialize and deserialize correctly', () {
      final deviceDto = DeviceDto(
        id: '123',
        name: 'Device Name',
        imei: '123456789012345',
        developerMode: DeveloperModeEnum.inactive,
        gpsOperationMode: GPSoperationModeEnum.inactive,
        dateTimeAutomatic: true,
        timeZoneAutomatic: false,
      );

      final json = deviceDto.toJson();
      expect(json['id'], '123');
      expect(json['name'], 'Device Name');
      expect(json['imei'], '123456789012345');
      expect(json['developerMode'], 'INACTIVE');
      expect(json['gpsOperationMode'], 'INACTIVE');
      expect(json['dateTimeAutomatic'], true);
      expect(json['timeZoneAutomatic'], false);

      final deserializedDeviceDto = DeviceDto.fromJson(json);
      expect(deserializedDeviceDto.id, '123');
      expect(deserializedDeviceDto.name, 'Device Name');
      expect(deserializedDeviceDto.imei, '123456789012345');
      expect(deserializedDeviceDto.developerMode, DeveloperModeEnum.inactive);
      expect(deserializedDeviceDto.gpsOperationMode, GPSoperationModeEnum.inactive);
      expect(deserializedDeviceDto.dateTimeAutomatic, true);
      expect(deserializedDeviceDto.timeZoneAutomatic, false);
    });

    test('should handle null values correctly', () {
      final deviceDto = DeviceDto();

      final json = deviceDto.toJson();
      expect(json['id'], null);
      expect(json['name'], null);
      expect(json['imei'], null);
      expect(json['developerMode'], null);
      expect(json['gpsOperationMode'], null);
      expect(json['dateTimeAutomatic'], null);
      expect(json['timeZoneAutomatic'], null);

      final deserializedDeviceDto = DeviceDto.fromJson(json);
      expect(deserializedDeviceDto.id, null);
      expect(deserializedDeviceDto.name, null);
      expect(deserializedDeviceDto.imei, null);
      expect(deserializedDeviceDto.developerMode, null);
      expect(deserializedDeviceDto.gpsOperationMode, null);
      expect(deserializedDeviceDto.dateTimeAutomatic, null);
      expect(deserializedDeviceDto.timeZoneAutomatic, null);
    });
  });
}
