import 'package:drift/drift.dart';

import 'employee_table.dart';

class ClockingEventUseTable extends Table {
  TextColumn get employeeId => text().references(EmployeeTable, #id)();
  TextColumn get description => text()();
  TextColumn get code => text()();
  TextColumn get clockingEventUseType => text()();

  @override
  Set<Column> get primaryKey => {employeeId, clockingEventUseType};

}
