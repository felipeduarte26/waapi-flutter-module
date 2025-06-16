import 'package:drift/drift.dart';

import 'employee_table.dart';

class OvernightTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get geolocation => text().nullable()();
  TextColumn get locationStatus => text()();
  TextColumn get type => text()();
  BoolColumn get synchronized => boolean()();
  TextColumn get employee => text().references(EmployeeTable, #id)();

  @override
  Set<Column> get primaryKey => {id, employee};
}
