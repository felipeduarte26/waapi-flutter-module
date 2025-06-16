import 'package:drift/drift.dart';

class PrivacyPolicyTable extends Table {

  DateTimeColumn get dateTimeCreated => dateTime().nullable()();
  DateTimeColumn get dateTimeEventRead => dateTime().nullable()();
  IntColumn get version => integer()();
  TextColumn get urlVersion => text()();

  @override
  Set<Column> get primaryKey => {version};
}
