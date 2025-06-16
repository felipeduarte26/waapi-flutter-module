
import '../../../../core/domain/enums/clocking_event_use_enum.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../functions/calculate_total_time_clocking_event_pair_function.dart';

abstract class GetDrivingTimeUsecase {
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  });
}

class GetDrivingTimeUsecaseImpl implements GetDrivingTimeUsecase {
  final IUtils _utils;

  GetDrivingTimeUsecaseImpl({
    required IUtils utils,
  }) : _utils = utils;

  @override
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  }) async {
    try {
      DateTime drivingTime = calculateTotaltimeClockingEventPair(
        clockingEvents: clockingEvents,
        typeUse: ClockingEventUseEnum.driving.codigo,
        utils: _utils,
      );

      return drivingTime;
    } catch (e) {
      return DateTime(0);
    }
  }
}
