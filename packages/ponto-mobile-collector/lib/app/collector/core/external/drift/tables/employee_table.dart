import 'package:drift/drift.dart';

import 'company_table.dart';

class EmployeeTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();
  TextColumn get pis => text().nullable()();
  TextColumn get cpfNumber => text()();
  TextColumn get mail => text().nullable()();
  TextColumn get companyId => text().references(CompanyTable, #id)();
  TextColumn get nfcCode => text().nullable()();
  TextColumn get employeeType => text()();
  TextColumn get registrationNumber => text().nullable()();
  TextColumn get arpId => text().nullable()();
  BoolColumn get enable => boolean().nullable()();
  TextColumn get faceRegistered => text().nullable()();
  TextColumn get employeeCode => text().nullable()(); // QR code

  @override
  Set<Column> get primaryKey => {id};
}
