import '../../../../core/domain/enums/clocking_event_use_enum.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/infra/utils/iutils.dart';
import 'get_mandatory_break_usecase.dart';
import 'get_meal_time_usecase.dart';

abstract class GetTotalHoursInJourneyUsecase {
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  });
}

class GetTotalHoursInJourneyUsecaseImpl
    implements GetTotalHoursInJourneyUsecase {
  final GetMealTimeUsecase _getMealTimeUsecase;
  final GetMandatoryBreakUsecase _getMandatoryBreakUsecase;
  final IUtils _utils;

  GetTotalHoursInJourneyUsecaseImpl({
    required IUtils utils,
    required GetMealTimeUsecase getMealTimeUsecase,
    required GetMandatoryBreakUsecase getMandatoryBreakUsecase,
  })  : _getMealTimeUsecase = getMealTimeUsecase,
        _getMandatoryBreakUsecase = getMandatoryBreakUsecase,
        _utils = utils;

  @override
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  }) async {
    try {
      List<ClockingEventDto> appointmentsTypePoint = clockingEvents
          .where(
            (element) =>
                element.use == ClockingEventUseEnum.clockingEvent.codigo.toString(),
          )
          .toList();

      int workingTime = 0;

      appointmentsTypePoint.asMap().forEach((index, element) {
        if (index != 0) {
          int difference = _utils.calculateDifferenceInSeconds(
            element.timeEvent,
            appointmentsTypePoint[index - 1].timeEvent,
          );

          workingTime += difference;
        }
      });

      if (!_utils.isEven(appointmentsTypePoint.length)) {
        List<ClockingEventDto> appointmentsWithoutPause =
            clockingEvents
                .where(
                  (element) =>
                      element.use !=
                      ClockingEventUseEnum.mandatoryBreak.codigo.toString(),
                )
                .toList();

        ClockingEventDto lastAppointment =
            appointmentsWithoutPause.last;

        if (lastAppointment.use !=
            ClockingEventUseEnum.clockingEvent.codigo.toString()) {
          String timeEventBefore = appointmentsTypePoint.last.timeEvent;

          int difference = _utils.calculateDifferenceInSeconds(
            lastAppointment.timeEvent,
            timeEventBefore,
          );
          workingTime += difference;
        }
      }

      DateTime getInterval =
          await _getMealTimeUsecase.call(clockingEvents: clockingEvents);
      int intervalTime = _utils.convertDateTimeToSeconds(getInterval);

      DateTime getMandatoryBreak =
         await _getMandatoryBreakUsecase.call(clockingEvents: clockingEvents);
      int mandatoryBreakTime =
          _utils.convertDateTimeToSeconds(getMandatoryBreak);

      workingTime -= intervalTime;
      workingTime -= mandatoryBreakTime;

      int hours = workingTime ~/ 3600;
      int minutes = (workingTime.remainder(3600)) ~/ 60;
      int seconds = workingTime.remainder(60);

      return DateTime(0, 0, 0, hours, minutes, seconds);
    } catch (e) {
      return DateTime(0);
    }
  }
}
