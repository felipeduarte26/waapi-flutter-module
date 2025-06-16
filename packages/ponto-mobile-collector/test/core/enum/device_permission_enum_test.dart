import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'DevicePermissionEnum test.',
    () {
      expect(
        DevicePermissionEnum.build(DevicePermissionEnum.camera.value),
        DevicePermissionEnum.camera,
      );

      expect(
        DevicePermissionEnum.build(DevicePermissionEnum.location.value),
        DevicePermissionEnum.location,
      );

      expect(
        DevicePermissionEnum.build(
          DevicePermissionEnum.manageExternalStorage.value,
        ),
        DevicePermissionEnum.manageExternalStorage,
      );

      expect(
        DevicePermissionEnum.build(DevicePermissionEnum.photos.value),
        DevicePermissionEnum.photos,
      );

      expect(
        DevicePermissionEnum.build(DevicePermissionEnum.notification.value),
        DevicePermissionEnum.notification,
      );

      expect(
        () => DevicePermissionEnum.build('error'),
        throwsA(
          isA<Exception>(),
        ),
      );
    },
  );
}
