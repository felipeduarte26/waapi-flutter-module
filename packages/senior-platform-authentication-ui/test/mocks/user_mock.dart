import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import 'integration_mock.dart';

const User userMock = User(
  changePassword: false,
  admin: true,
  allowedToChangePassword: true,
  id: 'id',
  username: 'username',
  fullName: 'fullName',
  email: 'email',
  tenantDomain: 'tenantDomain',
  tenantName: 'tenantName',
  tenantLocale: 'tenantLocale',
  blocked: false,
  locale: 'locale',
  photoUrl: 'photoUrl',
  authenticationType: 'authenticationType',
  description: 'description',
  properties: [],
  integration: integrationMock,
  discriminator: 'discriminator',
  activeBiometry: true,
);

const User userMockNotBiometric = User(
  changePassword: false,
  admin: true,
  allowedToChangePassword: true,
  id: 'id',
  username: 'username',
  fullName: 'fullName',
  email: 'email',
  tenantDomain: 'tenantDomain',
  tenantName: 'tenantName',
  tenantLocale: 'tenantLocale',
  blocked: false,
  locale: 'locale',
  photoUrl: 'photoUrl',
  authenticationType: 'authenticationType',
  description: 'description',
  properties: [],
  integration: integrationMock,
  discriminator: 'discriminator',
  activeBiometry: false,
);

const UserModel userModelMock = UserModel(
  changePassword: false,
  admin: true,
  allowedToChangePassword: true,
  id: 'id',
  username: 'username',
  fullName: 'fullName',
  email: 'email',
  tenantDomain: 'tenantDomain',
  tenantName: 'tenantName',
  tenantLocale: 'tenantLocale',
  blocked: false,
  locale: 'locale',
  photoUrl: 'photoUrl',
  authenticationType: 'authenticationType',
  description: 'description',
  properties: [],
  integration: integrationModelMock,
  discriminator: 'discriminator',
  activeBiometry: true,
);

const String userModelJson = '''
  {
    "changePassword":false,
    "admin":true,
    "allowedToChangePassword":true,
    "id":"id",
    "username":"username",
    "fullName":"fullName",
    "email":"email",
    "tenantDomain":"tenantDomain",
    "tenantName":"tenantName",
    "tenantLocale":"tenantLocale",
    "blocked":false,
    "locale":"locale",
    "photoUrl":"photoUrl",
    "authenticationType":"authenticationType",
    "description":"description",
    "properties":[],
    "integration":{
      "integrationName":"integrationName"
    },
    "discriminator":"discriminator",
    "activeBiometry":true

  }
''';
