import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_origin.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/clocking_event_exception.dart';

void main() {
  group('ClockingEventOriginEnum', () {
    test('should return the correct enum for valid values', () {
      expect(ClockingEventOriginEnum.build('Mobile'), ClockingEventOriginEnum.mobile);
      expect(ClockingEventOriginEnum.build('WEB'), ClockingEventOriginEnum.web);
      expect(ClockingEventOriginEnum.build('Client'), ClockingEventOriginEnum.client);
    });

    test('should throw ClockingEventException for invalid value', () {
      expect(
        () => ClockingEventOriginEnum.build('InvalidValue'),
        throwsA(isA<ClockingEventException>()),
      );
    });

    test('should have correct string values for each enum', () {
      expect(ClockingEventOriginEnum.mobile.value, 'Mobile');
      expect(ClockingEventOriginEnum.web.value, 'WEB');
      expect(ClockingEventOriginEnum.client.value, 'Client');
    });
  });
}