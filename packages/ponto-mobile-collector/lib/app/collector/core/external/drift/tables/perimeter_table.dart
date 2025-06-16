import 'package:drift/drift.dart';

class PerimeterTable extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get radius => real()();
  DateTimeColumn get dateAndTime => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
