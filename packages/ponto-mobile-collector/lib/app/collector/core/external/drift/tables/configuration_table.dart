import 'package:drift/drift.dart';

import 'employee_table.dart';

class ConfigurationTable extends Table {
  BoolColumn get onlyOnline => boolean().withDefault(const Constant(false))();
  TextColumn get operationMode => text()();
  TextColumn get timezone => text()();
  BoolColumn get takePhoto => boolean().withDefault(const Constant(false))();
  BoolColumn get allowChangeTime => boolean().nullable()();
  TextColumn get username => text().nullable()();
  TextColumn get employeeId => text().references(EmployeeTable, #id)();
  BoolColumn get faceRecognition => boolean().nullable()();
  BoolColumn get overnight => boolean().nullable()();
  BoolColumn get controlOvernight => boolean().nullable()();
  BoolColumn get gps => boolean().nullable()();
  BoolColumn get deviceAuthorizationType => boolean().nullable()();
  BoolColumn get allowDrivingTime => boolean().nullable()();
  BoolColumn get allowGpoOnApp => boolean().nullable()();
  BoolColumn get exportNotChecked => boolean().nullable()();
  TextColumn get insightOutOfBound => text().nullable()();
  BoolColumn get openExternalBrowser => boolean().nullable()();
  BoolColumn get allowUse => boolean().nullable()();
  BoolColumn get externalControlTimezone => boolean().nullable()();
  BoolColumn get nfcMode => boolean().nullable()();
  BoolColumn get takePhotoNfc => boolean().nullable()();
  BoolColumn get takePhotoSingle => boolean().nullable()();
  BoolColumn get takePhotoDriver => boolean().nullable()();
  BoolColumn get takePhotoQrcode => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {employeeId};
}
