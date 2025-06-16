import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'RegisterFCMTokenDto test.',
    () {
      RegisterFCMTokenDto dtoIn = RegisterFCMTokenDto(
        employeeId: 'id',
        platform: 'platform',
        token: 'token',
      );

      RegisterFCMTokenDto dtoOut = RegisterFCMTokenDto.fromJson(dtoIn.toJson());

      expect(dtoIn.employeeId, dtoOut.employeeId);
      expect(dtoIn.platform, dtoOut.platform);
      expect(dtoIn.token, dtoOut.token);
    },
  );
}
