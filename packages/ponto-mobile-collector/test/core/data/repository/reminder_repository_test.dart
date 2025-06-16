import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/reminder.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/reminder_repository.dart';
import 'package:test/test.dart';

import '../../../mocks/reminder_entity_mock.dart';

void main() {
  late CollectorDatabase database;
  late ReminderRepository repository;

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

      repository = ReminderRepository(
        database: database,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('ReminderRepository', () {
    test('findAllByEmployeeId test', () async {
      await repository.save(reminder: reminderEntityMock);

      List<Reminder> remindersDtoOut =
          await repository.findAllByEmployeeId(employeeId: reminderEntityMock.id!);

      expect(reminderEntityMock.id, remindersDtoOut.first.id);
      expect(reminderEntityMock.enabled, remindersDtoOut.first.enabled);
    });

    test('exist test', () async {
      await repository.save(reminder: reminderEntityMock);

      var platformUserEmployeeDtoOut =
          await repository.exist(id: reminderEntityMock.id!);

      expect(true, platformUserEmployeeDtoOut);
    });

    test('update test', () async {
      await repository.save(reminder: reminderEntityMock);

      var platformUserEmployeeDtoOut =
          await repository.update(reminder: reminderEntityMock);

      expect(true, platformUserEmployeeDtoOut);
    });

    test('deleteByEmployeeId test', () async {
      await repository.save(reminder: reminderEntityMock);

      await repository.deleteByEmployeeId(employeeId: reminderEntityMock.id!);

      var existReminderByEmployeeId = await repository.exist(
        id: reminderEntityMock.id!,
      );
      expect(false, existReminderByEmployeeId);
    });

    test('deleteByEmployeeIds test', () async {
      await repository.save(reminder: reminderEntityMock);
      await repository.deleteByEmployeeIds(employeeIds: []);

      final isReminderExists = await repository.exist(
        id: reminderEntityMock.id!,
      );

      expect(isReminderExists, isTrue);
    });
  });
}
