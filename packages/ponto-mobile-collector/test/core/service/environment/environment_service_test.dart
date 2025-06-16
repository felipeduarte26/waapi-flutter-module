import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {

  group(
    'Environment Service test',
    () {
      test(
        'Get Environment varables test',
        () async {
          // Arrange
          await dotenv.load(fileName: 'environment_dev.env');
          dotenv.clean();
          EnvironmentService service = EnvironmentService();

          expect(service.registerFcmToken(), true);
          expect(service.showDebugBanner(), false);
          expect(service.byPassSslVerification(), false);
          expect(service.platformUrlBase(), 'https://platform.senior.com.br/t/senior.com.br/bridge/1.0/rest');
          expect(service.environment().name, EnvironmentEnum.prod.name);

          Map<String, String> newMap = {};
          newMap['SHOW_DEBUG_BANNER'] = 'true';
          newMap['REGISTER_FCM_TOKEN'] = 'false';
          newMap['PLATFORM_URL_BASE'] = 'URL_TESTE';
          newMap['BYPASS_SSL_VERIFICATION'] = 'true';
          newMap['ENVIRONMENT'] = 'homolog';
          await dotenv.load(fileName: 'environment_dev.env', mergeWith: newMap);

          expect(service.registerFcmToken(), false);
          expect(service.showDebugBanner(), true);
          expect(service.byPassSslVerification(), true);
          expect(service.platformUrlBase(), 'URL_TESTE');
          expect(service.environment().name, EnvironmentEnum.homolog.name);

          newMap['ENVIRONMENT'] = 'dev';
          await dotenv.load(fileName: 'environment_dev.env', mergeWith: newMap);
          expect(service.environment().name, EnvironmentEnum.dev.name);
        },
      );
    },
  );
}
