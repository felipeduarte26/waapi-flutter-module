import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

void main() {
  late CollectorDatabase database;
  late IEmployeeFenceRepository repository;

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
      repository = EmployeeFenceRepository(
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
    'EmployeeFenceRepository test.',
    () async {
      EmployeeTableData employeeTable1 = const EmployeeTableData(
        cpfNumber: '49737807073',
        employeeType: '',
        id: 'dec52c53-81c0-438a-bdad-051d7cb1ac2f',
        name: 'Employee Teste 1',
        registrationNumber: '1',
        mail: 'employee1@email.com',
        nfcCode: '645834536534',
        companyId: 'fecd5e44-3034-41e5-89bc-211c9cb179ea',
      );

      FenceTableData fenceTable = const FenceTableData(
        id: '867b8199-faac-474a-9493-51a1008ab275',
        name: 'Fence Teste',
      );

      await database.into(database.employeeTable).insert(employeeTable1);
      await database.into(database.fenceTable).insert(fenceTable);

      bool successSave = await repository.save(
        employeeId: employeeTable1.id,
        fenceId: fenceTable.id,
      );

      bool successUpdate = await repository.save(
        employeeId: employeeTable1.id,
        fenceId: fenceTable.id,
      );

      List<String> fencesId = await repository.findAllByEmployeeId(
        employeeId: employeeTable1.id,
      );

      expect(successSave, true);
      expect(successUpdate, true);
      expect(fencesId.length, 1);
      expect(fencesId.first, fenceTable.id);

      await repository.deleteAll();
      fencesId = await repository.findAllByEmployeeId(
        employeeId: employeeTable1.id,
      );

      expect(fencesId, isEmpty);
    },
  );

  test(
    'deleteByEmployeeIds test',
    () async {
      await repository.save(
        employeeId: '1',
        fenceId: '1',
      );
      await repository.deleteByEmployeeIds(employeeIds: []);

      final employeeFences = await repository.findAllByEmployeeId(
        employeeId: '1',
      );

      expect(employeeFences, isNotEmpty);
    },
  );
}
