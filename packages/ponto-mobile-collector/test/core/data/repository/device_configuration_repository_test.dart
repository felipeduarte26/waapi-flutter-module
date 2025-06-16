import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/device_configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/i_device_configuration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/device_configuration_repository.dart';

void main() {
  late CollectorDatabase database;
  late IDeviceConfigurationRepository repository;

  LazyDatabase openConnection() {
    return LazyDatabase(
      () async {
        return NativeDatabase.memory(logStatements: false);
      },
    );
  }

  setUp(
    () {
      database = CollectorDatabase(database: openConnection());
      repository = DeviceConfigurationRepository(database);
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('save', () {
    test('Should save a configuration in database', () async {
      final now = DateTime.now();
      const tId = 'my-id';
      const tEnableNfc = false;
      const tEnableQrCode = false;
      const tEnableFacial = false;
      const tEnableUserAndPassword = false;
      const tAllowChangetime = false;
      final tTimeZone = now.timeZoneName;
      final tLastUpdate = now;
      final tLastSync = now;

      final tConfiguration = DeviceConfiguration(
        id: tId,
        enableNfc: tEnableNfc,
        enableQrCode: tEnableQrCode,
        enableFacial: tEnableFacial,
        enableUserPassword: tEnableUserAndPassword,
        allowChangeTime: tAllowChangetime,
        timeZone: tTimeZone,
        lastUpdate: tLastUpdate,
        lastSync: tLastSync,
      );

      final result = await repository.save(configuration: tConfiguration);

      expect(result, true);
    });

    test('Should update a configuration in database if the id exists',
        () async {
      final now = DateTime.now();
      final newDate = now.add(const Duration(days: 5));

      const tId = 'my-id';
      const tEnableNfc = false;
      const tEnableQrCode = false;
      const tEnableFacial = false;
      const tEnableUserAndPassword = false;
      const tAllowChangetime = false;
      final tTimeZone = now.timeZoneName;
      final tLastUpdate = now;
      final tLastSync = now;

      final tConfiguration = DeviceConfiguration(
        id: tId,
        enableNfc: tEnableNfc,
        enableQrCode: tEnableQrCode,
        enableFacial: tEnableFacial,
        enableUserPassword: tEnableUserAndPassword,
        allowChangeTime: tAllowChangetime,
        timeZone: tTimeZone,
        lastUpdate: tLastUpdate,
        lastSync: tLastSync,
      );
      final tUpdatedConfiguration = DeviceConfiguration(
        id: tId,
        enableNfc: tEnableNfc,
        enableQrCode: tEnableQrCode,
        enableFacial: tEnableFacial,
        enableUserPassword: tEnableUserAndPassword,
        allowChangeTime: tAllowChangetime,
        timeZone: tTimeZone,
        lastUpdate: newDate,
        lastSync: newDate,
      );

      await repository.save(configuration: tConfiguration);
      final result =
          await repository.save(configuration: tUpdatedConfiguration);

      expect(result, true);
    });
  });

  test('Should insert a configuration in database', () async {
    final now = DateTime.now();
    const tId = 'my-id';
    const tEnableNfc = false;
    const tEnableQrCode = false;
    const tEnableFacial = false;
    const tEnableUserAndPassword = false;
    const tAllowChangetime = false;
    final tTimeZone = now.timeZoneName;
    final tLastUpdate = now;
    final tLastSync = now;

    final tConfiguration = DeviceConfiguration(
      id: tId,
      enableNfc: tEnableNfc,
      enableQrCode: tEnableQrCode,
      enableFacial: tEnableFacial,
      enableUserPassword: tEnableUserAndPassword,
      allowChangeTime: tAllowChangetime,
      timeZone: tTimeZone,
      lastUpdate: tLastUpdate,
      lastSync: tLastSync,
    );

    final result = await repository.insert(configuration: tConfiguration);

    expect(result, 1);
  });

  test('Should update a configuration in database', () async {
    final now = DateTime.now();
    final newDate = now.add(const Duration(days: 5));

    const tId = 'my-id';
    const tEnableNfc = false;
    const tEnableQrCode = false;
    const tEnableFacial = false;
    const tEnableUserAndPassword = false;
    const tAllowChangetime = false;
    final tTimeZone = now.timeZoneName;
    final tLastUpdate = now;
    final tLastSync = now;

    final tConfiguration = DeviceConfiguration(
      id: tId,
      enableNfc: tEnableNfc,
      enableQrCode: tEnableQrCode,
      enableFacial: tEnableFacial,
      enableUserPassword: tEnableUserAndPassword,
      allowChangeTime: tAllowChangetime,
      timeZone: tTimeZone,
      lastUpdate: tLastUpdate,
      lastSync: tLastSync,
    );

    final tUpdatedConfiguration = DeviceConfiguration(
      id: tId,
      enableNfc: tEnableNfc,
      enableQrCode: tEnableQrCode,
      enableFacial: tEnableFacial,
      enableUserPassword: tEnableUserAndPassword,
      allowChangeTime: tAllowChangetime,
      timeZone: tTimeZone,
      lastUpdate: newDate,
      lastSync: newDate,
    );

    await repository.insert(configuration: tConfiguration);
    final result =
        await repository.update(configuration: tUpdatedConfiguration);

    expect(result, true);
  });

  test('Should verify if a configuration exists in database', () async {
    final now = DateTime.now();

    const tId = 'my-id';
    const tEnableNfc = false;
    const tEnableQrCode = false;
    const tEnableFacial = false;
    const tEnableUserAndPassword = false;
    const tAllowChangetime = false;
    final tTimeZone = now.timeZoneName;
    final tLastUpdate = now;
    final tLastSync = now;

    final tConfiguration = DeviceConfiguration(
      id: tId,
      enableNfc: tEnableNfc,
      enableQrCode: tEnableQrCode,
      enableFacial: tEnableFacial,
      enableUserPassword: tEnableUserAndPassword,
      allowChangeTime: tAllowChangetime,
      timeZone: tTimeZone,
      lastUpdate: tLastUpdate,
      lastSync: tLastSync,
    );

    await repository.insert(configuration: tConfiguration);
    final result = await repository.exist(id: tId);

    expect(result, true);
  });

  test('Should find a configuration by its identifier in database', () async {
    final now = DateTime.now();

    const tId = 'my-id';
    const tEnableNfc = false;
    const tEnableQrCode = false;
    const tEnableFacial = false;
    const tEnableUserAndPassword = false;
    const tAllowChangetime = false;
    final tTimeZone = now.timeZoneName;
    final tLastUpdate = now;
    final tLastSync = now;

    final tConfiguration = DeviceConfiguration(
      id: tId,
      enableNfc: tEnableNfc,
      enableQrCode: tEnableQrCode,
      enableFacial: tEnableFacial,
      enableUserPassword: tEnableUserAndPassword,
      allowChangeTime: tAllowChangetime,
      timeZone: tTimeZone,
      lastUpdate: tLastUpdate,
      lastSync: tLastSync,
    );

    await repository.insert(configuration: tConfiguration);
    final result = await repository.findByIdentifier(identifier: tId);

    expect(result != null, true);
    expect(result!.id, tId);
    expect(result.enableNfc, tEnableNfc);
    expect(result.enableQrCode, tEnableQrCode);
    expect(result.enableFacial, tEnableFacial);
  });
}
