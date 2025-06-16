import '../../../core/constants/platform_permissions.dart';
import '../../../core/constants/social_plataform_permissions.dart';
import '../infra/models/platform_authorizations_aggregator_model.dart';

class AuthorizationHelper {
  static bool hasPermissionPlatformAuthorization({
    required PlatformAuthorizationsAggregatorModel platformAuthorizationsAggregatorModel,
    required String resource,
    required String action,
  }) {
    if (platformAuthorizationsAggregatorModel.platformAuthorizations.isEmpty) {
      return false;
    }

    return platformAuthorizationsAggregatorModel.platformAuthorizations.firstWhere(
      (platformAuthorization) {
        return platformAuthorization.resource.trim() == resource.trim() &&
            platformAuthorization.action.trim() == action.trim();
      },
    ).authorized;
  }

  static Map<String, dynamic> getPlataformPermissions() {
    Map<String, dynamic> plataformPermissionReturn = {
      'permissions': [],
    };

    for (Map<String, dynamic> map in [platformPermissions, socialPlatformPermissions]) {
      plataformPermissionReturn['permissions'].addAll(map['permissions']);
    }

    return plataformPermissionReturn;
  }
}
