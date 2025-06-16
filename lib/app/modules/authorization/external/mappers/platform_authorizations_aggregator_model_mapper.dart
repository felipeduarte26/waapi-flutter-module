import 'dart:convert';

import '../../infra/models/platform_authorizations_aggregator_model.dart';
import 'platform_authorization_model_mapper.dart';

class PlatformAuthorizationsAggregatorModelMapper {
  PlatformAuthorizationsAggregatorModel fromMap({
    required Map<String, dynamic> map,
  }) {
    final mapAsList = map['permissions'] as List;

    return PlatformAuthorizationsAggregatorModel(
      platformAuthorizations: mapAsList.map(
        (permission) {
          return PlatformAuthorizationModelMapper.fromMap(
            map: permission,
          );
        },
      ).toList(),
    );
  }

  PlatformAuthorizationsAggregatorModel fromJson({
    required String json,
  }) {
    return fromMap(
      map: jsonDecode(json),
    );
  }
}
