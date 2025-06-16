import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/gps_operation_mode.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/clocking_event_exception.dart';

void main() {
  group('GPSoperationModeEnum', () {
    test('should return the correct enum for active value', () {
      const value = 'Active';
      final result = GPSoperationModeEnum.build(value);
      expect(result, GPSoperationModeEnum.active);
    });

    test('should return the correct enum for inactive value', () {
      const value = 'Inactive';
      final result = GPSoperationModeEnum.build(value);
      expect(result, GPSoperationModeEnum.inactive);
    });

    test('should return the correct enum for precision value', () {
      const value = 'Pecision';
      final result = GPSoperationModeEnum.build(value);
      expect(result, GPSoperationModeEnum.precision);
    });

    test('should throw ClockingEventException for an invalid value', () {
      const value = 'Invalid';
      expect(
        () => GPSoperationModeEnum.build(value),
        throwsA(isA<ClockingEventException>()),
      );
    });
  });
}