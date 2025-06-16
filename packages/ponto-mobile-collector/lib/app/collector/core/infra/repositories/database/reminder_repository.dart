import '../../../domain/entities/reminder.dart';
import '../../../domain/enums/reminder_type.dart';
import '../../../domain/repositories/database/ireminder_repository.dart';
import '../../../external/drift/collector_database.dart';

class ReminderRepository implements IReminderRepository {
  CollectorDatabase database;

  ReminderRepository({required this.database});

  @override
  Future<bool> exist({
    required String id,
    required ReminderType type,
  }) async {
    final query = database.select(database.reminderTable);
    query.where((tbl) => tbl.employeeId.equals(id));
    query.where((tbl) => tbl.reminder.equals(type.value));
    List<ReminderTableData> tableData = await query.get();
    return tableData.isNotEmpty;
  }

  @override
  Future<int> insert({
    required Reminder reminder,
  }) async {
    ReminderTableData tableData = convertToTable(reminder: reminder);
    return database.into(database.reminderTable).insert(tableData);
  }

  @override
  Future<bool> update({
    required Reminder reminder,
  }) async {
    ReminderTableData tableData = convertToTable(reminder: reminder);
    return database.update(database.reminderTable).replace(tableData);
  }

  @override
  Future<bool> save({
    required Reminder reminder,
  }) async {
    // Save Reminder
    if (await exist(id: reminder.id!, type: reminder.type)) {
      await update(reminder: reminder);
    } else {
      await insert(reminder: reminder);
    }

    return true;
  }

  @override
  Future<List<Reminder>> findAllByEmployeeId({
    required String employeeId,
  }) async {
    final query = database.select(database.reminderTable);
    query.where((tbl) => tbl.employeeId.equals(employeeId));
    List<ReminderTableData> tableDatas = await query.get();

    List<Reminder> reminders = [];
    for (ReminderTableData reminder in tableDatas) {
      reminders.add(converToDto(tableData: reminder));
    }

    return reminders;
  }

  @override
  Future<void> deleteByEmployeeId({required String employeeId}) async {
    final query = database.delete(database.reminderTable);
    query.where((tbl) => tbl.employeeId.isValue(employeeId));
    await query.go();
  }

  @override
  Future<void> deleteByEmployeeIds({
    required List<String> employeeIds,
  }) async {
    final query = database.delete(database.reminderTable);
    query.where((tbl) => tbl.employeeId.isIn(employeeIds));

    await query.go();
  }

  @override
  ReminderTableData convertToTable({
    required Reminder reminder,
  }) {
    ReminderTableData tableData = ReminderTableData(
      employeeId: reminder.id!,
      period: reminder.period,
      enabled: reminder.enabled,
      reminder: reminder.type.value,
    );

    return tableData;
  }

  Reminder converToDto({
    required ReminderTableData tableData,
  }) {
    Reminder reminder = Reminder(
      id: tableData.employeeId,
      period: tableData.period,
      enabled: tableData.enabled,
      type: ReminderType.build(tableData.reminder),
    );

    return reminder;
  }
}
