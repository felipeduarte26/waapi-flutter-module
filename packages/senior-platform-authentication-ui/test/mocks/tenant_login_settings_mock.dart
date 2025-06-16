import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import 'change_password_settings_mock.dart';
import 'login_providers_mock.dart';
import 'remember_me_settings_mock.dart';

TenantLoginSettings tenantLoginSettingsMock = TenantLoginSettings(
  tenantName: 'tenantName',
  cookieDomain: 'cookieDomain',
  changePasswordSettings: changePasswordSettingsMock,
  rememberMeSettings: rememberMeSettingsMock,
  loginProviders: loginProvidersMock,
  authenticationTypes: List.of(['', '']),
  tenantDomain: 'tenantDomain',
);

TenantLoginSettingsModel tenantLoginSettingsModelMock =
    TenantLoginSettingsModel(
  tenantName: 'tenantName',
  cookieDomain: 'cookieDomain',
  changePasswordSettings: changePasswordSettingsModelMock,
  rememberMeSettings: rememberMeSettingsModelMock,
  loginProviders: loginProvidersModelMock,
  authenticationTypes: List.of(['', '']),
  tenantDomain: 'tenantDomain',
);

const String tenantLoginSettingsJson = '''
  {
    "tenantName": "tenantName",
    "cookieDomain": "cookieDomain",
    "changePasswordSettings":{
      "allowed": true,
      "url": "url",
      "customRecaptchaSiteKey": "customRecaptchaSiteKey"
    },
    "rememberMeSettings":{
      "allowed": true,
      "expiration": 6000
    },
    "loginProviders": {
      "saml":{
        "url":"url"
      }
    },
    "authenticationTypes":["",""],
    "tenantDomain": "tenantDomain"
  }
''';
