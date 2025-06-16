import 'package:senior_platform_authentication/senior_platform_authentication.dart';

const TenantLogin tenantLoginMock = TenantLogin(
  tenantDomain: 'tenantDomain',
  scope: 'scope',
);

const String tenantLoginJson = '''
  {
    "tenantDomain": tenantDomain,
    "scope": "scope",
  }
''';
