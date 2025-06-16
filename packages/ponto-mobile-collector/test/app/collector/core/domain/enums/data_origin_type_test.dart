import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/data_origin_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/service_exception.dart';

void main() {
  group('DataOriginType.build', () {
    test('should return DataOriginType.g5 when value is "G5"', () {
      final result = DataOriginType.build('G5');
      expect(result, DataOriginType.g5);
    });

    test('should return DataOriginType.manual when value is "MANUAL"', () {
      final result = DataOriginType.build('MANUAL');
      expect(result, DataOriginType.manual);
    });

    test('should throw ServiceException when value is invalid', () {
      expect(
        () => DataOriginType.build('INVALID'),
        throwsA(isA<ServiceException>()),
      );
    });
  });
}