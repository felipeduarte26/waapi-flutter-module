import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/helper/database_helper.dart';

class MockCollectorDatabase extends Mock implements CollectorDatabase {}

void main() {
  late CollectorDatabase database;
  late IDatabaseHelper databaseHelper;

  LazyDatabase openConnection() => LazyDatabase(
        () async => NativeDatabase.memory(
          logStatements: false,
        ),
      );

  setUp(() {
    database = CollectorDatabase(
      database: openConnection(),
    );
    databaseHelper = DatabaseHelper(
      database: database,
    );
  });

  group(
    'DatabaseHelper',
    () {
      test(
        'should call transaction on the database',
        () async {
          await databaseHelper.transaction(
            transaction: () async {},
          );
        },
      );
    },
  );
}
