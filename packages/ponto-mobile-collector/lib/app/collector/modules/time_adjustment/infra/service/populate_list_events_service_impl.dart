import '../../../../core/infra/utils/enum/type_journey_time_enum.dart';
import '../../domain/model/time_info_model.dart';
import '../../domain/service/populate_list_events_service.dart';

class PopulateListEventsServiceImpl implements PopulateListEventsService {
  PopulateListEventsServiceImpl();

  @override
  List<List<TimeInfoModel>> groupEventsByType({
    required List<TimeInfoModel> clockingEvents,
  }) {
    return [
      filterEventsByType(TypeJourneyTimeEnum.clockingEvent, clockingEvents),
      filterEventsByType(TypeJourneyTimeEnum.paidBreak, clockingEvents),
      filterEventsByType(TypeJourneyTimeEnum.waiting, clockingEvents),
      filterEventsByType(TypeJourneyTimeEnum.mandatoryBreak, clockingEvents),
      filterEventsByType(TypeJourneyTimeEnum.driving, clockingEvents),
    ];
  }

  List<TimeInfoModel> filterEventsByType(
    TypeJourneyTimeEnum typeJourneyEnum,
    List<TimeInfoModel> clockingEvents,
  ) {
    return clockingEvents
        .where(
          (event) => event.use == TypeJourneyTimeEnum.toInt(typeJourneyEnum),
        )
        .toList();
  }
}
