import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/device_mapper.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

import '../../../mocks/device_entity_mock.dart';
import '../../../mocks/device_table_data_mock.dart';

class MockDeviceEntityMapper extends Mock implements DeviceMapper {}

void main() {
  late CollectorDatabase database;
  late IDeviceRepository repository;
  late DeviceMapper deviceEntityMapper;

  DeviceTableData device = const DeviceTableData(
    id: '1',
    imei: 'imei1',
    status: 'status1',
    model: 'model1',
    name: 'name1',
  );

  DeviceTableData device2 = const DeviceTableData(
    id: '2',
    imei: 'imei2',
    status: 'status2',
    model: 'model2',
    name: 'name2',
  );

  DeviceTableData device3 = DeviceTableData(
    id: device.id,
    imei: 'imei-new',
    status: 'status2-new',
    model: 'model2-new',
    name: 'name2-new',
  );

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      deviceEntityMapper = MockDeviceEntityMapper();

      database = CollectorDatabase(
        database: openConnection(),
      );

      repository = DeviceRepository(
        database: database,
        deviceEntityMapper: deviceEntityMapper,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('DeviceRepository', () {
    test('findById test', () async {
      bool exist = await repository.exist(id: '1', imei: 'imei1');
      bool insertValue1 = await repository.save(device: device);
      bool insertValue2 = await repository.save(device: device2);
      DeviceTableData? foundDevice =
          (await repository.findById(id: device.id))!;
      List<DeviceTableData> devices = await repository.getAll();

      bool updateSucess = await repository.save(device: device3);

      DeviceTableData foundUpdatedDevice =
          (await repository.findById(id: device3.id))!;

      expect(exist, false);
      expect(insertValue1, true);
      expect(insertValue2, true);
      expect(updateSucess, true);
      expect(device.id, foundDevice.id);
      expect(devices.length, 2);

      expect(foundDevice.id, device.id);
      expect(foundDevice.imei, device.imei);
      expect(foundDevice.status, device.status);
      expect(foundDevice.model, device.model);
      expect(foundDevice.name, device.name);

      expect(foundUpdatedDevice.id, device3.id);
      expect(foundUpdatedDevice.imei, device3.imei);
      expect(foundUpdatedDevice.status, device3.status);
      expect(foundUpdatedDevice.model, device3.model);
      expect(foundUpdatedDevice.name, device3.name);
    });

    test('findByIdentifier test', () async {
      await repository.save(device: device);
      await repository.save(device: device2);

      DeviceTableData deviceFound =
          (await repository.findByIdentifier(id: device.imei))!;

      expect(deviceFound.id, device.id);
      expect(deviceFound.imei, device.imei);
    });

    test('findByIdentifier test', () async {
      when(
        () => deviceEntityMapper.toTable(deviceEntityMock),
      ).thenReturn(deviceTableDataMock);

      await repository.saveEntity(device: deviceEntityMock);

      DeviceTableData deviceFound =
          (await repository.findByIdentifier(id: deviceEntityMock.identifier))!;

      expect(deviceFound.id, deviceEntityMock.id);
      expect(deviceFound.imei, deviceEntityMock.identifier);
    });
  });
}
