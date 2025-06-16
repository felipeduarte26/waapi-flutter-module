import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/biometric_patterns.dart';

void main() {
  group('BiometricPatterns', () {
    test('should create a valid BiometricPatterns instance', () {
      final biometricPatterns = BiometricPatterns(
        id: '123',
        employee: 'John Doe',
        pattern: 'fingerprint',
        patternNumber: 1.0,
        vendor: 'VendorX',
        createdAt: DateTime.parse('2023-01-01T00:00:00.000Z'),
        updatedAt: DateTime.parse('2023-01-02T00:00:00.000Z'),
        platformId: 'platform123',
      );

      expect(biometricPatterns.id, '123');
      expect(biometricPatterns.employee, 'John Doe');
      expect(biometricPatterns.pattern, 'fingerprint');
      expect(biometricPatterns.patternNumber, 1.0);
      expect(biometricPatterns.vendor, 'VendorX');
      expect(biometricPatterns.createdAt, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(biometricPatterns.updatedAt, DateTime.parse('2023-01-02T00:00:00.000Z'));
      expect(biometricPatterns.platformId, 'platform123');
    });

    test('should serialize and deserialize correctly', () {
      final json = {
        'id': '123',
        'employee': 'John Doe',
        'pattern': 'fingerprint',
        'patternNumber': 1.0,
        'vendor': 'VendorX',
        'createdAt': '2023-01-01T00:00:00.000Z',
        'updatedAt': '2023-01-02T00:00:00.000Z',
        'platformId': 'platform123',
      };

      final biometricPatterns = BiometricPatterns.fromJson(json);
      expect(biometricPatterns.id, '123');
      expect(biometricPatterns.updatedAt, DateTime.parse('2023-01-02T00:00:00.000Z'));

      final serializedJson = biometricPatterns.toJson();
      expect(serializedJson['id'], '123');
      expect(serializedJson['updatedAt'], '2023-01-02T00:00:00.000Z');
    });
  });
}
