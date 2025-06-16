import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';
import 'package:ponto_mobile_collector/app/collector/core/exception/service_exception.dart';

void main() {
  group('StatusDevice', () {
    test('should return the correct enum for a valid value', () {
      expect(StatusDevice.build('AUTHORIZED'), StatusDevice.authorized);
      expect(StatusDevice.build('AUTHORIZED_BY_EMPLOYEE'), StatusDevice.authorizedByEmployee);
      expect(StatusDevice.build('PENDING'), StatusDevice.pending);
      expect(StatusDevice.build('REJECTED'), StatusDevice.rejected);
    });

    test('should throw ServiceException for an invalid value', () {
      expect(
        () => StatusDevice.build('INVALID'),
        throwsA(isA<ServiceException>()),
      );
    });

    test('should have correct values for each enum', () {
      expect(StatusDevice.authorized.value, 'AUTHORIZED');
      expect(StatusDevice.authorizedByEmployee.value, 'AUTHORIZED_BY_EMPLOYEE');
      expect(StatusDevice.pending.value, 'PENDING');
      expect(StatusDevice.rejected.value, 'REJECTED');
    });
  });
}
