import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/overnight_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/sync_overnight_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockOvernightRepository extends Mock implements IOvernightRepository {}

class MockOvernightImportService extends Mock
    implements OvernightImportService {}

class MockEnvironmentService extends Mock implements EnvironmentService {}

void main() {
  late IOvernightRepository mockOvernightRepository;
  late OvernightImportService mockOvernightImportService;
  late EnvironmentService mockEnvironmentService;
  late SyncOvernightUsecaseImpl syncOvernightUsecase;
  late OvernightEntity overnightEntity;

  setUp(
    () {
      mockOvernightRepository = MockOvernightRepository();
      mockOvernightImportService = MockOvernightImportService();
      mockEnvironmentService = MockEnvironmentService();

      syncOvernightUsecase = SyncOvernightUsecaseImpl(
        overnightRepository: mockOvernightRepository,
        overnightImportService: mockOvernightImportService,
        environmentService: mockEnvironmentService,
      );

      overnightEntity = OvernightEntity(
        id: 'overnightId',
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
    'should return true when synchronization is successful',
    () async {
      when(
        () => mockOvernightRepository.findNotSynchronized(),
      ).thenAnswer(
        (_) async => [
          overnightEntity,
        ],
      );

      when(
        () => mockOvernightImportService.call(
          overnightImportDtoList: any(named: 'overnightImportDtoList'),
          environment: EnvironmentEnum.mapToClock(
            EnvironmentEnum.test,
          ),
        ),
      ).thenAnswer(
        (_) async => OvernightImportOutputDto(
          overnights: [
            OvernightImportDto(
              id: overnightEntity.id,
              date: DateFormat('yyyy-MM-dd').format(overnightEntity.date),
              type: overnightEntity.type,
              employee: overnightEntity.employee,
              externalId: overnightEntity.id,
              geolocation: overnightEntity.geolocation,
              locationStatus: overnightEntity.locationStatus,
            ),
          ],
        ),
      );

      when(
        () => mockEnvironmentService.environment(),
      ).thenReturn(
        EnvironmentEnum.test,
      );

      when(
        () => mockOvernightRepository.save(
          overnightEntity: any(named: 'overnightEntity'),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      final result = await syncOvernightUsecase.call();

      expect(
        result,
        true,
      );
    },
  );

  test(
    'should return false when synchronization fails',
    () async {
      when(
        () => mockOvernightRepository.findNotSynchronized(),
      ).thenAnswer(
        (_) async => [
          overnightEntity,
        ],
      );

      when(
        () => mockOvernightImportService.call(
          overnightImportDtoList: any(named: 'overnightImportDtoList'),
          environment: EnvironmentEnum.mapToClock(
            EnvironmentEnum.test,
          ),
        ),
      ).thenThrow(
        Exception('Failed to synchronize'),
      );

      when(
        () => mockEnvironmentService.environment(),
      ).thenReturn(
        EnvironmentEnum.test,
      );

      final result = await syncOvernightUsecase.call();

      expect(
        result,
        false,
      );
    },
  );

  test(
    'should return false when not all overnights are synchronized',
    () async {
      when(
        () => mockOvernightRepository.findNotSynchronized(),
      ).thenAnswer(
        (_) async => [
          overnightEntity,
        ],
      );

      when(
        () => mockOvernightImportService.call(
          overnightImportDtoList: any(named: 'overnightImportDtoList'),
          environment: EnvironmentEnum.mapToClock(
            EnvironmentEnum.test,
          ),
        ),
      ).thenAnswer(
        (_) async => OvernightImportOutputDto(
          overnights: [],
        ),
      );

      when(
        () => mockEnvironmentService.environment(),
      ).thenReturn(
        EnvironmentEnum.test,
      );

      final result = await syncOvernightUsecase.call();

      expect(
        result,
        false,
      );
    },
  );
}
