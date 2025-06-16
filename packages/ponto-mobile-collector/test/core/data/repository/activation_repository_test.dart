import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/activation.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/activation_situation_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:test/test.dart';

import '../../../mocks/employee_table_data_mock.dart';

void main() {
  final activation = Activation(
    deviceSituation: StatusDevice.authorized,
    employeeSituation: ActivationSituationType.authorized,
    requestDate: '2023-07-14',
    requestTime: '17:39:33',
    id: employeeTableDataMock.id,
  );

  late CollectorDatabase database;
  late IActivationRepository repository;

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
      repository = ActivationRepository(
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
    'ActivationRepository test.',
    () async {
      IActivationRepository repository =
          ActivationRepository(database: database);

      await database.into(database.employeeTable).insert(employeeTableDataMock);

      bool isEmpty = (await repository.getAll()).isEmpty;
      bool successSave = await repository.save(
        activation: activation,
        employeeId: employeeTableDataMock.id,
      );

      Activation activation2 = Activation(
        deviceSituation: StatusDevice.authorized,
        employeeSituation: ActivationSituationType.pending,
        requestDate: '2023-07-14',
        requestTime: '17:39:33',
        id: employeeTableDataMock.id,
      );

      bool successUpdate = await repository.save(
        activation: activation2,
        employeeId: employeeTableDataMock.id,
      );

      int totalActivations = (await repository.getAll()).length;

      Activation activationFindByEmployeeId =
          (await repository.findByEmployeeId(
        employeeId: employeeTableDataMock.id,
      ))!;

      expect(isEmpty, true);
      expect(successSave, true);
      expect(successUpdate, true);
      expect(totalActivations, 1);
      expect(activation2.id, activationFindByEmployeeId.id);
      expect(
        activation2.employeeSituation,
        activationFindByEmployeeId.employeeSituation,
      );
      expect(activation2.requestDate, activationFindByEmployeeId.requestDate);
      expect(activation2.requestTime, activationFindByEmployeeId.requestTime);
    },
  );

  test(
    'deleteByEmployeeIds test',
    () async {
      await repository.save(
        activation: activation,
        employeeId: employeeTableDataMock.id,
      );
      await repository.deleteByEmployeeIds(employeeIds: []);

      final activations = await repository.getAll();

      expect(activations, isNotEmpty);
    },
  );
}
