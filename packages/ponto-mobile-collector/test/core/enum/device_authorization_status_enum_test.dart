import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'DeviceAuthorizationStatusEnum test.',
    () {
      expect(
        DeviceAuthorizationStatusEnum.build(
          DeviceAuthorizationStatusEnum.authorized.name,
        ),
        DeviceAuthorizationStatusEnum.authorized,
      );

      expect(
        DeviceAuthorizationStatusEnum.build(
          DeviceAuthorizationStatusEnum.deviceAuthorizationIsPending.name,
        ),
        DeviceAuthorizationStatusEnum.deviceAuthorizationIsPending,
      );

      expect(
        DeviceAuthorizationStatusEnum.build(
            DeviceAuthorizationStatusEnum.deviceAuthorizationWasRejected.name,),
        DeviceAuthorizationStatusEnum.deviceAuthorizationWasRejected,
      );

      expect(
        DeviceAuthorizationStatusEnum.build(
            DeviceAuthorizationStatusEnum.deviceActivationIsPending.name,),
        DeviceAuthorizationStatusEnum.deviceActivationIsPending,
      );

      expect(
        DeviceAuthorizationStatusEnum.build(
            DeviceAuthorizationStatusEnum.deviceActivationWasRejected.name,),
        DeviceAuthorizationStatusEnum.deviceActivationWasRejected,
      );

      expect(
        () => DeviceAuthorizationStatusEnum.build('error'),
        throwsA(
          isA<Exception>(),
        ),
      );
    },
  );
}
