import 'device.dart';
import 'device_configuration.dart';
import 'global_configuration_entity.dart';

class GlobalDeviceConfigurationEntity {
  Device? device;
  GlobalConfigurationEntity? globalConfigurationEntity;
  DeviceConfiguration? deviceConfiguration;
  String? hlbDateTime;

  GlobalDeviceConfigurationEntity({
    required this.device,
    required this.globalConfigurationEntity,
    required this.deviceConfiguration,
    required this.hlbDateTime,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GlobalDeviceConfigurationEntity &&
        other.device == device &&
        other.globalConfigurationEntity == globalConfigurationEntity &&
        other.deviceConfiguration == deviceConfiguration &&
        other.hlbDateTime == hlbDateTime;
  }

  @override
  int get hashCode {
    return device.hashCode ^
        globalConfigurationEntity.hashCode ^
        deviceConfiguration.hashCode ^
        hlbDateTime.hashCode;
  }
}
