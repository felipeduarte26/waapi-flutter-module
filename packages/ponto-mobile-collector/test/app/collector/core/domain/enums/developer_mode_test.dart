import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/developer_mode.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/clocking_event_exception.dart';

void main() {
  group('DeveloperModeEnum', () {
    test('should return DeveloperModeEnum.inactive when value is "Inactive"', () {
      const value = 'Inactive';
      final result = DeveloperModeEnum.build(value);
      expect(result, DeveloperModeEnum.inactive);
    });

    test('should throw ClockingEventException when value is invalid', () {
      const value = 'Invalid';
      expect(() => DeveloperModeEnum.build(value), throwsA(isA<ClockingEventException>()));
    });
  });
}
