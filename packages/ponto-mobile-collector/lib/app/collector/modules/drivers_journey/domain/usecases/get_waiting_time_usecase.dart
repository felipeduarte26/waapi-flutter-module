import '../../../../core/domain/enums/clocking_event_use_enum.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../functions/calculate_total_time_clocking_event_pair_function.dart';

abstract class GetWaitingTimeUsecase {
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  });
}

class GetWaitingTimeUsecaseImpl extends GetWaitingTimeUsecase {
  final IUtils _utils;
  GetWaitingTimeUsecaseImpl({required IUtils utils}) : _utils = utils;
  @override
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  }) async {
    try {
      DateTime waitingTime = calculateTotaltimeClockingEventPair(
        clockingEvents: clockingEvents,
        typeUse: ClockingEventUseEnum.waiting.codigo,
        utils: _utils,
      );

      return waitingTime;
    } catch (e) {
      return DateTime(0);
    }
  }
}
