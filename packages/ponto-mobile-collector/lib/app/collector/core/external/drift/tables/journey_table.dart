import 'package:drift/drift.dart';

import 'employee_table.dart';
import 'overnight_table.dart';

class JourneyTable extends Table {
  TextColumn get id => text()();
  IntColumn get journeyNumber => integer()();
  TextColumn get overnightId =>
      text().nullable().references(OvernightTable, #id)();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get employeeId => text().references(EmployeeTable, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
