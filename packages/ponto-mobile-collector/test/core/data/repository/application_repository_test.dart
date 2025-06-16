import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../mocks/application_dto_mock.dart';

void main() {
  late CollectorDatabase database;

  LazyDatabase openConnection() {
    return LazyDatabase(() async {
      return NativeDatabase.memory(logStatements: false);
    });
  }

  setUp(
    () {
      database = CollectorDatabase(
        database: openConnection(),
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  test(
    'ApplicationRepository test.',
    () async {
      IApplicationRepository repository = ApplicationRepository(
        database: database,
      );

      bool isEmpty = (await repository.getAll()).isEmpty;
      bool successSave = await repository.save(application: applicationDtoMock);
      bool successUpdate =
          await repository.save(application: applicationDtoMock);
      int totalApplications = (await repository.getAll()).length;

      clock.ApplicationDto applicationFindByTenantName =
          (await repository.findByTenantName(
        tenantName: applicationDtoMock.tenantName,
      ))!;

      expect(isEmpty, true);
      expect(successSave, true);
      expect(successUpdate, true);
      expect(totalApplications, 1);
      expect(
        applicationFindByTenantName.tenantName,
        applicationDtoMock.tenantName,
      );
      expect(
        applicationFindByTenantName.accessKey,
        applicationDtoMock.accessKey,
      );
      expect(
        applicationFindByTenantName.secret,
        applicationDtoMock.secret,
      );
      expect(
        applicationFindByTenantName.lastUpdate,
        applicationDtoMock.lastUpdate,
      );
    },
  );
}
