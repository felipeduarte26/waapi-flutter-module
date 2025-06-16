import '../../../../core/domain/input_model/timeline_item_dto.dart';

import '../model/time_info_model.dart';
import '../service/timeline_service.dart';

abstract class GetDriverJourneyTimelineUsecase {
  List<TimelineItemDto> call({
    required List<TimeInfoModel> clockingEvents,
    required bool isJourneyFinished,
  });
}

class GetDriverJourneyTimelineUsecaseImpl
    implements GetDriverJourneyTimelineUsecase {
  final TimelineService _timelineService;

  GetDriverJourneyTimelineUsecaseImpl({
    required TimelineService timelineService,
  }) : _timelineService = timelineService;

  @override
  List<TimelineItemDto> call({
    required List<TimeInfoModel> clockingEvents,
    required bool isJourneyFinished,
  }) {
    List<TimelineItemDto> timelineItems =
        _timelineService.createTimelineItemList(
      clockingEvents: clockingEvents,
      isJourneyFinished: isJourneyFinished,
    );
    return timelineItems;
  }
}
