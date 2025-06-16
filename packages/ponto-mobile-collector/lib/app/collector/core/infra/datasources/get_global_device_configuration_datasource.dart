import '../../domain/entities/global_device_configuration_entity.dart';

abstract class GetGlobalDeviceConfigurationDatasource {
  Future<GlobalDeviceConfigurationEntity?> call({required String identifier});
}
