import 'package:senior_platform_authentication/src/data/models/models.dart';
import 'package:senior_platform_authentication/src/domain/entities/entities.dart';

const Token tokenMock = Token(
  version: 1,
  expiresIn: 6000,
  username: 'username',
  tokenType: 'token_type',
  accessToken: 'access_token',
  refreshToken: 'refresh_token',
  type: 'type',
  email: 'email',
  fullName: 'fullName',
  tenantName: 'tenantName',
  locale: 'locale',
  hash: [1, 2, 3, 4, 5, 6],
  salt: [1, 2, 3],
);

const Token keyTokenMock = Token(
  version: 1,
  expiresIn: 6000,
  username: 'username',
  tokenType: 'token_type',
  accessToken: 'key_access_token',
  refreshToken: 'key_refresh_token',
  type: 'type',
  email: 'email',
  fullName: 'fullName',
  tenantName: 'tenantName',
  locale: 'locale',
  hash: [1, 2, 3, 4, 5, 6],
  salt: [1, 2, 3],
);

const RefreshToken refreshTokenMock =
    RefreshToken(token: 'refreshToken', scope: 'mobile', tenant: 'tenant');

const TokenModel tokenModelMock = TokenModel(
  version: 1,
  expires_in: 6000,
  username: 'username',
  token_type: 'token_type',
  access_token: 'access_token',
  refresh_token: 'refresh_token',
  type: 'type',
  email: 'email',
  fullName: 'fullName',
  tenantName: 'tenantName',
  locale: 'locale',
  hash: [1, 2, 3, 4, 5, 6],
  salt: [1, 2, 3],
);

const String tokenModelJson = '''
  {
    "version": 1,
    "expires_in": 6000,
    "username": "username",
    "token_type": "token_type",
    "access_token": "access_token",
    "refresh_token": "refresh_token",
    "type": "type",
    "email": "email",
    "fullName": "fullName",
    "tenantName": "tenantName",
    "locale": "locale"
  }
''';

const AuthenticationResponse authenticationResponseMock =
    AuthenticationResponse(token: tokenMock);

const AuthenticationResponse invalidAuthenticationResponseMock =
    AuthenticationResponse(token: null);

const AuthenticationResponseModel authenticationResponseModelMock =
    AuthenticationResponseModel(jsonToken: tokenModelMock);

const String authenticationResponseJson = '''
  {
    "jsonToken": {
      "version": 1,
      "expires_in": 6000,
      "username": "username",
      "token_type": "token_type",
      "access_token": "access_token",
      "refresh_token": "refresh_token",
      "type": "type",
      "email": "email",
      "fullName": "fullName",
      "tenantName": "tenantName",
      "locale": "locale"
    },
    "mfaInfo": null,
    "resetPasswordInfo": null
  }
''';
