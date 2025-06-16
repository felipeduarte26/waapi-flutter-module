import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/configuration.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';

void main() {
  group('Configuration', () {
    test('should correctly initialize faceRecognitionMulti when provided', () {
      var configuration = const Configuration(
        onlyOnline: true,
        operationMode: OperationModeType.single,
        timezone: 'UTC',
        takePhoto: false,
        faceRecognitionMulti: true,
      );

      expect(configuration.faceRecognitionMulti, true);
    });

    test(
        'should correctly initialize faceRecognitionMulti as null when not provided',
        () {
      const configuration = Configuration(
        onlyOnline: true,
        operationMode: OperationModeType.single,
        timezone: 'UTC',
        takePhoto: false,
      );

      expect(configuration.faceRecognitionMulti, null);
    });

    test('copyWith should update faceRecognitionMulti correctly', () {
      const configuration = Configuration(
        onlyOnline: true,
        operationMode: OperationModeType.multi,
        timezone: 'UTC',
        takePhoto: false,
        faceRecognitionMulti: false,
      );

      final updatedConfiguration =
          configuration.copyWith(faceRecognitionMulti: true);

      expect(updatedConfiguration.faceRecognitionMulti, true);
      expect(configuration.faceRecognitionMulti, false); // Ensure immutability
    });

    test('should correctly initialize managerId when provided', () {
      const configuration = Configuration(
        onlyOnline: true,
        operationMode: OperationModeType.single,
        timezone: 'UTC',
        takePhoto: false,
        managerId: 'manager123',
      );

      expect(configuration.managerId, 'manager123');
    });

    test('should correctly initialize managerId as null when not provided', () {
      const configuration = Configuration(
        onlyOnline: true,
        operationMode: OperationModeType.single,
        timezone: 'UTC',
        takePhoto: false,
      );

      expect(configuration.managerId, null);
    });

    test('copyWith should update managerId correctly', () {
      const configuration = Configuration(
        onlyOnline: true,
        operationMode: OperationModeType.multi,
        timezone: 'UTC',
        takePhoto: false,
        managerId: 'manager123',
      );

      final updatedConfiguration =
          configuration.copyWith(managerId: 'manager456');

      expect(updatedConfiguration.managerId, 'manager456');
      expect(configuration.managerId, 'manager123'); // Ensure immutability
    });
  });
}
