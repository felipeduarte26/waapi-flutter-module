import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart'
    as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/type_journey_time_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/domain/model/time_info_model.dart';
import 'package:ponto_mobile_collector/app/collector/modules/time_adjustment/infra/service/populate_list_events_service_impl.dart';

void main() {
  late PopulateListEventsServiceImpl service;

  setUp(() {
    service = PopulateListEventsServiceImpl();
  });

  group(
    'PopulateListEventsServiceImpl',
    () {
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
        'should group clocking events by their types correctly',
        () {
          final clockingEvents = [
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
              dateTime: DateTime(2023, 03, 28, 09, 00),
              use: clock.ClockingEventUseEnum.driving.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id4',
              dateTime: DateTime(2023, 03, 28, 09, 30),
              use: clock.ClockingEventUseEnum.waiting.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id5',
              dateTime: DateTime(2023, 03, 28, 10, 00),
              use: clock.ClockingEventUseEnum.waiting.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id6',
              dateTime: DateTime(2023, 03, 28, 11, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: true,
            ),
          ];

          final result =
              service.groupEventsByType(clockingEvents: clockingEvents);

          expect(result.length, 5);
          expect(result[0].length, 2); // clockingEvent
          expect(result[1].length, 0); // paidBreak
          expect(result[2].length, 2); // waiting
          expect(result[3].length, 0); // mandatoryBreak
          expect(result[4].length, 2); // driving
        },
      );

      test(
        'should return grouped events with multiple types',
        () {
          final clockingEvents = [
            createTimeInfoModel(
              id: 'id1',
              dateTime: DateTime(2023, 03, 28, 08, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id2',
              dateTime: DateTime(2023, 03, 28, 08, 30),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id3',
              dateTime: DateTime(2023, 03, 28, 09, 00),
              use: clock.ClockingEventUseEnum.waiting.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id4',
              dateTime: DateTime(2023, 03, 28, 09, 30),
              use: clock.ClockingEventUseEnum.mandatoryBreak.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id5',
              dateTime: DateTime(2023, 03, 28, 10, 00),
              use: clock.ClockingEventUseEnum.driving.codigo,
              isMealBreak: false,
            ),
          ];

          final result =
              service.groupEventsByType(clockingEvents: clockingEvents);

          expect(result[0].length, 2); // clockingEvent
          expect(result[1].length, 0); // paidBreak
          expect(result[2].length, 1); // waiting
          expect(result[3].length, 1); // mandatoryBreak
          expect(result[4].length, 1); // driving
        },
      );

      test(
        'should filter clocking events by type correctly',
        () {
          final clockingEvents = [
            createTimeInfoModel(
              id: 'id1',
              dateTime: DateTime(2023, 03, 28, 08, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id2',
              dateTime: DateTime(2023, 03, 28, 08, 30),
              use: clock.ClockingEventUseEnum.waiting.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id3',
              dateTime: DateTime(2023, 03, 28, 09, 00),
              use: clock.ClockingEventUseEnum.clockingEvent.codigo,
              isMealBreak: true,
            ),
          ];

          final filteredEvents = service.filterEventsByType(
            TypeJourneyTimeEnum.clockingEvent,
            clockingEvents,
          );

          expect(filteredEvents.length, 2);
          expect(
            filteredEvents[0].use,
            clock.ClockingEventUseEnum.clockingEvent.codigo,
          );
          expect(
            filteredEvents[1].use,
            clock.ClockingEventUseEnum.clockingEvent.codigo,
          );
        },
      );

      test(
        'should return empty list when filtering by a type with no events',
        () {
          final clockingEvents = [
            createTimeInfoModel(
              id: 'id1',
              dateTime: DateTime(2023, 03, 28, 08, 00),
              use: clock.ClockingEventUseEnum.waiting.codigo,
              isMealBreak: false,
            ),
            createTimeInfoModel(
              id: 'id2',
              dateTime: DateTime(2023, 03, 28, 09, 00),
              use: clock.ClockingEventUseEnum.driving.codigo,
              isMealBreak: false,
            ),
          ];

          final filteredEvents = service.filterEventsByType(
            TypeJourneyTimeEnum.clockingEvent,
            clockingEvents,
          );

          expect(filteredEvents, []);
        },
      );
    },
  );
}
