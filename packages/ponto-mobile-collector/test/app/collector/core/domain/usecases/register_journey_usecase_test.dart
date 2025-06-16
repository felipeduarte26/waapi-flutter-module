import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/journey_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/ijourney_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/session/isession_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/register_journey_usecase.dart';

class MockJourneyRepository extends Mock implements IJourneyRepository {}

class MockSessionService extends Mock implements ISessionService {}

void main() {
  late RegisterJourneyUsecase registerJourneyUsecase;
  late IJourneyRepository mockJourneyRepository;
  late ISessionService mockSessionService;
  late JourneyEntity journeyEntity;

  setUp(
    () {
      mockJourneyRepository = MockJourneyRepository();
      mockSessionService = MockSessionService();

      registerJourneyUsecase = RegisterJourneyUsecase(
        journeyRepository: mockJourneyRepository,
        sessionService: mockSessionService,
      );

      journeyEntity = JourneyEntity(
        id: '123',
        startDate: DateTime.now(),
        employeeId: 'abc',
      );

      registerFallbackValue(
        journeyEntity,
      );
    },
  );

  test(
    'should register a journey and return the saved journey entity',
    () async {
      final dateTimeEvent = DateTime.now();

      when(
        () => mockSessionService.getEmployeeId(),
      ).thenReturn(
        journeyEntity.employeeId,
      );

      when(
        () => mockJourneyRepository.save(
          journeyEntity: any(named: 'journeyEntity'),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      when(
        () => mockJourneyRepository.findById(
          id: any(named: 'id'),
        ),
      ).thenAnswer(
        (_) async => journeyEntity,
      );

      final result = await registerJourneyUsecase.call(
        dateTimeEvent: dateTimeEvent,
      );

      expect(
        result,
        journeyEntity,
      );
    },
  );

  test(
    'should throw an exception if saving the journey fails',
    () async {
      final dateTimeEvent = DateTime.now();

      when(
        () => mockSessionService.getEmployeeId(),
      ).thenReturn(
        journeyEntity.employeeId,
      );

      when(
        () => mockJourneyRepository.save(
          journeyEntity: any(named: 'journeyEntity'),
        ),
      ).thenThrow(
        Exception('Failed to save'),
      );

      expect(
        () async => await registerJourneyUsecase.call(
          dateTimeEvent: dateTimeEvent,
        ),
        throwsException,
      );
    },
  );
}
