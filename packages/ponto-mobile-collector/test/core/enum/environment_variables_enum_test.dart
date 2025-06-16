import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'EnvironmentVariablesEnum test.',
    () {
      expect(
        EnvironmentVariablesEnum.build(
          EnvironmentVariablesEnum.platformUrlApi.value,
        ),
        EnvironmentVariablesEnum.platformUrlApi,
      );

      expect(
        EnvironmentVariablesEnum.build(
          EnvironmentVariablesEnum.showDebugBanner.value,
        ),
        EnvironmentVariablesEnum.showDebugBanner,
      );

      expect(
        EnvironmentVariablesEnum.build(
          EnvironmentVariablesEnum.registerFcmToken.value,
        ),
        EnvironmentVariablesEnum.registerFcmToken,
      );

      expect(
        EnvironmentVariablesEnum.build(
          EnvironmentVariablesEnum.byPassSslVerification.value,
        ),
        EnvironmentVariablesEnum.byPassSslVerification,
      );

      expect(
        EnvironmentVariablesEnum.build(
          EnvironmentVariablesEnum.environment.value,
        ),
        EnvironmentVariablesEnum.environment,
      );

      expect(
        () => EnvironmentVariablesEnum.build('error'),
        throwsA(
          isA<Exception>(),
        ),
      );
    },
  );
}
