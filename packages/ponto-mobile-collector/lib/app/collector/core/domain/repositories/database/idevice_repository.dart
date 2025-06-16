import '../../../external/drift/collector_database.dart';
import '../../entities/device.dart';

abstract class IDeviceRepository {
  Future<bool> exist({required String id, required String imei});
  Future<int> insert({required DeviceTableData device});
  Future<bool> update({required DeviceTableData device});
  Future<bool> save({required DeviceTableData device});
  Future<List<DeviceTableData>> getAll();
  Future<DeviceTableData?> findById({required String id});
  Future<DeviceTableData?> findByIdentifier({required String id});
  Future<bool> saveEntity({required Device device});
}
