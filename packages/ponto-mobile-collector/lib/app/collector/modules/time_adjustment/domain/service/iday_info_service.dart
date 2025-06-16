import '../../../../core/domain/entities/overnight_entity.dart';
import '../../../../core/domain/input_model/clocking_event_dto.dart';
import '../model/day_info_model.dart';

abstract class IDayInfoService {
  Future<List<DayInfoModel>> generate({
    required List<ClockingEventDto> clockingEvents,
    required DateTime initialDate,
    required DateTime finalDate,
    List<OvernightEntity>? overnights,
    String? journeyId,
  });
}
