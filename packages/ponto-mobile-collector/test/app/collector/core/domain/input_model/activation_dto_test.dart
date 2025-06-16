import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/activation_situation_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/activation_dto.dart';

void main() {
  group('ActivationDto', () {
    test('should serialize and deserialize correctly', () {
      // Arrange
      final activationDto = ActivationDto(
        id: '123',
        deviceSituation: StatusDevice.authorized,
        employeeSituation: ActivationSituationType.authorized,
        requestDate: '2023-01-01',
        requestTime: '12:00:00',
      );

      // Act
      final json = activationDto.toJson();
      final deserializedActivationDto = ActivationDto.fromJson(json);

      // Assert
      expect(deserializedActivationDto.id, activationDto.id);
      expect(deserializedActivationDto.deviceSituation, activationDto.deviceSituation);
      expect(deserializedActivationDto.employeeSituation, activationDto.employeeSituation);
      expect(deserializedActivationDto.requestDate, activationDto.requestDate);
      expect(deserializedActivationDto.requestTime, activationDto.requestTime);
    });

    test('should handle null id correctly', () {
      // Arrange
      final activationDto = ActivationDto(
        id: null,
        deviceSituation: StatusDevice.authorized,
        employeeSituation: ActivationSituationType.pending,
        requestDate: '2023-01-01',
        requestTime: '12:00:00',
      );

      // Act
      final json = activationDto.toJson();
      final deserializedActivationDto = ActivationDto.fromJson(json);

      // Assert
      expect(deserializedActivationDto.id, isNull);
      expect(deserializedActivationDto.deviceSituation, activationDto.deviceSituation);
      expect(deserializedActivationDto.employeeSituation, activationDto.employeeSituation);
      expect(deserializedActivationDto.requestDate, activationDto.requestDate);
      expect(deserializedActivationDto.requestTime, activationDto.requestTime);
    });
  });
}
