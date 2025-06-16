import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockInternalClockService extends Mock implements clock.IInternalClockService {}

void main() {
  group('RegisterClockingEventEvent', () {
    test('NewRegisterEvent test', () async {
      NewRegisterEvent event = NewRegisterEvent(
        clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      );

      expect(
        event.clockingEventRegisterType,
        isA<ClockingEventRegisterTypeSession>(),
      );
    });
  });
}
