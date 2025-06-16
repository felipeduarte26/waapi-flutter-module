import '../../../domain/entities/device_configuration.dart';
import '../../../external/drift/collector_database.dart';

abstract class IDeviceConfigurationRepository {
  Future<int> insert({required DeviceConfiguration configuration});

  Future<bool> update({required DeviceConfiguration configuration});

  Future<bool> save({required DeviceConfiguration configuration});

  Future<bool> exist({required String id});

  Future<DeviceConfiguration?> getConfiguration();

  Future<DeviceConfiguration?> findByIdentifier({
    required String identifier,
  });

  DeviceConfigurationTableData convertToTable({
    required DeviceConfiguration configuration,
  });

  DeviceConfiguration convertToEntity({
    required DeviceConfigurationTableData tableData,
  });
}
