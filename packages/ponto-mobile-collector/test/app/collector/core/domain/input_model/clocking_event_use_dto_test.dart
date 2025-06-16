import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/clocking_event_use_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_use_dto.dart';

void main() {
  group('ClockingEventUseDto', () {
    test('should create an instance with the correct values', () {
      const description = 'Test Description';
      const code = '12345';
      var clockingEventUseType = ClockingEventUseType.clockingEvent;
      const employeeId = 'emp123';

      final dto = ClockingEventUseDto(
        description: description,
        code: code,
        clockingEventUseType: clockingEventUseType,
        employeeId: employeeId,
      );

      expect(dto.description, description);
      expect(dto.code, code);
      expect(dto.clockingEventUseType, clockingEventUseType);
      expect(dto.employeeId, employeeId);
    });

    test('should convert to JSON correctly', () {
      const description = 'Test Description';
      const code = '12345';
      var clockingEventUseType = ClockingEventUseType.driving;
      const employeeId = 'emp123';

      final dto = ClockingEventUseDto(
        description: description,
        code: code,
        clockingEventUseType: clockingEventUseType,
        employeeId: employeeId,
      );

      final json = dto.toJson();

      expect(json['description'], description);
      expect(json['code'], code);
      expect(json['clockingEventUseType'], clockingEventUseType.name);
      expect(json['employeeId'], employeeId);
    });

    test('should create an instance from JSON correctly', () {
      const json = {
        'description': 'Test Description',
        'code': '12345',
        'clockingEventUseType': 'paidBreak',
        'employeeId': 'emp123',
      };

      final dto = ClockingEventUseDto.fromJson(json);

      expect(dto.description, json['description']);
      expect(dto.code, json['code']);
      expect(dto.clockingEventUseType, ClockingEventUseType.paidBreak);
      expect(dto.employeeId, json['employeeId']);
    });
  });
}
