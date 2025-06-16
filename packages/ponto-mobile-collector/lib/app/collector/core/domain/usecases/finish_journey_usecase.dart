import '../../../../../ponto_mobile_collector.dart';
import '../entities/journey_entity.dart';

abstract class IFinishJourneyUsecase {
  Future<JourneyEntity> call({
    required String journeyId,
    required DateTime dateTimeEvent,
    String? overnightId,
  });
}

class FinishJourneyUsecase implements IFinishJourneyUsecase {
  final IJourneyRepository _journeyRepository;

  FinishJourneyUsecase({
    required IJourneyRepository journeyRepository,
  }) : _journeyRepository = journeyRepository;

  @override
  Future<JourneyEntity> call({
    required String journeyId,
    required DateTime dateTimeEvent,
    String? overnightId,
  }) async {
    final journeyEntity = await _journeyRepository.findById(
      id: journeyId,
    );

    if (journeyEntity == null) {
      throw Exception('No journey found with id $journeyId');
    }

    final updatedJourneyEntity = journeyEntity.copyWith(
      endDate: dateTimeEvent,
      overnightId: overnightId,
    );

    await _journeyRepository.save(
      journeyEntity: updatedJourneyEntity,
    );

    return updatedJourneyEntity;
  }
}
