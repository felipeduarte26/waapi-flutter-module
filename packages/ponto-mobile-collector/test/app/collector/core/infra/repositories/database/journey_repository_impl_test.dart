// ignore_for_file: unused_local_variable

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/journey_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/ijourney_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/journey_repository.dart';

import '../../../../../../mocks/global_configuration_table_data_mock.dart';

void main() {
  var journeyEntity = JourneyEntity(
    id: 'c61f4b00-aaaa-48fa-b2dc-1e42f6a8fec8',
    employeeId: '591c3f16-864b-468b-aeb2-b6e133810d0f',
    journeyNumber: 1,
    startDate: DateTime(2024, 8, 27, 8, 0, 2),
    endDate: DateTime(2024, 8, 27, 12, 30, 2),
    overnightId: '1ffb441b-5c6b-4e70-8228-989c514afa03',
  );

  late CollectorDatabase database;
  late IJourneyRepository repository;

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
      repository = JourneyRepository(
        database: database,
      );
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group('JourneyRepository', () {
    test('testes de inser, save, update, findAll and findById test', () async {
      repository = JourneyRepository(
        database: database,
      );

      bool isEmpty = (await repository.getAll()).isEmpty;

      await database
          .into(database.globalConfigurationTable)
          .insert(globalConfigurationTableDataMock);

      bool successSave = await repository.save(journeyEntity: journeyEntity);

      journeyEntity = journeyEntity.copyWith(journeyNumber: 2);

      bool successUpdate = await repository.update(
        journeyEntity: journeyEntity,
      );

      int totalJourney = (await repository.getAll()).length;

      JourneyEntity? journeyFindById =
          (await repository.findById(id: journeyEntity.id))!;

      JourneyEntity? journeyFindByJourneyNumber = (await repository
          .findByJourneyNumber(journeyNumber: journeyEntity.journeyNumber))!;

      expect(isEmpty, true);
      expect(successSave, true);
      expect(successUpdate, true);
      expect(totalJourney, 1);
      expect(journeyEntity.id, journeyFindById.id);

      expect(
        journeyEntity.journeyNumber,
        journeyFindByJourneyNumber.journeyNumber,
      );
    });
  });

  group('JourneyRepository - findLastJourney', () {
    test('should return the only journey when there is one', () async {
      final journey = JourneyEntity(
        id: '1',
        employeeId: 'emp1',
        journeyNumber: 1,
        startDate: DateTime(2024, 8, 27, 8, 0, 2),
        endDate: DateTime(2024, 8, 27, 12, 30, 2),
        overnightId: 'ov1',
      );

      await repository.save(journeyEntity: journey);

      final lastJourney = await repository.findLastJourney();

      expect(lastJourney?.id, equals(journey.id));
    });

    test('should return the last journey when multiple journeys exist',
        () async {
      final journey1 = JourneyEntity(
        id: '1',
        employeeId: 'emp1',
        journeyNumber: 1,
        startDate: DateTime(2024, 8, 27, 8, 0, 2),
        endDate: DateTime(2024, 8, 27, 12, 30, 2),
        overnightId: 'ov1',
      );

      final journey2 = JourneyEntity(
        id: '2',
        employeeId: 'emp2',
        journeyNumber: 2,
        startDate: DateTime(2024, 8, 28, 8, 0, 2),
        endDate: DateTime(2024, 8, 28, 18, 30, 2), // Maior endDate
        overnightId: 'ov2',
      );

      await repository.save(journeyEntity: journey1);
      await repository.save(journeyEntity: journey2);

      final lastJourney = await repository.findLastJourney();

      expect(lastJourney?.id, equals(journey2.id));
      expect(lastJourney?.endDate!.toLocal(), equals(journey2.endDate));
    });
  });

  test(
    'deleteByEmployeeIds test',
    () async {
      await repository.save(journeyEntity: journeyEntity);
      await repository.deleteByEmployeeIds(employeeIds: []);

      final journeys = await repository.getAll();

      expect(journeys, isNotEmpty);
    },
  );
}
