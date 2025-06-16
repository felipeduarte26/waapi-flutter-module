import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/clocking_event_use.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/clocking_event_use_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/drift/collector_database.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/clocking_event_use_repository.dart';
import 'package:test/test.dart';

void main() {
  late CollectorDatabase database;
  late ClockingEventUseRepository repository;

  ClockingEventUse dto = const ClockingEventUse(
    employeeId: '1',
    description: 'Teste',
    code: '2',
    clockingEventUseType: ClockingEventUseType.clockingEvent,
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

      repository = ClockingEventUseRepositoryImpl(database: database);
    },
  );

  tearDown(
    () async {
      await database.close();
    },
  );

  group(
    'ClockingEventUseRepository',
    () {
      test('findAllByEmployeeId test', () async {
        await repository.save(clocking: dto, employeeId: '1');

        List<ClockingEventUse> response =
            await repository.findAllByEmployeeId(employeeId: '1');

        expect(dto.code, response.first.code);
        expect(dto.clockingEventUseType, response.first.clockingEventUseType);
      });

      test('exist test', () async {
        await repository.save(clocking: dto, employeeId: '1');

        var response = await repository.exist(
          employeeId: '1',
          clockingType: dto.clockingEventUseType.value,
        );

        expect(true, response);
      });

      test('update test', () async {
        await repository.save(clocking: dto, employeeId: '1');

        var value = await repository.update(clocking: dto, employeeId: '1');

        expect(true, value);
      });

      test('findByEmployeeIdAndClockingEventUseType should return DTO if found',
          () async {
        await repository.save(clocking: dto, employeeId: '1');

        final result = await repository.findByEmployeeIdAndClockingEventUseType(
          employeeId: '1',
          clockingEventUseType: ClockingEventUseType.clockingEvent,
        );

        expect(result!.employeeId, '1');
        expect(result.clockingEventUseType, ClockingEventUseType.clockingEvent);
      });

      test(
        'deleteByEmployeeIds test',
        () async {
          await repository.save(
            clocking: dto,
            employeeId: '1',
          );
          await repository.deleteByEmployeeIds(employeeIds: []);

          final clockingEventUses = await repository.findAllByEmployeeId(
            employeeId: '1',
          );

          expect(clockingEventUses, isNotEmpty);
        },
      );
    },
  );
}
