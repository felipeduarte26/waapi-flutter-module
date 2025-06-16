import 'package:senior_platform_authentication_ui/src/core/authentication/domain/entities/key_authentication_data.dart';

import 'login_with_key_mock.dart';
import 'token_mock.dart';

const KeyAuthenticationData keyAuthenticationDataMock = KeyAuthenticationData(
  loginWithKey: loginWithKeyMock,
  token: tokenMock,
);
