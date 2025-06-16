import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/timeline_item_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/type_journey_time_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/model/time_info_model.dart';

import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/service/timeline_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/usecases/get_driver_journey_timeline_usecase.dart';

class MockTimelineServiceImpl extends Mock implements TimelineService {}

void main() {
  late TimelineService mockTimelineService;
  late GetDriverJourneyTimelineUsecaseImpl usecase;

  setUp(() {
    mockTimelineService = MockTimelineServiceImpl();
    usecase = GetDriverJourneyTimelineUsecaseImpl(
      timelineService: mockTimelineService,
    );
  });

  TimeInfoModel createTimeInfoModel({
    required String id,
    required DateTime dateTime,
    required int use,
    required bool isMealBreak,
  }) {
    return TimeInfoModel(
      clockingEventId: id,
      dateTime: dateTime,
      isBold: false,
      isPhoneOrigin: false,
      isPlatformOrigin: false,
      isManual: false,
      isRemoteness: false,
      isSynchronized: false,
      use: use,
      isMealBreak: isMealBreak,
    );
  }

  test(
    'should return transformed timeline items when valid clocking events are provided',
    () {
      final List<TimeInfoModel> clockingEvents = [
        createTimeInfoModel(
          id: 'id1',
          dateTime: DateTime(2023, 03, 28, 08, 00),
          use: clock.ClockingEventUseEnum.clockingEvent.codigo,
          isMealBreak: false,
        ),
        createTimeInfoModel(
          id: 'id2',
          dateTime: DateTime(2023, 03, 28, 08, 30),
          use: clock.ClockingEventUseEnum.driving.codigo,
          isMealBreak: false,
        ),
        createTimeInfoModel(
          id: 'id3',
          dateTime: DateTime(2023, 03, 28, 11, 00),
          use: clock.ClockingEventUseEnum.driving.codigo,
          isMealBreak: false,
        ),
      ];
      final List<TimelineItemDto> expectedTimelineItems = [
        TimelineItemDto(
          typeJourneyTimeEnum: TypeJourneyTimeEnum.clockingEvent,
          isBeginning: true,
          startDate: DateTime(2023, 03, 28, 08, 30),
          endDate: null,
        ),
        TimelineItemDto(
          typeJourneyTimeEnum: TypeJourneyTimeEnum.driving,
          isBeginning: null,
          startDate: DateTime(2023, 03, 28, 08, 30),
          endDate: DateTime(2023, 03, 28, 11, 00),
        ),
      ];
      bool isJourneyFinished = false;

      when(
        () => mockTimelineService.createTimelineItemList(
          clockingEvents: clockingEvents,
          isJourneyFinished: isJourneyFinished,
        ),
      ).thenReturn(expectedTimelineItems);

      final result = usecase.call(
        clockingEvents: clockingEvents,
        isJourneyFinished: isJourneyFinished,
      );

      expect(result, expectedTimelineItems);
      verify(
        () => mockTimelineService.createTimelineItemList(
          clockingEvents: clockingEvents,
          isJourneyFinished: isJourneyFinished,
        ),
      ).called(1);
    },
  );

  test(
    'should return empty list when clocking events are empty',
    () {
      final List<TimeInfoModel> emptyClockingEvents = [];
      bool isJourneyFinished = false;
      when(
        () => mockTimelineService.createTimelineItemList(
          clockingEvents: emptyClockingEvents,
          isJourneyFinished: isJourneyFinished,
        ),
      ).thenReturn([]);

      final result = usecase.call(
        clockingEvents: emptyClockingEvents,
        isJourneyFinished: isJourneyFinished,
      );

      expect(result, isEmpty);

      verify(
        () => mockTimelineService.createTimelineItemList(
          clockingEvents: emptyClockingEvents,
          isJourneyFinished: isJourneyFinished,
        ),
      ).called(1);
    },
  );
}
