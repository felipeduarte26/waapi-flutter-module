import 'package:drift/drift.dart';



import 'employee_table.dart';

class ReminderTable extends Table {
  TextColumn get employeeId => text().references(EmployeeTable, #id)();
  DateTimeColumn get period => dateTime()();
  BoolColumn get enabled => boolean().withDefault(const Constant(false))();
  TextColumn get reminder => text()();

  @override
  Set<Column> get primaryKey => {employeeId, reminder};

}
