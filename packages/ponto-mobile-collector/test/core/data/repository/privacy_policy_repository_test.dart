import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/privacy_policy_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/privacy_policy_repository_impl.dart';

void main() {
  late PrivacyPolicyRepositoryImpl repository;
  late CollectorDatabase database;

  PrivacyPolicyEntity privacyPolicy = PrivacyPolicyEntity(
    version: 1,
    urlVersion: 'urlVersion',
    dateTimeEventCreated: DateTime.now(),
  );

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      database = CollectorDatabase(
        database: openConnection(),
      );

      repository = PrivacyPolicyRepositoryImpl(
        database: database,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('ManagerRepository', () {
    test('findById test', () async {
      await repository.save(
        privacyPolicy: privacyPolicy,
      );

      PrivacyPolicyEntity? privacyPolicyReturn =
          await repository.findByVersion(version: privacyPolicy.version);

      expect(privacyPolicy.version, privacyPolicyReturn!.version);
      expect(privacyPolicy.urlVersion, privacyPolicyReturn.urlVersion);
    });

  

    test('exist test', () async {
     await repository.save(
        privacyPolicy: privacyPolicy,
      );

      var privacyPolicyDtoOut =
          await repository.exist(version: privacyPolicy.version);

      expect(true, privacyPolicyDtoOut);
    });

       test('update test', () async {
         await repository.save(
        privacyPolicy: privacyPolicy,
      );

      var managerEmployeeDtoOut = await repository.update(privacyPolicy: privacyPolicy);

      expect(true, managerEmployeeDtoOut);
    });
  });
}
