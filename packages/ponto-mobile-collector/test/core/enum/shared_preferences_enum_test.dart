import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'SharedPreferencesEnum test.',
    () {
      expect(
        SharedPreferencesEnum.build(
          SharedPreferencesEnum.requestPermissionOnStatrtup.name,
        ),
        SharedPreferencesEnum.requestPermissionOnStatrtup,
      );

      expect(
        SharedPreferencesEnum.build(SharedPreferencesEnum.deviceUuid.name),
        SharedPreferencesEnum.deviceUuid,
      );

      expect(
        SharedPreferencesEnum.build(SharedPreferencesEnum.userId.name),
        SharedPreferencesEnum.userId,
      );

      expect(
        SharedPreferencesEnum.build(SharedPreferencesEnum.lastPhotoPath.name),
        SharedPreferencesEnum.lastPhotoPath,
      );

      expect(
        () => SharedPreferencesEnum.build('error'),
        throwsA(
          isA<Exception>(),
        ),
      );
    },
  );
}
