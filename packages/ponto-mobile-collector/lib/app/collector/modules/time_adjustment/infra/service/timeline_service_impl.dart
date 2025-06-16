import '../../../../core/domain/enums/clocking_event_use_enum.dart';
import '../../../../core/domain/input_model/timeline_item_dto.dart';
import '../../../../core/infra/utils/enum/type_journey_time_enum.dart';
import '../../../../core/infra/utils/iutils.dart';
import '../../domain/model/time_info_model.dart';
import '../../domain/service/populate_list_events_service.dart';
import '../../domain/service/timeline_service.dart';

class TimelineServiceImpl implements TimelineService {
  final IUtils _utils;
  final PopulateListEventsService _populateListEventsService;

  TimelineServiceImpl({
    required PopulateListEventsService populateListEventsService,
    required IUtils utils,
  })  : _populateListEventsService = populateListEventsService,
        _utils = utils;

  bool isAppointmentEvent(TimeInfoModel event) {
    return event.use == ClockingEventUseEnum.clockingEvent.codigo &&
        event.isMealBreak == false;
  }

  @override
  List<TimelineItemDto> createTimelineItemList({
    required List<TimeInfoModel> clockingEvents,
    required isJourneyFinished,
  }) {
    List<TimelineItemDto> timelineItems = [];
    if (clockingEvents.isNotEmpty) {
      var listEvents = _populateListEventsService.groupEventsByType(
        clockingEvents: clockingEvents,
      );
      var appointmentsClockingEvents = findAppointments(listEvents: listEvents);
      return buildTimeline(
        appointmentsClockingEvents: appointmentsClockingEvents,
        listEvents: listEvents,
        isJourneyFinished: isJourneyFinished,
      );
    }
    return timelineItems;
  }

  @override
  List<TimeInfoModel> findAppointments({
    required List<List<TimeInfoModel>> listEvents,
  }) {
    return listEvents
        .firstWhere(
          (list) => list.any((event) => isAppointmentEvent(event)),
          orElse: () => [],
        )
        .where((event) => !event.isMealBreak)
        .toList();
  }

  List<TimelineItemDto> buildTimeline({
    List<TimeInfoModel>? appointmentsClockingEvents,
    required List<List<TimeInfoModel>> listEvents,
    required bool isJourneyFinished,
  }) {
    List<TimelineItemDto> timelineItems = [];

    _startTimeline(
      timelineItems,
      appointmentsClockingEvents,
      isJourneyFinished,
    );
    convertClockingEventsToTimelineItem(
      listEvents: listEvents,
      timelineItems: timelineItems,
    );

    if (isJourneyFinished) {
      _endTimeline(timelineItems, appointmentsClockingEvents);
    }

    return timelineItems;
  }

  void _startTimeline(
    List<TimelineItemDto> timelineItems,
    List<TimeInfoModel>? appointmentsClockingEvents,
    bool isJourneyFinished,
  ) {
    if (appointmentsClockingEvents != null &&
        appointmentsClockingEvents.isNotEmpty) {
      if (isJourneyFinished &&
          hasEvenNumberOfAppointments(
            appointments: appointmentsClockingEvents,
          )) {
        timelineItems.add(
          addTimelineItem(
            typeJourneyEnum: TypeJourneyTimeEnum.working,
            startDate: appointmentsClockingEvents.first.dateTime,
            isBeginning: true,
          ),
        );
      } else if (isJourneyFinished == false &&
          appointmentsClockingEvents.isNotEmpty) {
        timelineItems.add(
          addTimelineItem(
            typeJourneyEnum: TypeJourneyTimeEnum.working,
            startDate: appointmentsClockingEvents.first.dateTime,
            isBeginning: true,
          ),
        );
      }
    }
  }

  void _endTimeline(
    List<TimelineItemDto> timelineItems,
    List<TimeInfoModel>? appointmentsClockingEvents,
  ) {
    if (appointmentsClockingEvents != null &&
        appointmentsClockingEvents.isNotEmpty) {
      timelineItems.add(
        addTimelineItem(
          typeJourneyEnum: TypeJourneyTimeEnum.working,
          startDate: appointmentsClockingEvents.first.dateTime,
          endDate: appointmentsClockingEvents.last.dateTime,
          isBeginning: false,
        ),
      );
    }
  }

  TimelineItemDto addTimelineItem({
    required TypeJourneyTimeEnum typeJourneyEnum,
    DateTime? startDate,
    DateTime? endDate,
    required bool isBeginning,
  }) {
    return TimelineItemDto(
      typeJourneyTimeEnum: typeJourneyEnum,
      startDate: startDate,
      endDate: endDate,
      isBeginning: isBeginning,
    );
  }

  bool hasEvenNumberOfAppointments({
    required List<TimeInfoModel> appointments,
  }) {
    return _utils.isEven(appointments.length);
  }

  List<TimelineItemDto> convertClockingEventsToTimelineItem({
    required List<List<TimeInfoModel>> listEvents,
    required List<TimelineItemDto> timelineItems,
  }) {
    for (var list in listEvents) {
      if (list.isEmpty) continue;

      TimelineItemDto? lastItem;

      for (var i = 0; i < list.length; i++) {
        var event = list[i];

        if (event.isMealBreak) {
          if (!_utils.isEven(i)) {
            lastItem = TimelineItemDto(
              typeJourneyTimeEnum: TypeJourneyTimeEnum.mealBreak,
              startDate: event.dateTime,
            );
          } else {
            if (lastItem != null) {
              TimelineItemDto item = TimelineItemDto(
                typeJourneyTimeEnum: lastItem.typeJourneyTimeEnum,
                startDate: lastItem.startDate,
                endDate: event.dateTime,
              );
              timelineItems.add(item);
              lastItem = null;
            }
          }
        }
        if (event.use != ClockingEventUseEnum.clockingEvent.codigo) {
          if (_utils.isEven(i)) {
            lastItem = TimelineItemDto(
              typeJourneyTimeEnum: TypeJourneyTimeEnum.fromInt(event.use),
              startDate: event.dateTime,
            );
          } else {
            if (lastItem != null) {
              TimelineItemDto item = TimelineItemDto(
                typeJourneyTimeEnum: lastItem.typeJourneyTimeEnum,
                startDate: lastItem.startDate,
                endDate: event.dateTime,
              );
              timelineItems.add(item);
              lastItem = null;
            }
          }
        }
      }
    }
    timelineItems.sort(
      (a, b) => a.startDate!.compareTo(b.startDate!),
    );

    return timelineItems;
  }
}
