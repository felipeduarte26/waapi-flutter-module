import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'UnregisterFCMTokenDto test.',
    () {
      UnregisterFCMTokenDto dtoIn = UnregisterFCMTokenDto(
        employeeId: 'id',
        platform: 'platform',
      );

      UnregisterFCMTokenDto dtoOut = UnregisterFCMTokenDto.fromJson(dtoIn.toJson());

      expect(dtoIn.employeeId, dtoOut.employeeId);
      expect(dtoIn.platform, dtoOut.platform);
    },
  );
}
