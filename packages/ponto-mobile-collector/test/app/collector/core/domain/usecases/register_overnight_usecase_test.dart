import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/overnight_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iovernight_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/register_overnight_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_overnight_usecase.dart';

class MockOvernightRepository extends Mock implements IOvernightRepository {}

class MockSyncOvernightUsecase extends Mock implements SyncOvernightUsecase {}

void main() {
  late IOvernightRepository mockOvernightRepository;
  late SyncOvernightUsecase mockSyncOvernightUsecase;
  late RegisterOvernightUsecase registerOvernightUsecase;
  late OvernightEntity overnightEntity;

  setUp(
    () {
      mockOvernightRepository = MockOvernightRepository();
      mockSyncOvernightUsecase = MockSyncOvernightUsecase();

      registerOvernightUsecase = RegisterOvernightUsecase(
        overnightRepository: mockOvernightRepository,
        syncOvernightUsecase: mockSyncOvernightUsecase,
      );

      overnightEntity = OvernightEntity(
        id: 'uuid',
        date: DateTime.now(),
        locationStatus: LocationStatusEnum.location,
        geolocation: LocationDTO(
          dateAndTime: DateTime.now(),
          latitude: 0.0,
          longitude: 0.0,
        ),
        employee: EmployeeDto(
          id: 'employeeId',
          name: '',
          employeeType: '',
          cpf: '',
        ),
        type: 'SYSTEM',
        synchronized: false,
      );

      registerFallbackValue(
        overnightEntity,
      );
    },
  );

  test(
    'should register overnight event successfully',
    () async {
      when(
        () => mockOvernightRepository.save(
          overnightEntity: any(named: 'overnightEntity'),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => mockOvernightRepository.findById(
          id: any(named: 'id'),
        ),
      ).thenAnswer(
        (_) async => overnightEntity,
      );

      when(
        () => mockSyncOvernightUsecase.call(),
      ).thenAnswer(
        (_) async => true,
      );

      final result = await registerOvernightUsecase.call(
        dateTimeEvent: overnightEntity.date,
        manual: false,
        employeeId: overnightEntity.employee.id,
        locationDTO: overnightEntity.geolocation,
        locationStatus: overnightEntity.locationStatus,
      );

      expect(
        result,
        equals(overnightEntity),
      );
    },
  );

  test(
    'should handle missing locationDTO',
    () async {
      final overnightEntity = OvernightEntity(
        id: 'uuid',
        date: DateTime.now(),
        locationStatus: LocationStatusEnum.noLocation,
        employee: EmployeeDto(
          id: 'employeeId',
          name: '',
          employeeType: '',
          cpf: '',
        ),
        type: 'SYSTEM',
        synchronized: false,
      );

      when(
        () => mockOvernightRepository.save(
          overnightEntity: any(named: 'overnightEntity'),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => mockOvernightRepository.findById(
          id: any(named: 'id'),
        ),
      ).thenAnswer(
        (_) async => overnightEntity,
      );

      when(
        () => mockSyncOvernightUsecase.call(),
      ).thenAnswer(
        (_) async => true,
      );

      final result = await registerOvernightUsecase.call(
        dateTimeEvent: overnightEntity.date,
        manual: false,
        employeeId: overnightEntity.employee.id,
      );

      expect(
        result,
        equals(overnightEntity),
      );
    },
  );

  test(
    'should handle manual event type',
    () async {
      final overnightEntity = OvernightEntity(
        id: 'uuid',
        date: DateTime.now(),
        locationStatus: LocationStatusEnum.location,
        geolocation: LocationDTO(
          dateAndTime: DateTime.now(),
          latitude: 0.0,
          longitude: 0.0,
        ),
        employee: EmployeeDto(
          id: 'employeeId',
          name: '',
          employeeType: '',
          cpf: '',
        ),
        type: 'MANUAL',
        synchronized: false,
      );

      when(
        () => mockOvernightRepository.save(
          overnightEntity: any(named: 'overnightEntity'),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => mockOvernightRepository.findById(
          id: any(named: 'id'),
        ),
      ).thenAnswer(
        (_) async => overnightEntity,
      );

      when(
        () => mockSyncOvernightUsecase.call(),
      ).thenAnswer(
        (_) async => true,
      );

      final result = await registerOvernightUsecase.call(
        dateTimeEvent: overnightEntity.date,
        manual: true,
        employeeId: overnightEntity.employee.id,
        locationDTO: overnightEntity.geolocation,
        locationStatus: overnightEntity.locationStatus,
      );

      expect(
        result,
        equals(overnightEntity),
      );
    },
  );
}
