import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:ponto_mobile_collector/app/collector/core/domain/entities/configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

void main() {
  const employeeId1 = '0ea901d8-9701-4694-95b9-6619a8aa08a3';

  const config1 = Configuration(
    id: employeeId1,
    onlyOnline: true,
    operationMode: OperationModeType.single,
    takePhoto: true,
    timezone: '+03:00',
  );

  late CollectorDatabase database;
  late IConfigurationRepository repository;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      database = CollectorDatabase(
        database: openConnection(),
      );
      repository = ConfigurationRepository(
        database: database,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  test(
    'ConfigurationRepository test.',
    () async {
      String employeeId2 = '3473ecf1-3c2e-4f8c-a521-c522e2f670bb';

      Configuration config2 = Configuration(
        id: employeeId2,
        onlyOnline: false,
        operationMode: OperationModeType.multi,
        takePhoto: false,
        timezone: '+04:00',
      );

      bool successSave =
          await repository.save(config: config1, employeeId: employeeId1);
      bool successUpdate = await repository.save(
        config: config2,
        employeeId: employeeId2,
      );

      config2 = Configuration(
        id: employeeId2,
        onlyOnline: false,
        operationMode: OperationModeType.multi,
        takePhoto: false,
        timezone: '+06:00',
      );

      bool successUpdate2 = await repository.save(
        config: config2,
        employeeId: employeeId2,
        username: 'username',
      );
      bool successUpdate3 =
          await repository.save(config: config2, employeeId: employeeId2);

      List<Configuration> configs = await repository.getAll();
      Configuration configTable =
          (await repository.findByEmployeeId(employeeId: employeeId2))!;

      expect(successSave, true);
      expect(successUpdate, true);
      expect(successUpdate2, true);
      expect(successUpdate3, true);
      expect(configs.length, 2);
      expect(configTable.id, config2.id);
      expect(configTable.onlyOnline, config2.onlyOnline);
      expect(configTable.operationMode, config2.operationMode);
      expect(configTable.takePhoto, config2.takePhoto);
      expect(configTable.timezone, config2.timezone);
      expect(configTable.username, 'username');
      expect(configs[0].id, employeeId1);
      expect(configs[1].id, employeeId2);
    },
  );

  test(
    'deleteByEmployeeIds test',
    () async {
      await repository.save(
        config: config1,
        employeeId: employeeId1,
      );
      await repository.deleteByEmployeeIds(employeeIds: []);

      final configurations = await repository.getAll();

      expect(configurations, isNotEmpty);
    },
  );
}
