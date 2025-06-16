import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/device_configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_configuration_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/global_device_configuration_entity.dart';

class FakeDeviceConfiguration extends Mock implements DeviceConfiguration {}

class FakeGlobalConfigurationEntity extends Mock
    implements GlobalConfigurationEntity {}

class FakeDeviceEntity extends Mock implements Device {}

void main() {
  late GlobalDeviceConfigurationEntity globalDeviceConfigurationEntity;
  late DeviceConfiguration deviceConfiguration;
  late GlobalConfigurationEntity globalConfigurationEntity;
  late Device deviceEntity;

  setUp(() {
    deviceConfiguration = FakeDeviceConfiguration();
    globalConfigurationEntity = FakeGlobalConfigurationEntity();
    deviceEntity = FakeDeviceEntity();

    globalDeviceConfigurationEntity = GlobalDeviceConfigurationEntity(
      deviceConfiguration: deviceConfiguration,
      globalConfigurationEntity: globalConfigurationEntity,
      hlbDateTime: 'hlbDateTime',
      device: deviceEntity,
    );
  });

  group('GlobalDeviceConfigurationEntity', () {
    test('constructor test', () {
      GlobalDeviceConfigurationEntity globalDeviceConfigurationEntity2 =
          GlobalDeviceConfigurationEntity(
        deviceConfiguration: deviceConfiguration,
        globalConfigurationEntity: globalConfigurationEntity,
        hlbDateTime: 'hlbDateTime',
        device: deviceEntity,
      );

      expect(
        globalDeviceConfigurationEntity == globalDeviceConfigurationEntity2,
        true,
      );
      expect(
        globalDeviceConfigurationEntity.deviceConfiguration,
        deviceConfiguration,
      );
      expect(
        globalDeviceConfigurationEntity.globalConfigurationEntity,
        globalConfigurationEntity,
      );
      expect(globalDeviceConfigurationEntity.hlbDateTime, 'hlbDateTime');
      expect(globalDeviceConfigurationEntity.hashCode, 792363540);
    });
  });
}
