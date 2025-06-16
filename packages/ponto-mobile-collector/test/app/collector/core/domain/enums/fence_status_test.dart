import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/fence_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/clocking_event_exception.dart';

void main() {
  group('FenceStatusEnum', () {
    test('should return FenceStatusEnum.into when id is "IN"', () {
      final result = FenceStatusEnum.build('IN');
      expect(result, FenceStatusEnum.into);
    });

    test('should return FenceStatusEnum.out when id is "OUT"', () {
      final result = FenceStatusEnum.build('OUT');
      expect(result, FenceStatusEnum.out);
    });

    test('should return FenceStatusEnum.noFence when id is "NO_FENCE"', () {
      final result = FenceStatusEnum.build('NO_FENCE');
      expect(result, FenceStatusEnum.noFence);
    });

    test('should return FenceStatusEnum.noLocation when id is "NO_LOCATION"', () {
      final result = FenceStatusEnum.build('NO_LOCATION');
      expect(result, FenceStatusEnum.noLocation);
    });

    test('should return FenceStatusEnum.noLocationPermission when id is "NO_LOCATION_PERMISSION"', () {
      final result = FenceStatusEnum.build('NO_LOCATION_PERMISSION');
      expect(result, FenceStatusEnum.noLocationPermission);
    });

    test('should throw ClockingEventException when id is invalid', () {
      expect(() => FenceStatusEnum.build('INVALID_ID'), throwsA(isA<ClockingEventException>()));
    });
  });
}