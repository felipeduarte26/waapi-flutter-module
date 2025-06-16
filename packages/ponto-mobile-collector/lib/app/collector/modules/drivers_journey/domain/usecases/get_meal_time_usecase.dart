import 'dart:developer';

import '../../../../core/domain/enums/clocking_event_use_enum.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/infra/utils/iutils.dart';

abstract class GetMealTimeUsecase {
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  });
}

class GetMealTimeUsecaseImpl implements GetMealTimeUsecase {
  final IUtils _utils;

  GetMealTimeUsecaseImpl({
    required IUtils utils,
  }) : _utils = utils;

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

      int getMealTimeInSeconds = 0;

      appointmentsTypePoint.asMap().forEach(
        (index, element) {
          if (_utils.isEven(index) && index != 0) {
            int difference = _utils.calculateDifferenceInSeconds(
              element.timeEvent,
              appointmentsTypePoint[index - 1].timeEvent,
            );
            getMealTimeInSeconds += difference;
          }
        },
      );

      int hours = getMealTimeInSeconds ~/ 3600;
      int minutes = (getMealTimeInSeconds.remainder(3600)) ~/ 60;
      int seconds = getMealTimeInSeconds.remainder(60);

      return DateTime(0, 0, 0, hours, minutes, seconds);
    } catch (e) {
      log(e.toString());
      return DateTime(0);
    }
  }
}
