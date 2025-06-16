import '../../../../core/domain/entities/journey_entity.dart';
import '../../../../core/infra/repositories/database/journey_repository.dart';
import '../../../clocking_event/domain/usecase/get_clock_time_usecase.dart';

abstract class GetTotalTimeSinceLastJourneyUseCase {
  Future<Duration?> call();
}

class GetTotalTimeSinceLastJourneyUseCaseImpl
    implements GetTotalTimeSinceLastJourneyUseCase {
  final JourneyRepository _journeyRepository;
  final GetClockDateTimeUsecase _getClockDateTimeUsecase;  

  GetTotalTimeSinceLastJourneyUseCaseImpl({
    required JourneyRepository journeyRepository,
    required GetClockDateTimeUsecase getClockDateTimeUsecase,
  }) : _journeyRepository = journeyRepository,
       _getClockDateTimeUsecase = getClockDateTimeUsecase;

@override
Future<Duration?> call() async {
  JourneyEntity? lastJourney = await _journeyRepository.findLastJourney();
  if (lastJourney != null && lastJourney.endDate != null) {
    DateTime currentDate = _getClockDateTimeUsecase.call();
    
    Duration difference = currentDate.difference(lastJourney.endDate!);

    return difference;
  }
  return null;
}
}
