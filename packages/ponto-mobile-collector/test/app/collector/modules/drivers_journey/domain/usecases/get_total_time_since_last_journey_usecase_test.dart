import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/repositories/database/journey_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_total_time_since_last_journey_usecase.dart';

import '../../../../../../mocks/journey_mock.dart';

class MockJourneyRepository extends Mock implements JourneyRepository {}

class MockGetClockDateTimeUsecase extends Mock
    implements GetClockDateTimeUsecase {}

void main() {
  late JourneyRepository mockJourneyRepository;
  late GetTotalTimeSinceLastJourneyUseCase usecase;
  late GetClockDateTimeUsecase mockGetClockDateTimeUsecase;

  setUp(() {
    mockJourneyRepository = MockJourneyRepository();
    mockGetClockDateTimeUsecase = MockGetClockDateTimeUsecase();
    usecase = GetTotalTimeSinceLastJourneyUseCaseImpl(
      journeyRepository: mockJourneyRepository,
      getClockDateTimeUsecase: mockGetClockDateTimeUsecase,
    );
  });

  test('should return total time since last Journey', () async {
    var currentDate = DateTime.now().add(const Duration(days: 2));

    when(
      () => mockJourneyRepository.findLastJourney(),
    ).thenAnswer((_) async => journeyMock);

    when(
      () => mockGetClockDateTimeUsecase.call(),
    ).thenReturn(currentDate);

    final result = await usecase.call();

    expect(
      result!.inHours,
      getExpectedDuration(currentDate: currentDate).inHours,
    );
    expect(
      result.inMinutes,
      getExpectedDuration(currentDate: currentDate).inMinutes,
    );
  });
}

Duration getExpectedDuration({required DateTime currentDate}) {
  // Calcula a diferença
  Duration difference = currentDate.difference(journeyMock.endDate!);

  return difference;
}
