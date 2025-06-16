import '../../../domain/entities/device_configuration.dart';
import '../../../domain/repositories/database/i_device_configuration_repository.dart';
import '../../../external/drift/collector_database.dart';

class DeviceConfigurationRepository implements IDeviceConfigurationRepository {
  final CollectorDatabase database;

  const DeviceConfigurationRepository(this.database);

  @override
  Future<int> insert({required DeviceConfiguration configuration}) {
    final tableData = convertToTable(configuration: configuration);
    return database.into(database.deviceConfigurationTable).insert(tableData);
  }

  @override
  Future<bool> update({required DeviceConfiguration configuration}) {
    final tableData = convertToTable(configuration: configuration);
    return database
        .update(database.deviceConfigurationTable)
        .replace(tableData);
  }

  @override
  Future<bool> save({required DeviceConfiguration configuration}) async {
    if (await exist(id: configuration.id)) {
      return await update(configuration: configuration);
    } else {
      await insert(configuration: configuration);
      return true;
    }
  }

  @override
  DeviceConfigurationTableData convertToTable({
    required DeviceConfiguration configuration,
  }) =>
      DeviceConfigurationTableData(
        id: configuration.id,
        enableFacial: configuration.enableFacial,
        enableNfc: configuration.enableNfc,
        enableQrCode: configuration.enableQrCode,
        lastSync: configuration.lastSync,
        lastUpdate: configuration.lastUpdate,
        takePhotoMulti: false,
        timeZone: configuration.timeZone,
        enableUserPassword: configuration.enableUserPassword, 
        allowChangeTime: configuration.allowChangeTime,
      );

  @override
  Future<bool> exist({
    required String id,
  }) async {
    final query = database.select(database.deviceConfigurationTable);
    query.where((table) => table.id.equals(id));
    DeviceConfigurationTableData? tableData = await query.getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<DeviceConfiguration?> getConfiguration() async {
    final query = database.select(database.deviceConfigurationTable);
    final tableData = await query.getSingleOrNull();
    if (tableData != null) {
      return convertToEntity(tableData: tableData);
    } else {
      return null;
    }
  }

  @override
  Future<DeviceConfiguration?> findByIdentifier({
    required String identifier,
  }) async {
    List<DeviceConfigurationTableData> tableData =
        await (database.select(database.deviceConfigurationTable)
              ..where((table) => table.id.equals(identifier)))
            .get();

    if (tableData.isEmpty) {
      return null;
    }

    return convertToEntity(tableData: tableData.first);
  }

  @override
  DeviceConfiguration convertToEntity({
    required DeviceConfigurationTableData tableData,
  }) {
    final configuration = DeviceConfiguration(
      id: tableData.id,
      enableFacial: tableData.enableFacial,
      enableNfc: tableData.enableNfc,
      enableQrCode: tableData.enableQrCode,
      lastSync: tableData.lastSync,
      lastUpdate: tableData.lastUpdate,
      timeZone: tableData.timeZone,
      enableUserPassword: tableData.enableUserPassword ?? false,
      allowChangeTime: tableData.allowChangeTime ?? false,
    );

    return configuration;
  }
}
