import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/clocking_event_exception.dart';

void main() {
  group('ClockingEventUseEnum', () {
    test('should return correct enum for valid codigo', () {
      expect(ClockingEventUseEnum.build(2), ClockingEventUseEnum.clockingEvent);
      expect(ClockingEventUseEnum.build(18), ClockingEventUseEnum.paidBreak);
      expect(ClockingEventUseEnum.build(22), ClockingEventUseEnum.mandatoryBreak);
      expect(ClockingEventUseEnum.build(23), ClockingEventUseEnum.driving);
      expect(ClockingEventUseEnum.build(21), ClockingEventUseEnum.waiting);
    });

    test('should throw ClockingEventException for invalid codigo', () {
      expect(() => ClockingEventUseEnum.build(99), throwsA(isA<ClockingEventException>()));
    });

    test('should have correct value and codigo for each enum', () {
      expect(ClockingEventUseEnum.clockingEvent.value, 'Clocking Event');
      expect(ClockingEventUseEnum.clockingEvent.codigo, 2);

      expect(ClockingEventUseEnum.paidBreak.value, 'Paid Break');
      expect(ClockingEventUseEnum.paidBreak.codigo, 18);

      expect(ClockingEventUseEnum.mandatoryBreak.value, 'Mandatory Break');
      expect(ClockingEventUseEnum.mandatoryBreak.codigo, 22);

      expect(ClockingEventUseEnum.driving.value, 'Driving');
      expect(ClockingEventUseEnum.driving.codigo, 23);

      expect(ClockingEventUseEnum.waiting.value, 'Waiting');
      expect(ClockingEventUseEnum.waiting.codigo, 21);
    });
  });
}
