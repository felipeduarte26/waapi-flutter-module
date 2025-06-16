import 'package:drift/drift.dart';

import 'manager_table.dart';
import 'platform_users_table.dart';

class ManagersPlatformUsersTable extends Table {
  TextColumn get managerId => text().references(ManagerTable, #id)();
  TextColumn get platforUsersId => text().references(PlatformUsersTable, #id)();

  @override
  Set<Column> get primaryKey => {managerId, platforUsersId};
}
