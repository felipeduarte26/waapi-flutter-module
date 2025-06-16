import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/clocking_event_use.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';

void main() {
  group('ClockingEventUse', () {
    test('should correctly create an instance with all properties', () {
      const clockingEventUse = ClockingEventUse(
        description: 'Test Description',
        code: '123',
        clockingEventUseType: ClockingEventUseType.clockingEvent,
        employeeId: 'EMP001',
      );

      expect(clockingEventUse.description, 'Test Description');
      expect(clockingEventUse.code, '123');
      expect(clockingEventUse.clockingEventUseType, ClockingEventUseType.clockingEvent);
      expect(clockingEventUse.employeeId, 'EMP001');
    });

    test('should correctly create a copy with modified properties', () {
      const original = ClockingEventUse(
        description: 'Original Description',
        code: '123',
        clockingEventUseType: ClockingEventUseType.clockingEvent,
        employeeId: 'EMP001',
      );

      final modified = original.copyWith(
        description: 'Modified Description',
        code: '456',
      );

      expect(modified.description, 'Modified Description');
      expect(modified.code, '456');
      expect(modified.clockingEventUseType, ClockingEventUseType.clockingEvent);
      expect(modified.employeeId, 'EMP001');
    });

    test('should correctly compare two instances with the same properties', () {
      const instance1 = ClockingEventUse(
        description: 'Test Description',
        code: '123',
        clockingEventUseType: ClockingEventUseType.clockingEvent,
        employeeId: 'EMP001',
      );

      const instance2 = ClockingEventUse(
        description: 'Test Description',
        code: '123',
        clockingEventUseType: ClockingEventUseType.clockingEvent,
        employeeId: 'EMP001',
      );

      expect(instance1, instance2);
    });

    test('should correctly handle null employeeId', () {
      const clockingEventUse = ClockingEventUse(
        description: 'Test Description',
        code: '123',
        clockingEventUseType: ClockingEventUseType.clockingEvent,
        employeeId: null,
      );

      expect(clockingEventUse.employeeId, isNull);
    });
  });
}
