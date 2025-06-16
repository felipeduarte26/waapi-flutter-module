import 'package:senior_platform_authentication/senior_platform_authentication.dart';

const ChangePasswordSettings changePasswordSettingsMock =
    ChangePasswordSettings(
  allowed: true,
  url: 'url',
  customRecaptchaSiteKey: 'customRecaptchaSiteKey',
);

const ChangePasswordSettingsModel changePasswordSettingsModelMock =
    ChangePasswordSettingsModel(
  allowed: true,
  url: 'url',
  customRecaptchaSiteKey: 'customRecaptchaSiteKey',
);

const String changePasswordSettingsJson = '''
  {
    "allowed": true,
    "url": "url",
    "customRecaptchaSiteKey": "customRecaptchaSiteKey"
  }
''';
