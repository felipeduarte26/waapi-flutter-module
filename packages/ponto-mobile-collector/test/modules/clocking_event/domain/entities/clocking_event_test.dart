
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/clocking_event.dart';

void main() {
  group('ClockingEvent', () {
    test('should correctly assign the signature property', () {
      const testSignature = 'test_signature';
      final clockingEvent = ClockingEvent(
        id: '12345',
        dateEvent: '2023-01-01',
        timeEvent: '12:00:00',
        timeZone: 'UTC',
        cpf: '12345678900',
        employeeName: 'John Doe',
        employeeId: 'emp123',
        companyName: 'Test Company',
        companyIdentifier: 'test_company_id',
        signature: testSignature,
        use: 'test_use',
        signatureVersion: 1,
      );

      expect(clockingEvent.signature, testSignature);
    });

    test('copyWith should update the signature property', () {
      const initialSignature = 'initial_signature';
      const updatedSignature = 'updated_signature';

      final clockingEvent = ClockingEvent(
        id: '12345',
        dateEvent: '2023-01-01',
        timeEvent: '12:00:00',
        timeZone: 'UTC',
        cpf: '12345678900',
        employeeName: 'John Doe',
        employeeId: 'emp123',
        companyName: 'Test Company',
        companyIdentifier: 'test_company_id',
        signature: initialSignature,
        use: 'test_use',
        signatureVersion: 1,
      );

      final updatedClockingEvent = clockingEvent.copyWith(signature: updatedSignature);

      expect(updatedClockingEvent.signature, updatedSignature);
      expect(clockingEvent.signature, initialSignature); // Ensure immutability
    });
  });
}
