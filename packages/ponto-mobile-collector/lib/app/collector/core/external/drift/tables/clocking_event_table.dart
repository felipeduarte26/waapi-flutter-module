import 'package:drift/drift.dart';

import 'journey_table.dart';

class ClockingEventTable extends Table {
  /// Locally generated identifier
  TextColumn get clockingEventId => text()();

  DateTimeColumn get dateTimeEvent => dateTime()();
  TextColumn get dateEvent => text()();
  TextColumn get timeEvent => text()();
  TextColumn get timeZone => text()();
  TextColumn get companyIdentifier => text()();
  TextColumn get pis => text().nullable()();
  TextColumn get cpf => text()();
  TextColumn get appVersion => text()();
  TextColumn get platform => text()();

  TextColumn get identifierDevice => text().nullable()();
  TextColumn get nameDevice => text().nullable()();
  TextColumn get developerModeDevice => text().nullable()();
  TextColumn get gpsOperationModeDevice => text().nullable()();
  BoolColumn get dateTimeAutomaticDevice => boolean().nullable()();
  BoolColumn get timeZoneAutomaticDevice => boolean().nullable()();

  RealColumn get latitudeLocation => real().nullable()();
  RealColumn get longitudeLocation => real().nullable()();
  BoolColumn get geolocationIsMock => boolean()();
  DateTimeColumn get dateAndTimeLocation => dateTime().nullable()();

  TextColumn get employeeId => text()();
  TextColumn get fenceState => text().nullable()();
  IntColumn get use => integer()();
  TextColumn get mode => text()();
  BoolColumn get online => boolean().withDefault(const Constant(false))();
  TextColumn get origin => text()();
  TextColumn get signature => text()();
  IntColumn get signatureVersion => integer()();
  TextColumn get clientOriginInfo => text().nullable()();
  TextColumn get appointmentImage => text().nullable()();
  TextColumn get photoNotCaptured => text().nullable()();
  TextColumn get locationStatus => text().nullable()();
  BoolColumn get isSynchronized => boolean()();

  TextColumn get journeyId => text().nullable().references(JourneyTable, #id)();
  BoolColumn get isMealBreak => boolean().withDefault(const Constant(false))();
  TextColumn get journeyEventName => text().nullable()();
  TextColumn get employeeName =>
      text().withDefault(const Constant('defaultValue'))();
  TextColumn get companyName =>
      text().withDefault(const Constant('defaultValue'))();
  TextColumn get facialRecognitionStatus => text().nullable()();

  @override
  Set<Column> get primaryKey => {clockingEventId};
}
