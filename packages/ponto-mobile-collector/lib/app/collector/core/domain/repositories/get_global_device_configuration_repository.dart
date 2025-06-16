import '../entities/global_device_configuration_entity.dart';

abstract class GetGlobalDeviceConfigurationRepository {
  Future<GlobalDeviceConfigurationEntity?> call({required String identifier});
}
