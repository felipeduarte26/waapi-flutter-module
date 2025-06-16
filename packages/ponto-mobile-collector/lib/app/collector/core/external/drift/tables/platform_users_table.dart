import 'package:drift/drift.dart';

class PlatformUsersTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  
  @override
  Set<Column> get primaryKey => {id};
}
