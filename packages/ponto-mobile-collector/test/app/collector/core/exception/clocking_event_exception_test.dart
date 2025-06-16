import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/clocking_event_exception.dart';

void main() {
  group('ClockingEventException', () {
    test('should store and return the error message', () {
      const errorMessage = 'An error occurred';
      final exception = ClockingEventException(errorMessage);

      expect(exception.erro, errorMessage);
      expect(exception.message, errorMessage);
    });
  });
}
