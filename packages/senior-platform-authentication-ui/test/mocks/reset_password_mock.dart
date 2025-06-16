import 'package:senior_platform_authentication/senior_platform_authentication.dart';

const ResetPassword resetPasswordMock = ResetPassword(
  username: 'username',
  captcha: 'captcha',
);

const ResetPasswordModel resetPasswordModelMock = ResetPasswordModel(
  username: 'username',
  captcha: 'captcha',
  baseUrl: 'baseUrl',
);

const String resetPasswordJson = '''
  {
    "username": "username",
    "captcha": "captcha",
    "baseURL": "baseUrl"
  }
''';

const ResetPasswordInfo resetPasswordInfoMock = ResetPasswordInfo(
  temporaryToken: 'temporaryToken',
  tenant: 'apphcmcom',
);

const ResetPasswordInfoModel resetPasswordInfoModelMock = ResetPasswordInfoModel(
  temporaryToken: 'temporaryToken',
  tenant: 'apphcmcom',
);
