import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/insight_out_of_bound_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/service_exception.dart';

void main() {
  group('InsightOutOfBoundType.build', () {
    test('should return allClockingEvents when value is ALL_CLOCKING_EVENTS', () {
      final result = InsightOutOfBoundType.build('ALL_CLOCKING_EVENTS');
      expect(result, InsightOutOfBoundType.allClockingEvents);
    });

    test('should return mobileOnly when value is MOBILE_ONLY', () {
      final result = InsightOutOfBoundType.build('MOBILE_ONLY');
      expect(result, InsightOutOfBoundType.mobileOnly);
    });

    test('should return doNotSend when value is DO_NOT_SEND', () {
      final result = InsightOutOfBoundType.build('DO_NOT_SEND');
      expect(result, InsightOutOfBoundType.doNotSend);
    });

    test('should throw ServiceException when value is invalid', () {
      expect(
        () => InsightOutOfBoundType.build('INVALID_VALUE'),
        throwsA(isA<ServiceException>()),
      );
    });
  });
}