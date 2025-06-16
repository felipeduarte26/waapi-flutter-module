import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/network_status.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/clocking_event_exception.dart';

void main() {
  group('NetworkStatusEnum', () {
    test('should return the correct enum for valid values', () {
      expect(NetworkStatusEnum.build('Active'), NetworkStatusEnum.active);
      expect(NetworkStatusEnum.build('Inactive'), NetworkStatusEnum.inactive);
      expect(NetworkStatusEnum.build('Undefined'), NetworkStatusEnum.undefined);
    });

    test('should throw ClockingEventException for invalid value', () {
      expect(
        () => NetworkStatusEnum.build('InvalidValue'),
        throwsA(isA<ClockingEventException>()),
      );
    });

    test('should have correct string values', () {
      expect(NetworkStatusEnum.active.value, 'Active');
      expect(NetworkStatusEnum.inactive.value, 'Inactive');
      expect(NetworkStatusEnum.undefined.value, 'Undefined');
    });
  });
}
