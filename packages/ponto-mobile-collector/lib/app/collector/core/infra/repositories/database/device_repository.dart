import 'package:drift/drift.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/entities/device.dart';
import '../../../external/drift/collector_database.dart';
import '../../../external/mappers/device_mapper.dart';

class DeviceRepository implements IDeviceRepository {
  final CollectorDatabase database;
  final DeviceMapper deviceEntityMapper;

  DeviceRepository({
    required this.database,
    required this.deviceEntityMapper,
  });

  @override
  Future<bool> exist({required String id, required String imei}) async {
    String? tableData = await (database.select(database.deviceTable)
          ..where((tbl) => Expression.or([tbl.id.equals(id), tbl.imei.equals(imei)])))
        .map((p0) => p0.id)
        .getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({required DeviceTableData device}) async {
    return database.into(database.deviceTable).insert(device);
  }

  @override
  Future<bool> update({required DeviceTableData device}) async {
    return database.update(database.deviceTable).replace(device);
  }

  @override
  Future<bool> saveEntity({required Device device}) {
    DeviceTableData deviceTableData = deviceEntityMapper.toTable(device);
    return save(device: deviceTableData);
  }

  @override
  Future<bool> save({required DeviceTableData device}) async {
    return (await exist(id: device.id, imei: device.imei))
        ? await update(device: device)
        : (await insert(device: device)) > 0;
  }

  @override
  Future<DeviceTableData?> findById({
    required String id,
  }) async {
    return (database.select(database.deviceTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<List<DeviceTableData>> getAll() async {
    return database.select(database.deviceTable).get();
  }

  @override
  Future<DeviceTableData?> findByIdentifier({required String id}) async {
    return (database.select(database.deviceTable)
          ..where((tbl) => tbl.imei.equals(id)))
        .getSingleOrNull();
  }
}
