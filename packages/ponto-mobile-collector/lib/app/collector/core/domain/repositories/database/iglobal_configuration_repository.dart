import '../../../external/drift/collector_database.dart';
import '../../entities/global_configuration_entity.dart';

abstract class IGlobalConfigurationRepository {
  Future<bool> exist({
    required String id,
  });

  Future<int> insert({
    required GlobalConfigurationTableData configuration,
  });

  Future<bool> update({
    required GlobalConfigurationTableData configuration,
  });

  Future<bool> saveEntity({
    required GlobalConfigurationEntity globalConfigurationEntity,
  });

  Future<bool> save({
    required GlobalConfigurationTableData configuration,
  });

  Future<bool> saveAll({
    required List<GlobalConfigurationTableData> configurations,
  });

  Future<List<GlobalConfigurationEntity>> getAll();

  Future<GlobalConfigurationTableData?> findById({
    required String id,
  });

  Future<GlobalConfigurationEntity?> findFirst();
}
