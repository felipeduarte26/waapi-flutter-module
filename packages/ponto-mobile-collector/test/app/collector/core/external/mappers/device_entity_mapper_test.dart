import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/device.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/device_mapper.dart';

import '../../../../../mocks/device_entity_mock.dart';
import '../../../../../mocks/device_table_data_mock.dart';

void main() {
  late DeviceMapper deviceEntityMapper;

  setUp(() {
    deviceEntityMapper = DeviceMapper();
  });

  group('DeviceEntityMapper', () {
    test('mapper fromTable test', () {
      Device deviceEntity  =  deviceEntityMapper.fromTable(deviceTableDataMock);
      expect(deviceEntity.id, deviceTableDataMock.id);
      expect(deviceEntity.identifier, deviceTableDataMock.imei);
      expect(deviceEntity.name, deviceTableDataMock.name);
      expect(deviceEntity.model, deviceTableDataMock.model);
      expect(deviceEntity.status!.value, deviceTableDataMock.status);
    });

    test('mapper toTable test', () {
      DeviceTableData deviceData  =  deviceEntityMapper.toTable(deviceEntityMock);
      expect(deviceData.id, deviceEntityMock.id);
      expect(deviceData.imei, deviceEntityMock.identifier);
      expect(deviceData.name, deviceEntityMock.name);
      expect(deviceData.model, deviceEntityMock.model);
      expect(deviceData.status, deviceEntityMock.status!.value);
    });

    test('mapper toMap from map test', () {
      Map<String, dynamic> deviceMap  =  deviceEntityMapper.toMap(deviceEntityMock);
      Device deviceEntity = deviceEntityMapper.fromMap(deviceMap);
      
      expect(deviceEntity.id, deviceEntityMock.id);
      expect(deviceEntity.identifier, deviceEntityMock.identifier);
      expect(deviceEntity.name, deviceEntityMock.name);
      expect(deviceEntity.model, deviceEntityMock.model);
      expect(deviceEntity.status, deviceEntityMock.status);
    });
  });
}
