import 'package:drift/drift.dart';

class DeviceConfigurationTable extends Table {
  TextColumn get id => text()(); // Device Identifier
  BoolColumn get enableNfc => boolean()();
  BoolColumn get enableQrCode => boolean()();
  BoolColumn get enableFacial => boolean()();
  TextColumn get timeZone => text()();
  DateTimeColumn get lastUpdate => dateTime()();
  BoolColumn get takePhotoMulti => boolean()(); // Não utilizar, esse campo será substituido pelo takePhotoMulti na tabela de configuração.
  DateTimeColumn get lastSync => dateTime()();
  BoolColumn get enableUserPassword => boolean().nullable()();
  BoolColumn get allowChangeTime => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
