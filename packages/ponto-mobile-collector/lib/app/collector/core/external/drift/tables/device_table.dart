import 'package:drift/drift.dart';

class DeviceTable extends Table {
  TextColumn get id => text()();

  TextColumn get imei => text()();
  TextColumn get name => text().nullable()();
  TextColumn get model => text().nullable()();
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}
