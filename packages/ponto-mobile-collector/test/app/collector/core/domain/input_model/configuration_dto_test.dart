import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/operation_mode_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/configuration_dto.dart';

void main() {
  group('ConfigurationDto', () {
    test('should serialize and deserialize correctly', () {
      // Arrange
      final configuration = ConfigurationDto(
        id: '123',
        onlyOnline: true,
        operationMode: OperationModeType.driver,
        timezone: 'UTC',
        takePhoto: true,
        takePhotoNfc: true,
      );

      // Act
      final json = configuration.toJson();
      final deserializedConfiguration = ConfigurationDto.fromJson(json);

      // Assert
      expect(deserializedConfiguration.id, configuration.id);
      expect(deserializedConfiguration.onlyOnline, configuration.onlyOnline);
      expect(deserializedConfiguration.operationMode, configuration.operationMode);
      expect(deserializedConfiguration.timezone, configuration.timezone);
      expect(deserializedConfiguration.takePhoto, configuration.takePhoto);
      expect(deserializedConfiguration.takePhotoNfc, configuration.takePhotoNfc);
    });

    test('should handle null values correctly', () {
      // Arrange
      final configuration = ConfigurationDto(
        onlyOnline: false,
        operationMode: OperationModeType.driver,
        timezone: 'PST',
        takePhoto: false,
        takePhotoNfc: null,
      );

      // Act
      final json = configuration.toJson();
      final deserializedConfiguration = ConfigurationDto.fromJson(json);

      // Assert
      expect(deserializedConfiguration.takePhotoNfc, configuration.takePhotoNfc);
    });
  });
}
