import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

const LoginWithKey loginWithKeyMock = LoginWithKey(
  accessKey: 'accessKey',
  secret: 'secret',
  tenantName: 'tenantName',
  scope: 'mobile',
);

const LoginWithKeyModel loginWithKeyModelMock = LoginWithKeyModel(
  accessKey: 'accessKey',
  secret: 'secret',
  tenantName: 'tenantName',
  scope: 'mobile',
);

const String loginWithKeyModelJsonMock = '''
  {
    "accessKey": "accessKey",
    "secret": "secret",
    "tenantName": "tenantName",
    "scope": "mobile"
  }
''';
