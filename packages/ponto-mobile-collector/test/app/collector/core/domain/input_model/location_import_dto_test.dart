import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/location_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/location_import_dto.dart';

void main() {
  group('LocationImportDto', () {
    test('should create a valid instance with required fields', () {
      final dto = LocationImportDto(
        latitude: 12.345678,
        longitude: 98.765432,
        createAt: DateTime.now(),
      );

      expect(dto.latitude, 12.345678);
      expect(dto.longitude, 98.765432);
      expect(dto.createAt, isA<DateTime>());
      expect(dto.locationStatus, isNull);
    });

    test('should serialize to JSON correctly', () {
      final dto = LocationImportDto(
        latitude: 12.345678,
        longitude: 98.765432,
        createAt: DateTime.parse('2023-01-01T12:00:00Z'),
        locationStatus: LocationStatusEnum.location,
      );

      final json = dto.toJson();

      expect(json['latitude'], 12.345678);
      expect(json['longitude'], 98.765432);
      expect(json['createAt'], '2023-01-01T12:00:00.000Z');
      expect(json['locationStatus'], 'LOCATION');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'latitude': 12.345678,
        'longitude': 98.765432,
        'createAt': '2023-01-01T12:00:00.000Z',
        'locationStatus': 'LOCATION',
      };

      final dto = LocationImportDto.fromJson(json);

      expect(dto.latitude, 12.345678);
      expect(dto.longitude, 98.765432);
      expect(dto.createAt, DateTime.parse('2023-01-01T12:00:00Z'));
      expect(dto.locationStatus, LocationStatusEnum.location);
    });
  });
}
