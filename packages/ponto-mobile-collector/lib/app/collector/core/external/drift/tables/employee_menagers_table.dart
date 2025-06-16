import 'package:drift/drift.dart';

import 'employee_table.dart';
import 'manager_table.dart';

class EmployeeManagersTable extends Table {
  TextColumn get employeeId => text().references(EmployeeTable, #id)();
  TextColumn get managerId => text().references(ManagerTable, #id)();

  @override
  Set<Column> get primaryKey => {employeeId, managerId};
}
