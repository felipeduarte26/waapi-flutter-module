import '../../../domain/entities/global_configuration_entity.dart';
import '../../../domain/repositories/database/iglobal_configuration_repository.dart';
import '../../../external/drift/collector_database.dart';
import '../../../external/mappers/global_configuration_mapper.dart';

class GlobalConfigurationRepository implements IGlobalConfigurationRepository {
  CollectorDatabase database;
  final GlobalConfigurationEntityMapper _globalConfigurationEntityMapper;

  GlobalConfigurationRepository({
    required this.database,
    required GlobalConfigurationEntityMapper globalConfigurationEntityMapper,
  }) : _globalConfigurationEntityMapper = globalConfigurationEntityMapper;

  @override
  Future<bool> exist({required String id}) async {
    String? tableData =
        await (database.select(database.globalConfigurationTable)
              ..where((tbl) => tbl.id.equals(id)))
            .map((p0) => p0.id)
            .getSingleOrNull();
    return tableData != null;
  }

  @override
  Future<int> insert({
    required GlobalConfigurationTableData configuration,
  }) async {
    return database
        .into(database.globalConfigurationTable)
        .insert(configuration);
  }

  @override
  Future<bool> update({
    required GlobalConfigurationTableData configuration,
  }) async {
    return database
        .update(database.globalConfigurationTable)
        .replace(configuration);
  }

  @override
  Future<bool> saveEntity({
    required GlobalConfigurationEntity globalConfigurationEntity,
  }) async {
    GlobalConfigurationTableData globalConfigurationTableData =
        _globalConfigurationEntityMapper.toTableData(
      globalConfigurationEntity: globalConfigurationEntity,
    );

    return save(configuration: globalConfigurationTableData);
  }

  @override
  Future<bool> save({
    required GlobalConfigurationTableData configuration,
  }) async {
    if ((await exist(id: configuration.id))) {
      return await update(configuration: configuration);
    } else {
      return (await insert(configuration: configuration)) > 0;
    }
  }

  @override
  Future<GlobalConfigurationTableData?> findById({
    required String id,
  }) async {
    return await (database.select(database.globalConfigurationTable)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  @override
  Future<List<GlobalConfigurationEntity>> getAll() async {
    List<GlobalConfigurationTableData> tableDatas =
        await database.select(database.globalConfigurationTable).get();

    List<GlobalConfigurationEntity> configurations = [];

    for (GlobalConfigurationTableData tableData in tableDatas) {
      configurations
          .add(_globalConfigurationEntityMapper.fromTableData(tableData));
    }

    return configurations;
  }

  @override
  Future<bool> saveAll({
    required List<GlobalConfigurationTableData> configurations,
  }) async {
    for (var configuration in configurations) {
      var result = await save(configuration: configuration);
      if (!result) {
        return false;
      }
    }
    return true;
  }

  @override
  Future<GlobalConfigurationEntity?> findFirst() async {
    return (await getAll()).firstOrNull;
  }
}
