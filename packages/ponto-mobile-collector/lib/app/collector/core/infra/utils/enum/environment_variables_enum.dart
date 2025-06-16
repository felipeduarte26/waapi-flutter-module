enum EnvironmentVariablesEnum {
  platformUrlApi(value: 'PLATFORM_URL_BASE'),
  showDebugBanner(value: 'SHOW_DEBUG_BANNER'),
  registerFcmToken(value: 'REGISTER_FCM_TOKEN'),
  byPassSslVerification(value: 'BYPASS_SSL_VERIFICATION'),
  environment(value: 'ENVIRONMENT'),
  syncBatchSize(value: 'SYNC_BATCH_SIZE');

  final String value;

  const EnvironmentVariablesEnum({required this.value});

  static EnvironmentVariablesEnum build(String value) {
    if (value == EnvironmentVariablesEnum.platformUrlApi.value) {
      return EnvironmentVariablesEnum.platformUrlApi;
    }

    if (value == EnvironmentVariablesEnum.showDebugBanner.value) {
      return EnvironmentVariablesEnum.showDebugBanner;
    }

    if (value == EnvironmentVariablesEnum.registerFcmToken.value) {
      return EnvironmentVariablesEnum.registerFcmToken;
    }

    if (value == EnvironmentVariablesEnum.byPassSslVerification.value) {
      return EnvironmentVariablesEnum.byPassSslVerification;
    }

    if (value == EnvironmentVariablesEnum.environment.value) {
      return EnvironmentVariablesEnum.environment;
    }

    if (value == EnvironmentVariablesEnum.syncBatchSize.value) {
      return EnvironmentVariablesEnum.syncBatchSize;
    }

    throw Exception('EnvironmentVariablesEnum not found.');
  }
}
