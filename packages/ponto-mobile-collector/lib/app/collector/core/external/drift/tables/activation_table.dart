import 'package:drift/drift.dart';

import 'employee_table.dart';

class ActivationTable extends Table {
  TextColumn get deviceSituation => text()();
  TextColumn get employeeSituation => text()();
  DateTimeColumn get requestDateTime => dateTime()();
  TextColumn get employeeId => text().references(EmployeeTable, #id)();

  @override
  Set<Column> get primaryKey => {employeeId};
}
