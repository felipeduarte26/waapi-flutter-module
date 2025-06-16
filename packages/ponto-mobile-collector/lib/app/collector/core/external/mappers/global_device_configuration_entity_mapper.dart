import '../../domain/entities/global_device_configuration_entity.dart';
import '../../infra/adapters/device_configuration_adapter.dart';
import 'device_mapper.dart';
import 'global_configuration_mapper.dart';

class GlobalDeviceConfigurationEntityMapper {
  GlobalDeviceConfigurationEntity fromMap(Map<String, dynamic> map) {
    return GlobalDeviceConfigurationEntity(
      device: map['deviceDto'] == null
          ? null
          : DeviceMapper().fromMap(map['deviceDto']),
      deviceConfiguration: map['deviceConfiguration'] == null
          ? null
          : DeviceConfigurationAdapter.fromMap(map['deviceConfiguration']),
      globalConfigurationEntity: map['configuration'] == null
          ? null
          : GlobalConfigurationEntityMapper()
              .fromMap(map: map['configuration']),
      hlbDateTime: map['instanceDateAndTime'],
    );
  }
}
