import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/timeline_item_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/type_journey_time_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/iutils.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/model/time_info_model.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/service/populate_list_events_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/infra/service/timeline_service_impl.dart';

class MockPopulateListEventsService extends Mock
    implements PopulateListEventsService {}

class MockIUtils extends Mock implements IUtils {}

void main() {
  late MockPopulateListEventsService mockPopulateListEventsService;
  late MockIUtils mockUtils;
  late TimelineServiceImpl timelineService;

  setUp(() {
    mockPopulateListEventsService = MockPopulateListEventsService();
    mockUtils = MockIUtils();
    timelineService = TimelineServiceImpl(
      populateListEventsService: mockPopulateListEventsService,
      utils: mockUtils,
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

  group(
    'TimelineServiceImpl',
    () {
      test(
        'should return empty list when clocking events are empty',
        () {
          final result = timelineService.createTimelineItemList(
            clockingEvents: [],
            isJourneyFinished: false,
          );

          expect(result, []);
        },
      );

      test(
        'should process clocking events and return timeline items',
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
              dateTime: DateTime(2023, 03, 28, 11, 30),
              use: clock.ClockingEventUseEnum.driving.codigo,
              isMealBreak: false,
            ),
          ];

          final List<List<TimeInfoModel>> expectedGroupedList = [
            [
              createTimeInfoModel(
                id: 'id1',
                dateTime: DateTime(2023, 03, 28, 08, 00),
                use: clock.ClockingEventUseEnum.clockingEvent.codigo,
                isMealBreak: false,
              ),
            ],
            [
              createTimeInfoModel(
                id: 'id2',
                dateTime: DateTime(2023, 03, 28, 08, 30),
                use: clock.ClockingEventUseEnum.driving.codigo,
                isMealBreak: false,
              ),
              createTimeInfoModel(
                id: 'id3',
                dateTime: DateTime(2023, 03, 28, 11, 30),
                use: clock.ClockingEventUseEnum.driving.codigo,
                isMealBreak: false,
              ),
            ],
          ];

          final List<TimelineItemDto> expectedTimelineItems = [
            TimelineItemDto(
              typeJourneyTimeEnum: TypeJourneyTimeEnum.working,
              isBeginning: true,
              startDate: DateTime(2023, 03, 28, 08, 00),
              endDate: null,
            ),
            TimelineItemDto(
              typeJourneyTimeEnum: TypeJourneyTimeEnum.driving,
              isBeginning: null,
              startDate: DateTime(2023, 03, 28, 08, 30),
              endDate: DateTime(2023, 03, 28, 11, 30),
            ),
          ];

          when(
            () => mockPopulateListEventsService.groupEventsByType(
              clockingEvents: clockingEvents,
            ),
          ).thenReturn(expectedGroupedList);

          when(() => mockUtils.isEven(any())).thenAnswer(
            (invocation) {
              final arg = invocation.positionalArguments[0] as int;
              return arg % 2 == 0;
            },
          );

          final result = timelineService.createTimelineItemList(
            clockingEvents: clockingEvents,
            isJourneyFinished: false,
          );

          expect(
            result,
            equals(expectedTimelineItems),
          );
          verify(
            () => mockPopulateListEventsService.groupEventsByType(
              clockingEvents: clockingEvents,
            ),
          ).called(1);
        },
      );

      test(
        'should find appointments correctly',
        () {
          final List<List<TimeInfoModel>> listEvents = [
            [
              createTimeInfoModel(
                id: 'id1',
                dateTime: DateTime(2023, 03, 28, 08, 00),
                use: clock.ClockingEventUseEnum.clockingEvent.codigo,
                isMealBreak: false,
              ),
              createTimeInfoModel(
                id: 'id4',
                dateTime: DateTime(2023, 03, 28, 12, 00),
                use: clock.ClockingEventUseEnum.clockingEvent.codigo,
                isMealBreak: true,
              ),
            ],
            [
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
            ],
          ];

          final result =
              timelineService.findAppointments(listEvents: listEvents);

          expect(result.length, 1);
        },
      );

      test(
        'should not add start timeline item if no appointments are found',
        () {
          final List<TimeInfoModel> clockingEvents = [
            createTimeInfoModel(
              id: 'id1',
              dateTime: DateTime(2023, 03, 28, 08, 00),
              use: clock.ClockingEventUseEnum.driving.codigo,
              isMealBreak: false,
            ),
          ];

          when(
            () => mockPopulateListEventsService.groupEventsByType(
              clockingEvents: clockingEvents,
            ),
          ).thenReturn([clockingEvents]);

          when(() => mockUtils.isEven(any())).thenAnswer(
            (invocation) {
              final arg = invocation.positionalArguments[0] as int;
              return arg % 2 == 0;
            },
          );

          final result = timelineService.createTimelineItemList(
            clockingEvents: clockingEvents,
            isJourneyFinished: false,
          );

          expect(result.isEmpty, true);
        },
      );

      test(
        'should add end timeline item if journey is finished',
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
              dateTime: DateTime(2023, 03, 28, 18, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: false,
            ),
          ];

          when(
            () => mockPopulateListEventsService.groupEventsByType(
              clockingEvents: clockingEvents,
            ),
          ).thenReturn([clockingEvents]);

          when(() => mockUtils.isEven(any())).thenAnswer(
            (invocation) {
              final arg = invocation.positionalArguments[0] as int;
              return arg % 2 == 0;
            },
          );

          final result = timelineService.createTimelineItemList(
            clockingEvents: clockingEvents,
            isJourneyFinished: true,
          );

          expect(result.length, 2);
          expect(result[0].isBeginning, true);
        },
      );

      test(
        'should handle meal breaks correctly',
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
              dateTime: DateTime(2023, 03, 28, 11, 30),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: true,
            ),
            createTimeInfoModel(
              id: 'id3',
              dateTime: DateTime(2023, 03, 28, 13, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: true,
            ),
          ];

          when(
            () => mockPopulateListEventsService.groupEventsByType(
              clockingEvents: clockingEvents,
            ),
          ).thenReturn([clockingEvents]);

          when(() => mockUtils.isEven(any())).thenAnswer(
            (invocation) {
              final arg = invocation.positionalArguments[0] as int;
              return arg % 2 == 0;
            },
          );

          final result = timelineService.createTimelineItemList(
            clockingEvents: clockingEvents,
            isJourneyFinished: false,
          );

          expect(result.length, 2);
        },
      );

      test('should handle overlapping events correctly, and sort time', () {
        final List<List<TimeInfoModel>> listEvents = [
          [
            createTimeInfoModel(
              id: 'id1',
              dateTime: DateTime(2023, 03, 28, 08, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id3',
              dateTime: DateTime(2023, 03, 28, 12, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: true,
            ),
            createTimeInfoModel(
              id: 'id4',
              dateTime: DateTime(2023, 03, 28, 13, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: true,
            ),
          ],
          [
            createTimeInfoModel(
              id: 'id2',
              dateTime: DateTime(2023, 03, 28, 09, 00),
              use: clock.ClockingEventUseEnum.driving.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id5',
              dateTime: DateTime(2023, 03, 28, 13, 30),
              use: clock.ClockingEventUseEnum.driving.codigo,
              isMealBreak: false,
            ),
          ],
        ];

        final List<TimelineItemDto> initialTimelineItems = [
          TimelineItemDto(
            typeJourneyTimeEnum: TypeJourneyTimeEnum.working,
            isBeginning: true,
            startDate: DateTime(2023, 03, 28, 08, 00),
            endDate: null,
          ),
        ];

        final List<TimelineItemDto> expectedTimelineItems = [
          TimelineItemDto(
            typeJourneyTimeEnum: TypeJourneyTimeEnum.working,
            isBeginning: true,
            startDate: DateTime(2023, 03, 28, 08, 00),
            endDate: null,
          ),
          TimelineItemDto(
            typeJourneyTimeEnum: TypeJourneyTimeEnum.driving,
            isBeginning: null,
            startDate: DateTime(2023, 03, 28, 09, 00),
            endDate: DateTime(2023, 03, 28, 13, 30),
          ),
          TimelineItemDto(
            typeJourneyTimeEnum: TypeJourneyTimeEnum.mealBreak,
            isBeginning: null,
            startDate: DateTime(2023, 03, 28, 12, 00),
            endDate: DateTime(2023, 03, 28, 13, 00),
          ),
        ];
        when(() => mockUtils.isEven(any())).thenAnswer(
          (invocation) {
            final arg = invocation.positionalArguments[0] as int;
            return arg % 2 == 0;
          },
        );
        final result = timelineService.convertClockingEventsToTimelineItem(
          listEvents: listEvents,
          timelineItems: initialTimelineItems,
        );

        expect(result.length, expectedTimelineItems.length);
        for (var i = 0; i < expectedTimelineItems.length; i++) {
          expect(result[i].startDate, expectedTimelineItems[i].startDate);
          expect(
            result[i].typeJourneyTimeEnum,
            expectedTimelineItems[i].typeJourneyTimeEnum,
          );
        }
      });
    },
  );
}
