import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/hlb_time_dto.dart';

void main() {
  group('HlbTimeDto', () {
    test('should create an instance with given values', () {
      final dto = HlbTimeDto(hlbTime: 12345, defaultTimezone: 'UTC');

      expect(dto.hlbTime, 12345);
      expect(dto.defaultTimezone, 'UTC');
    });

    test('should serialize to JSON correctly', () {
      final dto = HlbTimeDto(hlbTime: 12345, defaultTimezone: 'UTC');
      final json = dto.toJson();

      expect(json['hlbTime'], 12345);
      expect(json['defaultTimezone'], 'UTC');
    });

    test('should deserialize from JSON correctly', () {
      final json = {'hlbTime': 12345, 'defaultTimezone': 'UTC'};
      final dto = HlbTimeDto.fromJson(json);

      expect(dto.hlbTime, 12345);
      expect(dto.defaultTimezone, 'UTC');
    });

    test('should handle null values correctly', () {
      final dto = HlbTimeDto();

      expect(dto.hlbTime, isNull);
      expect(dto.defaultTimezone, isNull);
    });
  });
}