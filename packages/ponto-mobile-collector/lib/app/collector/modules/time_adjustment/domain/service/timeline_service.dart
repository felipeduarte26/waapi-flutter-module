import '../../../../core/domain/input_model/timeline_item_dto.dart';
import '../model/time_info_model.dart';

abstract class TimelineService {
  List<TimelineItemDto> createTimelineItemList({
    required List<TimeInfoModel> clockingEvents,
    required bool isJourneyFinished,
  });

  List<TimeInfoModel> findAppointments({
    required List<List<TimeInfoModel>> listEvents,
  });
}
