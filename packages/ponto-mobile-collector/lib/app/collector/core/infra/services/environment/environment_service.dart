import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../../../ponto_mobile_collector.dart';


class EnvironmentService implements IEnvironmentService {
  @override
  String platformUrlBase() {
    return EnvironmentService.platformUrlBaseStatic();
  }

  @override
  bool registerFcmToken() {
    String? item = dotenv.env[EnvironmentVariablesEnum.registerFcmToken.value];

    if (item != null) {
      return item == 'true' ? true : false;
    }

    return true;
  }

  @override
  bool showDebugBanner() {
    return EnvironmentService.showDebugBannerStatic();
  }

  @override
  EnvironmentEnum environment() {
    String? item = dotenv.env[EnvironmentVariablesEnum.environment.value];
    if (item != null) {
      if (item == 'dev') {
        return EnvironmentEnum.dev;
      }

      if (item == 'homolog') {
        return EnvironmentEnum.homolog;
      }
    }

    return EnvironmentEnum.prod;
  }

  @override
  bool byPassSslVerification() {
    return EnvironmentService.byPassSslVerificationStatic();
  }

  static bool byPassSslVerificationStatic() {
    String? item =
        dotenv.env[EnvironmentVariablesEnum.byPassSslVerification.value];

    if (item != null) {
      return item == 'true' ? true : false;
    }

    return false;
  }

  static bool showDebugBannerStatic() {
    String? item = dotenv.env[EnvironmentVariablesEnum.showDebugBanner.value];

    if (item != null) {
      return item == 'true' ? true : false;
    }

    return false;
  }

  static String platformUrlBaseStatic() {
    String? url = dotenv.env[EnvironmentVariablesEnum.platformUrlApi.value];

    if (url == null) {
      return 'https://platform.senior.com.br/t/senior.com.br/bridge/1.0/rest';
    }

    return url;
  }

  @override
  int syncBatchSize() {
    String? item = dotenv.env[EnvironmentVariablesEnum.syncBatchSize.value];

    if (item == null) {
      return 50;
    }

    return int.parse(item);
  }

  @override
  String encryptionKey() {
    return const String.fromEnvironment('ENCRYPTION_KEY');
  }
}
