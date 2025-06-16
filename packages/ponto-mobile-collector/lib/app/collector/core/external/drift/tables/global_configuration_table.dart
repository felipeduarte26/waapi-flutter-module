import 'package:drift/drift.dart';

class GlobalConfigurationTable extends Table {
  TextColumn get id => text()();
  BoolColumn get gps => boolean().nullable()();
  BoolColumn get online => boolean().nullable()();
  TextColumn get timeout => text().nullable()();
  TextColumn get operationMode => text().nullable()();
  BoolColumn get nfcMode => boolean().nullable()();
  BoolColumn get allowChangeTime => boolean().nullable()();
  TextColumn get timezone => text().nullable()();
  TextColumn get deviceAuthModeSingleMode => text().nullable()();
  TextColumn get deviceAuthModeMultiMode => text().nullable()();
  TextColumn get deviceAuthModeDriverMode => text().nullable()();
  BoolColumn get allowDrivingTime => boolean().nullable()();
  BoolColumn get overnight => boolean().nullable()();
  BoolColumn get controlOvernight => boolean().nullable()();
  BoolColumn get allowGpoOnApp => boolean().nullable()();
  BoolColumn get exportNotChecked => boolean().nullable()();
  TextColumn get insightOutOfBound => text().nullable()();
  BoolColumn get takePhotoSingle => boolean().nullable()();
  BoolColumn get takePhotoMulti => boolean().nullable()();
  BoolColumn get takePhotoDriver => boolean().nullable()();
  BoolColumn get takePhotoQrcode => boolean().nullable()();
  BoolColumn get takePhotoNfc => boolean().nullable()();
  BoolColumn get openExternalBrowser => boolean().nullable()();
  TextColumn get clockingEventUses => text().nullable()();
  BoolColumn get allowUse => boolean().nullable()();
  BoolColumn get externalControlTimezone =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get faceRecognition =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
