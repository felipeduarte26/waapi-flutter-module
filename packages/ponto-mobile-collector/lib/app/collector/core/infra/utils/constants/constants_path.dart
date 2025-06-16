class ConstantsPath {
  static const String pontoBulletPoint = '\u2022';

  static const String pontoLinkSeniorDocumentation =
      'https://documentacao.senior.com.br/home.htm';
  static const String pontoLinkSeniorDocumentationRegisterKey =
      'https://documentacao.senior.com.br/seniorxplatform/index.htm#administracao/gerenciamento-de-aplicacoes.htm?';

  static const String pontoLinkSeniorDocumentationNfc =
      'https://documentacao.senior.com.br/seniorxplatform/manual-do-usuario/hcm/marcacao-de-ponto/modos-de-uso/smart-card.htm?';

  static const pontoLinkSeniorDocumentationHelpCenter =
      'https://documentacao.senior.com.br/seniorxplatform/manual-do-usuario/hcm/#marcacao-de-ponto.htm';

  static const String pathPontomobile =
      't/senior.com.br/bridge/1.0/rest/hcm/pontomobile';
  static const String pathPontomobileAnonymous =
      't/senior.com.br/bridge/1.0/anonymous/rest/hcm/pontomobile';
  static const String queries = 'queries';
  static const String actions = 'actions';
  static const String entities = 'entities';
  static const String signals = 'signals';
  static const String pathQuery = '$pathPontomobile/$queries';
  static const String pathQueryAnonymous = '$pathPontomobileAnonymous/$queries';
  static const String pathActions = '$pathPontomobile/$actions';
  static const String pathEntities = '$pathPontomobile/$entities';
  static const String pathSignals = '$pathPontomobile/$signals';

  /// Queryes
  static const String personExistsOnFacialRecognitionPlatform =
      '$pathQuery/personExistsOnFacialRecognitionPlatform';

  static const String tokenAndroidSDKFacialRecognitionPath =
      '$pathQuery/tokenAndroidSDKFacialRecognitionQuery';

  static const String hasFeatureEnabledQuery =
      '$pathQuery/hasFeatureEnabledQuery';

  static const String configurationsGlobalQueryPath =
      '$pathQuery/configurationsGlobalQuery';

  static const String getDeviceConfigurationQueryPath =
      '$pathQuery/getDeviceConfiguration';

  static const String getPushNotificationsQueryPath =
      '$pathQuery/getPushNotificationsQuery';

  /// Actions
  static const String registerCompanyGroupPath =
      '$pathActions/registerCompanyGroupAndCompanyOnFaceRecognitionsPlatform';

  static const String registerPersonOnFaceRecognitionsPlatform =
      '$pathActions/registerPersonOnFaceRecognitionsPlatform';

  static const String getDeviceConfiguration =
      '$pathActions/deviceConfigurationAction';
  static const String multiEmployeeSyncPath =
      '$pathActions/multiEmployeeSyncAction';

  static const String privacyPoliceVersion =
      '$pathQueryAnonymous/privacyPoliceVersion';

  static const String getSearchEmployeesFacialAuthOn =
      '$pathActions/searchEmployeesFacialAuthOn';

  static const String hasUnreadPushMessageQueryPath =
      '$pathActions/hasUnreadPushMessageQuery';

  static const String confirmReadPushMessageActionPath =
      '$pathActions/confirmReadPushMessageAction';

  static const String getMenuAppQueryPath = '$pathQuery/menuApp';

  static const String overnightImportPath = '$pathActions/overnightImport';

  /// Entities
  static const String getDeviceEntityPath = '$pathEntities/device';

  static const String mobileLogPath = '$pathEntities/mobileLog/bulk';

  static const String registerDeviceWithFcmTokenPath =
      '$pathSignals/registerFCMTokenInDevice';
}
