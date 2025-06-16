import '../../infra/models/legacy_authorization_model.dart';
import '../../infra/models/platform_authorizations_aggregator_model.dart';

typedef GetUserLegacyAuthorizationsDatasourceCallback = Future<LegacyAuthorizationModel>;
typedef GetUserPlatformAuthorizationsDatasourceCallback = Future<PlatformAuthorizationsAggregatorModel>;
