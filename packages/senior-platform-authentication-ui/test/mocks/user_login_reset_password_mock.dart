import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

const UserLoginResetPassword userLoginResetPasswordMock =
    UserLoginResetPassword(
        username: 'username',
        newPassword: 'newPassword',
        temporaryToken: 'temporaryToken');

const UserLoginResetPasswordModel resetPasswordModelMock =
    UserLoginResetPasswordModel(
        username: 'username',
        newPassword: 'newPassword',
        temporaryToken: 'temporaryToken');

const String resetPasswordModelJson = '''
  {
    "username": "username",
    "newPassword": "newPassword",
    "temporaryToken": "temporaryToken"
  }
''';
