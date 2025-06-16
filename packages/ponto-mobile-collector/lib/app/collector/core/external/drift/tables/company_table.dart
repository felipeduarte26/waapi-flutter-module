import 'package:drift/drift.dart';

class CompanyTable extends Table {
  TextColumn get id => text()();
  TextColumn get identifier => text()();
  TextColumn get name => text()();
  TextColumn get timeZone => text()();
  TextColumn get arpId => text().nullable()();
  TextColumn get caepf => text().nullable()();
  TextColumn get cnoNumber => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
