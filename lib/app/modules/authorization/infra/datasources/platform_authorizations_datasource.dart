import '../../external/types/authorization_external_types.dart';

abstract class PlatformAuthorizationsDatasource {
  GetUserPlatformAuthorizationsDatasourceCallback call();
}
