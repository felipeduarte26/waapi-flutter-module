import 'package:drift/drift.dart';

import 'employee_table.dart';
import 'platform_users_table.dart';

class EmployeePlatformUsersTable extends Table {
  TextColumn get employeeId => text().references(EmployeeTable, #id)();
  TextColumn get platforUsersId => text().references(PlatformUsersTable, #id)();

  @override
  Set<Column> get primaryKey => {employeeId, platforUsersId};
}
