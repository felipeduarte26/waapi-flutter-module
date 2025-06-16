import 'package:drift/drift.dart';

class ManagerTable extends Table {
  TextColumn get id => text()();
  TextColumn get mail => text().nullable()();
  TextColumn get platformUserName => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
