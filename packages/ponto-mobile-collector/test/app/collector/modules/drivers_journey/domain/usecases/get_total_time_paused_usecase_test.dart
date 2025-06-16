import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_mandatory_break_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_meal_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/drivers_journey/domain/usecases/get_total_time_paused_usecase.dart';

class MockGetMandatoryBreakUsecase extends Mock
    implements GetMandatoryBreakUsecase {}

class MockGetMealTimeUsecase extends Mock implements GetMealTimeUsecase {}

class MockIUtils extends Mock implements IUtils {}

void main() {
  late MockGetMandatoryBreakUsecase mockGetMandatoryBreakUsecase;
  late MockGetMealTimeUsecase mockGetMealTimeUsecase;
  late MockIUtils mockIUtils;
  late GetTotalTimePausedUsecaseImpl usecase;

  setUp(() {
    mockGetMandatoryBreakUsecase = MockGetMandatoryBreakUsecase();
    mockGetMealTimeUsecase = MockGetMealTimeUsecase();
    mockIUtils = MockIUtils();
    usecase = GetTotalTimePausedUsecaseImpl(
      getMandatoryBreakUsecase: mockGetMandatoryBreakUsecase,
      getMealTimeUsecase: mockGetMealTimeUsecase,
      utils: mockIUtils,
    );
  });

  test('should return total paused time correctly', () async {
    final clockingEvents = <ClockingEventDto>[];
    final mandatoryBreakTime = DateTime(0, 0, 0, 1, 30); // 1 hour 30 minutes
    final mealTime = DateTime(0, 0, 0, 0, 45); // 45 minutes

    when(
      () => mockGetMandatoryBreakUsecase.call(clockingEvents: clockingEvents),
    ).thenAnswer((_) => Future.value(mandatoryBreakTime));
    when(() => mockGetMealTimeUsecase.call(clockingEvents: clockingEvents))
        .thenAnswer((_) => Future.value(mealTime));
        
    when(() => mockIUtils.convertDateTimeToMinutes(mandatoryBreakTime))
        .thenReturn(90); // 1 hour 30 minutes = 90 minutes
    when(() => mockIUtils.convertDateTimeToMinutes(mealTime))
        .thenReturn(45); // 45 minutes

    final result = await usecase.call(clockingEvents: clockingEvents);

    expect(result, DateTime(0, 0, 0, 2, 15)); // 2 hours 15 minutes
  });
}
