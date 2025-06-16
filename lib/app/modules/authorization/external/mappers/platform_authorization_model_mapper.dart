import 'dart:convert';

import '../../infra/models/platform_authorization_model.dart';

class PlatformAuthorizationModelMapper {
  static PlatformAuthorizationModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PlatformAuthorizationModel(
      resource: map['resource'] ?? '',
      action: map['action'] ?? '',
      authorized: map['authorized'] ?? false,
    );
  }

  static PlatformAuthorizationModel fromJson({
    required String json,
  }) {
    return fromMap(
      map: jsonDecode(json),
    );
  }
}
