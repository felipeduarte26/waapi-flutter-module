import '../../domain/entities/global_device_configuration_entity.dart';
import '../../domain/repositories/get_global_device_configuration_repository.dart';
import '../datasources/get_global_device_configuration_datasource.dart';

class GetGlobalDeviceConfigurationRepositoryImpl
    implements GetGlobalDeviceConfigurationRepository {
  final GetGlobalDeviceConfigurationDatasource _getDeviceConfigurationDatasource;

  const GetGlobalDeviceConfigurationRepositoryImpl({
    required GetGlobalDeviceConfigurationDatasource getDeviceConfigurationDatasource,
  }) : _getDeviceConfigurationDatasource = getDeviceConfigurationDatasource;

  @override
  Future<GlobalDeviceConfigurationEntity?> call({required String identifier}) async {
    return await _getDeviceConfigurationDatasource.call(
      identifier: identifier,
    );
  }
}
