import '../../../modules/time_adjustment/domain/model/day_info_model.dart';
import '../entities/journey_entity.dart';
import 'journey_time_details_dto.dart';
import 'timeline_item_dto.dart';

class ClockingeventJourney {
  final List<DayInfoModel> dayInfoModeltList;
  final JourneyEntity journey;
  final List<JourneyTimeDetailsDto> journeyTimeDetailsDto;
  final DateTime totalBreakTime;
  final List<TimelineItemDto>? timelineItems;
  ClockingeventJourney({
    required this.dayInfoModeltList,
    required this.journey,
    required this.journeyTimeDetailsDto,
    required this.totalBreakTime,
    required this.timelineItems,
  });
}
