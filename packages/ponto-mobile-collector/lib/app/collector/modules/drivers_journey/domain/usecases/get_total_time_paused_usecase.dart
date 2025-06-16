import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/infra/utils/iutils.dart';
import 'get_mandatory_break_usecase.dart';
import 'get_meal_time_usecase.dart';

abstract class GetTotalTimePausedUsecase {
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  });
}

class GetTotalTimePausedUsecaseImpl implements GetTotalTimePausedUsecase {
  final GetMandatoryBreakUsecase _getMandatoryBreakUsecase;
  final GetMealTimeUsecase _getMealTimeUsecase;
  final IUtils _utils;
  GetTotalTimePausedUsecaseImpl({
    required GetMandatoryBreakUsecase getMandatoryBreakUsecase,
    required GetMealTimeUsecase getMealTimeUsecase,
    required IUtils utils,
  })  : _getMandatoryBreakUsecase = getMandatoryBreakUsecase,
        _getMealTimeUsecase = getMealTimeUsecase,
        _utils = utils;

  @override
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  }) async {
    int breaks = 0;
    DateTime getMandatoryBreak =
        await _getMandatoryBreakUsecase.call(clockingEvents: clockingEvents);
    int mandatoryBreak = _utils.convertDateTimeToMinutes(getMandatoryBreak);

    DateTime getMealTime =
        await _getMealTimeUsecase.call(clockingEvents: clockingEvents);
    int meal = _utils.convertDateTimeToMinutes(getMealTime);

    breaks += mandatoryBreak;
    breaks += meal;

    int hours = breaks ~/ 60;
    int minutes = breaks % 60;

    return DateTime(0, 0, 0, hours, minutes);
  }
}
