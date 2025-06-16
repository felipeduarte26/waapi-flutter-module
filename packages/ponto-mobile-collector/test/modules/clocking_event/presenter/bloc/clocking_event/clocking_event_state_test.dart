
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../mocks/clocking_event_dto_mock.dart';
class MockInternalClockService extends Mock implements clock.IInternalClockService {}

void main() {
  test(
    'ClockingEventState ReadyContentClockingEventState test',
    () async {
      ReadyContentClockingEventState state = ReadyContentClockingEventState(
        clockingEventsDto: [clockingEventDtoMock],
      );

      expect(state.clockingEventsDto.first.appVersion, [clockingEventDtoMock].first.appVersion);
      expect(state.clockingEventsDto.first.clockingEventId, [clockingEventDtoMock].first.clockingEventId);
      expect(state.clockingEventsDto.first.cpf, [clockingEventDtoMock].first.cpf);
    },
  );
}
