import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_dto.dart';

void main() {
  group('ClockingEventDto', () {
    test('should allow null id', () {
      final clockingEvent = ClockingEventDto(
        dateEvent: '2023-01-01',
        timeEvent: '12:00:00',
        timeZone: 'UTC',
        companyIdentifier: '12345',
        cpf: '12345678900',
        appVersion: '1.0.0',
        platform: 'Android',
        use: 'test',
        clockingEventId: 'event123',
        signature: 'signature123',
        signatureVersion: 1,
      );

      expect(clockingEvent.id, isNull);
    });

    test('should allow setting id', () {
      final clockingEvent = ClockingEventDto(
        id: 'test-id',
        dateEvent: '2023-01-01',
        timeEvent: '12:00:00',
        timeZone: 'UTC',
        companyIdentifier: '12345',
        cpf: '12345678900',
        appVersion: '1.0.0',
        platform: 'Android',
        use: 'test',
        clockingEventId: 'event123',
        signature: 'signature123',
        signatureVersion: 1,
      );

      expect(clockingEvent.id, equals('test-id'));
    });
  });
}
