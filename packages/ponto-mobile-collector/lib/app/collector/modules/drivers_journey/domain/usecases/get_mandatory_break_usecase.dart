import '../../../../core/domain/enums/clocking_event_use_enum.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../functions/calculate_total_time_clocking_event_pair_function.dart';

abstract class GetMandatoryBreakUsecase {
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  });
}

class GetMandatoryBreakUsecaseImpl implements GetMandatoryBreakUsecase {
  final IUtils _utils;

  GetMandatoryBreakUsecaseImpl({
    required IUtils utils,
  }) : _utils = utils;

  @override
  Future<DateTime> call({
    required List<ClockingEventDto> clockingEvents,
  }) async {
    try {
      DateTime mandatoryTime = calculateTotaltimeClockingEventPair(
        clockingEvents: clockingEvents,
        typeUse: ClockingEventUseEnum.mandatoryBreak.codigo,
        utils: _utils,
      );

      return mandatoryTime;
    } catch (e) {
      return DateTime(0);
    }
  }
}
