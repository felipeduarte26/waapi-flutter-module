import '../../domain/entities/global_configuration_entity.dart';

abstract class ConfigurationGlobalQueryDatasource {
  Future<GlobalConfigurationEntity> call();
}
