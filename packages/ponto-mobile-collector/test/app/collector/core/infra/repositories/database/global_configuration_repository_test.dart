import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/global_configuration_mapper.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/global_configuration_repository.dart';

import '../../../../../../mocks/global_configuration_entity_mock.dart';
import '../../../../../../mocks/global_configuration_table_data_mock.dart';

class MockGlobalConfigurationEntityMapper extends Mock
    implements GlobalConfigurationEntityMapper {}

void main() {
  late CollectorDatabase database;
  late GlobalConfigurationRepository repository;
  late GlobalConfigurationEntityMapper globalConfigurationEntityMapper;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      globalConfigurationEntityMapper = MockGlobalConfigurationEntityMapper();

      database = CollectorDatabase(
        database: openConnection(),
      );
      
      repository = GlobalConfigurationRepository(
        database: database,
        globalConfigurationEntityMapper: globalConfigurationEntityMapper,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('GlobalConfigurationRepository', () {
    test('testes de inser, save, update, findAll and findById test', () async {
      repository = GlobalConfigurationRepository(
        database: database,
        globalConfigurationEntityMapper: GlobalConfigurationEntityMapper(),
      );

      bool isEmpty = (await repository.getAll()).isEmpty;

      await database
          .into(database.globalConfigurationTable)
          .insert(globalConfigurationTableDataMock);

      bool successSave = await repository.save(
        configuration: globalConfigurationTableDataMock,
      );

      bool successUpdate = await repository.update(
        configuration: globalConfigurationTableDataMock,
      );

      int totalConfigurations = (await repository.getAll()).length;

      GlobalConfigurationTableData configurationFindById =
          (await repository.findById(id: globalConfigurationTableDataMock.id))!;

      expect(isEmpty, true);
      expect(successSave, true);
      expect(successUpdate, true);
      expect(totalConfigurations, 1);
      expect(globalConfigurationTableDataMock.id, configurationFindById.id);
    });

    test('saveEntity test', () async {
      when(
        () => globalConfigurationEntityMapper.toTableData(
          globalConfigurationEntity: globalConfigurationEntityMock,
        ),
      ).thenReturn(globalConfigurationTableDataMock);

      bool successSave = await repository.saveEntity(
        globalConfigurationEntity: globalConfigurationEntityMock,
      );

      expect(successSave, true);

      verify(
        () => globalConfigurationEntityMapper.toTableData(
          globalConfigurationEntity: globalConfigurationEntityMock,
        ),
      );
    });
  });
}
