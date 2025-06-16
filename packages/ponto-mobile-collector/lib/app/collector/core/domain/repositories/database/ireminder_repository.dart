import '../../../external/drift/collector_database.dart';
import '../../entities/reminder.dart';
import '../../enums/reminder_type.dart';

abstract class IReminderRepository {
  Future<bool> save({
    required Reminder reminder,
  });

  Future<List<Reminder>> findAllByEmployeeId({
    required String employeeId,
  });

  Future<bool> exist({
    required String id,
    required ReminderType type,
  });

  Future<int> insert({
    required Reminder reminder,
  });

  Future<bool> update({
    required Reminder reminder,
  });

  Future<void> deleteByEmployeeId({required String employeeId});

  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  });

  ReminderTableData convertToTable({
    required Reminder reminder,
  });
}
