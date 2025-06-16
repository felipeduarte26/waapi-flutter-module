import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/environment_enum.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

/// Contains the environment variables that are passed using --dart-defines parameter.
/// Consider to define the default values using the production information and with this
/// you do not need to define it while building the app.
class EnvironmentVariables {
  /// Indicates the name of the firebase configuration to set the firebase options.
  /// This configuration replaces the need to have a googleservices.json file to configure Firebase.
  /// Currently the values development and production are accepted.
  /// The default value is production, and this means you do not need to pass it through the production build process.
  static String get firebaseEnvironment {
    return const String.fromEnvironment(
      'FIREBASE_ENVIRONMENT',
      defaultValue: 'production',
    );
  }

  /// Indicates whether the debug banner should be visible or not.
  /// It is highly recommended that you show it then use an internal environment.
  /// The default value is false, and this means you do not need to pass it through the production build process.
  static bool get showDebugBanner {
    return const bool.fromEnvironment(
      'SHOW_DEBUG_BANNER',
      defaultValue: false,
    );
  }

  /// Contains the URL base to use in the Senior X Platform requests.
  /// The default is the URL from the production environment, and this means you do not need to pass it through
  /// the production build process.
  static String get platformUrlBase {
    return const String.fromEnvironment(
      'PLATFORM_URL_BASE',
      defaultValue: 'https://platform.senior.com.br/t/senior.com.br/bridge/1.0/rest',
    );
  }

  /// Contains the URL base to use in the Senior X Platform redirect.
  /// The default is the URL from the production environment, and this means you do not need to pass it through
  /// the production build process.
  static String get platformRedirectBase {
    return const String.fromEnvironment(
      'PLATFORM_REDIRECT_BASE',
      defaultValue: 'https://platform.senior.com.br/senior-x?tenant=TENANT_NAME&/#/?link=',
    );
  }

  String getPlatformUrlBase(String tenant) {
    return platformRedirectBase.replaceAll('TENANT_NAME', tenant);
  }

  /// Contains the URL base to use in the Legacy HCM API.
  /// The default is the URL from the production environment, and this means you do not need to pass it through
  /// the production build process.
  static String get hcmApiUrlBase {
    return const String.fromEnvironment(
      'HCM_API_URL_BASE',
      defaultValue: 'https://hcm-api.senior.com.br/frontend-api',
    );
  }

  /// Contains the URL to access the app documentation.
  /// The default is the URL from the production environment, and this means you do not need to pass it through
  /// the production build process.
  static String get helpUrl {
    return const String.fromEnvironment(
      'HELP_URL',
      defaultValue:
          'https://documentacao.senior.com.br/seniorxplatform/manual-do-usuario/hcm/waapi/perguntas-frequentes.htm?fromMobile=true',
    );
  }

  /// Contains the URL to access the app privacy policy.
  /// The default is the URL from the production environment, and this means you do not need to pass it through
  /// the production build process.
  static String get privacyPolicyUrl {
    return const String.fromEnvironment(
      'PRIVACY_POLICY_URL',
      defaultValue:
          'https://documentacao.senior.com.br/seniorxplatform/manual-do-usuario/hcm/politica-privacidade/app-hcm-mobile.htm?fromMobile=true',
    );
  }

  /// Contains the URL to access the app documentation.
  /// The default is the URL from the Happiness Index, and this means you do not need to pass it through
  /// the production build process.
  static String get documentationMoodDiary {
    return const String.fromEnvironment(
      'DOCUMENTATION_HAPPINESS_INDEX',
      defaultValue:
          'https://documentacao.senior.com.br/seniorxplatform/manual-do-usuario/hcm/waapi/funcionalidades/definir-humor-dia.htm?fromMobile=true?utm_source=botao-tela-happiness-index',
    );
  }

  /// Contains the URL to access the integration URL.
  static String get integrationLink {
    return const String.fromEnvironment(
      'INTEGRATION_LINK',
      defaultValue: 'https://hcm.senior.com.br/integration.html',
    );
  }

  /// Contains the URL to access the app documentation.
  /// The default is the URL from the Happiness Index, and this means you do not need to pass it through
  /// the production build process.
  static String get documentationWaapiLite {
    return const String.fromEnvironment(
      'DOCUMENTATION_WAAPI_LITE',
      defaultValue: 'https://documentacao.senior.com.br/seniorxplatform/manual-do-usuario/hcm/#waapi/waapi.htm',
    );
  }

  /// Contains the 32 characters key to encrypt the sensible data.
  /// The variable not contains a default value, and this means you need to pass it through the build process.
  static String get encryptionKey {
    return const String.fromEnvironment('ENCRYPTION_KEY');
  }

    // Método para determinar o ambiente da plataforma
  static PlatformEnvironment get platformEnvironmentWaapi {
    switch (firebaseEnvironment) {
      case 'development':
        return PlatformEnvironment.cloudLeaf;
      case 'production':
        return PlatformEnvironment.production;
      case 'homolog':
        return PlatformEnvironment.homolog;
      default:
        return PlatformEnvironment.production;
    }    
  }

  // Método para determinar o ambiente do Clock Module
  static EnvironmentEnum get environmentClockModuleEnum {    
    switch (firebaseEnvironment) {
      case 'development':
        return EnvironmentEnum.dev;
      case 'production':
        return EnvironmentEnum.prod;
      case 'homolog':
        return EnvironmentEnum.homolog;
      default:
        return EnvironmentEnum.prod;
    }
  }
}
