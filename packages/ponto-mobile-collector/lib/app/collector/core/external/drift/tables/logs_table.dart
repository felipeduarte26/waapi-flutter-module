import 'package:drift/drift.dart';

class LogsTable extends Table {
  TextColumn get id => text()();
  TextColumn get createdAt => text().nullable()();
  TextColumn get deviceId => text()();
  TextColumn get userPlatform => text().nullable()();
  TextColumn get employeeId => text().nullable()();
  TextColumn get employeeExternalId => text().nullable()();
  TextColumn get log => text()();
  @override
  Set<Column> get primaryKey => {id};
}
