import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/journey_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/ijourney_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/finish_journey_usecase.dart';

class MockJourneyRepository extends Mock implements IJourneyRepository {}

void main() {
  late IJourneyRepository mockJourneyRepository;
  late FinishJourneyUsecase finishJourneyUsecase;
  late JourneyEntity journeyEntity;

  setUp(
    () {
      mockJourneyRepository = MockJourneyRepository();

      finishJourneyUsecase = FinishJourneyUsecase(
        journeyRepository: mockJourneyRepository,
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
    'should finish journey successfully',
    () async {
      final dateTimeEvent = DateTime.now();

      when(
        () => mockJourneyRepository.findById(
          id: journeyEntity.id,
        ),
      ).thenAnswer(
        (_) async => journeyEntity,
      );

      when(
        () => mockJourneyRepository.save(
          journeyEntity: any(named: 'journeyEntity'),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      final result = await finishJourneyUsecase.call(
        journeyId: journeyEntity.id,
        dateTimeEvent: dateTimeEvent,
      );

      expect(
        result.endDate,
        dateTimeEvent,
      );
    },
  );

  test(
    'should throw exception if journey not found',
    () async {
      final dateTimeEvent = DateTime.now();

      when(
        () => mockJourneyRepository.findById(
          id: journeyEntity.id,
        ),
      ).thenAnswer(
        (_) async => null,
      );

      expect(
        () async => await finishJourneyUsecase.call(
          journeyId: journeyEntity.id,
          dateTimeEvent: dateTimeEvent,
        ),
        throwsException,
      );
    },
  );

  test(
    'should finish journey with overnightId',
    () async {
      final dateTimeEvent = DateTime.now();
      const overnightId = 'xyz';

      when(
        () => mockJourneyRepository.findById(
          id: journeyEntity.id,
        ),
      ).thenAnswer(
        (_) async => journeyEntity,
      );

      when(
        () => mockJourneyRepository.save(
          journeyEntity: any(named: 'journeyEntity'),
        ),
      ).thenAnswer(
        (_) async => true,
      );

      final result = await finishJourneyUsecase.call(
        journeyId: journeyEntity.id,
        dateTimeEvent: dateTimeEvent,
        overnightId: overnightId,
      );

      expect(
        result.endDate,
        dateTimeEvent,
      );

      expect(
        result.overnightId,
        overnightId,
      );
    },
  );
}
