import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import 'saml_provider_mock.dart';

const LoginProviders loginProvidersMock = LoginProviders(saml: null);

const LoginProvidersModel loginProvidersModelMock =
    LoginProvidersModel(saml: samlProviderModelMock);

const String loginProvidersJson = '''
  {
    "saml":{
      "url":"url"
    }
  }
''';
