import 'package:senior_platform_authentication/senior_platform_authentication.dart';

const RememberMeSettings rememberMeSettingsMock = RememberMeSettings(
  allowed: true,
  expiration: 6000,
);

const RememberMeSettingsModel rememberMeSettingsModelMock =
    RememberMeSettingsModel(
  allowed: true,
  expiration: 6000,
);

const String rememberMeSettingsJson = '''
  {
    "allowed": true,
    "expiration": 6000
  }
''';
