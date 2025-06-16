import 'package:drift/drift.dart';

class ApplicationTable extends Table {
  TextColumn get tenantName => text()();
  TextColumn get accessKey => text()();
  TextColumn get secret => text()();
  DateTimeColumn get lastUpdate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {tenantName};
}
