import 'package:mobile_authentication/mobile_authentication_service.dart';

import 'permission_check_access_mock.dart';

AuthorizationResponse authorizationResponseMock = AuthorizationResponse(
  authorized: true,
  permissions: [permissionCheckAccessMock],
);
