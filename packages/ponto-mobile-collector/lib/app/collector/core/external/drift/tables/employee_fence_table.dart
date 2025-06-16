import 'package:drift/drift.dart';

import 'employee_table.dart';
import 'fence_table.dart';

class EmployeeFenceTable extends Table {
  TextColumn get employeeId => text().references(EmployeeTable, #id)();
  TextColumn get fenceId => text().references(FenceTable, #id)();

  @override
  Set<Column> get primaryKey => {employeeId, fenceId};
}
